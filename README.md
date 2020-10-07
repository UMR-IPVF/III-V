# III-V
Project on III-V heterostructures

 This program Plots parameters of III-V alloys 
(see list below section 1) in several ways chosen in section 2 
and defined from an input file. 
Version 2.1 With input windows

When the program starts using the command:
heterostructure_IIIV_GUI2.m

A first prompt asks for the type of information to be plotted
- A heterostructure
- A property-composition plot
- The classical Property-lattice parameter plot
This is used to set the output.
The list of available properties is given below in section 1

A second prompt then asks for the type of material systems to be
investigated as they are handled differently : binaries, ternaries,
quaternaries and lattice matched to some substrates (this last to be
implemented).
The list of available compounds is given in section 1 below, as well as
the rules to enter the molar fractions.  
    
 A third Prompt asks for the temperature of the lattice and the number
of data points used for Property versus lattice or composition plots.
    
 A 4th prompt asks for the way data on the selected compounds will be 
provided: through a file (a prompt searches the current directory),
through an input window, or other (directly in the workspace or via the
command window).
For further help, exemples of data format are provided
 - for binaries: heterostructure plot showing the band position of all
 binaries:
 ZZ=[1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000];%layer thicknesses
 MM={'AlN','GaN','InN','AlP','GaP','InP','AlAs','GaAs','InAs','AlSb','GaSb','InSb'};  
also by calling the file: binaries_display_W_Nitrides.m

- for ternaries: heterostructure using ternaries
ZZ=[10,50,50,100,50,50,10];%layer thicknesses
MM={'AlGaAs','GaInP','GaAsP','InGaAs','GaAsP','GaInP','AlGaAs'};%layer material
XX=[0,0.51,1,0.2,1,0.51,0];%layer ternary alloy composition
also by calling the file: test_structure.m

- for quaternaries: heterostructure using quaternaries  
   ZZ=[150,15,50,15,150];%layer thicknesses
  MM={'InGaAsP','AlInAsP','InGaAsP','AlInAsP','InGaAsP'};%layer material
  XX=[1,0.5,0.5,0.5,1];%layer alloy composition 1st cation   
  YY=[0,1,0.8,1,0];%layer alloy composition  1st anion or 2nd cation

Plots are generated and labeled automatically. At this point mostly the
heterostructure plotting is available.


% Credits
This program is based on that written by Prof T. Mei, Nanyang Techonogical University, Singapore, March 2005.
The author allows free usage of the program, but preserves all rights.
   T. Mei, “Interpolation of quaternary III-V alloys parameters with surface bowing estimations”, J. App. Phys. 101, 013520 (2007)

This program was specifically developed for plotting the stacks of
heterostuctures of III-V alloys by JF Guillemoles
The author allows free usage of his contribution to the program as a GNU
licence: https://fr.wikipedia.org/wiki/Licence_publique_g%C3%A9n%C3%A9rale_GNU

% 1-Definition of variables
materialParameter: 1D array  containing the following parameters
  01. a1c1(A)  02. a2c1(1e-5 A/K) 03. Eg0G(eV) 04. alfaG(meV/K) 05. betaG(K) 06. Eg0X(eV) 07. alfaX(meV/K) 08. betaX(K)
  09. Eg0L(eV) 10. alfaL(meV/K)   11. betaL(K) 12. Dltaso       13. meG      14. mlL      15. mtL          16. mDOSL
  17. mlX      18. mtX            19. mDOSX    20. gama1        21. gama2    22. gama3    23. mso          24. Ep(eV)
  25. F        26. VBO(eV)        27. ac(eV)   28. av(eV)       29. b(eV)    30. d(eV)    31. c11(GPa)     32. c12(GPa)
  33. c44(GPa) 34. alc = alc1+alc2*1e-5*(T-300)
  35. EgG=Eg0-alfa*T^2/(T+beta)   36. EgX=Eg0-alfa*T^2/(T+beta)              37. EgL=Eg0-alfa*T^2/(T+beta)
  38. mhh100 = 1/(gama1-2*gama2)  39. mhh110 = 2/(2*gama1-gama2-3*gama3)     40. mhh111 = 1/(gama1-2*gama3)
  41. mlh100 = 1/(gama1+2*gama2)  42. mlh110 = 2/(2*gama1+gama2+3*gama3)     43. mlh111 = 1/(gama1+2*gama3)
  VBO: valence band offset w.r.t. InSb valence band maxima
