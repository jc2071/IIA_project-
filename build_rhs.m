function rhsvec = build_rhs(xs, ys, alpha)
% b is length np+1 and first and last elements are 0 to satisfy auxillary
% equations.
% The intermediate elements are psi_fs(i) - psi_fs(i+1)

    %Make psi_fs
    psi_fs = ( ys*cos(alpha) - xs*sin(alpha) );
    
    %Subtract psi_fs(i+1) from psi_fs(i) - don't worry about edge effects
    %these will get cleaned up in truncation
    temp = ( circshift(psi_fs, 1) - psi_fs );
    
    %Truncate the first and last elements of psi and replace them with 0
    %Then transpose to column vector
    rhsvec = [0, temp( 2:length(temp)-1 ), 0]';
end