# cython: language_level=3, boundscheck=False, wraparound=False

cdef extern from "_parse_records.h":
    ctypedef enum stdf_dtc_Vn_type:
        STDF_GDR_B0 = 0
        STDF_GDR_U1 = 1
        STDF_GDR_U2 = 2
        STDF_GDR_U4 = 3
        STDF_GDR_I1 = 4
        STDF_GDR_I2 = 5
        STDF_GDR_I4 = 6
        STDF_GDR_R4 = 7
        STDF_GDR_R8 = 8
        STDF_GDR_Cn = 10
        STDF_GDR_Bn = 11
        STDF_GDR_Dn = 12
        STDF_GDR_N1 = 13

    ctypedef signed char int8_t
    ctypedef unsigned char uint8_t
    ctypedef short int16_t
    ctypedef unsigned short uint16_t
    ctypedef int int32_t
    ctypedef unsigned uint32_t
    ctypedef char* stdf_dtc_Cn
    ctypedef char stdf_dtc_C1
    ctypedef uint8_t stdf_dtc_U1
    ctypedef uint16_t stdf_dtc_U2
    ctypedef uint32_t stdf_dtc_U4
    ctypedef int8_t stdf_dtc_I1
    ctypedef int16_t stdf_dtc_I2
    ctypedef int32_t stdf_dtc_I4
    ctypedef float stdf_dtc_R4
    ctypedef double stdf_dtc_R8
    ctypedef unsigned char* stdf_dtc_Bn
    ctypedef unsigned char stdf_dtc_B1
    ctypedef unsigned char* stdf_dtc_Dn
    ctypedef unsigned char stdf_dtc_N1
    ctypedef stdf_dtc_Cn* stdf_dtc_xCn
    ctypedef stdf_dtc_U1* stdf_dtc_xU1
    ctypedef stdf_dtc_U2* stdf_dtc_xU2
    ctypedef stdf_dtc_R4* stdf_dtc_xR4
    ctypedef stdf_dtc_N1* stdf_dtc_xN1
    ctypedef struct stdf_dtc_Vn_ele:
        stdf_dtc_Vn_type type
        void *data
    ctypedef stdf_dtc_Vn_ele* stdf_dtc_Vn
    ctypedef enum stdf_rec_typ:
        STDF_REC_TYP_INFO = 0
        STDF_REC_TYP_PER_LOT = 1
        STDF_REC_TYP_PER_WAFER = 2
        STDF_REC_TYP_PER_PART = 5
        STDF_REC_TYP_PER_TEST = 10
        STDF_REC_TYP_PER_EXEC = 15
        STDF_REC_TYP_PER_PROG = 20
        STDF_REC_TYP_PER_SITE = 25
        STDF_REC_TYP_GENERIC = 50
        STDF_REC_TYP_RESV_IMAGE = 180
        STDF_REC_TYP_RESV_IG900 = 181
        STDF_REC_TYP_UNKNOWN = 0xFF
    ctypedef enum stdf_rec_sub:
        STDF_REC_SUB_FAR = 10
        STDF_REC_SUB_ATR = 20
        STDF_REC_SUB_MIR = 10
        STDF_REC_SUB_MRR = 20
        STDF_REC_SUB_PCR = 30
        STDF_REC_SUB_HBR = 40
        STDF_REC_SUB_SBR = 50
        STDF_REC_SUB_PMR = 60
        STDF_REC_SUB_PGR = 62
        STDF_REC_SUB_PLR = 63
        STDF_REC_SUB_RDR = 70
        STDF_REC_SUB_SDR = 80
        STDF_REC_SUB_WIR = 10
        STDF_REC_SUB_WRR = 20
        STDF_REC_SUB_WCR = 30
        STDF_REC_SUB_PIR = 10
        STDF_REC_SUB_PRR = 20
        STDF_REC_SUB_TSR = 30
        STDF_REC_SUB_PTR = 10
        STDF_REC_SUB_MPR = 15
        STDF_REC_SUB_FTR = 20
        STDF_REC_SUB_BPS = 10
        STDF_REC_SUB_EPS = 20
        STDF_REC_SUB_GDR = 10
        STDF_REC_SUB_DTR = 30
        STDF_REC_SUB_UNKNOWN = 0xFF
    ctypedef enum stdf_rec_state:
        STDF_REC_STATE_RAW
        STDF_REC_STATE_PARSED
    ctypedef struct stdf_rec_header:
        stdf_rec_state state
        stdf_dtc_U2 REC_LEN
        stdf_rec_typ REC_TYP
        stdf_rec_sub REC_SUB
    ctypedef struct stdf_rec_unknown:
        stdf_rec_header header
        void *data
    ctypedef struct stdf_rec_far:
        stdf_dtc_U1 CPU_TYPE
        stdf_dtc_U1 STDF_VER
    ctypedef struct stdf_rec_atr:
        stdf_dtc_U4 MOD_TIM
        stdf_dtc_Cn CMD_LINE
    ctypedef struct stdf_rec_mir:
        stdf_dtc_U4 SETUP_T
        stdf_dtc_U4 START_T
        stdf_dtc_U1 STAT_NUM
        stdf_dtc_C1 MODE_COD
        stdf_dtc_C1 RTST_COD
        stdf_dtc_C1 PROT_COD
        stdf_dtc_U2 BURN_TIM
        stdf_dtc_C1 CMOD_COD
        stdf_dtc_Cn LOT_ID
        stdf_dtc_Cn PART_TYP
        stdf_dtc_Cn NODE_NAM
        stdf_dtc_Cn TSTR_TYP
        stdf_dtc_Cn JOB_NAM
        stdf_dtc_Cn JOB_REV
        stdf_dtc_Cn SBLOT_ID
        stdf_dtc_Cn OPER_NAM
        stdf_dtc_Cn EXEC_TYP
        stdf_dtc_Cn EXEC_VER
        stdf_dtc_Cn TEST_COD
        stdf_dtc_Cn TST_TEMP
        stdf_dtc_Cn USER_TXT
        stdf_dtc_Cn AUX_FILE
        stdf_dtc_Cn PKG_TYP
        stdf_dtc_Cn FAMILY_ID
        stdf_dtc_Cn DATE_COD
        stdf_dtc_Cn FACIL_ID
        stdf_dtc_Cn FLOOR_ID
        stdf_dtc_Cn PROC_ID
        stdf_dtc_Cn OPER_FRQ
        stdf_dtc_Cn SPEC_NAM
        stdf_dtc_Cn SPEC_VER
        stdf_dtc_Cn FLOW_ID
        stdf_dtc_Cn SETUP_ID
        stdf_dtc_Cn DSGN_REV
        stdf_dtc_Cn ENG_ID
        stdf_dtc_Cn ROM_COD
        stdf_dtc_Cn SERL_NUM
        stdf_dtc_Cn SUPR_NAM
    ctypedef struct stdf_rec_mrr:
        stdf_dtc_U4 FINISH_T
        stdf_dtc_C1 DISP_COD
        stdf_dtc_Cn USR_DESC
        stdf_dtc_Cn EXC_DESC
    ctypedef struct stdf_rec_pcr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_U4 PART_CNT
        stdf_dtc_U4 RTST_CNT
        stdf_dtc_U4 ABRT_CNT
        stdf_dtc_U4 GOOD_CNT
        stdf_dtc_U4 FUNC_CNT
    ctypedef struct stdf_rec_hbr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_U2 HBIN_NUM
        stdf_dtc_U4 HBIN_CNT
        stdf_dtc_C1 HBIN_PF
        stdf_dtc_Cn HBIN_NAM
    ctypedef struct stdf_rec_sbr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_U2 SBIN_NUM
        stdf_dtc_U4 SBIN_CNT
        stdf_dtc_C1 SBIN_PF
        stdf_dtc_Cn SBIN_NAM
    ctypedef struct stdf_rec_pmr:
        stdf_dtc_U2 PMR_INDX
        stdf_dtc_U2 CHAN_TYP
        stdf_dtc_Cn CHAN_NAM
        stdf_dtc_Cn PHY_NAM
        stdf_dtc_Cn LOG_NAM
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
    ctypedef struct stdf_rec_pgr:
        stdf_dtc_U2 GRP_INDX
        stdf_dtc_Cn GRP_NAM
        stdf_dtc_U2 INDX_CNT
        # stdf_dtc_xU2 PMR_INDX
    ctypedef struct stdf_rec_plr:
        stdf_dtc_U2 GRP_CNT
        # stdf_dtc_xU2 GRP_INDX
        # stdf_dtc_xU2 GRP_MODE
        # stdf_dtc_xU1 GRP_RADX
        # stdf_dtc_xCn PGM_CHAR
        # stdf_dtc_xCn RTN_CHAR
        # stdf_dtc_xCn PGM_CHAL
        # stdf_dtc_xCn RTN_CHAL
    ctypedef struct stdf_rec_rdr:
        stdf_dtc_U2 NUM_BINS
        # stdf_dtc_xU2 RTST_BIN
    ctypedef struct stdf_rec_sdr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_GRP
        stdf_dtc_U1 SITE_CNT
        # stdf_dtc_xU1 SITE_NUM
        stdf_dtc_Cn HAND_TYP
        stdf_dtc_Cn HAND_ID
        stdf_dtc_Cn CARD_TYP
        stdf_dtc_Cn CARD_ID
        stdf_dtc_Cn LOAD_TYP
        stdf_dtc_Cn LOAD_ID
        stdf_dtc_Cn DIB_TYP
        stdf_dtc_Cn DIB_ID
        stdf_dtc_Cn CABL_TYP
        stdf_dtc_Cn CABL_ID
        stdf_dtc_Cn CONT_TYP
        stdf_dtc_Cn CONT_ID
        stdf_dtc_Cn LASR_TYP
        stdf_dtc_Cn LASR_ID
        stdf_dtc_Cn EXTR_TYP
        stdf_dtc_Cn EXTR_ID
    ctypedef struct stdf_rec_wir:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_GRP
        stdf_dtc_U4 START_T
        stdf_dtc_Cn WAFER_ID
    ctypedef struct stdf_rec_wrr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_GRP
        stdf_dtc_U4 FINISH_T
        stdf_dtc_U4 PART_CNT
        stdf_dtc_U4 RTST_CNT
        stdf_dtc_U4 ABRT_CNT
        stdf_dtc_U4 GOOD_CNT
        stdf_dtc_U4 FUNC_CNT
        stdf_dtc_Cn WAFER_ID
        stdf_dtc_Cn FABWF_ID
        stdf_dtc_Cn FRAME_ID
        stdf_dtc_Cn MASK_ID
        stdf_dtc_Cn USR_DESC
        stdf_dtc_Cn EXC_DESC
    ctypedef struct stdf_rec_wcr:
        stdf_dtc_R4 WAFR_SIZ
        stdf_dtc_R4 DIE_HT
        stdf_dtc_R4 DIE_WID
        stdf_dtc_U1 WF_UNITS
        stdf_dtc_C1 WF_FLAT
        stdf_dtc_I2 CENTER_X
        stdf_dtc_I2 CENTER_Y
        stdf_dtc_C1 POS_X
        stdf_dtc_C1 POS_Y
    ctypedef struct stdf_rec_pir:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
    ctypedef struct stdf_rec_prr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_B1 PART_FLG
        stdf_dtc_U2 NUM_TEST
        stdf_dtc_U2 HARD_BIN
        stdf_dtc_U2 SOFT_BIN
        stdf_dtc_I2 X_COORD
        stdf_dtc_I2 Y_COORD
        stdf_dtc_U4 TEST_T
        stdf_dtc_Cn PART_ID
        stdf_dtc_Cn PART_TXT
        stdf_dtc_Bn PART_FIX
    ctypedef struct stdf_rec_tsr:
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_C1 TEST_TYP
        stdf_dtc_U4 TEST_NUM
        stdf_dtc_U4 EXEC_CNT
        stdf_dtc_U4 FAIL_CNT
        stdf_dtc_U4 ALRM_CNT
        stdf_dtc_Cn TEST_NAM
        stdf_dtc_Cn SEQ_NAME
        stdf_dtc_Cn TEST_LBL
        stdf_dtc_B1 OPT_FLAG
        stdf_dtc_R4 TEST_TIM
        stdf_dtc_R4 TEST_MIN
        stdf_dtc_R4 TEST_MAX
        stdf_dtc_R4 TST_SUMS
        stdf_dtc_R4 TST_SQRS
    ctypedef struct stdf_rec_ptr:
        stdf_dtc_U4 TEST_NUM
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_B1 TEST_FLG
        stdf_dtc_B1 PARM_FLG
        stdf_dtc_R4 RESULT
        stdf_dtc_Cn TEST_TXT
        stdf_dtc_Cn ALARM_ID
        stdf_dtc_B1 OPT_FLAG
        stdf_dtc_I1 RES_SCAL
        stdf_dtc_I1 LLM_SCAL
        stdf_dtc_I1 HLM_SCAL
        stdf_dtc_R4 LO_LIMIT
        stdf_dtc_R4 HI_LIMIT
        stdf_dtc_Cn UNITS
        stdf_dtc_Cn C_RESFMT
        stdf_dtc_Cn C_LLMFMT
        stdf_dtc_Cn C_HLMFMT
        stdf_dtc_R4 LO_SPEC
        stdf_dtc_R4 HI_SPEC
    ctypedef struct stdf_rec_mpr:
        stdf_dtc_U4 TEST_NUM
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_B1 TEST_FLG
        stdf_dtc_B1 PARM_FLG
        stdf_dtc_U2 RTN_ICNT
        stdf_dtc_U2 RSLT_CNT
        stdf_dtc_xN1 RTN_STAT
        # stdf_dtc_xR4 RTN_RSLT
        stdf_dtc_Cn TEST_TXT
        stdf_dtc_Cn ALARM_ID
        stdf_dtc_B1 OPT_FLAG
        stdf_dtc_I1 RES_SCAL
        stdf_dtc_I1 LLM_SCAL
        stdf_dtc_I1 HLM_SCAL
        stdf_dtc_R4 LO_LIMIT
        stdf_dtc_R4 HI_LIMIT
        stdf_dtc_R4 START_IN
        stdf_dtc_R4 INCR_IN
        # stdf_dtc_xU2 RTN_INDX
        stdf_dtc_Cn UNITS
        stdf_dtc_Cn UNITS_IN
        stdf_dtc_Cn C_RESFMT
        stdf_dtc_Cn C_LLMFMT
        stdf_dtc_Cn C_HLMFMT
        stdf_dtc_R4 LO_SPEC
        stdf_dtc_R4 HI_SPEC
    ctypedef struct stdf_rec_ftr:
        stdf_dtc_U4 TEST_NUM
        stdf_dtc_U1 HEAD_NUM
        stdf_dtc_U1 SITE_NUM
        stdf_dtc_B1 TEST_FLG
        stdf_dtc_B1 OPT_FLAG
        stdf_dtc_U4 CYCL_CNT
        stdf_dtc_U4 REL_VADR
        stdf_dtc_U4 REPT_CNT
        stdf_dtc_U4 NUM_FAIL
        stdf_dtc_I4 XFAIL_AD
        stdf_dtc_I4 YFAIL_AD
        stdf_dtc_I2 VECT_OFF
        stdf_dtc_U2 RTN_ICNT
        stdf_dtc_U2 PGM_ICNT
        # stdf_dtc_xU2 RTN_INDX
        stdf_dtc_xN1 RTN_STAT
        # stdf_dtc_xU2 PGM_INDX
        stdf_dtc_xN1 PGM_STAT
        stdf_dtc_Dn FAIL_PIN
        stdf_dtc_Cn VECT_NAM
        stdf_dtc_Cn TIME_SET
        stdf_dtc_Cn OP_CODE
        stdf_dtc_Cn TEST_TXT
        stdf_dtc_Cn ALARM_ID
        stdf_dtc_Cn PROG_TXT
        stdf_dtc_Cn RSLT_TXT
        stdf_dtc_U1 PATG_NUM
        stdf_dtc_Dn SPIN_MAP
    ctypedef struct stdf_rec_bps:
        stdf_dtc_Cn SEQ_NAME
    ctypedef struct stdf_rec_eps:
        pass
    ctypedef struct stdf_rec_gdr:
        stdf_dtc_U2 FLD_CNT
        # stdf_dtc_Vn GEN_DATA
    ctypedef struct stdf_rec_dtr:
        stdf_dtc_Cn TEXT_DAT

    cdef extern int MAKE_REC(stdf_rec_typ, stdf_rec_sub)
    cdef extern int HEAD_TO_REC(stdf_rec_header)
    cdef int STDF_REC_FAR
    cdef int STDF_REC_ATR
    cdef int STDF_REC_MIR
    cdef int STDF_REC_MRR
    cdef int STDF_REC_PCR
    cdef int STDF_REC_HBR
    cdef int STDF_REC_SBR
    cdef int STDF_REC_PMR
    cdef int STDF_REC_PGR
    cdef int STDF_REC_PLR
    cdef int STDF_REC_RDR
    cdef int STDF_REC_SDR
    cdef int STDF_REC_WIR
    cdef int STDF_REC_WRR
    cdef int STDF_REC_WCR
    cdef int STDF_REC_PIR
    cdef int STDF_REC_PRR
    cdef int STDF_REC_TSR
    cdef int STDF_REC_PTR
    cdef int STDF_REC_MPR
    cdef int STDF_REC_FTR
    cdef int STDF_REC_BPS
    cdef int STDF_REC_EPS
    cdef int STDF_REC_GDR
    cdef int STDF_REC_DTR
    cdef int STDF_REC_UNKNOWN

    ctypedef void stdf_file
    ctypedef enum stdf_runtime_settings:
        STDF_SETTING_WRITE_SIZE = 0x001
        STDF_SETTING_VERSION = 0x002
        STDF_SETTING_BYTE_ORDER = 0x003

    cdef extern stdf_file* stdf_open(char *)
    cdef extern int stdf_close(stdf_file *)
    cdef extern void stdf_get_setting(stdf_file *, uint32_t, ...)
    cdef extern stdf_rec_unknown* stdf_read_record(stdf_file *)
    cdef extern stdf_rec_unknown* stdf_read_record_raw(stdf_file*)
    cdef extern stdf_rec_unknown* stdf_parse_raw_record(stdf_rec_unknown*)
    cdef extern void stdf_free_record(stdf_rec_unknown *)
    cdef extern char* stdf_get_rec_name(stdf_rec_typ, stdf_rec_sub)

    cdef dict _parse_gdr(stdf_rec_unknown *)
