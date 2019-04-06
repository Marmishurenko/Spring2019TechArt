// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "StripedBee"
{
	Properties
	{
		_Float0("Float 0", Float) = 20
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float _Float0;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float4 transform14 = mul(unity_WorldToObject,float4( ase_worldPos , 0.0 ));
			float4 color9 = IsGammaSpace() ? float4(1,0.5567206,0,0) : float4(1,0.270347,0,0);
			o.Albedo = ( sin( ( transform14.y * _Float0 ) ) * color9 ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
-130;641;1906;976;1454.884;412.7844;1.362942;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;7;-934.116,-380.007;Float;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;4;-791,-52;Float;False;Property;_Float0;Float 0;0;0;Create;True;0;0;False;0;20;34;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldToObjectTransfNode;14;-693.5528,-313.2505;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-508,-43;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;9;-404,249;Float;False;Constant;_Color0;Color 0;1;0;Create;True;0;0;False;0;1,0.5567206,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;5;-348,-295;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;10;-112,-16;Float;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;287,-272;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;StripedBee;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;14;0;7;0
WireConnection;6;0;14;2
WireConnection;6;1;4;0
WireConnection;5;0;6;0
WireConnection;10;0;5;0
WireConnection;10;1;9;0
WireConnection;0;0;10;0
ASEEND*/
//CHKSM=38AAD1B2F63B673F72448DA8E16FEA89FE242E79