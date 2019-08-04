# StableDoS

Brief Description: This main script computes and saves the analytic stability maps of a system, using Petrovich's, Giuppone's and the Hill AMD stability criteria. By convolving them with the corresponding depth-of-search and occurrence grids, the expected number of stable and imageable planets in a system, according to each stability criteria, is obtained. The depth-of-search grids have been previously calculated using Garrett's publicly available code at https://github.com/dgarrett622/DoS.

Use Instructions: 
1. Define TargetList and Initialize grid size
2. For computing (a, m) analytic stability maps run Section: Compute (a, m) Stability Grids
3. For constructing intersection grids in the (a, R) space and perform
     systems prioritization: 
     - First Run Section: Compute (a, R) Stability Grids and Occurrence Grids
     - Then Run Section: Import Data and Convolve Grids

References: 

- [1] Garrett, D., Savransky, D., and Macintosh, B. (2017). A simple depth-of-search metric for exoplanet imaging surveys. The Astronomical Journal, 154(2):47.

- [2] Giuppone, C., Morais, M., and Correia, A. (2013). A semi-empirical stability criterion for real planetary systems with eccentric orbits. Monthly Notices of the Royal Astronomical Society, 436(4):3547{3556.

- [3] Petit, A. C., Laskar, J., and Boue, G. (2018). Hill stability in the amd framework. Astronomy & Astrophysics, 617:A93.

- [4] Petrovich, C. (2015). The stability and fates of hierarchical two-planets systems. The Astrophysical Journal, 808(2):120.
