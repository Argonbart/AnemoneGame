shader_type canvas_item;

uniform vec4 color1: source_color;
uniform vec4 color2: source_color;

void fragment() {
    vec2 uv = SCREEN_UV;
    float segment = mod(floor(uv.x / 0.01), 2.0);
    vec4 color = mix(color1, color2, segment);
    COLOR = color;
}
