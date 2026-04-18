
// Helper functions for color space conversion
vec3 rgb2hcv(vec3 c) {
    vec4 P = (c.g < c.b) ? vec4(c.bg, -1.0, 2.0/3.0) : vec4(c.gb, 0.0, -1.0/3.0);
    vec4 Q = (c.r < P.x) ? vec4(P.xyw, c.r) : vec4(c.r, P.yzx);
    float D = Q.x - min(Q.w, Q.y);
    float E = 1.0e-10;
    return vec3(abs(Q.z + (Q.w - Q.y) / (6.0 * D + E)), D / (Q.x + E), Q.x);
}

vec3 hsv2rgb(vec3 c) {
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void windowShader(inout vec4 color) {
    // 1. Remove premultiplied alpha
    if (color.a > 0.0) color.rgb /= color.a;

    // 2. Convert RGB to HSV (Hue, Saturation, Value/Brightness)
    vec3 hsv = rgb2hcv(color.rgb);

    if (hsv.z < 0.3)
        hsv.z *= hsv.z * hsv.z * hsv.z;

    // 3. FLIP THE BRIGHTNESS
    // This is the "Clear -> Dark" and "Dark -> Clear" logic

    hsv.z = 1.0 - hsv.z;


    // 4. Convert back to RGB
    color.rgb = hsv2rgb(hsv);

    // 5. Remultiply alpha
    color.rgb *= color.a;
}
