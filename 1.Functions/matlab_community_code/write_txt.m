function [] = write_txt(file_name, A)

[ClassesNumber x] = size(A);
[x FeaturesNumber] = size(A{1});

TotPattern = 0;
for i=1:ClassesNumber
    [PatternNumber(i) x]=size(A{i});
    TotPattern = TotPattern + PatternNumber(i);
end

fid=fopen(file_name ,'wt');


count=1;
for i=1:ClassesNumber
    for j=1:PatternNumber(i)
        fprintf(fid,'P%d ',count);
        for n=1:FeaturesNumber
            fprintf(fid,'%f ',A{i}(j,n));
        end
         fprintf(fid,'%d ',i);
        
        fprintf(fid,'\n');  
        count = count + 1;
    end
end
        

fclose(fid);