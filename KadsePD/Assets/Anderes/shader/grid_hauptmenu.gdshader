shader_type canvas_item;

uniform float brightness: hint_range(0.1, 4.0, 0.1) = 2.0;
uniform float thickness: hint_range(1.0, 10.0, 0.1) = 2.0;
uniform float zoom: hint_range(1.0, 50.0, 0.1) = 20.0;
uniform vec2 resolution = vec2(1920.0, 1080.0);
uniform vec3 line_color: source_color = vec3(0.2,0.5,0.9);
uniform vec3 replacement_color: source_color = vec3(0.1,0.1,0.1);

float draw_grid(vec2 uv) {
	vec2 grid_uv = cos(uv * TAU);
	return max(grid_uv.x, grid_uv.y);
}

vec2 rotate(vec2 uv, float angle) {
	return uv * mat2(vec2(cos(angle), -sin(angle)), vec2(sin(angle), cos(angle)));
}

void fragment() {
	vec2 uv = UV - 0.5;
	uv.x *= resolution.x / resolution.y;
	uv -= vec2(TIME * 0.1, TIME * 0.1);
	//uv = rotate(uv, TIME * 0.9);
	//float zoom = 4.0 + abs(cos(TIME * 0.3) * sin(TIME * 0.3)) * 30.0;
	float line_thickness = zoom * thickness / resolution.y;
	vec3 color = smoothstep(1.0 - line_thickness, 1.0, draw_grid(uv * zoom)) * line_color;
	if (color == vec3(0.0)) {
        color = replacement_color;
    }
	COLOR = vec4(color * brightness, 0.7);
}