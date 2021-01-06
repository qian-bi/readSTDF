# cython: language_level=3, boundscheck=False, wraparound=False

from readSTDF cimport _cstdf
from libc.string cimport strcmp
from libc.stdio cimport fprintf, stderr
from cpython cimport array

import array


cdef int _type_picked(int recname, array.array record_type):
    return record_type[0] == 0 or recname in record_type


cdef list __readSTDF(char *file_name, array.array record_type, int n):
    cdef:
        _cstdf.stdf_file *f = NULL
        int recname
        _cstdf.stdf_rec_unknown *rec = NULL
        _cstdf.stdf_rec_unknown *far = NULL
        # _cstdf.stdf_dtc_U4 stdf_ver
        list l = []

    f = _cstdf.stdf_open(file_name)
    if f == NULL:
        fprintf(stderr, b"Error: %s is not a valid STDF file.\n", file_name)
        return l
    # _cstdf.stdf_get_setting(f, _cstdf.STDF_SETTING_VERSION, &stdf_ver)
    rec = _cstdf.stdf_read_record_raw(f)
    while rec != NULL and n != 0:
        recname = rec.header.REC_TYP * 100 + rec.header.REC_SUB
        if _type_picked(recname, record_type):
            if recname == 10:
                far = _cstdf.stdf_parse_raw_record(rec)
                l.append((recname, (<_cstdf.stdf_rec_far *>far)[0]))
                _cstdf.stdf_free_record(far)
            elif recname == 20:
                l.append((recname, (<_cstdf.stdf_rec_atr *>rec)[0]))
            elif recname == 110:
                l.append((recname, (<_cstdf.stdf_rec_mir *>rec)[0]))
            elif recname == 120:
                l.append((recname, (<_cstdf.stdf_rec_mrr *>rec)[0]))
            elif recname == 130:
                l.append((recname, (<_cstdf.stdf_rec_pcr *>rec)[0]))
            elif recname == 140:
                l.append((recname, (<_cstdf.stdf_rec_hbr *>rec)[0]))
            elif recname == 150:
                l.append((recname, (<_cstdf.stdf_rec_sbr *>rec)[0]))
            elif recname == 160:
                l.append((recname, (<_cstdf.stdf_rec_pmr *>rec)[0]))
            elif recname == 162:
                l.append((recname, (<_cstdf.stdf_rec_pgr *>rec)[0]))
            elif recname == 163:
                l.append((recname, (<_cstdf.stdf_rec_plr *>rec)[0]))
            elif recname == 170:
                l.append((recname, (<_cstdf.stdf_rec_rdr *>rec)[0]))
            elif recname == 180:
                l.append((recname, (<_cstdf.stdf_rec_sdr *>rec)[0]))
            elif recname == 210:
                l.append((recname, (<_cstdf.stdf_rec_wir *>rec)[0]))
            elif recname == 220:
                l.append((recname, (<_cstdf.stdf_rec_wrr *>rec)[0]))
            elif recname == 230:
                l.append((recname, (<_cstdf.stdf_rec_wcr *>rec)[0]))
            elif recname == 510:
                l.append((recname, (<_cstdf.stdf_rec_pir *>rec)[0]))
            elif recname == 520:
                l.append((recname, (<_cstdf.stdf_rec_prr *>rec)[0]))
            elif recname == 1030:
                l.append((recname, (<_cstdf.stdf_rec_tsr *>rec)[0]))
            elif recname == 1510:
                l.append((recname, (<_cstdf.stdf_rec_ptr *>rec)[0]))
            elif recname == 1515:
                l.append((recname, (<_cstdf.stdf_rec_mpr *>rec)[0]))
            elif recname == 1520:
                l.append((recname, (<_cstdf.stdf_rec_ftr *>rec)[0]))
            elif recname == 2010:
                l.append((recname, (<_cstdf.stdf_rec_bps *>rec)[0]))
            elif recname == 2020:
                pass
                # l.append((recname, (<_cstdf.stdf_rec_eps *>rec)[0]))
            elif recname == 5010:
                l.append((recname, _cstdf._parse_gdr(rec)))
            elif recname == 5030:
                l.append((recname, (<_cstdf.stdf_rec_dtr *>rec)[0]))
            else:
                fprintf(stderr, b"Unknown Record! REC_TYP: %d, REC_SUB: %d\n", rec.header.REC_TYP, rec.header.REC_SUB)
            n -= 1
        _cstdf.stdf_free_record(rec)
        rec = _cstdf.stdf_read_record(f)

    _cstdf.stdf_free_record(rec)
    _cstdf.stdf_close(f)
    return l


def _readSTDF(str file_name, object record_type, int n=1) -> list:
    cdef array.array r
    cdef dict rec2int

    rec2int = {
        'FAR': 10,
        'ATR': 20,
        'MIR': 110,
        'MRR': 120,
        'PCR': 130,
        'HBR': 140,
        'SBR': 150,
        'PMR': 160,
        'PGR': 162,
        'PLR': 163,
        'RDR': 170,
        'SDR': 180,
        'WIR': 210,
        'WRR': 220,
        'WCR': 230,
        'PIR': 510,
        'PRR': 520,
        'TSR': 1030,
        'PTR': 1510,
        'MPR': 1515,
        'FTR': 1520,
        'BPS': 2010,
        'EPS': 2020,
        'GDR': 5010,
        'DTR': 5030,
    }
    if isinstance(record_type, str):
        if record_type.upper() == 'ALL':
            r = array.array('i', [0])
        else:
            r = array.array('i', [rec2int[record_type.upper()]])
    elif isinstance(record_type, (list, tuple)):
        r = array.array('i', [rec2int[t.upper()] for t in record_type])
    else:
        raise ValueError('`record_type` must be str, list or tuple.')
    return __readSTDF(file_name.encode(), r, n)
