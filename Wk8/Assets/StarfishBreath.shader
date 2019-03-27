// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/StarfishBreath"
{
	Properties
	{
		_Amp("Amp", Float) = 0
		_AmpOffset("AmpOffset", Float) = 0
		_TimeOffset("TimeOffset", Float) = 0
		_Freq("Freq", Float) = 0
		_PosOffsetScale("PosOffsetScale", Float) = 0
		_PositionalAmpScalar("Positional Amp Scalar", Float) = 0
		_BreathFreq("BreathFreq", Range( 0 , 1)) = 0
		_BreathAmp("BreathAmp", Float) = 0
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
			float4 vertexColor : COLOR;
		};

		uniform float _BreathFreq;
		uniform float _BreathAmp;
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
			float temp_output_5_0 = sin( ( ( _Freq * _Time.y ) + _TimeOffset + ( ase_vertex3Pos.y * _PosOffsetScale ) ) );
			float temp_output_22_0 = ( ase_vertex3Pos.y * _PositionalAmpScalar );
			float4 appendResult13 = (float4(( ( sin( ( _Time.y * _BreathFreq ) ) * ( ase_vertex3Pos.y * v.color.r ) * _BreathAmp ) + 0.0 ) , ( ( temp_output_5_0 * _Amp * temp_output_22_0 * ( v.color.b * ase_vertex3Pos.y ) ) + _AmpOffset ) , ( ( temp_output_5_0 * _Amp * temp_output_22_0 * ( v.color.g * ase_vertex3Pos.y ) ) + _AmpOffset ) , 0.0));
			v.vertex.xyz += appendResult13.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = i.vertexColor.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
7;7;1906;1004;2490.644;571.4343;1.651886;True;True
Node;AmplifyShaderEditor.CommentaryNode;19;-2562.42,-367.2823;Float;False;854.116;771.9102;Adding the scaled offset time value to the vertex's Y pos;5;5;12;17;18;15;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-2507.844,-317.2823;Float;False;428.8311;371.9731;Scales and offsets time input;4;9;6;8;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-2512.419,71.17854;Float;False;439;309.9999;Scales Vert Y pos;2;16;14;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;2;-2457.843,-124.8097;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-2424.47,-267.2826;Float;False;Property;_Freq;Freq;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;41;-3140.814,562.2015;Float;False;685.4246;334.2174;Breathing;4;40;38;37;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-2473.681,121.6648;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-2472.637,292.841;Float;False;Property;_PosOffsetScale;PosOffsetScale;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2071.206,261.9916;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;37;-3048.96,612.2012;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-3090.814,781.4185;Float;False;Property;_BreathFreq;BreathFreq;6;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;-1838.128,261.0035;Float;False;503.1093;303.4244;Uses distance from origin as scalar multiplier for amp;2;22;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-2277.025,-55.30915;Float;False;Property;_TimeOffset;TimeOffset;2;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2231.016,-191.6605;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1788.128,449.4284;Float;False;Property;_PositionalAmpScalar;Positional Amp Scalar;5;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;25;-2294.88,961.8826;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;12;-1990.258,-123.2355;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;20;-1099.928,306.1736;Float;False;648.8218;404.7925;Scaling and offsetting the output;4;7;10;4;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;40;-2805.147,667.7454;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;44;-1059.242,1467.621;Float;False;Property;_BreathAmp;BreathAmp;7;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;5;-1841.356,-108.1803;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;35;-2598.295,700.3337;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;42;-1614.618,1198.282;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;30;-1586.537,895.0763;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1028.815,571.7888;Float;False;Property;_Amp;Amp;0;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1504.02,311.0034;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1761.897,650.2077;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-837.0564,364.7381;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-774.7542,875.6139;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-823.5361,557.4484;Float;False;Property;_AmpOffset;AmpOffset;1;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-896.5723,1237.018;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;-363.4188,45.27705;Float;False;217;229;Applying result to X;1;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;7;-649.7014,356.9886;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;34;-604.0884,867.8643;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;45;-618.8284,1235.123;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;-313.4193,95.27699;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.VertexColorNode;29;-433.8142,-378.2959;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-76.07124,-24.34948;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Custom/StarfishBreath;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;14;2
WireConnection;15;1;16;0
WireConnection;9;0;8;0
WireConnection;9;1;2;0
WireConnection;12;0;9;0
WireConnection;12;1;6;0
WireConnection;12;2;15;0
WireConnection;40;0;37;0
WireConnection;40;1;38;0
WireConnection;5;0;12;0
WireConnection;35;0;40;0
WireConnection;42;0;14;2
WireConnection;42;1;25;1
WireConnection;30;0;25;2
WireConnection;30;1;14;2
WireConnection;22;0;14;2
WireConnection;22;1;23;0
WireConnection;26;0;25;3
WireConnection;26;1;14;2
WireConnection;4;0;5;0
WireConnection;4;1;3;0
WireConnection;4;2;22;0
WireConnection;4;3;26;0
WireConnection;32;0;5;0
WireConnection;32;1;3;0
WireConnection;32;2;22;0
WireConnection;32;3;30;0
WireConnection;43;0;35;0
WireConnection;43;1;42;0
WireConnection;43;2;44;0
WireConnection;7;0;4;0
WireConnection;7;1;10;0
WireConnection;34;0;32;0
WireConnection;34;1;10;0
WireConnection;45;0;43;0
WireConnection;13;0;45;0
WireConnection;13;1;7;0
WireConnection;13;2;34;0
WireConnection;0;0;29;0
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=D79FA276F4E0062478CA99484439BB1C819C81D7