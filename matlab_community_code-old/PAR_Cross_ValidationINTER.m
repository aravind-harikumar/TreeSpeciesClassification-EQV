

function [cmd,bestc]=PAR_Cross_ValidationINTER(X,t,C_values)
%%%%matlab libsvm cross validation

cvResults = zeros(1,size(C_values,2));

parfor c =1:size(C_values,2)
        cmd = ['-v 5 -t 5 -c ', num2str(C_values(1,c))];
        cv = svmtrain(t',X,cmd);
        if (cv >= cvResults(1,c))
            cvResults(1,c) = cv;
        end
        %fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv,
        %bestc, bestg, bestcv);
end


[~,i] = max(cvResults);
bestc = C_values(1,i);
fprintf('bestc = %d %d %d\n', bestc);

cmd = ['-t 5 -c ', num2str(bestc)];
