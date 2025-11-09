shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

uniform float amplitude : hint_range(0.0, 100.0) = 10.0; // Fraction of screen width
uniform float speed : hint_range(0.0, 10.0) = 0.8;
uniform float frequency : hint_range(0.0, 20.0) = 1.0;

void fragment() {
    vec2 uv = SCREEN_UV;
    uv.x += sin(TIME * speed + uv.y * frequency) * amplitude / 1920.0;
    COLOR = texture(screen_texture, uv);
}
