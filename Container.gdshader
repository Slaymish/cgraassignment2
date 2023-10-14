shader_type spatial;


uniform vec3 ao_color = vec3(0, 0, 0);
uniform vec3 diffuse_color = vec3(0, 0, 0);
uniform vec3 specular_color = vec3(0, 0, 0);

uniform vec3 model_color = vec3(1.0,1.0,1.0);

// Light settings
uniform vec3 light_color = vec3(1.0, 1.0, 1.0);
uniform vec3 light_position = vec3(0, 0.5, 1);

uniform float light_strength = 1.0;

// Strengths
uniform float ao_strength = 0;
uniform float diffuse_strength = 0;
uniform float specular_strength = 0;
uniform float shininess_amount = 2;

void fragment() {	
	vec3 diffuse_light = diffuse_color * light_strength;
	vec3 ao_light = ao_color * light_strength;	
	vec3 specular_light = specular_color * light_strength;
	
	
	// Calculate AO
	vec3 ambient = ao_light * ao_strength;
	
	// Calculate Diffuse	
	float diffuseStrength = dot(light_position,NORMAL);
	vec3 diffuse = diffuseStrength * diffuse_light;
	
	// Calculate Specular	
	vec3 reflectSource = normalize(reflect(-light_position, NORMAL)); // normalised
	float specularStrength = dot(VIEW, reflectSource);
	specularStrength = pow(specularStrength,shininess_amount); // makes it shiny
	vec3 specular = specularStrength * specular_light;
	
	// Combine all to get final color
    vec3 lighting = (ambient * ao_strength)
	+ (diffuse * diffuse_strength)
	+ (specular * specular_strength);
    
    ALBEDO = model_color * lighting;
}
