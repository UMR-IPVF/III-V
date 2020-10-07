% This program Plots III-V parameters of alloys (see list below section 1) in several
% ways chosen in section 2 and defined from an input file (section 3). 
% Version 2.1 With input windows

%% Credits
% This program is based on that written by Prof T. Mei, Nanyang Techonogical University, Singapore, March 2005.
% The author allows free usage of the program, but preserves all rights.
%    T. Mei, “Interpolation of quaternary III-V alloys parameters with surface bowing estimations”, J. App. Phys. 101, 013520 (2007)
%
% This program was specifically developed for plotting the stacks of
% heterostuctures of III-V alloys by JF Guillemoles
% The author allows free usage of his contribution to the program as a GNU
% licence: https://fr.wikipedia.org/wiki/Licence_publique_g%C3%A9n%C3%A9rale_GNU
        
%% Data processing

%Band alignement
        EgG=zeros(size(ZZ));EgGm=zeros(size(ZZ));EgXm=zeros(size(ZZ));
        EgLm=zeros(size(ZZ));VB=zeros(size(ZZ));Latt_param=zeros(size(ZZ));
        
        %choix des axes
        Matformula=cell(MM);
        %Matformulas=char(Matformula);
        
        for i=1:N1
            Alloy=char(MM(i));%Alloy=char(MM{i});
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
        
        
        
        