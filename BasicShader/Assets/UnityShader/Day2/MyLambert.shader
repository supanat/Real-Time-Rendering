﻿Shader "CGM499/Day2/MyLambert" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf MyLambert

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput o) {

			o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
		}

		half4 LightingMyLambert(SurfaceOutput s,half3 lightDir,half atten){

			half NdotL = dot(s.Normal, lightDir);
			half4 c;
			c.rgb = s.Albedo*_LightColor0.rgb*NdotL*atten;
			c.a = s.Alpha;

			return c;
		}


		ENDCG
	}
	FallBack "Diffuse"
}
