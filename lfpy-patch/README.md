# LFPy patch

The thesis ran on a lightly modified LFPy v2.1.1. Upstream is
[LFPy/LFPy](https://github.com/LFPy/LFPy), and the patch applies on top of upstream commit
[`49f819f`](https://github.com/LFPy/LFPy/commit/49f819f) (`v2.1.1-5-g49f819f`).

`lfpy-v2.1.1-thesis.patch` contains only the source changes from the original fork at
`steinnhauser/LFPy`. Generated Cython C files, compiled NEURON mechanisms and file-mode
changes are left out.

| File | Change |
| --- | --- |
| `LFPy/network.py` | `Network.connect` also stores synapse index, weight, delay and presynaptic GID for each connection. The kernel and hybrid reconstructions need these. |
| `LFPy/cell.py`, `LFPy/lfpcalc.py` | Silences warnings and prints that flooded output in large MPI runs. |
| `LFPy/eegmegcalc.py`, `LFPy/test/test_eegmegcalc.py` | Small differences in imports, docstrings and exception handling, carried over when the package was copied into the fork from a local install. |

## Install

```bash
git clone https://github.com/LFPy/LFPy.git
cd LFPy
git checkout 49f819f
git apply /path/to/msc-thesis-lfp/lfpy-patch/lfpy-v2.1.1-thesis.patch
pip install .
```

The original fork commits (2020-10-29 to 2020-11-08) were:

- `a0a8b3c` Adding altered Network.py version to the forked LFPy repo.
- `1c1d8e7` Removing unnecessary comment
- `b2cf759` Adding full lfpy package from laptop
- `89c6e0e` Adding lfpcalc
- `224cfa7` Strange merge conflicts
- `655c891` Adding fully working LFPy module...
- `5c01354` Adding full LFPy
- `142f33b` Adding a removed print() statement from cell and network modules
