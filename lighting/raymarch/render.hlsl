#include "cast.hlsl"
#include "ao.hlsl"
#include "normal.hlsl"
#include "softShadow.hlsl"
#include "material.glsl"

/*
original_author:  Inigo Quiles
description: default raymarching renderer
use: <float4> raymarchDefaultRender( in <float3> ro, in <float3> rd ) 
options:
    - LIGHT_COLOR: float3(0.5, 0.5, 0.5) or u_lightColor in GlslViewer
    - LIGHT_POSITION: float3(0.0, 10.0, -50.0) or u_light in GlslViewer
    - RAYMARCH_BACKGROUND: float3(0.0, 0.0, 0.0)
    - RAYMARCH_AMBIENT: float3(1.0, 1.0, 1.0)
    - RAYMARCH_MATERIAL_FNC(RAY, POSITION, NORMAL, ALBEDO)
*/

#ifndef FNC_RAYMARCHDEFAULT
#define FNC_RAYMARCHDEFAULT

vec4 raymarchDefaultRender( in vec3 ray_origin, in vec3 ray_direction ) { 
    vec3 col = vec3(0.0);
    
    vec4 res = raymarchCast(ray_origin, ray_direction);
    float t = res.a;

    vec3 pos = ray_origin + t * ray_direction;
    vec3 nor = raymarchNormal( pos );
    col = raymarchMaterial(ray_direction, pos, nor, res.rgb);

    return vec4( saturate(col), t );
}


#endif