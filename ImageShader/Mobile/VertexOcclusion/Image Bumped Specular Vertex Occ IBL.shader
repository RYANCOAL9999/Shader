Shader "Image/Mobile/Vertex Occlusion/Bumped Specular IBL" {
	Properties {
		_Color   ("Diffuse Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,1)
		_SpecInt ("Specular Intensity", Float) = 1.0
		_Shininess ("Specular Sharpness", Range(2.0,8.0)) = 4.0
		_Fresnel ("Fresnel Strength", Range(0.0,1.0)) = 0.0
		_OccStrength("Occlusion Strength", Range(0.0,1.0)) = 1.0
		_MainTex ("Diffuse(RGB) Alpha(A)", 2D) = "white" {}
		_SpecTex ("Specular(RGB) Gloss(A)", 2D) = "white" {}
		_BumpMap ("Normalmap", 2D) 	= "bump" {}
		
		//slots for custom lighting cubemaps
		_DiffCubeIBL ("Custom Diffuse Cube", Cube) = "black" {}
		_SpecCubeIBL ("Custom Specular Cube", Cube) = "black" {}
	}
	
	SubShader {
		Tags {
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}
		LOD 400
		//diffuse LOD 200
		//diffuse-spec LOD 250
		//bumped-diffuse, spec 350
		//bumped-spec 400
		
		//mac stuff
		CGPROGRAM
		#ifdef SHADER_API_OPENGL
			#pragma glsl
		#endif
		
		#pragma debug
				
		#pragma target 3.0
		#pragma exclude_renderers d3d11_9x
		#pragma surface ImageSurf ImageDirect fullforwardshadows vertex:ImageVert approxview
		#define MARMO_GAMMA
		
		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		#define MARMO_SPECULAR_IBL
		#define MARMO_DIFFUSE_DIRECT
		#define MARMO_SPECULAR_DIRECT
		#define MARMO_NORMALMAP
		#define MARMO_MIP_GLOSS
		//#define MARMO_GLOW
		//#define MARMO_PREMULT_ALPHA
		//#define MARMO_OCCLUSION
		//#define MARMO_VERTEX_COLOR
		#define MARMO_VERTEX_OCCLUSION
			
		#include "../../ImageMobile.cginc"			
		#include "../../ImageInput.cginc"
		#include "../../ImageCore.cginc"
		#include "../../ImageDirect.cginc"
		#include "../../ImageSurf.cginc"


		ENDCG
	}
	SubShader {
		Tags {
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}
		LOD 400
		//diffuse LOD 200
		//diffuse-spec LOD 250
		//bumped-diffuse, spec 350
		//bumped-spec 400
		
		//mac stuff
		CGPROGRAM
		#ifdef SHADER_API_OPENGL
			#pragma glsl
		#endif
		
		#pragma debug
				
		#pragma target 3.0
		#pragma exclude_renderers d3d11_9x
		#pragma surface ImageSurf ImageDirect fullforwardshadows vertex:ImageVert approxview
		#define MARMO_GAMMA
		
		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		#define MARMO_SPECULAR_IBL
		#define MARMO_DIFFUSE_DIRECT
		#define MARMO_SPECULAR_DIRECT
		#define MARMO_NORMALMAP
		//#define MARMO_MIP_GLOSS
		//#define MARMO_GLOW
		//#define MARMO_PREMULT_ALPHA
		//#define MARMO_OCCLUSION
		//#define MARMO_VERTEX_COLOR
		#define MARMO_VERTEX_OCCLUSION
			
		#include "../../ImageMobile.cginc"			
		#include "../../ImageInput.cginc"
		#include "../../ImageCore.cginc"
		#include "../../ImageDirect.cginc"
		#include "../../ImageSurf.cginc"


		ENDCG
	}
	FallBack "Image/Bumped Specular IBL"
}
