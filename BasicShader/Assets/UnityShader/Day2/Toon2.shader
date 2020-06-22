Shader "CGM499/Day2/Toon2" {
	Properties{
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_ShadingLevels("Shading Levels",Range(2,10)) = 4
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf Toon 
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		float _ShadingLevels;

	void surf(Input IN, inout SurfaceOutput o) {
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
	}

	half4 LightingToon(SurfaceOutput s, half3 lightDir, half atten) {

		half NdotL = dot(s.Normal, lightDir);
		half shade = floor(NdotL*_ShadingLevels) / (_ShadingLevels*0.5);

		half4 c;
		c.rgb = s.Albedo*_LightColor0.rgb*shade*atten;
		c.a = s.Alpha;

		return c;
	}


	ENDCG
	}
		FallBack "Diffuse"
}
