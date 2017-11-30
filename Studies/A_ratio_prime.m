function [ a_ratio ] = A_ratio_prime( Ae_Astar_half, )


a_ratio=1/M*(2/(gamma+1)*(1+(gamma-1)/2*M.^2)).^((gamma+1)/(2*(gamma-1)))-A/A_star;

for i=1:length(Area_full)
    
    A_i=Area_full(i);
    syms M
    f = 1/M*(2/(gm+1)*(1+(gm-1)/2*M.^2)).^((gm+1)/(2*(gm-1)))-A_i/A_star;
    G=matlabFunction(f);
    m_i=newtzero(G);
    if x_full(i)>=0
        M_full(i)=m_i(2);
    else
        M_full(i)=m_i(1);
    end
end
    
end

