%% Andrea_structure.m
%Andrea structure for HCSC 5/10/2020
%GaInAsP lattice matched on In
% (Ga0.47In0.53As)1-z (InP)z is (always) lattice matched on InP and, depending on z, we can tune
% the bandgap from In0.47Ga0.53As (0.74 eV) to InP (1.34 eV)
% z=0 In0.53Ga0.47As 0.75 eV 0.74 eV
% z=0.19 In0.62Ga0.38As0.81P0.19 0.89 eV 0.82 eV
% z=0.3 In0.67Ga0.33As0.7P0.3 0.97 eV 0.9 eV
% z=0.4 In0.72Ga0.28As0.6P0.4 1.04 eV 0.95 eV
% z=1 InP 1.35 eV 1.34 eV
% The barriers are always Al0.48In0.52As, while the absorbers are:


ZZ=[100,100,100,100,100,100,100];%layer thicknesses
MM={'AlInAsP','InGaAsP','InGaAsP','InGaAsP','InGaAsP','InGaAsP','AlInAsP'};%layer material
XX=[0.48,0.53,0.62,0.67,0.72,1,0.48];%layer alloy composition 1st cation   
YY=[1,1,0.81,0.7,0.6,0,1];%layer alloy composition  1st anion or 2nd cation
