function err = Mitra01_sig_con(W_coef)

global levels
global responses

%param1 = 0.5*(sin(W_coef(1))+1);
%param2 = (1-param1)*0.5*(sin(W_coef(2))+1);
%y = param1 + param2./(1+exp(-(levels-W_coef(3))/W_coef(4)));
%err = sum((y-responses).^2);

y = W_coef(1) + W_coef(2)./(1+exp(-(levels-W_coef(3))/W_coef(4)));
err = sum((y-responses).^2);
penalty1 = double(W_coef(1)<0 | W_coef(1)>1);
penalty2 = double((W_coef(1)+W_coef(2))>1);
err = err+penalty1*sum(responses.^2)+penalty2*sum(responses.^2);

