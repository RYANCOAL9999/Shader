Shader "Image/Mobile/Specular IBL" {
	Properties {
		_Color   ("Diffuse Color", Color) = (1,1,1,1)
		_SpecColor ("Specular Color", Color) = (1,1,1,1)
		_SpecInt ("Specular Intensity", Float) = 1.0
		_Shininess ("Specular Sharpness", Range(2.0,8.0)) = 4.0
		_Fresnel ("Fresnel Strength", Range(0.0,1.0)) = 0.0
		_MainTex ("Diffuse(RGB) Alpha(A)", 2D) = "white" {}
		_SpecTex ("Specular(RGB) Gloss(A)", 2D) = "white" {}
		//slots for custom lighting cubemaps
		_DiffCubeIBL ("Custom Diffuse Cube", Cube) = "black" {}
		_SpecCubeIBL ("Custom Specular Cube", Cube) = "black" {}
	}
	
	SubShader {
		Tags {
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}
		LOD 250
		//diffuse LOD 200
		//diffuse-spec LOD 250
		//bumped-diffuse, spec 350
		//bumped-spec 400
		
		//mac stuff
		CGPROGRAM
		#ifdef SHADER_API_OPENGL	
			#pragma glsl
			#pragma glsl_no_auto_normalization 
		#endif
		#pragma target 3.0
		#pragma surface ImageSurf ImageDirect exclude_path:prepass noforwardadd approxview
		#define MARMO_GAMMA
		
		
		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		#define MARMO_SPECULAR_IBL
		#define MARMO_DIFFUSE_DIRECT
		#define MARMO_SPECULAR_DIRECT
		//#define MARMO_NORMALMAP
		#define MARMO_MIP_GLOSS
		
		//#define MARMO_GLOW
		//#define MARMO_PREMULT_ALPHA
		
		#include "../ImageMobile.cginc"
		#include "../ImageInput.cginc"
		#include "../ImageCore.cginc"
		#include "../ImageDirect.cginc"
		#include "../ImageSurf.cginc"

		ENDCG
	}
	//no mip-gloss fallback
	SubShader {
		Tags {
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}
		LOD 250
		//diffuse LOD 200
		//diffuse-spec LOD 250
		//bumped-diffuse, spec 350
		//bumped-spec 400
		
		//mac stuff
		CGPROGRAM
		#ifdef SHADER_API_OPENGL	
			#pragma glsl
			#pragma glsl_no_auto_normalization 
		#endif
		#pragma target 3.0
		#pragma surface ImageSurf ImageDirect exclude_path:prepass noforwardadd approxview
		#define MARMO_GAMMA
		
		
		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		#define MARMO_SPECULAR_IBL
		#define MARMO_DIFFUSE_DIRECT
		#define MARMO_SPECULAR_DIRECT
		//#define MARMO_NORMALMAP
		//#define MARMO_MIP_GLOSS
		
		//#define MARMO_GLOW
		//#define MARMO_PREMULT_ALPHA
		
		#include "../ImageMobile.cginc"
		#include "../ImageInput.cginc"
		#include "../ImageCore.cginc"
		#include "../ImageDirect.cginc"
		#include "../ImageSurf.cginc"

		ENDCG
	}
	FallBack "Specular"
}
