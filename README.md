# Thalamocortical Neural Network Analysis

## Introduction
This repository contains the computational tools and scripts used in our recent study on the hierarchical organization of the thalamocortical network during sensory processing. The study focuses on how functional connections within and across brain areas influence the hierarchical organization of sensory signal processing. We conducted experiments using spiking data recorded from monkeys trained to detect the presence or absence of a vibrotactile stimulus. This analysis helps in understanding the underlying neural mechanisms and dynamics at play within the somatosensory cortex and thalamus.

In our research, we employed a range of computational neuroscience methods to quantify neural variability and connectivity. We analyzed intrinsic timescales, computed the Fano factor for assessing neuronal response variability, and applied directed connectivity measures to explore the information flow across the thalamocortical network.

## Project Characteristics
- **Neural Data**: Analysis of spiking data from monkeys, focusing on neurons within the somatosensory thalamus (VPL) and cortical areas 3b and 1 in the primary Somatosensory cortex (S1). 
- **Key Measures**: Intrinsic timescales, Fano factor, and directionality measures of connectivity.
- **Findings**: The study reveals distinct patterns of neural dynamics and interactions, which contribute to the hierarchical processing within the network, particularly how sensory information is processed across different areas of the thalamocortical circuit.

Link to the preprint: https://doi.org/10.48550/arXiv.2403.09965

Additionally, this repository contains a poster summarizing the project's key findings and methodologies, providing a visual and succinct overview of the research for easier dissemination and understanding.

## Repository Structure

This repository includes the following main computational tools, essential for analyzing the thalamocortical neural data presented in our study:

1. **Intrinsic Timescales Code**
   - Scripts to calculate and analyze the intrinsic timescales of neuronal activity, allowing for an understanding of input integration across different brain regions and a within-trial measure of variability.

2. **Fano Factor Code**
   - Code to compute the Fano factor for neuronal spike counts, used to assess intrinsic variability in neural responses across trials.

3. **Directed Information Inference**
   - Tools to infer directional interactions between neurons using the Directional Information (DI) inference method. This method estimates single-trial directional interactions between discrete time series within sequential time windows.

### External References

The DI inference method implemented in this repository builds upon existing tools available for both MATLAB and Python environments. For more details and to access the original implementations, please refer to the following resources:

  - MATLAB Implementation, GitHub: [DI-Inference in MATLAB](https://github.com/AdTau/DI-Inference)
  - Python Implementation, GitHub: [DI-Inference for Python](https://github.com/mvilavidal/DI-Inference-for-Python)
  - Reference: Tauste Campo A, Vázquez Y, Álvarez M, Zainos A, Rossi-Pool R, Deco G, Romo R. Feed-forward information and zero-lag synchronization in the sensory   thalamocortical circuit are modulated during stimulus perception. Proceedings National Academy Sciences USA, 116(15):7513-7522, 2019.

### Future Directions
In the future, we plan to expand and reorganize this repository to enhance its utility and navigability. The code will be structured to align with the sections of our published article. Each main and supplementary figure presented in the paper will correspond to a specific folder in this repository, which will contain all the necessary scripts used to generate that figure. We acknowledge that some parts of the codebase require further refinement for enhanced readability and structural coherence. Plans are underway to improve the overall quality of the code, including better documentation, refactoring of existing code, and optimization of performance. 
