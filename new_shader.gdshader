shader_type canvas_item;

uniform sampler2D tex;
uniform vec4 color : hint_color;
uniform float freq1;
uniform float speed1;
uniform float amp1;
uniform float custom_time;
uniform float offset;

void vertex() {
	float x = VERTEX.x;
	float addY = sin(x * freq1 + custom_time * speed1 + offset) * amp1;
	VERTEX.y += addY;
}

void fragment(){
	vec4 shape = texture(tex, UV);
	COLOR = shape * color;
}