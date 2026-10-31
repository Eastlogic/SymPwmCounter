/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/ARCHIVE/XilinxISE_14_7/SymPwmCounter/SymPwmCounter.vhd";
extern char *IEEE_P_3620187407;

unsigned char ieee_p_3620187407_sub_2546382208_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_2546418145_3965413181(char *, char *, char *, int );
unsigned char ieee_p_3620187407_sub_2546454082_3965413181(char *, char *, char *, int );
char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );
char *ieee_p_3620187407_sub_436351764_3965413181(char *, char *, char *, char *, int );


static void work_a_3592163595_0838582154_p_0(char *t0)
{
    char t13[16];
    char *t1;
    char *t2;
    unsigned char t3;
    unsigned char t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;
    char *t9;
    char *t10;
    unsigned char t11;
    unsigned char t12;
    unsigned int t14;
    unsigned int t15;
    unsigned char t16;
    char *t17;
    char *t18;
    char *t19;
    char *t20;
    int t21;

LAB0:    xsi_set_current_line(34, ng0);
    t1 = (t0 + 1032U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t4 = (t3 == (unsigned char)2);
    if (t4 != 0)
        goto LAB2;

LAB4:    t1 = (t0 + 1152U);
    t4 = xsi_signal_has_event(t1);
    if (t4 == 1)
        goto LAB7;

LAB8:    t3 = (unsigned char)0;

LAB9:    if (t3 != 0)
        goto LAB5;

LAB6:
LAB3:    t1 = (t0 + 3960);
    *((int *)t1) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(35, ng0);
    t1 = xsi_get_transient_memory(4U);
    memset(t1, 0, 4U);
    t5 = t1;
    memset(t5, (unsigned char)2, 4U);
    t6 = (t0 + 4056);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    memcpy(t10, t1, 4U);
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(36, ng0);
    t1 = (t0 + 4120);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast(t1);
    xsi_set_current_line(38, ng0);
    t1 = (t0 + 4184);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(39, ng0);
    t1 = (t0 + 4248);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    goto LAB3;

LAB5:    xsi_set_current_line(44, ng0);
    t2 = (t0 + 4184);
    t6 = (t2 + 56U);
    t7 = *((char **)t6);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    *((unsigned char *)t9) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t2);
    xsi_set_current_line(45, ng0);
    t1 = (t0 + 4248);
    t2 = (t1 + 56U);
    t5 = *((char **)t2);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = (unsigned char)2;
    xsi_driver_first_trans_fast_port(t1);
    xsi_set_current_line(48, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)2);
    if (t11 == 1)
        goto LAB13;

LAB14:    t3 = (unsigned char)0;

LAB15:    if (t3 != 0)
        goto LAB10;

LAB12:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)2);
    if (t11 == 1)
        goto LAB20;

LAB21:    t3 = (unsigned char)0;

LAB22:    if (t3 != 0)
        goto LAB18;

LAB19:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB27;

LAB28:    t3 = (unsigned char)0;

LAB29:    if (t3 != 0)
        goto LAB25;

LAB26:    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB34;

LAB35:    t3 = (unsigned char)0;

LAB36:    if (t3 != 0)
        goto LAB32;

LAB33:
LAB11:    xsi_set_current_line(69, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)2);
    if (t11 == 1)
        goto LAB42;

LAB43:    t3 = (unsigned char)0;

LAB44:    if (t3 != 0)
        goto LAB39;

LAB41:
LAB40:    xsi_set_current_line(73, ng0);
    t1 = (t0 + 1832U);
    t2 = *((char **)t1);
    t4 = *((unsigned char *)t2);
    t11 = (t4 == (unsigned char)3);
    if (t11 == 1)
        goto LAB48;

LAB49:    t3 = (unsigned char)0;

LAB50:    if (t3 != 0)
        goto LAB45;

LAB47:
LAB46:    goto LAB3;

LAB7:    t2 = (t0 + 1192U);
    t5 = *((char **)t2);
    t11 = *((unsigned char *)t5);
    t12 = (t11 == (unsigned char)3);
    t3 = t12;
    goto LAB9;

LAB10:    xsi_set_current_line(49, ng0);
    t6 = (t0 + 1992U);
    t7 = *((char **)t6);
    t6 = (t0 + 6524U);
    t8 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t7, t6, 1);
    t9 = (t13 + 12U);
    t14 = *((unsigned int *)t9);
    t15 = (1U * t14);
    t16 = (4U != t15);
    if (t16 == 1)
        goto LAB16;

LAB17:    t10 = (t0 + 4056);
    t17 = (t10 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t8, 4U);
    xsi_driver_first_trans_fast(t10);
    goto LAB11;

LAB13:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t12 = ieee_p_3620187407_sub_2546382208_3965413181(IEEE_P_3620187407, t5, t1, 15);
    t3 = t12;
    goto LAB15;

