shader_type canvas_item;

uniform float amplitude;
uniform float frequency;

void vertex() {
	float x_coord = TIME;
	x_coord = x_coord * frequency;
	x_coord = amplitude * sin(x_coord);
	x_coord = UV.r + x_coord;
	UV.r = x_coord;
}