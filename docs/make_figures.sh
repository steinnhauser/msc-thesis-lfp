#!/usr/bin/env bash
# Render the README figures in docs/assets/ from thesis.pdf and the misc/ figures.
# Requires poppler-utils (pdftoppm). Run from the repository root: bash docs/make_figures.sh
set -euo pipefail

out=docs/assets
dpi=200
mkdir -p "$out"

# crop NAME PAGE X Y W H: a region of a thesis page, with coordinates in pixels at $dpi.
crop() {
  pdftoppm -png -r "$dpi" -f "$2" -l "$2" -x "$3" -y "$4" -W "$5" -H "$6" -singlefile thesis.pdf "$out/$1"
}

crop network-layout   65 440  340  760  700   # Fig. 4.1: neuron positions and electrode
crop spike-raster     65 430 1170  790  680   # Fig. 4.2: spike raster of the recipe network
crop result-bas-lfp   75 230  620 1160 1270   # Fig. 4.11: Reference vs hybrid vs kernel LFP
crop result-synchrony 78 330  330 1000  710   # Fig. 4.14 (top): PCC for increased stimulus
crop hay-cell         83 330  390  990 1410   # Fig. 4.18: Hay cell morphology and synapses
crop result-hay-lfp   87 230  370 1190 1520   # Fig. 4.23: detailed network LFP comparison

# Concept figures produced by the scripts in misc/
pdftoppm -png -r 130 -singlefile misc/convolution_example.pdf "$out/concept-convolution"
pdftoppm -png -r 130 -singlefile misc/dipole_conceptualization.pdf "$out/concept-dipole"
pdftoppm -png -r 130 -singlefile misc/spike_raster_example.pdf "$out/concept-raster"

ls -l "$out"
