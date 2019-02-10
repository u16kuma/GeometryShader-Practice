Shader "Custom/SketchTemplate"
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
			#include "SketchTemplate.hlsl"
			ENDCG
		}
	}
}