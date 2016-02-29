Shader "Image/Mobile/Occlusion/Diffuse IBL" {
	Properties {
		_Color   ("Diffuse Color", Color) = (1,1,1,1)
		_OccStrength("Occlusion Strength", Range(0.0,1.0)) = 1.0
		_MainTex ("Diffuse(RGB) Alpha(A)", 2D) = "white" {}
		_OccTex	 ("Occlusion Diff(R) Spec(G)", 2D) = "white" {}
		
		//slots for custom lighting cubemaps
		_DiffCubeIBL ("Custom Diffuse Cube", Cube) = "black" {}
		_SpecCubeIBL ("Custom Specular Cube", Cube) = "black" {}
	}
	
	SubShader {
		Tags {
			"Queue"="Geometry"
			"RenderType"="Opaque"
		}
		LOD 200
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
		#pragma surface ImageSurf ImageDirect exclude_path:prepass noforwardadd approxview vertex:ImageVert
		#define MARMO_GAMMA
		
		
		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		//#define MARMO_SPECULAR_IBL
		#define MARMO_DIFFUSE_DIRECT
		//#define MARMO_SPECULAR_DIRECT
		//#define MARMO_NORMALMAP
		//#define MARMO_MIP_GLOSS 
		//#define MARMO_GLOW
		//#define MARMO_PREMULT_ALPHA
		#define MARMO_OCCLUSION

		#include "../../ImageMobile.cginc"
		#include "../../ImageInput.cginc"
		#include "../../ImageCore.cginc"
		#include "../../ImageDirect.cginc"
		#include "../../ImageSurf.cginc"

		ENDCG
	}
	
	FallBack "Image/Mobile/Diffuse IBL"
}
