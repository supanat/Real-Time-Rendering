Shader "Hidden/MyImageFX1"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_LuminosityAmount("Luminosity",Range(0.0,1.0)) = 1.0
	}
	SubShader
	{

		Pass
		{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragment ARB_precision_hint_fastest
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			fixed _LuminosityAmount;

			fixed4 frag (v2f_img i) : COLOR
			{
				fixed4 renderTex = tex2D(_MainTex,i.uv);

				
				//float luminosity = renderTex

				renderTex.r *= 2;
				renderTex.g *= _LuminosityAmount;

				fixed4 outColor = renderTex;

				return outColor;
			}
			ENDCG
		}
	}
}
