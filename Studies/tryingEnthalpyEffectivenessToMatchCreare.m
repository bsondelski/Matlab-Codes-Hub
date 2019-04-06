        % 1 sub HEX
%         q_max = C_dot_min*(T_H_in-T_C_in)
%         p_H_out = p_H(N+1)
%         [~, ~, h_H_min] = getPropsTP(T_C_in,p_H_out,fluid_H,mode,1);
%         q_max_H = m_dot_H*(h_H_in-h_H_min)
%         p_C_out = p_C(1)l
%         [~, ~, h_C_max] = getPropsTP(T_H_in,p_C_out,fluid_C,mode,1);
%         q_max_C = m_dot_C*(h_C_max-h_C_in)
%         q_max = min(q_max_H,q_max_C);
%         epsilon = q_dot/q_max;
        
% >1 sub HEX
%         [~, ~, h_H_min] = getPropsTP(T_C(2:N+1),p_H(2:N+1),fluid_H,mode,1);
%         q_max_H = m_dot_H.*(h_H(1:N)-h_H_min);
%         [~, ~, h_C_max] = getPropsTP(T_H(1:N),p_C(1:N),fluid_C,mode,1);
%         q_max_C = m_dot_C.*(h_C_max-h_C(2:N+1));
%         q_max = min(q_max_H,q_max_C);
%         epsilon = q_dot./(N.*q_max);