% This program Plots III-V parameters of alloys (see list below section 1) in several
% ways chosen in section 2 and defined from an input file (section 3). 
% Version 2. Fonctionnelle au 5/10/2020

%% Credits
% This program is based on that written by Prof T. Mei, Nanyang Techonogical University, Singapore, March 2005.
% The author allows free usage of the program, but preserves all rights.
%    T. Mei, “Interpolation of quaternary III-V alloys parameters with surface bowing estimations”, J. App. Phys. 101, 013520 (2007)
%
% This program was specifically developed for plotting the stacks of
% heterostuctures of III-V alloys by JF Guillemoles
% The author allows free usage of his contribution to the program as a GNU
% licence: https://fr.wikipedia.org/wiki/Licence_publique_g%C3%A9n%C3%A9rale_GNU
%
%% 1-Definition of variables
% materialParameter: 1D array  containing the following parameters
%   01. a1c1(A)  02. a2c1(1e-5 A/K) 03. Eg0G(eV) 04. alfaG(meV/K) 05. betaG(K) 06. Eg0X(eV) 07. alfaX(meV/K) 08. betaX(K)
%   09. Eg0L(eV) 10. alfaL(meV/K)   11. betaL(K) 12. Dltaso       13. meG      14. mlL      15. mtL          16. mDOSL
%   17. mlX      18. mtX            19. mDOSX    20. gama1        21. gama2    22. gama3    23. mso          24. Ep(eV)
%   25. F        26. VBO(eV)        27. ac(eV)   28. av(eV)       29. b(eV)    30. d(eV)    31. c11(GPa)     32. c12(GPa)
%   33. c44(GPa) 34. alc = alc1+alc2*1e-5*(T-300)
%   35. EgG=Eg0-alfa*T^2/(T+beta)   36. EgX=Eg0-alfa*T^2/(T+beta)              37. EgL=Eg0-alfa*T^2/(T+beta)
%   38. mhh100 = 1/(gama1-2*gama2)  39. mhh110 = 2/(2*gama1-gama2-3*gama3)     40. mhh111 = 1/(gama1-2*gama3)
%   41. mlh100 = 1/(gama1+2*gama2)  42. mlh110 = 2/(2*gama1+gama2+3*gama3)     43. mlh111 = 1/(gama1+2*gama3)
%   VBO: valence band offset w.r.t. InSb valence band maxima
% - Elements #01 ~ #11 make sense only for binary compounds
% - Elements are trival if their values are NaN or 1e-100
%
% List of ternaries:
%    {'AlGaAs','AlInAs','InGaAs','InGaP','AlGaP','AlInP','AlGaSb','AlInSb','InGaSb','AlPAs','AlSbAs','AlPSb','GaPAs','GaSbAs','GaPSb','InPAs','InSbAs','InPSb'};%layer material
% Composition:
% - For binary compounds AB: the variable should be void.
% - For ternary compounds A(x)B(1-x)C, or AB(x)C(1-x): 
%   A scalar x or a [nx1] column vector X, assigned to 1st element in the same group. e.g. x-> Al for AlGaAs but ->Ga for GaAlAs 
% - For quaternary compounds A(x)B(1-x)C(y)D(1-y), A(x)B(y)C(1-x-y)D, or AB(x)C(y)D(1-x-y): 
%   1D vector [x,y], e.g. [0.1,0.2]; or [nx2] array: [X,Y] 
%   x,y are assigned to the element shown in the material formula by sequence. e.g.  x->In,y->As for InGaAsP; x->In,y->Al for InAlGaAs
% - For quaternary compounds latticed-matched to substrate:
%   A scalar z, or a [nx1] column vector Z specific to the following
%   - Lattice-matched to GaAs:
%       - AlGaInP: [Al(0.52)In(0.48)P](z)/[Ga(0.51)In(0.49)P](1-z)
%       - GaInAsP: [Ga(0.51)In(0.49)P](z)/[GaAs](1-z)
%       - AlGaInAs: not programmed
%   - Lattice-matched to InP:
%       - GaInAsP: [Ga(0.47)In(0.53)As](z)/[InP](1-z)
%       - AlGaInAs: [Al(0.48)In(0.52)As](z)/[Ga(0.47)In(0.53)As](1-z)
%       - GaInAsSb: [Ga(0.47)In(0.53)As](z)/[GaAs(0.5)Sb(0.5)](1-z)
%   - Lattice-matched to InAs:
%       - GaInAsSb: [GaAs(0.08)Sb(0.92)](z)/[InAs](1-z)
%       - AlGaAsSb: [AlAs(0.16)Sb(0.84](z)/[GaAs(0.08)Sb(0.92)](1-z)
%       - InAsPSb: [InSb(0.31)P(0.69)](z)/[InAs](1-z)
%   - Lattice-matched to GaSb:
%       - GaInAsSb: [InAs(0.91)Sb(0.09)](z)/[GaSb](1-z)
%       - AlGaAsSb: [AlAs(0.08)Sb(0.92](z)/[GaSb](1-z)
%   - Lattice-matched to GaAs(0.61)P(0.39):
%       - AlGaAsP: [AlAs(0.61)P(0.39)](z)/[GaAs(0.61)P(0.39)](1-z)
%
% substrate: 'GaAs', 'InP', 'InAs', 'GaSb', or 'GaAsP'.


%% 2-Inputs
clear

T=300;        % Temperature
PlotType=1;   % 1 pour stack et 2 pour variations continues (par exemple en fonction du paramètre de maille)
C=4;          % Ternaires (C=3) ou Binaires (C=2) ou quaternaires (C=4) ou 
             %lattice matched (C=5)

%% 3-Structure definition: input data

if PlotType==1
    if C==2
    binaries_display  % Stack de tous les binaires  
    
    elseif C==3
    %HCSC_GaInP_structure;% exemples of files
        
    %C=3; exemple of a stack structure:   
%Structure II-1 :InP substrate test SEC structure
% ZZ=[50,15,10,15,50,10,50];%layer thicknesses
% MM={'InGaAs','AlInAs','AlInAs','AlInAs','InGaAs','AlInAs','InGaP'};%layer material
% XX=[0.5,0.65,0.5,0.3,0.5,0.5,1];%layer alloy composition

ZZ=[50,10,10,30,20,50,50];%layer thicknesses
MM={'InGaP','AlInAs','AlInAs','AlInAs','InGaAs','AlInAs','InGaP'};%layer material
XX=[0,0.5,0.5,0.5,0.5,0.5,1];%layer alloy composition
   
    elseif C==4
%- For quaternary compounds A(x)B(1-x)C(y)D(1-y), A(x)B(y)C(1-x-y)D, or AB(x)C(y)D(1-x-y): 
%   1D vector [x,y], e.g. [0.1,0.2]; or [nx2] array: [X,Y] 
%   x,y are assigned to the element shown in the material formula by sequence. 
%e.g.  x->In,y->As for InGaAsP; x->In,y->Al for InAlGaAs
        % C=4, exemple de syntaxe
% ZZ=[150,15,50,15,150];%layer thicknesses
% MM={'InGaAsP','AlInAsP','InGaAsP','AlInAsP','InGaAsP'};%layer material
% XX=[1,0.5,0.5,0.5,1];%layer alloy composition 1st cation   
% YY=[0,1,0.8,1,0];%layer alloy composition  1st anion or 2nd cation
% Andrea_structure
Olivier_structure

    elseif C==5
% C=5, exemple de syntaxe
        fprintf('choose case, C= 2 to 4, C=5 not implemented')
    else
       fprintf('choose case, C= 2 to 4') 
    end
    
N1=size(ZZ,2);          %number of layers
Z=zeros(size(ZZ));z=0;  % abscisses des interfaces
    for i=2:N1+1
    z=z+ZZ(i-1);
    Z(i)=z;
    end

elseif PlotType==2
    % Evolution with composition of a ternary's parameters
    STR='AlGaAs';
    N2=11;
    ZZ=ones(1,N2)/N2;%layer thicknesses
    XX=([1:N2]-1)/(N2-1);%layer alloy composition
    
    
    %MMM={'AlGaAs','AlInAs','InGaAs','InGaP','AlGaP','AlInP','AlGaSb','AlInSb','InGaSb','AlPAs','AlSbAs','AlPSb','GaPAs','GaSbAs','GaPSb','InPAs','InSbAs','InPSb'};%layer material
    %N3=size(MMM,2);%number of compounds
   % for j=1:N3
   %     STR=MMM(j);
   % end      
        
        for i=1:N2
            MM(i)={STR};
        end
        % MM={'AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs','AlGaAs'};%layer material

else
        fprintf('choose case, PlotType=1,2 ')
end        


       
        
%% Data

%Band alignement
        EgG=zeros(size(ZZ));EgGm=zeros(size(ZZ));EgXm=zeros(size(ZZ));
        EgLm=zeros(size(ZZ));VB=zeros(size(ZZ));Latt_param=zeros(size(ZZ));
        
        %choix des axes
        Matformula=cell(MM);
        %Matformulas=char(Matformula);
        
        for i=1:N1
            Alloy=char(MM(i));
            x=XX(i);           
            
            if C==2
                %Calcul binaire
                [materialParameter, materialFormula, parameterTable] = ZincBlendeIIIV(Alloy, T);                
            elseif C==3
                %Calcul ternaire
                [materialParameter, materialFormula, parameterTable,BF3] = ZincBlendeIIIV(Alloy, T, x);
                % [materialParameter, materialFormula, parameterTable] = ZincBlendeIIIV(Alloy, T, x);
                MaterialFormula = strcat(MM(i),', x = ', num2str(XX(i)));
                Matformula(i)=MaterialFormula;
            elseif C==4
                % Quaternaire
                y=YY(i);r=[x,y];
                [materialParameter, materialFormula, parameterTable] = ZincBlendeIIIV(Alloy,T,r);
                MaterialFormula = strcat(MM(i),', x = ', num2str(XX(i)),', y = ', num2str(YY(i)));
                Matformula(i)=MaterialFormula;
            elseif C==5
                % lattice matched
                [materialParameter, materialFormula, parameterTable, BF3] = ZincBlendeIIIV(material, T, composition, substrate);
            else
                 fprintf('choose case, C= 2 to 5:  Ternaries (C=3)  Binaries (C=2) ou quaternaries(C=4) or lattice matched (C=5)')
            end
            
            % Gap
            EgG(i)=materialParameter(35,:);% Gap en Gamma
            EgGm(i)=((materialParameter(35,:)<=materialParameter(36,:)).*(materialParameter(35,:)<=materialParameter(37,:))).*materialParameter(35,:); %gap minimal en Gamma
            EgXm(i)=((materialParameter(36,:)<=materialParameter(35,:)).*(materialParameter(36,:)<=materialParameter(37,:))).*materialParameter(36,:); %gap minimal en X
            EgLm(i)=((materialParameter(37,:)<=materialParameter(36,:)).*(materialParameter(35,:)>=materialParameter(37,:))).*materialParameter(37,:); %gap minimal en L
            Latt_param(i)=materialParameter(34,:);
            % Bands position vs InSb VB
            VB(i)=materialParameter(26,:);% Valence Band position vs InSb
            
        end
        
        Eg=EgGm+EgXm+EgLm; % gap min
        CB=VB+Eg; %conduction band position
        
        
        
        %% Output stack
        
        if PlotType==1                      
            figure(1);
            if C==2
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.2*(4*Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),MM(i))                    
                    hold on
                    if i<N1 % traits verticaux
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];
                        subplot (1,2,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                    
                end
                
            elseif C==3                
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.5*(Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                    hold on                    
                    if i<N1
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];% traits verticaux
                        subplot (1,2,1);%subplot (2,1,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                   
                end
                
            elseif C==4                
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.5*(Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                    hold on                    
                    if i<N1
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];% traits verticaux
                        subplot (1,2,1);%subplot (2,1,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                   
                end    
                
            end
            
            xlabel('x');ylabel('VB, CB edges');
            legend('VB edge', 'CB edge','Location','South');%'BestOutside')
            title('Band edges within the stack');
            axes('Position',[0 0 8 8],'PlotBoxAspectRatio' ,[1 1 1]);
            hold off

            % Position [left bottom width height]
            % PlotBoxAspectRatio [px py pz]
            
            
            for i=1:N1
                X=[Z(i),Z(i+1)];
                EgGb=[EgG(i),EgG(i)];Egb=[Eg(i),Eg(i)];
                subplot (1,2,2);%subplot (2,1,2);
                plot(X,EgGb,'s-',X,Egb,'s-');
                text(0.5*(Z(i)+Z(i+1)),0.5*(Eg(i)+EgG(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                hold on                
                if i<N1
                    Y=[Z(i+1),Z(i+1)];
                    EgGc=[EgG(i),EgG(i+1)];Egc=[Eg(i),Eg(i+1)];
                    subplot (1,2,2);%subplot (2,1,2);
                    plot(Y,EgGc,'s-',Y,Egc,'s-');
                end                
            end
                     
            hold off           
            xlabel('x');ylabel('Gap');
            legend('Direct Gap ', 'minimum gap','Location','North');%'BestOutside')
            title('Gap sequence of stack');
            axes('Position',[9 0 8 8],'PlotBoxAspectRatio' ,[1 1 1]);
            
        end
               
        %% Output property plot
        
        if C==3 && PlotType==2
       
            figure(2)
            plot(XX,CB,XX,VB)
            xlabel('x');ylabel('Gap');
            legend('VB edge', 'CB edge','Location','South');%'BestOutside')
            title('Band edges vs x');
            
            hold on
            
            figure(3)
            plot(XX,Eg,XX,EgG)
            xlabel('x');ylabel('VB, CB edges');
            legend('Direct Gap ', 'minimum gap','Location','South');%'BestOutside')
            title('Band edges vs x');
            
            hold on
            
            figure(4)
            plot(Latt_param,CB,Latt_param,VB)
            xlabel('a');ylabel('Gap');
            legend('VB edge', 'CB edge','Location','South');%'BestOutside')
            title('Band edges vs x');
            
            hold on
            
            figure(5)
            plot(Latt_param,Eg,Latt_param,EgG)
            xlabel('a');ylabel('VB, CB edges');
            legend('Direct Gap ', 'minimum gap','Location','South');%'BestOutside')
            title('Band edges vs x');
            
            hold on
            
        end
        
        hold off
        
    