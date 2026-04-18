
void windowShader(inout vec4 color) {
    // remove premultiplied alpha
    if (color.a > 0.0) {
        color.rgb /= color.a;
    }

    // Standard Invert
    // 1.0 - color turns White (1.0) into Black (0.0)
    color.rgb = 1.0 - color.rgb;

    // Optional: Boost contrast to make blacks "inkier"
    // Higher numbers = darker darks. 1.0 is standard.
    // color.rgb = pow(color.rgb, vec3(1.2)); 

    // remultiply alpha
    color.rgb *= color.a;
}
