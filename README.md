# Read and parse STDF records

## Install

`pip install readSTDF`

## Example

```python
from readSTDF import readSTDF

l = readSTDF('test.std', 'FAR')
print(l)  # [{'CPU_TYPE': 1, 'STDF_VER': 4}]
```
