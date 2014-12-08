function [entropy] = Entro(prob)
if prob==1 || prob ==0
    entropy =0;
else
    entropy = prob*log2(1/prob) + ...
            (1-prob)*log2(1/(1-prob));
end
end