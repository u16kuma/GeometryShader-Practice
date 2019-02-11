Shader "Custom/VertexDot"
{
	Properties
	{
		_DotScale("Dot Scale", Range(0.001, 10)) = 0.01
		_Color("Color", Color) = (1, 1, 1, 1)
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
			#include "VertexDot.hlsl"
			ENDCG
		}
	}
}