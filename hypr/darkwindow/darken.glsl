void windowShader(inout vec4 color) {
    // remove premultiplied alpha
    if (color.a > 0.0) {
        color.rgb /= color.a;
    }

    // Calculate Luminance (Perceived Brightness)
    float lum = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));

    // Invert Luminance
    // This turns bright things dark, but keeps the color information
    float lumInverse = 1.0 - lum;

    // Blend the original color with the new luminance
    // This effectively darkens the background without turning blue into orange
    color.rgb = color.rgb * (lumInverse / max(lum, 0.001));

    // remultiply alpha
    color.rgb *= color.a;
}
