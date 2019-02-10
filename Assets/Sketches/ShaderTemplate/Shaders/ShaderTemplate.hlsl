#include "UnityCG.cginc"

struct Attributes
{
    float4 position : POSITION;
    half3 normal : NORMAL;
};

struct Varyings
{
    float4 position : SV_POSITION;
    half3 normal : NORMAL;
};

Varyings MakeVaryings(float4 position, half3 normal)
{
    Varyings output;
    output.position = position;
    output.normal = normal;
    return output;
}

void vert(inout Attributes input)
{
}

[maxvertexcount(3)]
void geom(
    uint primitiveID : SV_PrimitiveID,
	uint instanceID : SV_GSInstanceID,
	triangle Attributes input[3],
	inout TriangleStream<Varyings> outStream)
{
    float3 edge1 = (input[1].position.xyz - input[0].position.xyz);
    float3 edge2 = (input[2].position.xyz - input[0].position.xyz);
    float3 nor = normalize(cross(edge1, edge2));

    for (int i = 0; i < 3; i++)
    {
        Attributes v = input[i];
        float4 pos = UnityObjectToClipPos(v.position);
        outStream.Append(MakeVaryings(pos, nor));
    }
    outStream.RestartStrip();
}

half4 frag(Varyings input) : SV_Target
{
    return half4(input.normal, 1);
}