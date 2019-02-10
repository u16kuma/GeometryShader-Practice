Shader "Custom/ShaderTemplate"
{
	Properties
	{
	}
	SubShader
	{
		Tags { "RenderType" = "Opaque" }

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma geometry geom
			#include "ShaderTemplate.hlsl"
			ENDCG
		}
	}
}