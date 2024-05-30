function feat_to_select = featureSelection( FileSFFS,num_feat,Output )

    FID = fopen(FileSFFS, 'r');
    Data = textscan(FID, '%s', 'delimiter', '\n', 'whitespace', '');
    CStr = Data{1};
    fclose(FID);

    SearchedString=['Feature to select ' num2str(num_feat)];
    Index = find(strcmp(CStr, SearchedString), 1);
    a=CStr(Index+4);
    C2 = strsplit(a{1,1});
    feat=C2(1,3:2+num_feat);
    m=cellfun(@str2num,feat(1:end),'un',0);
    feat_to_select=cell2mat(m);

    save([Output num2str(num_feat) 'featSFFS' ],'feat_to_select');
end

