# clad-estimator-mip-bnb
Exact computation of Censored Least Absolute Deviations estimator with Mixed Integer Programming via MATLAB code and detailed B&amp;B algorithm

For general framework consult README of repository clad-estimator-mip.

This is a variant of the same code which can be used with MATLAB versions <R2014a and also without the CPLEX commercial solver.
I have implemented a detailed Branch and Bound (B&B) code based on Prof. Tomsovic's generic B&B code,
customized for the CLAD estimator MIP optimization model.

The code has 4 refinements which are shortly:
1. Depth-First-Search (DFS).
2. Branch as 10 (first try 1 and then try 0 for the binary variables).
3. Branching priority implemented with a greedy rule.
4. LP solver CLP from OPTI toolbox.

For more details consult paper: Exact computation of censored least absolute deviations estimator by Bilias, Florios and Skouras.
 Suggested reference: http://ssrn.com/abstract=2372588
 
 This code requires only a MATLAB working installation and the free OPTI optimization toolbox available in http://www.i2c2.aut.ac.nz/Wiki/OPTI/index.php

The main routine is Script_run_monte_greedy_k5_scenario1_CLP.m
and the remaining .m files contain all needed functions.
