void windowShader(inout vec4 color) {
    // remove premultiplied alpha
    if (color.a > 0.0) {
        color.rgb /= color.a;
    }

    float lum = dot(color.rgb, vec3(0.2126, 0.7152, 0.0722));

    float lumInverse = 1.0 - lum;

    color.rgb = color.rgb * (lumInverse / max(lum, 0.1));

    // remultiply alpha
    color.rgb *= color.a;
}
