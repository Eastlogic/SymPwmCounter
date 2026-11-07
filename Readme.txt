

----------------------------------------------------------------------------------------------------------------
Addr_Offset		Register			Fields												| Implementation Status 
----------------------------------------------------------------------------------------------------------------
0x00				CNT_CTRL1		RESERVED[31:1],EN[0]								|	Read/Write 
0x04				CNT_CTRL2		DTR_FIELDS, Other Control Fields				|	Not Implemented
0x08				CNT_PSC			PSC[15:0]											|	Not Implemented
0x0C				CNT_TOP			TOP[31:0]											|	Read (active reg)/Write (shadow reg)
0x10				CNT_STATUS		Status Fields/Flags								|	Not Implemented
0x14				CNT_VAL			CNT_VALUE[31:0]									|	Read-Only

0x18				RESERVED																	|
0x1C				RESERVED																	|
0x20				RESERVED																	|
0x24				RESERVED																	|
0x28				RESERVED																	|
0x2C				RESERVED																	|

0x30				CMPR1				CMPR1_VAL[31:0]									|	Write (shadow reg)
0x34				CMPR2				CMPR2_VAL[31:0]									|	Write (shadow reg)
0x38				CMPR3				CMPR3_VAL[31:0]									|	Write (shadow reg)
0x3C				CMPR4				CMPR4_VAL[31:0]									|	Write (shadow reg)

0x40				CMPR5				CMPR5_VAL[31:0]									|	Write (shadow reg)
0x44				CMPR6				CMPR6_VAL[31:0]									|	Write (shadow reg)
0x48				CMPR7				CMPR7_VAL[31:0]									|	Write (shadow reg)
0x4C				CMPR8				CMPR8_VAL[31:0]									|	Write (shadow reg)

0x50				CMPR9				CMPR9_VAL[31:0]									|	Write (shadow reg)
0x54				CMPR10			CMPR10_VAL[31:0]									|	Write (shadow reg)
0x58				CMPR11			CMPR11_VAL[31:0]									|	Write (shadow reg)
0x5C				CMPR12			CMPR12_VAL[31:0]									|	Write (shadow reg)

0x60				CMPR13			CMPR13_VAL[31:0]									|	Write (shadow reg)
0x64				CMPR14			CMPR14_VAL[31:0]									|	Write (shadow reg)
0x68				CMPR15			CMPR15_VAL[31:0]									|	Write (shadow reg)
0x6C				CMPR16			CMPR16_VAL[31:0]									|	Write (shadow reg)



