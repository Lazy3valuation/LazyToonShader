//    Copyright (C) 2023 SenfinecoGames
//    This code has been greatly inspired by NedMakesGames toon shading tutorials, perfectioned for this shader's purpose and turned Forward+ compatible. Thanks, Ned! Check out more at https://twitter.com/NedMakesGames
//    SenfinecoGames twitter: https://twitter.com/senfinecogames


//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.

//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//    GNU General Public License for more details.

//    You should have received a copy of the GNU General Public License
//    along with this program. If not, see <https://www.gnu.org/licenses/>.

#ifndef CUSTOM_LIGHTING_INCLUDED
#define CUSTOM_LIGHTING_INCLUDED


float max3(float a, float b, float c)
{
    return max(a, max(b, c));
}

float GetLightIntensity(float3 color)
{
    return max3(color.r, color.g, color.b);
}



void CalculateMainLight_float(float3 WorldPos, out float3 Direction, out float3 Color, out half DistanceAtten, out half ShadowAtten, out float Intensity)
{
#ifdef SHADERGRAPH_PREVIEW
    Direction = half3(0.5, 0.5, 0);
    Color = 1;
    Intensity = 0;
    DistanceAtten = 1;
    ShadowAtten = 1;
#else
#if SHADOWS_SCREEN
    half4 clipPos = TransformWorldToHClip(WorldPos);
    half4 shadowCoord = ComputeScreenPos(clipPos);
#else
    half4 shadowCoord = TransformWorldToShadowCoord(WorldPos);
#endif
    Light mainLight = GetMainLight(shadowCoord);
    Direction = mainLight.direction;
    Color = mainLight.color;
    DistanceAtten = mainLight.distanceAttenuation;
    ShadowAtten = mainLight.shadowAttenuation;
    Intensity = GetLightIntensity(mainLight.color);
#endif
}


void AddAdditionalLights_float(float Smoothness, float3 WorldPosition, float3 WorldNormal, float3 WorldView,
    float MainDiffuse, float MainSpecular, float3 MainColor, float3 ScreenPosition,
    out float Diffuse, out float Specular, out float3 Color)
{
    float mainIntensity = GetLightIntensity(MainColor);
    Diffuse = 0;
    Specular = 0;
    Color = MainColor;

#ifndef SHADERGRAPH_PREVIEW
    InputData inputData = (InputData) 0;
    SurfaceData surfaceData;
    AmbientOcclusionFactor aoFactor = CreateAmbientOcclusionFactor(inputData, surfaceData);
    half thisSpecular = 0;
    half maxIntensity = 0;
    uint meshRenderingLayers = GetMeshRenderingLayer();

    inputData.normalizedScreenSpaceUV = ScreenPosition;
    inputData.positionWS = WorldPosition;
    uint lightsCount = GetAdditionalLightsCount();
    half4 shadowMask = CalculateShadowMask(inputData);
    uint _AdditionalLightsDirectionalCount = 128;

#if USE_FORWARD_PLUS
    for(uint lightIndex = 0; lightIndex < min(URP_FP_DIRECTIONAL_LIGHTS_COUNT, MAX_VISIBLE_LIGHTS); lightIndex++)
    {
    Light light = GetAdditionalLight(lightIndex, WorldPosition);
        half NdotL = max(0, dot(WorldNormal, light.direction));
        half atten = light.distanceAttenuation * light.shadowAttenuation * GetLightIntensity(light.color);
        half thisDiffuse = atten * NdotL;
        thisSpecular += LightingSpecular(thisDiffuse, light.direction, WorldNormal, WorldView, 1, Smoothness);
        Diffuse += thisDiffuse;

        Color = (thisDiffuse > 0 && GetLightIntensity(light.color) > maxIntensity) ? light.color : Color;
        maxIntensity = (thisDiffuse > 0 && GetLightIntensity(light.color) > maxIntensity) ? GetLightIntensity(light.color) : maxIntensity;
    }
#endif
    
    
    LIGHT_LOOP_BEGIN(lightsCount)

    Light light = GetAdditionalLight(lightIndex, WorldPosition);
    half NdotL = max(0, dot(WorldNormal, light.direction));
    half atten = light.distanceAttenuation * light.shadowAttenuation * GetLightIntensity(light.color);
    half thisDiffuse = atten * NdotL;
    thisSpecular += LightingSpecular(thisDiffuse, light.direction, WorldNormal, WorldView, 1, Smoothness);
    Diffuse += thisDiffuse;

    Color = (thisDiffuse > 0 && GetLightIntensity(light.color) > maxIntensity) ? light.color : Color;
    maxIntensity = (thisDiffuse > 0 && GetLightIntensity(light.color) > maxIntensity) ? GetLightIntensity(light.color) : maxIntensity;
    LIGHT_LOOP_END

    Specular = thisSpecular;
#endif
}
#endif