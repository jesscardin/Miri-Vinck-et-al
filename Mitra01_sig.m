function err = Mitra01_sig(W_coef)

global levels
global responses

y = W_coef(1) + W_coef(2)./(1+exp(-(levels-W_coef(3))/W_coef(4)));
err = sum((y-responses).^2);
