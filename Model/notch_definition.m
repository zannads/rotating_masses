function notch = notch_definition( wn_num, psi_num, wn_den, psi_den )
    notch = (wn_den^2/wn_num^2) * tf( [1, 2*psi_num*wn_num, wn_num^2],[1, 2*psi_den*wn_den, wn_den^2] );
end
