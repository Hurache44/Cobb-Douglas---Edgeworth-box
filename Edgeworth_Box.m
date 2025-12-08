



        %%% Edgeworth Box %%%

        % Code via Google request, simplified
        % Cobb Douglas Function

        Total_X = 10;
        Total_Y = 10;

        % Parameter Cobb Douglas Function
        % IDC
        % IDC2
        a1 = 0.8;
        b1 = 0.2;
        a2 = 0.3;
        b2 = 0.7;

        InitialX = 3;
        InitialY = 4;

        figure;
        hold on;
        axis equal;
        axis([0 Total_X 0 Total_Y]);

        rectangle('Position',[0,0,Total_X,Total_Y],'EdgeColor','k','LineWidth',1.5);
        % rectangle('Position',[Total_X,Total_Y,-Total_X,-Total_Y],'EdgeColor','k','LineWidth',1.5);
        
        xlabel('Good X for Agent 1 (and Agent 2 from right to left)');
        ylabel('Good Y for Agent 1 (and AGend 2 from top to bottom)');
        title('Edgeworth Box');
        grid on;
        
        % Utility 1
        x_1 = linspace(0.1,Total_X,100);
        y_1 = linspace(0.1,Total_Y,100);
        [X_1,Y_1] = meshgrid(x_1,y_1);
        IDC = (X_1.^a1).*(Y_1.^b1)

        contour(X_1,Y_1,IDC,10,'DisplayName','Utility 1 IDC','LineColor','blue');

        % Utility 2 - inverse attributes of graph

        % x_2 = linspace(0.1,Total_X,100);
        % y_2 = linspace(0.1,Total_Y,100);
        U2_ConsX = Total_X - X_1;
        U2_ConsY = Total_Y - Y_1;
        % [X_2,Y_2] = meshgrid(x_2,y_2);
        IDC2 = (U2_ConsX.^a2).*(U2_ConsY.^b2);

        contour(X_1,Y_1,IDC2,10,'DisplayName','Utility 2','LineColor','red','LineStyle','--');

        % Endowment Point
        plot(InitialX,InitialY,'ko','MarkerSize',8,'MarkerFaceColor','k','DisplayName','Initial Endowment');
        hold off;
        legend show;
        %%
        

        %%
        U_A1 = 10;
        U_A2 = 20;
        level_A1 = contourc(x_A,y_A,X_A.*Y_A,[U_A1 U_A1]);      % Function form?
        level_A2 = contourc(x_A,y_A,X_A.*Y_A,[U_A2 U_A2]);
        plot(level_A1(1,2:end),level_A2(1,2:end),'b-','LineWidth',1.5);
        plot(level_A2(1,2:end),level_A1(1,2:end),'b-','LineWidth',1.5);

        U_B1 = 15;
        U_B2 = 25;
        level_B1 = contourc(x_A,y_A,(Total_X - X_A).*(Total_Y - Y_A),[U_B1 U_B1]);
        level_B2 = contourc(x_A,y_A,(Total_X - X_A).*(Total_Y - Y_A),[U_B2 U_B2]);
        plot(level_B1(1,2:end),level_B1(2,2:end),'r-','LineWidth',1.5);
        plot(level_B2(1,2:end),level_B2(2,2:end),'r-','LineWidth',1.5);

        Endowment_X = 3;
        Endowment_Y = 4;
        plot(Endowment_X,Endowment_Y,'ko','MarkerFaceColor','k','')