LAB16:    xsi_size_not_matching(4U, t15, 0);
    goto LAB17;

LAB18:    xsi_set_current_line(53, ng0);
    t6 = (t0 + 4120);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(54, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 6524U);
    t5 = ieee_p_3620187407_sub_436351764_3965413181(IEEE_P_3620187407, t13, t2, t1, 1);
    t6 = (t13 + 12U);
    t14 = *((unsigned int *)t6);
    t15 = (1U * t14);
    t3 = (4U != t15);
    if (t3 == 1)
        goto LAB23;

LAB24:    t7 = (t0 + 4056);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t17 = *((char **)t10);
    memcpy(t17, t5, 4U);
    xsi_driver_first_trans_fast(t7);
    goto LAB11;

LAB20:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t12 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t5, t1, 15);
    t3 = t12;
    goto LAB22;

LAB23:    xsi_size_not_matching(4U, t15, 0);
    goto LAB24;

LAB25:    xsi_set_current_line(58, ng0);
    t6 = (t0 + 1992U);
    t7 = *((char **)t6);
    t6 = (t0 + 6524U);
    t8 = ieee_p_3620187407_sub_436351764_3965413181(IEEE_P_3620187407, t13, t7, t6, 1);
    t9 = (t13 + 12U);
    t14 = *((unsigned int *)t9);
    t15 = (1U * t14);
    t16 = (4U != t15);
    if (t16 == 1)
        goto LAB30;

LAB31:    t10 = (t0 + 4056);
    t17 = (t10 + 56U);
    t18 = *((char **)t17);
    t19 = (t18 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t8, 4U);
    xsi_driver_first_trans_fast(t10);
    goto LAB11;

LAB27:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t12 = ieee_p_3620187407_sub_2546454082_3965413181(IEEE_P_3620187407, t5, t1, 0);
    t3 = t12;
    goto LAB29;

LAB30:    xsi_size_not_matching(4U, t15, 0);
    goto LAB31;

LAB32:    xsi_set_current_line(62, ng0);
    t6 = (t0 + 4120);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)2;
    xsi_driver_first_trans_fast(t6);
    xsi_set_current_line(63, ng0);
    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 6524U);
    t5 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t13, t2, t1, 1);
    t6 = (t13 + 12U);
    t14 = *((unsigned int *)t6);
    t15 = (1U * t14);
    t3 = (4U != t15);
    if (t3 == 1)
        goto LAB37;

LAB38:    t7 = (t0 + 4056);
    t8 = (t7 + 56U);
    t9 = *((char **)t8);
    t10 = (t9 + 56U);
    t17 = *((char **)t10);
    memcpy(t17, t5, 4U);
    xsi_driver_first_trans_fast(t7);
    goto LAB11;

LAB34:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t12 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t5, t1, 0);
    t3 = t12;
    goto LAB36;

LAB37:    xsi_size_not_matching(4U, t15, 0);
    goto LAB38;

LAB39:    xsi_set_current_line(70, ng0);
    t6 = (t0 + 4184);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t6);
    goto LAB40;

LAB42:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t21 = (15 - 1);
    t12 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t5, t1, t21);
    t3 = t12;
    goto LAB44;

LAB45:    xsi_set_current_line(74, ng0);
    t6 = (t0 + 4248);
    t7 = (t6 + 56U);
    t8 = *((char **)t7);
    t9 = (t8 + 56U);
    t10 = *((char **)t9);
    *((unsigned char *)t10) = (unsigned char)3;
    xsi_driver_first_trans_fast_port(t6);
    goto LAB46;

LAB48:    t1 = (t0 + 1992U);
    t5 = *((char **)t1);
    t1 = (t0 + 6524U);
    t12 = ieee_p_3620187407_sub_2546418145_3965413181(IEEE_P_3620187407, t5, t1, 1);
    t3 = t12;
    goto LAB50;

}

static void work_a_3592163595_0838582154_p_1(char *t0)
{
    char *t1;
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;

LAB0:    xsi_set_current_line(83, ng0);

LAB3:    t1 = (t0 + 1992U);
    t2 = *((char **)t1);
    t1 = (t0 + 4312);
    t3 = (t1 + 56U);
    t4 = *((char **)t3);
    t5 = (t4 + 56U);
    t6 = *((char **)t5);
    memcpy(t6, t2, 4U);
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t7 = (t0 + 3976);
    *((int *)t7) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}


extern void work_a_3592163595_0838582154_init()
{
	static char *pe[] = {(void *)work_a_3592163595_0838582154_p_0,(void *)work_a_3592163595_0838582154_p_1};
	xsi_register_didat("work_a_3592163595_0838582154", "isim/SymPwmCounter_tb_isim_beh.exe.sim/work/a_3592163595_0838582154.didat");
	xsi_register_executes(pe);
}
