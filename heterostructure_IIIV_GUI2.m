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
%



%% 2-Inputs

%%%%%Choose the data output type              
 answer = questdlg('Choose the data output type:', ...
	'Problem selection', ...
	'Heterostructure Stack','Material property-composition','Property-lattice','Heterostructure Stack');
% Handle response
switch answer
    case 'Heterostructure Stack'
        disp([answer ' OK'])
        PlotType=1;
    case 'Material property-composition'
        disp([answer ' To be done'])
        PlotType = 2;
    case 'Property-lattice'
        disp('In progress')
        PlotType = 2;
end    

%%%%%%%%Choose the material system type
answer = questdlg('Choose the material system type:', ...
	'Materials', ...
	'Binaries','Ternaries','Quaternaries','Ternaries');
% Handle response
switch answer
    case 'Binaries'
        disp([answer ' OK'])
        C=2;
    case 'Ternaries'
        disp([answer ' OK'])
        C=3;
    case 'Quaternaries'
        disp([answer ' OK'])
        C=4;
%     case 'Lattice Matched'
%         disp('In progress')
%         C=5;
end    

%%%%%%%%%%%%%% Other
prompt = {'Enter Material Temperature:','Enter #datapoints:'};
title = 'Input';
dims = [1 35];
definput = {'300','11'};
answer = inputdlg(prompt,title,dims,definput);
T = str2num(answer{1});N2 = str2num(answer{2});

%%%%%%%% Input system definition data
answer = questdlg('Select input data:', ...
	'Input', ...
	'From file','From input window','Other','From input window');
% Handle response
switch answer
    case 'From file'
        disp([answer ' Choose directory and select file'])
        d = dir;
fn = {d.name};
[indx,tf] = listdlg('PromptString','Select a definition file:',...
                           'SelectionMode','single',...
                           'ListString',fn);
fprintf('the definition file is:')
fprintf('%s\n',fn{indx})
if PlotType==1
    fprintf('%s\n',fn{indx})       %Works
else
    fprintf('to be done')
end
    case 'From input window'
        disp([answer ' Check data format'])
        prompt = {'layer thicknesses vector:','Material string names:', 'composition vector x: ', 'composition vector y (quaternaries):','filename.m'};
        title = 'Input';
        dims = [1 200];
        %S={'InAsP','AlInAs','InGaAs','AlInAs','InAsP'};
        %definput = {'[150,15,50,15,150]','InAsP'',''AlInAs'',''InGaAs'',''AlInAs'',''InAsP','[1,0.5,0.5,0.5,1]','[0,1,0.8,1,0]','test_structure.m'};
        definput = {'[150,15,50,15,150]','InAsP','[1,0.5,0.5,0.5,1]','[0,1,0.8,1,0]','test_structure'};
        answer = inputdlg(prompt,title,dims,definput);
        ZZ = str2num(answer{1});XX = str2num(answer{3});YY = str2num(answer{4});
        %MM=answer{2}; %MM=S;%%%%% ERROR sur MM?Conversion to cell from char is not possible line246
        file=answer{5};
        fprintf('%s\n',file)
                
    case 'Other'
        disp([answer ' Use command window or load data into workspace manually '])
        
end    
  
%% Table generation
heterostructure_IIIV_2main

 %choix des axes
        Matformula=cell(MM);
        %Matformulas=char(Matformula);
        
        
 %% Output stack
        
        if PlotType==1                      
            figure(1);%title('Band edges within the stack');
            if C==2
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    %subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.2*(4*Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),MM(i))                    
                    hold on
                    if i<N1 % traits verticaux
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];
                        %subplot (1,2,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                    
                end
                
            elseif C==3                
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    %subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.5*(Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                    hold on                    
                    if i<N1
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];% traits verticaux
                        %subplot (1,2,1);%subplot (2,1,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                   
                end
                
            elseif C==4                
                for i=1:N1
                    X=[Z(i),Z(i+1)];
                    VBb=[VB(i),VB(i)];CBb=[CB(i),CB(i)];
                    %subplot (1,2,1);%subplot (2,1,1);
                    plot(X,VBb,'s-',X,CBb,'s-');
                    text(0.5*(Z(i)+Z(i+1)),0.5*(VB(i)+CB(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                    hold on                    
                    if i<N1
                        Y=[Z(i+1),Z(i+1)];
                        VBc=[VB(i),VB(i+1)];CBc=[CB(i),CB(i+1)];% traits verticaux
                        %subplot (1,2,1);%subplot (2,1,1);
                        plot(Y,VBc,'s-',Y,CBc,'s-');
                    end                   
                end    
                
            end
            
            xlabel('x');ylabel('VB, CB edges');
            legend('VB edge', 'CB edge','Location','South');%'BestOutside')
            %title('Band edges within the stack');
            axes('Position',[0 0 8 8],'PlotBoxAspectRatio' ,[1 1 1]);
            hold off

            % Position [left bottom width height]
            % PlotBoxAspectRatio [px py pz]
            
            figure(2);%title('Gap sequence of stack');
            for i=1:N1
                X=[Z(i),Z(i+1)];
                EgGb=[EgG(i),EgG(i)];Egb=[Eg(i),Eg(i)];
                %subplot (1,2,2);%subplot (2,1,2);
                plot(X,EgGb,'s-',X,Egb,'s-');
                text(0.5*(Z(i)+Z(i+1)),0.5*(Eg(i)+EgG(i)),Matformula(i),...
                        'VerticalAlignment','middle','HorizontalAlignment','center','Rotation', 90)
                hold on                
                if i<N1
                    Y=[Z(i+1),Z(i+1)];
                    EgGc=[EgG(i),EgG(i+1)];Egc=[Eg(i),Eg(i+1)];
                    %subplot (1,2,2);%subplot (2,1,2);
                    plot(Y,EgGc,'s-',Y,Egc,'s-');
                end                
            end
                     
            hold off           
            xlabel('x');ylabel('Gap');
            legend('Direct Gap ', 'minimum gap','Location','North');%'BestOutside')
            %title('Gap sequence of stack');
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

        
        
    