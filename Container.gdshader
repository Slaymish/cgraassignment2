shader_type spatial;

// User-defined sliders as uniforms
uniform float ao_slider : hint_range(0, 1);
uniform float diffuse_slider : hint_range(0, 1);
uniform float specular_slider : hint_range(0, 10);
uniform float shininess_slider : hint_range(0, 100);

uniform vec3 light_color;

// Light settings
uniform vec3 light_position;
uniform vec3 light_intensity;

// Uniforms for controlling the wave
uniform float wave_frequency : hint_range(0.0, 10.0) = 1.0;
uniform float wave_amplitude : hint_range(0.0, 2.0) = 0.1;
uniform float wave_speed : hint_range(0.0, 2.0) = 0.5;

void vertex() {
    // Calculate the wave function based on vertex y-coordinate, time, and frequency
    float wave = wave_amplitude * sin(wave_frequency * VERTEX.y + TIME * wave_speed);
    
    // Extract the horizontal components of the normal
    vec3 horizontal_normal = NORMAL;
    horizontal_normal.y = 0.0;  // Remove the vertical component
    
    // Apply the wave offset along the horizontal components of the normal vector
    VERTEX += horizontal_normal * wave;
}

void fragment() {
    vec3 hitPoint = FRAGCOORD.xyz;
    vec3 hitNormal = NORMAL;
    vec3 dir = normalize(hitPoint - VIEW_MATRIX[3].xyz); // From hit point to camera

    // Phong components
    vec3 ambient = vec3(0.0);
    vec3 diffuse = vec3(0.0);
    vec3 specular = vec3(0.0);

    // Light calculations
    vec3 lightDir = normalize(light_position - hitPoint);
    float vis = 1.0; // Visibility, implement your logic here if needed
    vec3 lightIntensity = light_color;

    // Compute the ambient component
    ambient = ao_slider * light_color;  // Assuming white ambient light for now
    
    // Compute the diffuse component
    diffuse = diffuse_slider * lightIntensity * max(0.0, dot(hitNormal, -lightDir));

    // Compute the specular component
    vec3 R = reflect(-lightDir, hitNormal);
    specular = specular_slider * lightIntensity * pow(max(0.0, dot(R, -dir)), shininess_slider);

    // Combine all to get final color
    vec3 hitColor = ambient + diffuse + specular;
    
    ALBEDO = hitColor;
}
