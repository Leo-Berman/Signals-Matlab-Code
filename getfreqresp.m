% Leo Berman
% 10/10/2023
% usage: getfreqresp(input your transfer function, input your title as
% 'title'
function[peakmag]=getfreqresp(transfunc,string,freqs)
    
    % getting the transfer function
    [n, d]=numden(transfunc);
    coeffs_n=fliplr(double(coeffs(n)));
    coeffs_d=fliplr(double(coeffs(d)));
    Hs_fromtf=tf(coeffs_n,coeffs_d);
    
    % plots the bode diagram
    bode(Hs_fromtf); 
    title(string)
    hold off
    snapnow

    %
    [mags,frequencies,wout]= bode(Hs_fromtf,freqs);
    peakmag=max(abs(mags));


end
