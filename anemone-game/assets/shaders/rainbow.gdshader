shader_type canvas_item;

uniform float strength: hint_range(0., 1.) = 1.0;
uniform float speed: hint_range(0., 10.) = 0.01;
uniform float angle: hint_range(0., 360.) = 30.0;
uniform float start_offset: hint_range(0.0, 6.28) = 0.0;
uniform float phase_scale : hint_range(0.01, 10.0) = 10.0;

uniform float amplitude : hint_range(0.0, 500.0) = 100.0;
uniform float vertex_speed : hint_range(0.0, 10.0) = 1.0;
uniform float frequency : hint_range(0.0, 6.28) = 4.4;

void vertex() {
    VERTEX.x += sin(TIME * vertex_speed + UV.y * frequency) * amplitude * (1.0 - UV.y);
}

void fragment() {
    float hue = (UV.x * cos(radians(angle)) - UV.y * sin(radians(angle))) / phase_scale;
    hue = fract(hue + fract(TIME * speed + start_offset));
    float x = 1. - abs(mod(hue / (1./ 6.), 2.) - 1.);
    vec3 rainbow;
    if(hue < 1./6.){
        rainbow = vec3(1., x, 0.);
    } else if (hue < 1./3.) {
        rainbow = vec3(x, 1., 0);
    } else if (hue < 0.5) {
        rainbow = vec3(0, 1., x);
    } else if (hue < 2./3.) {
        rainbow = vec3(0., x, 1.);
    } else if (hue < 5./6.) {
        rainbow = vec3(x, 0., 1.);
    } else {
        rainbow = vec3(1., 0., x);
    }
    vec4 color = texture(TEXTURE, UV);
    COLOR = mix(color, vec4(rainbow, color.a), strength);
}