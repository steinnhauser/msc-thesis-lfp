# Evaluating Approximate Methods for Computing Extracellular Potentials from Neuronal Networks

Code for my MSc thesis in Computational Science (Physics) at the University of Oslo, 2021 (grade A),
supervised by Gaute Einevoll and Espen Hagen. Full text: [`thesis.pdf`](thesis.pdf).

Part of this work was published in
**Hagen E, Magnusson SH, et al. (2022), *Brain signal predictions from multi-scale networks using a linearized framework*, PLoS Comput Biol 18(8): e1010353.**
[doi:10.1371/journal.pcbi.1010353](https://doi.org/10.1371/journal.pcbi.1010353)

## What it does

The local field potential (LFP) is the low-frequency part of the extracellular signal recorded in brain tissue.
Computing it directly requires simulating every neuron with full morphology, which is expensive.
The **hybrid scheme** and the **kernel method** ([Hagen et al. 2016](https://doi.org/10.1093/cercor/bhw237)) approximate
the LFP from much cheaper point-neuron network activity.

This thesis measured how accurate those approximations are under different network conditions:

- A **recipe ball-and-stick network** of 1,280 neurons gives the reference LFP. The hybrid and kernel approximations are compared against it.
- **Stimulus increase and weight search** push the network into more synchronous regimes, where the linear assumptions behind the methods begin to break down.
- A **biophysically detailed network** of layer 5b pyramidal cells (Hay et al. 2011 model) tests the kernel method with realistic morphologies.

The detailed network simulations ran with MPI on 512 threads on the JUSUF cluster at the Jülich Supercomputing Centre.

## Repository layout

| Path | Contents |
| --- | --- |
| `recipeBaS/` | Ball-and-stick network: model setup, kernel generation, population simulation, and hybrid and kernel reconstructions (`01`–`06` scripts, `sim.sh`) |
| `detailedHay/` | The same pipeline for the detailed Hay L5b pyramidal cell network |
| `detailedHay/L5bPCmodelsEH/` | Hay et al. (2011) L5b pyramidal cell model, from [ModelDB #139653](https://modeldb.science/139653) |
| `misc/` | Scripts for the illustrative figures in the thesis (convolution, dipoles, Fourier, spike rasters) |
| `masters_utils/` | Installable helper package (`utils.plotter`, `utils.misc`, `utils.tester`) used by the scripts |
| `lfpy-patch/` | The small patch to LFPy v2.1.1 that the thesis relies on (see its [README](lfpy-patch/README.md)) |
| `thesis.pdf` | The thesis |

## Running

Versions used in the thesis (section 3.7.2): Python 3.8.5, NEURON 7.8.2, numpy 1.20.1, SciPy 1.6.1, Cython 0.29.22,
mpi4py 3.0.3, h5py 3.1.0, pandas 1.2.2, matplotlib 3.3.4, and LFPy 2.1.1 with the patch in `lfpy-patch/`.

```bash
# 1. LFPy with the thesis patch
git clone https://github.com/LFPy/LFPy.git && cd LFPy
git checkout 49f819f && git apply ../msc-thesis-lfp/lfpy-patch/lfpy-v2.1.1-thesis.patch
pip install . && cd ..

# 2. Thesis utilities
pip install -e msc-thesis-lfp/masters_utils

# 3. Compile NEURON mechanisms and run, e.g. the ball-and-stick network
cd msc-thesis-lfp/recipeBaS
nrnivmodl
./sim.sh 12.8 1 run0    # population scale, external drive scale, run name
```

For `detailedHay/`, also run `nrnivmodl` inside `detailedHay/L5bPCmodelsEH/mod/`.

## History

This repository combines the original `linearLFP` and `linearLFP_utils` repositories, with all their commits kept.
The thesis PDF (section 3.7.1) links to those repositories and to an LFPy fork, which are no longer public. Their contents live here:
`linearLFP` at the root (its old URL redirects here), `linearLFP_utils` in `masters_utils/`, and the fork's changes in `lfpy-patch/`.

## Credits

- Supervisors: Gaute T. Einevoll and Espen Hagen
- [LFPy](https://github.com/LFPy/LFPy) (GPL-3.0). `exp2isyn.mod` is taken from LFPy's examples.
- Hay E, Hill S, Schürmann F, Markram H, Segev I (2011). *Models of neocortical layer 5b pyramidal cells capturing a wide range of dendritic and perisomatic active properties.* PLoS Comput Biol 7(7): e1002107.

## License

The code in this repository is licensed under the [GNU General Public License v3.0](LICENSE). This includes the thesis scripts, `masters_utils/` and the LFPy patch, consistent with LFPy's own GPL-3.0 license.

Not covered by that license:
- `thesis.pdf`, © 2021 Steinn Hauser Magnússon, all rights reserved.
- `detailedHay/L5bPCmodelsEH/`, the Hay et al. (2011) model from ModelDB, which remains under its authors' terms.
