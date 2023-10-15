shader_type spatial;

// Vars for wave
uniform float wave_amplitude =  0.0;



// Vars for phong
uniform vec3 ao_color = vec3(0.7, 0.7, 0.7);
uniform vec3 diffuse_color = vec3(1, 1, 1);
uniform vec3 specular_color = vec3(1, 1, 1);

uniform vec3 model_color = vec3(1.0,1.0,1.0);

// Light settings
uniform vec3 light_color = vec3(1.0, 1.0, 1.0);
uniform vec3 light_position = vec3(0, 0.5, 1);

uniform float light_strength = 5;

// Strengths
uniform float ao_strength = 1;
uniform float diffuse_strength = 1;
uniform float specular_strength = 1;
uniform float shininess_amount = 2;

void vertex() {
    float angle = wave_amplitude * length(VERTEX.xz);
    float cosA = cos(angle);
    float sinA = sin(angle);
    float newX = VERTEX.x * cosA - VERTEX.z * sinA;
    float newZ = VERTEX.x * sinA + VERTEX.z * cosA;

    VERTEX.x = newX;
    VERTEX.z = newZ;
}


void fragment() {
    vec3 normalized_light_position = normalize(light_position);
    vec3 normalized_normal = normalize(NORMAL);

    // Calculate AO
    vec3 ambient = ao_color * light_color * ao_strength;

    // Calculate Diffuse	
    float diffuseFactor = max(dot(normalized_light_position, normalized_normal), 0.0);
    vec3 diffuse = diffuse_color * light_color * diffuseFactor;

    // Calculate Specular
    vec3 reflectDir = reflect(-normalized_light_position, normalized_normal);
    float spec = pow(max(dot(VIEW, reflectDir), 0.0), shininess_amount);
    vec3 specular = specular_color * light_color * spec;

    // Combine all to get final color
    vec3 lighting_from_strength = (diffuse * diffuse_strength + specular * specular_strength);
    ALBEDO = model_color * (ambient + light_strength * lighting_from_strength);
}
