



        %%% Edgeworth Box %%%

        % to do: Pareto, Efficient Frontier, Skalenerträge

        % Code via Google request, simplified
        % Cobb Douglas Function

        Total_X = 10;
        Total_Y = 10;

        % Parameter Cobb Douglas Function
        % IDC
        % IDC2
        % Output elasticity of capital and labor/Utility 
        a1 = 0.8;
        b1 = 1.05;           % sum a1+b1 < 1 decreasing returns to scale, = 1 constant returns to scale, > 1 increasing returns to scale
        a2 = 1.05;
        b2 = 0.95;

        % Shifted or "initial" endowment of 1
        InitialX = 5;       % can be changed 
        InitialY = 8;
        % unexplained residual for IDC1
        % A = 0.6;
        
        figure(1);
        hold on;
        axis equal;
        axis([0 Total_X 0 Total_Y]);

        rectangle('Position',[0,0,Total_X,Total_Y],'EdgeColor','k','LineWidth',1.5);
        % rectangle('Position',[Total_X,Total_Y,-Total_X,-Total_Y],'EdgeColor','k','LineWidth',1.5);
        
        xlabel('Good X for Agent 1 (and Agent 2 from right to left)');
        ylabel('Good Y for Agent 1 (and Agent 2 from top to bottom)');
        title('Edgeworth Box');
        grid on;
        
        % Utility 1
        x_1 = linspace(0.1,Total_X,100);
        y_1 = linspace(0.1,Total_Y,100);
        [X_1,Y_1] = meshgrid(x_1,y_1);
        IDC = ((X_1.^a1)).*((Y_1.^b1))

        % contour(X_1,Y_1,IDC,10,'DisplayName','Utility 1 IDC','LineColor','blue');

        % Utility 2 - inverse attributes of graph

        % x_2 = linspace(0.1,Total_X,100);
        % y_2 = linspace(0.1,Total_Y,100);
        U2_ConsX = Total_X - X_1;
        U2_ConsY = Total_Y - Y_1;
        U2_ConsX(U2_ConsX <= 0) = eps;
        U2_ConsY(U2_ConsY <= 0) = eps;
        % [X_2,Y_2] = meshgrid(x_2,y_2);
        IDC2 = (U2_ConsX.^a2).*(U2_ConsY.^b2);

        % plot(X_contract,Y_contract,'k-','LineWidth',2.5,'DisplayName','Contract Curve (Pareto Set)');

        % Endowment Point
        % plot(InitialX,InitialY,'ko','MarkerSize',8,'MarkerFaceColor','k','DisplayName','Initial Endowment');

        U1_endowment = (InitialX^a1)*(InitialY^b1);
        contour(X_1,Y_1,IDC,[U1_endowment U1_endowment],'LineColor','cyan','LineWidth',1.5,'DisplayName','U1 at Endowment');

        U2_endowment = ((Total_X-InitialX)^a2)*((Total_Y-InitialY)^b2);
        contour(X_1,Y_1,IDC2,[U2_endowment U2_endowment],'LineColor','cyan','LineWidth',1.5,'DisplayName','U2 at Endowment');
       
        % Contract curve
        param_num = a1*b2*Total_Y;
        param_den_const = b1*a2*Total_X;
        param_den_mult = (a1*b2)-(b1*a2);

        X_contract = linspace(0.1,Total_X-0.1,100);
        % Contract curve
        % Y = (a1*b2*Ty*Xcontract)/(b1*a2*Tx+(a1*b2-b1*a2)Xcontract)
        Y_contract = (param_num.*X_contract)./(param_den_const+param_den_mult.*X_contract);
        plot(X_contract,Y_contract,'k-','LineWidth',1.5,'DisplayName','Contract Curve (Pareto Set)');

        plot(InitialX,InitialY,'ko','MarkerSize',8,'MarkerFaceColor','k','DisplayName','Vector of Endowment');
        
        hold off;
        legend show;
        
        text(Total_X*0.55, Total_Y*0.5, ...
            '$\mathrm{MRS}_{XY1} = \frac{a1}{b1}\frac{Y}{X}$', ...
            'Interpreter','latex', ...
            'FontSize',12, ...
            'Color','blue');
        text(Total_X*0.05, Total_Y*0.1, ...
            '$\mathrm{MRS}_{XY2} = \frac{a2}{b2}\frac{Y_2}{X_2}$', ...
            'Interpreter','latex', ...
            'FontSize',12, ...
            'HorizontalAlignment','left', ...
            'Color','red');

        % Efficient
        efficient_sets_table = table(X_contract',Y_contract','VariableNames',{'X_Agent','Y_Agent'});
        disp('Table of Efficient Parameter Sets (Coordinates along the Contract Curve:');
        disp(efficient_sets_table);
        figure;
        plot(X_contract,Y_contract,'ko','MarkerSize',4,'MarkerFaceColor','k','DisplayName','Efficient Parameter Set (Points)');
        
        % Utility function 1:
        % Regressionsgerade: Aktien (n), Correlationskoeffizient als Potenz
        % Regressionsgerade: Wechselkurse, Correlationskoeffizienten und
        % Zinsen (Covered Interest rate partität)

        % MRS
        MUX1 = a1.*(X_1.^(a1-1)).*(Y_1.^b1);
        MUY1 = b1.*(X_1.^a1).*(Y_1.^(b1-1));

        MUX2 = a2.*(U2_ConsX.^(a2-1)).*(U2_ConsY.^b2);
        MUY2 = b2.*(U2_ConsX.^a2).*(U2_ConsY.^(b2-1));

        MRSXY1 = MUX1./MUY1
        MRSYX1 = MUY1./MUX1

        MRSXY2 = MUX2./MUY2
        MRSYX2 = MUY2./MUX2

        % Marginal rate of Substitution
        MRSXY1_func = (a1/b1).*(Y_contract./X_contract);
        U2_X_contract = Total_X - X_contract;
        U2_Y_contract = Total_Y - Y_contract;
        MRSXY2_func = (a2/b2).*(U2_Y_contract./U2_X_contract);


        figure(2);
        hold on;
        plot(X_contract,MRSXY1_func,'b-','LineWidth',2,'DisplayName','MRSXY Agent 1 Function (along CC)');
        plot(X_contract,MRSXY2_func,'r--','LineWidth',1.5,'DisplayName','MRSXY Agent 2 Function (along CC)');
        hold off;

        xlabel('Good X allocation to Agent 1');
        ylabel('Marginal Rate of Substitution (MRSXY)');
        title('MRS Function - along the contract curve (non-linear relationship)');
        grid on;
        legend show;

        str1 = sprintf('$$MRS_{XY1} = (%.2f/%.2f) \\ cdot(Y/X)$$',a1,b1);
        str2 = sprintf('$$MRS_{XY2} = (%.2f/%.2f) \\ cdot(Y_2/X_2)$$',a2,b2);

        text(2,max(MRSXY1_func)*0.5,str1, ...
            'Interpreter','latex', ...
            'FontSize',12, ...
            'Color','blue');
        text(6,max(MRSXY2_func)*0.6,str2, ...
            'Interpreter','latex', ...
            'FontSize',12, ...
            'Color','red');

        %% Utility function
        

        %% Marginal rate of substitution


        %% Marginal rate of technical substitution
        
