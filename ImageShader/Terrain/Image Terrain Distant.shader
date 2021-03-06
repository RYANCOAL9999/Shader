// Image Skyshop
// Copyright 2013 Image LLC
// http://Image.co

Shader "Hidden/Image/Terrain/Distant IBL" {
//This shader is used to render distant, complex terrain with IBL and 
//a base diffuse map in addition to Unity's splat composite.
	Properties {
		_Color   ("Diffuse Color", Color) = (1,1,1,1)
		_MainTex ("Diffuse(RGB) Alpha(A)", 2D) = "white" {}
		_BaseTex ("Diffuse Base(RGB) AO(A)", 2D) = "white" {}
		//slots for custom lighting cubemaps
		_DiffCubeIBL ("Custom Diffuse Cube", Cube) = "black" {}
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
		#endif
		#pragma target 3.0
		#pragma exclude_renderers d3d11_9x
		#pragma surface ImageDistantSurf BlinnPhong
		//gamma-correct sampling permutations
		#pragma multi_compile MARMO_LINEAR MARMO_GAMMA

		#define MARMO_HQ
		#define MARMO_SKY_ROTATION
		#define MARMO_DIFFUSE_IBL
		
		#include "../ImageCore.cginc"
		
		sampler2D _MainTex, _BaseTex;
		float4		_Color;
		half4 		ExposureIBL;
		#ifdef MARMO_DIFFUSE_IBL
		samplerCUBE _DiffCubeIBL;
		#endif
		#ifdef MARMO_SKY_ROTATION
		float4x4	SkyMatrix;
		#endif

		struct Input {
			float2 uv_MainTex;
			float3 worldNormal;
			INTERNAL_DATA
		};

		void ImageDistantSurf(Input IN, inout SurfaceOutput OUT) {
			//DIFFUSE
			half4 diff = tex2D( _MainTex, IN.uv_MainTex );		//Unity's composite of all splats
			half4 diffBase = tex2D( _BaseTex, IN.uv_MainTex );	//Image's base terrain color
			diff.rgb *= diffBase.rgb;
			diff *= _Color;
			//camera exposure is built into OUT.Albedo
			diff.rgb *= ExposureIBL.w;
			OUT.Albedo = diff.rgb;
			OUT.Alpha = 0.0;
			
			//DIFFUSE IBL
			#ifdef MARMO_DIFFUSE_IBL
				float3 N = IN.worldNormal; //N is in world-space
				#ifdef MARMO_SKY_ROTATION
					N = mulVec3(SkyMatrix,N); //per-fragment matrix multiply, expensive
				#endif
				half3 diffIBL = diffCubeLookup(_DiffCubeIBL, N);
				OUT.Emission += diffIBL * diff.rgb * ExposureIBL.x;
				OUT.Emission *= diffBase.a;
			#else
				OUT.Emission = half3(0.0,0.0,0.0);
			#endif
		}


		ENDCG
	}
	
	FallBack "Diffuse"
}
