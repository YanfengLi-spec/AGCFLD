 function  [SamplsFea,XSmpgnd,gndSmpNum]=Creat_SampleDatasets(fea,KClass,gnd,nClass,LabelsRatio)
Tags=tabulate(gnd);
SmpNumPerClass=Tags(:,2);
Per=cumsum(SmpNumPerClass);
%Per=All/nClass;         % ÿ�����к��е�������
Kmix=randperm(nClass);  % ���ұ�ǩ��˳��
Klei=Kmix(1:KClass);    % ȡ��������� Klei ��(��Ҫ������Klei=2,3��������10)
% ȡ���� Klei ��������ͱ�ǩ���ԭʼ�ֽ���� X
% ���磺
% ����� KClass=2,��ȡ�������������£�
% TempFea=[fea(1+(Klei(1)-1)*Per:Klei(1)*Per,:);fea(1+(Klei(2)-1)*Per:Klei(2)*Per,:)];
TempFea=[];
TempOrders=[];
TempLabelsOrders=[];
for i=1:KClass
    if Klei(i)==1
        SmpNumPerClassOrders=1:Per(Klei(i));
       % TempFea=cat(1,TempFea,fea(1:Klei(i),:));
        TempOrders=cat(2,TempOrders,SmpNumPerClassOrders);
         NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);
%        if strcmp(dataset,'myORL32')        % �ж������ַ�����ȣ���������ݼ�ORL��ÿ������ȡ��������
%          NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);
%        else
%          NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);     % ÿ������ȡ 10% ��������Ϊÿ�����������ı�ǩ������
%        end
        %SmpNumPerClassOrders=Per(1:Klei(i));
        Orders=randperm(length(SmpNumPerClassOrders));
        TempLabelsOrders=[TempLabelsOrders,SmpNumPerClassOrders(Orders(1:NumP))];
    else
        %TempFea=cat(1,TempFea,fea(Per(Klei(i)-1)+1:Per(Klei(i)),:));
        SmpNumPerClassOrders=Per(Klei(i)-1)+1:Per(Klei(i));
        TempOrders=cat(2,TempOrders,SmpNumPerClassOrders);
%          if strcmp(dataset,'myORL32')        % �ж������ַ�����ȣ���������ݼ�ORL��ÿ������ȡ��������
%              NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);
%          else
%              NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);     % ÿ������ȡ 10% ��������Ϊÿ�����������ı�ǩ������
%          end
         NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio); 
         Orders=randperm(length(SmpNumPerClassOrders));
         TempLabelsOrders=[TempLabelsOrders,SmpNumPerClassOrders(Orders(1:NumP))];
       
    end
  
end
gndSmpNum=length(TempLabelsOrders);
SampleOrders=[TempLabelsOrders,setdiff(TempOrders,TempLabelsOrders)];
SamplsFea=fea(SampleOrders,:);% ����µ���������
%SamplsFea = NormalizeFea(SamplsFea);
SamplsGnd=gnd(SampleOrders);% ����µ���������

% ���¹涨 gnd �еı�ǩ
Temp=SamplsGnd;
for i=1:KClass
    SamplsGnd(Temp==Klei(i))=i;
end
XSmpgnd=SamplsGnd;
%X=SamplsFea;
 end
 