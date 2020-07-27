# StableDoS

The main script computes and saves the analytic stability maps of a system, using Petrovich's, Giuppone's and the Hill AMD stability criteria. By convolving them with the corresponding depth-of-search and occurrence grids, the expected number of stable and imageable planets in a system, according to each stability criteria, is obtained. 

Calculations are performed using the Main script and following the use instructions: 
1. Define TargetList struct: {'System Name', 'planet letter'; 'System Name', 'planet letter' ...}
2. Initialize grid size by defining Na, Nm and Nr (number of semi-major axis, mass and planetary radius bins respectively).
3. Perform calculations:
     - For obtaining (a, m) analytic stability maps run Section: Compute (a, m) Stability Grids
     - For constructing intersection grids in the (a, R) space and perform
     systems prioritization: 
          1. Run Section: Compute (a, R) Stability Grids and Occurrence Grids
          2. Run Section: Import Data and Convolve Grids

The previously calculated depth-of-search data (for all 213 systems) is stored in the following folders:

- DoSGrids: Depth-of-search grids calculated using Garrett's code (https://github.com/dgarrett622/DoS).
- Datalimits: 4-element array containing the semi-major axis (a) and planetary radius (R) imageable limits [amin, amax, Rmin, Rmax], calculated together with the depth-of-search grids using Garrett's code (https://github.com/dgarrett622/DoS).

When the code is executed, the generated data is stored in the following folders: 

- Edges: Arrays containing the a and R bin edges corresponding to the grids where the calculations are performed.
- StabGrids: Analytic stability maps obtained using Petrovich's, Giuppone's and the Hill AMD criteria. 
- StabDoSGrids: Stable depth-of-search grids (calculated as Stab * DoS).
- OccGrids: Occurrence rates grids calculated using the SAG13 parametric fit, where each bin value is also multiplied by the bin area.
- StabCompGrids: Stable completeness grids (calculated as StabDoS * Occ).
- Res.mat: Dynamically stable depth-of-search and completeness results. 

Additional comments:
- As an example, the results for the system HD 154345 are given in the corresponding data folders.
- The generated data used to perform the systems prioritization presented in Gascón et al. 2020 is all available via Cornell eCommons at https://doi.org/10.7298/3c98-m177
- The Figures folder stores the generated figures (when the corresponding lines are uncommented) and also contains the data associated to Figures 4, 5 and 6 presented in Gascón et al. 2020. 

References: 

- [1] Garrett, D., Savransky, D., and Macintosh, B. (2017). A simple depth-of-search metric for exoplanet imaging surveys. The Astronomical Journal, 154(2):47.

- [2] Giuppone, C., Morais, M., and Correia, A. (2013). A semi-empirical stability criterion for real planetary systems with eccentric orbits. Monthly Notices of the Royal Astronomical Society, 436(4):3547{3556.

- [3] Petit, A. C., Laskar, J., and Boue, G. (2018). Hill stability in the amd framework. Astronomy & Astrophysics, 617:A93.

- [4] Petrovich, C. (2015). The stability and fates of hierarchical two-planets systems. The Astrophysical Journal, 808(2):120.
