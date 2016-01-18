HOMEANNOTATIONS = 'http://labelme.csail.mit.edu/Annotations';
HOMEIMAGES = 'http://labelme.csail.mit.edu/Images';
D = LMdatabase(HOMEANNOTATIONS, {'web_btn_images'});
% LMdbshowscenes(D, HOMEIMAGES);

%%
[a,img] = LMread(D,1,HOMEIMAGES);

%%