- Elements #01 ~ #11 make sense only for binary compounds
- Elements are trival if their values are NaN or 1e-100

List of ternaries:
   {'AlGaAs','AlInAs','InGaAs','InGaP','AlGaP','AlInP','AlGaSb','AlInSb','InGaSb','AlPAs','AlSbAs','AlPSb','GaPAs','GaSbAs','GaPSb','InPAs','InSbAs','InPSb'};%layer material
Composition:
- For binary compounds AB: the variable should be void.
- For ternary compounds A(x)B(1-x)C, or AB(x)C(1-x): 
  A scalar x or a [nx1] column vector X, assigned to 1st element in the same group. e.g. x-> Al for AlGaAs but ->Ga for GaAlAs 
- For quaternary compounds A(x)B(1-x)C(y)D(1-y), A(x)B(y)C(1-x-y)D, or AB(x)C(y)D(1-x-y): 
  1D vector [x,y], e.g. [0.1,0.2]; or [nx2] array: [X,Y] 
  x,y are assigned to the element shown in the material formula by sequence. e.g.  x->In,y->As for InGaAsP; x->In,y->Al for InAlGaAs
- For quaternary compounds latticed-matched to substrate:
  A scalar z, or a [nx1] column vector Z specific to the following
  - Lattice-matched to GaAs:
      - AlGaInP: [Al(0.52)In(0.48)P](z)/[Ga(0.51)In(0.49)P](1-z)
      - GaInAsP: [Ga(0.51)In(0.49)P](z)/[GaAs](1-z)
      - AlGaInAs: not programmed
  - Lattice-matched to InP:
      - GaInAsP: [Ga(0.47)In(0.53)As](z)/[InP](1-z)
      - AlGaInAs: [Al(0.48)In(0.52)As](z)/[Ga(0.47)In(0.53)As](1-z)
      - GaInAsSb: [Ga(0.47)In(0.53)As](z)/[GaAs(0.5)Sb(0.5)](1-z)
  - Lattice-matched to InAs:
      - GaInAsSb: [GaAs(0.08)Sb(0.92)](z)/[InAs](1-z)
      - AlGaAsSb: [AlAs(0.16)Sb(0.84](z)/[GaAs(0.08)Sb(0.92)](1-z)
      - InAsPSb: [InSb(0.31)P(0.69)](z)/[InAs](1-z)
  - Lattice-matched to GaSb:
      - GaInAsSb: [InAs(0.91)Sb(0.09)](z)/[GaSb](1-z)
      - AlGaAsSb: [AlAs(0.08)Sb(0.92](z)/[GaSb](1-z)
  - Lattice-matched to GaAs(0.61)P(0.39):
      - AlGaAsP: [AlAs(0.61)P(0.39)](z)/[GaAs(0.61)P(0.39)](1-z)

substrate: 'GaAs', 'InP', 'InAs', 'GaSb', or 'GaAsP'.


% 2-Inputs


%%%%Choose the data output type              
 answer = questdlg('Choose the data output type:', ...
	'Problem selection', ...
	'Heterostructure Stack','Material property-composition','Property-lattice');

%%%%%%%Choose the material system type
answer = questdlg('Choose the material system type:', ...
	'Materials', ...
	'Binaries','Ternaries','Quaternaries');

%%%%%%%%%%%%% Other
prompt = {'Enter Material Temperature:','Enter #datapoints:'};

%%%%%%% Input system definition data
answer = questdlg('Select input data:', ...
	'Input', ...
	'From file','From input window','Other');
                
 
