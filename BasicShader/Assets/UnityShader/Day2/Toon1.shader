﻿Shader "CGM499/Day2/Toon1" {
	Properties {
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_RampTex("Ramp", 2D) = "white" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Toon 
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _RampTex;

		struct Input {
			float2 uv_MainTex;
		};


		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = tex2D (_MainTex, IN.uv_MainTex) ;
		}

		half4 LightingToon(SurfaceOutput s, half3 lightDir, half atten) {
			
			half NdotL = dot(s.Normal, lightDir);
			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));

			half4 c;
			c.rgb = s.Albedo*_LightColor0.rgb*NdotL*atten;
			c.a = s.Alpha;

			return c;
		}


		ENDCG
	}
	FallBack "Diffuse"
}
