shader_type canvas_item;

uniform float hue : hint_range(0.0, 6.283185) = 0.0;
uniform float saturation : hint_range(0.0, 2.0) = 1.0;
uniform float brightness : hint_range(0.0, 2.0) = 1.0;

void fragment() {
    vec4 col = texture(TEXTURE, UV);
    float alpha = col.a;
    vec3 color = col.rgb;

    mat3 RGB_to_YIQ = mat3(
        vec3(0.2989, 0.5959, 0.2115),
        vec3(0.5870, -0.2774, -0.5229),
        vec3(0.1140, -0.3216, 0.3114)
    );
    color = RGB_to_YIQ * color;

    float sin_hue = sin(hue);
    float cos_hue = cos(hue);

    mat3 hue_Shift = mat3(
        vec3(1.0, 0, 0),
        vec3(0, cos_hue, -sin_hue),
        vec3(0, sin_hue, cos_hue)
    );
    color = hue_Shift * color;

    mat3 sat_Shift = mat3(
        vec3(1, 0, 0),
        vec3(0, saturation, 0),
        vec3(0, 0, saturation)
    );
    color = sat_Shift * color;

    color = inverse(RGB_to_YIQ) * color;

    color.rgb = mix(vec3(0.0), color.rgb, brightness);

    col.rgb = color;
    col.a = alpha;

    col *= COLOR;
    COLOR = col;
}
