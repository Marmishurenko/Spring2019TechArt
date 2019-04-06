// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/FishAnim"
{
	Properties
	{
		_Amp("Amp", Float) = 0
		_AmpOffset("AmpOffset", Float) = 0
		_TimeOffset("TimeOffset", Float) = 0
		_Freq("Freq", Float) = 0
		_PosOffsetScale("PosOffsetScale", Float) = 0
		_PositionalAmpScalar("Positional Amp Scalar", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _Freq;
		uniform float _TimeOffset;
		uniform float _PosOffsetScale;
		uniform float _Amp;
		uniform float _PositionalAmpScalar;
		uniform float _AmpOffset;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 appendResult13 = (float4(( ( sin( ( ( _Freq * _Time.y ) + _TimeOffset + ( ase_vertex3Pos.y * _PosOffsetScale ) ) ) * _Amp * ( ase_vertex3Pos.y * _PositionalAmpScalar ) ) + _AmpOffset ) , 0.0 , 0.0 , 0.0));
			v.vertex.xyz += appendResult13.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
7;44;1906;967;2543.442;260.7467;1.479419;False;True
Node;AmplifyShaderEditor.CommentaryNode;19;-2172.261,-93.99164;Float;False;854.116;771.9102;Adding the scaled offset time value to the vertex's Y pos;4;5;12;17;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2117.684,-43.99156;Float;False;428.8311;371.9731;Scales and offsets time input;4;9;6;8;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-2122.26,344.4696;Float;False;439;309.9999;Scales Vert Y pos;3;15;16;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-2083.522,394.9561;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-2082.477,566.1324;Float;False;Property;_PosOffsetScale;PosOffsetScale;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2034.31,6.008307;Float;False;Property;_Freq;Freq;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2;-2067.682,148.4811;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1282.535,365.967;Float;False;503.1093;303.4244;Uses;2;22;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1840.851,81.63033;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1886.862,217.9814;Float;False;Property;_TimeOffset;TimeOffset;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1826.478,469.1315;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;20;-1267.878,-94.50327;Float;False;648.8218;404.7925;Scaling and offsetting the output;4;7;10;4;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1625.243,145.617;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1232.535,554.3912;Float;False;Property;_PositionalAmpScalar;Positional Amp Scalar;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;5;-1454.151,165.1104;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1196.766,171.1117;Float;False;Property;_Amp;Amp;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-948.4271,415.967;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-1005.008,-35.93908;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-991.488,156.7715;Float;False;Property;_AmpOffset;AmpOffset;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-817.6526,-43.68849;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;-566.674,6.304585;Float;False;217;229;Applying result to X;1;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-516.6747,56.30452;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-264.6638,-19.3426;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Custom/FishAnim;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;8;0
WireConnection;9;1;2;0
WireConnection;15;0;14;2
WireConnection;15;1;16;0
WireConnection;12;0;9;0
WireConnection;12;1;6;0
WireConnection;12;2;15;0
WireConnection;5;0;12;0
WireConnection;22;0;14;2
WireConnection;22;1;23;0
WireConnection;4;0;5;0
WireConnection;4;1;3;0
WireConnection;4;2;22;0
WireConnection;7;0;4;0
WireConnection;7;1;10;0
WireConnection;13;0;7;0
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=59A922282B658E480883E07009FA40AB46D5E3D6