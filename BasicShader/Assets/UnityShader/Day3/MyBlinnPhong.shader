Shader "CGM499/Day3/MyBlinnPhong" {
	Properties{
		_Color("Color", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}
		_SpecularPower("Specular Power",Range(0,100)) = 0.5
		_SpecularColor("Specular Color",Color) = (1,1,1,1)
	}
		SubShader{
		Tags{ "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM
		#pragma surface surf MyBlinnPhong


		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		fixed4 _Color;
		fixed _SpecularPower;
		fixed4 _SpecularColor;

		fixed4 LightingMyBlinnPhong(SurfaceOutput s,fixed3 lightDir,half3 viewDir,fixed atten) {

			float3 halfVector = normalize(lightDir + viewDir);
			
			//float diff = max(0, dot(s.Normal, lightDir));

			//float nDotH = max(0,dot(s.Normal, halfVector));

			float diff = saturate(dot(s.Normal, lightDir));

			float nDotH = saturate(dot(s.Normal, halfVector));

			float spec = pow(nDotH, _SpecularPower);

			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb*diff) + 
				(_LightColor0.rgb*_SpecularColor*spec)*(atten * 2);
			c.a = s.Alpha;
			return c;
		}

		void surf(Input IN, inout SurfaceOutput o) {

			half4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;

			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
		}
		FallBack "Diffuse"
}
