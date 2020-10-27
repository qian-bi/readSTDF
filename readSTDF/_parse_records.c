#include "_parse_records.h"

PyObject *_parse_gdr(stdf_rec_unknown *rec)
{
	stdf_rec_gdr *gdr;
	stdf_dtc_Vn v;
	PyObject *key;
	PyObject *value;
	PyObject *res = PyDict_New();
	PyObject *l = PyList_New(0);
	gdr = (stdf_rec_gdr *)rec;
	v = gdr->GEN_DATA;
	key = Py_BuildValue("s", "FLD_CNT");
	value = Py_BuildValue("i", gdr->FLD_CNT);
	PyDict_SetItem(res, key, value);
	Py_DECREF(key);
	Py_DECREF(value);
	for (int i = 0; i < gdr->FLD_CNT; ++i)
	{
		switch (v[i].type)
		{
		case STDF_GDR_B0:
		{
			value = Py_BuildValue("i", "");
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_U1:
		{
			value = Py_BuildValue("i", *((stdf_dtc_U1*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_U2:
		{
			value = Py_BuildValue("i", *((stdf_dtc_U2*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_U4:
		{
			value = Py_BuildValue("l", *((stdf_dtc_U4*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_I1:
		{
			value = Py_BuildValue("i", *((stdf_dtc_I1*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_I2:
		{
			value = Py_BuildValue("i", *((stdf_dtc_I2*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_I4:
		{
			value = Py_BuildValue("l", *((stdf_dtc_I4*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_R4:
		{
			value = Py_BuildValue("d", *((stdf_dtc_R4*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_R8:
		{
			value = Py_BuildValue("d", *((stdf_dtc_R8*)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_Cn:
		{
			value = Py_BuildValue("s", *((stdf_dtc_Cn *)v[i].data) + 1);
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_Bn:
		{
			value = Py_BuildValue("s", *((stdf_dtc_Bn *)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_Dn:
		{
			value = Py_BuildValue("s", *((stdf_dtc_Dn *)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		case STDF_GDR_N1:
		{
			value = Py_BuildValue("s", *((stdf_dtc_N1 *)v[i].data));
			PyList_Append(l, value);
			Py_DECREF(value);
			break;
		}
		}
	}
	key = Py_BuildValue("s", "GEN_DATA");
	PyDict_SetItem(res, key, l);
	Py_DECREF(key);
	Py_DECREF(l);
	return res;
}
