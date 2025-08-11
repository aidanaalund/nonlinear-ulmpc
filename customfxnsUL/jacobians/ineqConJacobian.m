function [Geq,Gmv,Ge] = ineqConJacobian(X,U,e,data,params)
    Nx = Dimensions.NumberOfStates;
    Nmv = 1;
    Nc = params.numConstraints;
    Hp = data.PredictionHorizon;


    % 20 x 2 x 6
    Geq = zeros(Hp,Nx,Nc);
    
    for i=1:Hp
        Geq(i,:,:) = [0,0,1,-1,0,0;
                      0,0,0,0,0,0];

    end

    % 20 x 1 x 1
    Gmv = zeros(Hp,Nmv,Nc);
    for i=1:Hp
        data.MVIndex;
    end
    Ge = 0;
end
