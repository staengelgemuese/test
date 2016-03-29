%% Strohal # Find
clc
clear
close all
Fs=1000;
R=1
C=1
%% RE100D1E1_Data
RE100_D1_E1_MP4 = dlmread('C:\db_1\sessions\2d8fff16-6271-4fc2-91b3-8bfdfe41c0c6\LiftAndDragForce.txt','',1,0);
RE100_D1_E1_MP6 = dlmread('C:\db_1\sessions\5ab1e990-b0c1-4a72-92e7-914030a1660a\LiftAndDragForce.txt','',1,0);
RE100_D1_E1_MP8 = dlmread('C:\db_1\sessions\e73f6cb2-404d-436a-b7fb-c9c7fa24141b\LiftAndDragForce.txt','',1,0);
RE100_D1_E1_MP10 = dlmread('C:\db_1\sessions\ab40428b-a535-4c36-b367-31b0c5ad8d67\LiftAndDragForce.txt','',1,0);
RE100_D1_E1_MP11 = dlmread('C:\db_1\sessions\fa2fcfad-63d3-4cae-ab27-1637f6618754\LiftAndDragForce.txt','',1,0);



A1 = find(RE100_D1_E1_MP4(:,1) >= 90);
B1 = find(RE100_D1_E1_MP6(:,1) >= 90);
C1 = find(RE100_D1_E1_MP8(:,1) >= 90);
D1 = find(RE100_D1_E1_MP10(:,1) >= 90);
E1 = find(RE100_D1_E1_MP11(:,1) >= 90);

%figure
%plot(RE100_D1_E1_MP4(:,1),RE100_D1_E1_MP4(:,3)*2,...
%     RE100_D1_E1_MP6(:,1),RE100_D1_E1_MP6(:,3)*2,...
%     RE100_D1_E1_MP8(:,1),RE100_D1_E1_MP8(:,3)*2,...
%     RE100_D1_E1_MP10(:,1),RE100_D1_E1_MP10(:,3)*2,...
%     RE100_D1_E1_MP11(:,1),RE100_D1_E1_MP11(:,3)*2)
%legend('D1MP4','D1MP6','D1MP8','D1MP10','D1MP11')
%title('RE100 DG1E1')

RE100_D1_E1_MP4=RE100_D1_E1_MP4(A1,:);
RE100_D1_E1_MP6=RE100_D1_E1_MP6(B1,:);
RE100_D1_E1_MP8=RE100_D1_E1_MP8(C1,:);
RE100_D1_E1_MP10=RE100_D1_E1_MP10(D1,:);
RE100_D1_E1_MP11=RE100_D1_E1_MP11(E1,:);

x_D1_MP4 = RE100_D1_E1_MP4(1,1);
x_11=x_D1_MP4:0.001:120;
x_D1_MP6 = RE100_D1_E1_MP6(1,1);
x_12=x_D1_MP6:0.001:120;
x_D1_MP8 = RE100_D1_E1_MP8(1,1);
x_13=x_D1_MP8:0.001:120;
x_D1_MP10 = RE100_D1_E1_MP10(1,1);
x_14=x_D1_MP10:0.001:120;
x_D1_MP11 = RE100_D1_E1_MP10(1,1);
x_15=x_D1_MP10:0.001:120;

%figure
%plot(RE100_D1_E1_MP4(:,1),RE100_D1_E1_MP4(:,3),...
%     RE100_D1_E1_MP6(:,1),RE100_D1_E1_MP6(:,3),...
%     RE100_D1_E1_MP8(:,1),RE100_D1_E1_MP8(:,3),...
%     RE100_D1_E1_MP10(:,1),RE100_D1_E1_MP10(:,3))
%legend('D1MP4','D1MP6','D1MP8','D1MP10')
%title('RE100 DG1E1')

%Drag Coeff
yD1MP4 = interp1(RE100_D1_E1_MP4(:,1),RE100_D1_E1_MP4(:,3),x_11);
yD1MP6 = interp1(RE100_D1_E1_MP6(:,1),RE100_D1_E1_MP6(:,3),x_12);
yD1MP8 = interp1(RE100_D1_E1_MP8(:,1),RE100_D1_E1_MP8(:,3),x_13);
yD1MP10 = interp1(RE100_D1_E1_MP10(:,1),RE100_D1_E1_MP10(:,3),x_14);
yD1MP11 = interp1(RE100_D1_E1_MP11(:,1),RE100_D1_E1_MP11(:,3),x_15);

%figure
%plot(RE100_D1_E1_MP4(:,1),RE100_D1_E1_MP4(:,3)*2,...
%     RE100_D1_E1_MP6(:,1),RE100_D1_E1_MP6(:,3)*2,...
%     RE100_D1_E1_MP8(:,1),RE100_D1_E1_MP8(:,3)*2,...
%     RE100_D1_E1_MP10(:,1),RE100_D1_E1_MP10(:,3)*2,...
%     RE100_D1_E1_MP11(:,1),RE100_D1_E1_MP11(:,3)*2)
%legend('D3MP4','D3MP6','D3MP8','D3MP10','D3MP11')
%title('RE100 DG3E3')

xdft_yD1MP4 = fft(yD1MP4-mean(yD1MP4));
xdft_yD1MP6 = fft(yD1MP6-mean(yD1MP6));
xdft_yD1MP8 = fft(yD1MP8-mean(yD1MP8));
xdft_yD1MP10 = fft(yD1MP10-mean(yD1MP10));
xdft_yD1MP11 = fft(yD1MP11-mean(yD1MP11));

[YD1MP4,ID1MP4]=max(abs(xdft_yD1MP4));
freqD1MP4=0:Fs/length(yD1MP4):Fs/2;
freq(1,1)=freqD1MP4(ID1MP4);
Cd_D1MP4=mean(RE100_D1_E1_MP4(:,3))*2;
CdMax_D1MP4=max(RE100_D1_E1_MP4(:,3))*2-Cd_D1MP4;
CdMin_D1MP4=abs(min(RE100_D1_E1_MP4(:,3))*2-Cd_D1MP4);
Cd(1,1)=Cd_D1MP4;
Var(1,1)=CdMax_D1MP4-CdMin_D1MP4;
Cd_Range(1,1)=(CdMax_D1MP4+CdMin_D1MP4)/2;

[YD1MP6,ID1MP6]=max(abs(xdft_yD1MP6));
freqD1MP6=0:Fs/length(yD1MP6):Fs/2;
freq(1,2)=freqD1MP6(ID1MP6);
Cd_D1MP6=mean(RE100_D1_E1_MP6(:,3))*2;
CdMax_D1MP6=max(RE100_D1_E1_MP6(:,3))*2-Cd_D1MP6;
CdMin_D1MP6=abs(min(RE100_D1_E1_MP6(:,3))*2-Cd_D1MP6);
Cd(1,2)=Cd_D1MP6;
Var(1,2)=CdMax_D1MP6-CdMin_D1MP6;
Cd_Range(1,2)=(CdMax_D1MP6+CdMin_D1MP6)/2;

[YD1MP8,ID1MP8]=max(abs(xdft_yD1MP8));
freqD1MP8=0:Fs/length(yD1MP8):Fs/2;
freq(1,3)=freqD1MP8(ID1MP8);
Cd_D1MP8=mean(RE100_D1_E1_MP8(:,3))*2;
CdMax_D1MP8=max(RE100_D1_E1_MP8(:,3))*2-Cd_D1MP8;
CdMin_D1MP8=abs(min(RE100_D1_E1_MP8(:,3))*2-Cd_D1MP8);
Cd(1,3)=Cd_D1MP8;
Var(1,3)=CdMax_D1MP8-CdMin_D1MP8;
Cd_Range(1,3)=(CdMax_D1MP8+CdMin_D1MP8)/2;

[YD1MP10,ID1MP10]=max(abs(xdft_yD1MP10));
freqD1MP10=0:Fs/length(yD1MP10):Fs/2;
freq(1,4)=freqD1MP10(ID1MP10);
Cd_D1MP10=mean(RE100_D1_E1_MP10(:,3))*2;
CdMax_D1MP10=max(RE100_D1_E1_MP10(:,3))*2-Cd_D1MP10;
CdMin_D1MP10=abs(min(RE100_D1_E1_MP10(:,3))*2-Cd_D1MP10);
Cd(1,4)=Cd_D1MP10;
Var(1,4)=CdMax_D1MP10-CdMin_D1MP10;
Cd_Range(1,4)=(CdMax_D1MP10+CdMin_D1MP10)/2;

[YD1MP11,ID1MP11]=max(abs(xdft_yD1MP11));
freqD1MP11=0:Fs/length(yD1MP11):Fs/2;
freq(1,5)=freqD1MP10(ID1MP11);
Cd_D1MP11=mean(RE100_D1_E1_MP11(:,3))*2;
CdMax_D1MP11=max(RE100_D1_E1_MP11(:,3))*2-Cd_D1MP11;
CdMin_D1MP11=abs(min(RE100_D1_E1_MP11(:,3))*2-Cd_D1MP11);
Cd(1,5)=Cd_D1MP11;
Var(1,5)=CdMax_D1MP11-CdMin_D1MP11;
Cd_Range(1,5)=(CdMax_D1MP11+CdMin_D1MP11)/2;

%Lift Coeff
ClyD1MP4 = interp1(RE100_D1_E1_MP4(:,1),RE100_D1_E1_MP4(:,2),x_11);
ClyD1MP6 = interp1(RE100_D1_E1_MP6(:,1),RE100_D1_E1_MP6(:,2),x_12);
ClyD1MP8 = interp1(RE100_D1_E1_MP8(:,1),RE100_D1_E1_MP8(:,2),x_13);
ClyD1MP10 = interp1(RE100_D1_E1_MP10(:,1),RE100_D1_E1_MP10(:,2),x_14);
ClyD1MP11 = interp1(RE100_D1_E1_MP11(:,1),RE100_D1_E1_MP11(:,2),x_15);

Clxdft_yD1MP4 = fft(ClyD1MP4-mean(ClyD1MP4));
Clxdft_yD1MP6 = fft(ClyD1MP6-mean(ClyD1MP6));
Clxdft_yD1MP8 = fft(ClyD1MP8-mean(ClyD1MP8));
Clxdft_yD1MP10 = fft(ClyD1MP10-mean(ClyD1MP10));
Clxdft_yD1MP11 = fft(ClyD1MP11-mean(ClyD1MP11));

[ClYD1MP4,ClID1MP4]=max(abs(Clxdft_yD1MP4));
ClfreqD1MP4=0:Fs/length(ClyD1MP4):Fs/2;
Clfreq(1,1)=ClfreqD1MP4(ClID1MP4);
Cl_D1MP4=mean(RE100_D1_E1_MP4(:,2));
ClMax_D1MP4=max(RE100_D1_E1_MP4(:,2))-Cl_D1MP4;
ClMin_D1MP4=abs(min(RE100_D1_E1_MP4(:,2))-Cl_D1MP4);
Cl(1,1)=Cl_D1MP4;
ClVar(1,1)=ClMax_D1MP4-ClMin_D1MP4;
Cl_Range(1,1)=(ClMax_D1MP4+ClMin_D1MP4);

[ClYD1MP6,ClID1MP6]=max(abs(Clxdft_yD1MP6));
ClfreqD1MP6=0:Fs/length(ClyD1MP6):Fs/2;
Clfreq(1,2)=ClfreqD1MP6(ClID1MP6);
Cl_D1MP6=mean(RE100_D1_E1_MP6(:,2));
ClMax_D1MP6=max(RE100_D1_E1_MP6(:,2))-Cl_D1MP6;
ClMin_D1MP6=abs(min(RE100_D1_E1_MP6(:,2))-Cl_D1MP6);
Cl(1,2)=Cl_D1MP6;
ClVar(1,2)=ClMax_D1MP6-ClMin_D1MP6;
Cl_Range(1,2)=(ClMax_D1MP6+ClMin_D1MP6);

[ClYD1MP8,ClID1MP8]=max(abs(Clxdft_yD1MP8));
ClfreqD1MP8=0:Fs/length(ClyD1MP8):Fs/2;
Clfreq(1,3)=ClfreqD1MP8(ClID1MP8);
Cl_D1MP8=mean(RE100_D1_E1_MP8(:,2));
ClMax_D1MP8=max(RE100_D1_E1_MP8(:,2))-Cl_D1MP8;
ClMin_D1MP8=abs(min(RE100_D1_E1_MP8(:,2))-Cl_D1MP8);
Cl(1,3)=Cl_D1MP8;
ClVar(1,3)=ClMax_D1MP8-ClMin_D1MP8;
Cl_Range(1,3)=(ClMax_D1MP8+ClMin_D1MP8);

[ClYD1MP10,ClID1MP10]=max(abs(Clxdft_yD1MP10));
ClfreqD1MP10=0:Fs/length(ClyD1MP10):Fs/2;
Clfreq(1,4)=ClfreqD1MP10(ClID1MP10);
Cl_D1MP10=mean(RE100_D1_E1_MP10(:,2));
ClMax_D1MP10=max(RE100_D1_E1_MP10(:,2))-Cl_D1MP10;
ClMin_D1MP10=abs(min(RE100_D1_E1_MP10(:,2))-Cl_D1MP10);
Cl(1,4)=Cl_D1MP10;
ClVar(1,4)=ClMax_D1MP10-ClMin_D1MP10;
Cl_Range(1,4)=(ClMax_D1MP10+ClMin_D1MP10);

[ClYD1MP11,ClID1MP11]=max(abs(Clxdft_yD1MP11));
ClfreqD1MP11=0:Fs/length(ClyD1MP11):Fs/2;
Clfreq(1,5)=ClfreqD1MP11(ClID1MP11);
Cl_D1MP11=mean(RE100_D1_E1_MP11(:,2));
ClMax_D1MP11=max(RE100_D1_E1_MP11(:,2))-Cl_D1MP11;
ClMin_D1MP11=abs(min(RE100_D1_E1_MP11(:,2))-Cl_D1MP11);
Cl(1,5)=Cl_D1MP11;
ClVar(1,5)=ClMax_D1MP11-ClMin_D1MP11;
Cl_Range(1,5)=(ClMax_D1MP11+ClMin_D1MP11);

%% RE100D2E2_Data
RE100_D2_E2_MP4 = dlmread('C:\db_1\sessions\ead610e5-1024-4a7f-85a6-489560359c6c\LiftAndDragForce.txt','',1,0);
RE100_D2_E2_MP6 = dlmread('C:\db_1\sessions\bc79dacb-e908-44fe-a8fb-4da49904da20\LiftAndDragForce.txt','',1,0);
RE100_D2_E2_MP8 = dlmread('C:\db_1\sessions\088a8921-c323-45b8-aae2-b4171f150f82\LiftAndDragForce.txt','',1,0);
RE100_D2_E2_MP10 = dlmread('C:\db_1\sessions\d0f7854a-4d64-4b85-82c2-e0f607b6ef5a\LiftAndDragForce.txt','',1,0);

A2 = find(RE100_D2_E2_MP4(:,1) >= 90);
B2 = find(RE100_D2_E2_MP6(:,1) >= 90);
C2 = find(RE100_D2_E2_MP8(:,1) >= 90);
D2 = find(RE100_D2_E2_MP10(:,1) >= 90);

RE100_D2_E2_MP4=RE100_D2_E2_MP4(A2,:);
RE100_D2_E2_MP6=RE100_D2_E2_MP6(B2,:);
RE100_D2_E2_MP8=RE100_D2_E2_MP8(C2,:);
RE100_D2_E2_MP10=RE100_D2_E2_MP10(D2,:);

x_D2_MP4 = RE100_D2_E2_MP4(1,1);
x_21=x_D2_MP4:0.001:120;
x_D2_MP6 = RE100_D2_E2_MP6(1,1);
x_22=x_D2_MP6:0.001:120;
x_D2_MP8 = RE100_D2_E2_MP8(1,1);
x_23=x_D2_MP8:0.001:120;
x_D2_MP10 = RE100_D2_E2_MP10(1,1);
x_24=x_D2_MP10:0.001:120;

yD2MP4 = interp1(RE100_D2_E2_MP4(:,1),RE100_D2_E2_MP4(:,3),x_21);
yD2MP6 = interp1(RE100_D2_E2_MP6(:,1),RE100_D2_E2_MP6(:,3),x_22);
yD2MP8 = interp1(RE100_D2_E2_MP8(:,1),RE100_D2_E2_MP8(:,3),x_23);
yD2MP10 = interp1(RE100_D2_E2_MP10(:,1),RE100_D2_E2_MP10(:,3),x_24);

%figure
%plot(RE100_D2_E2_MP4(:,1),RE100_D2_E2_MP4(:,3),...
%     RE100_D2_E2_MP6(:,1),RE100_D2_E2_MP6(:,3),...
%     RE100_D2_E2_MP8(:,1),RE100_D2_E2_MP8(:,3),...
%     RE100_D2_E2_MP10(:,1),RE100_D2_E2_MP10(:,3))
%legend('D2MP4','D2MP6','D2MP8','D2MP10')
%title('RE100 DG2E2') 

xdft_yD2MP4 = fft(yD2MP4-mean(yD2MP4));
xdft_yD2MP6 = fft(yD2MP6-mean(yD2MP6));
xdft_yD2MP8 = fft(yD2MP8-mean(yD2MP8));
xdft_yD2MP10 = fft(yD2MP10-mean(yD2MP10));

[YD2MP4,ID2MP4]=max(abs(xdft_yD2MP4));
freqD2MP4=0:Fs/length(yD2MP4):Fs/2;
freq(2,1)=freqD2MP4(ID2MP4);
Cd_D2MP4=mean(RE100_D2_E2_MP4(:,3))*2;
CdMax_D2MP4=max(RE100_D2_E2_MP4(:,3))*2-Cd_D2MP4;
CdMin_D2MP4=abs(min(RE100_D2_E2_MP4(:,3))*2-Cd_D2MP4);
Cd(2,1)=Cd_D2MP4;
Var(2,1)=CdMax_D2MP4-CdMin_D2MP4;
Cd_Range(2,1)=(CdMax_D2MP4+CdMin_D2MP4)/2;

[YD2MP6,ID2MP6]=max(abs(xdft_yD2MP6));
freqD2MP6=0:Fs/length(yD2MP6):Fs/2;
freq(2,2)=freqD2MP6(ID2MP6);
Cd_D2MP6=mean(RE100_D2_E2_MP6(:,3))*2;
CdMax_D2MP6=max(RE100_D2_E2_MP6(:,3))*2-Cd_D2MP6;
CdMin_D2MP6=abs(min(RE100_D2_E2_MP6(:,3))*2-Cd_D2MP6);
Cd(2,2)=Cd_D2MP6;
Var(2,2)=CdMax_D2MP6-CdMin_D2MP6;
Cd_Range(2,2)=(CdMax_D2MP6+CdMin_D2MP6)/2;

[YD2MP8,ID2MP8]=max(abs(xdft_yD2MP8));
freqD2MP8=0:Fs/length(yD2MP8):Fs/2;
freq(2,3)=freqD2MP8(ID2MP8);
Cd_D2MP8=mean(RE100_D2_E2_MP8(:,3))*2;
CdMax_D2MP8=max(RE100_D2_E2_MP8(:,3))*2-Cd_D2MP8;
CdMin_D2MP8=abs(min(RE100_D2_E2_MP8(:,3))*2-Cd_D2MP8);
Cd(2,3)=Cd_D2MP8;
Var(2,3)=CdMax_D2MP8-CdMin_D2MP8;
Cd_Range(2,3)=(CdMax_D2MP8+CdMin_D2MP8)/2;

[YD2MP10,ID2MP10]=max(abs(xdft_yD2MP10));
freqD2MP10=0:Fs/length(yD2MP10):Fs/2;
freq(2,4)=freqD2MP10(ID2MP10);
Cd_D2MP10=mean(RE100_D2_E2_MP10(:,3))*2;
CdMax_D2MP10=max(RE100_D2_E2_MP10(:,3))*2-Cd_D2MP10;
CdMin_D2MP10=abs(min(RE100_D2_E2_MP10(:,3))*2-Cd_D2MP10);
Cd(2,4)=Cd_D2MP10;
Var(2,4)=CdMax_D2MP10-CdMin_D2MP10;
Cd_Range(2,4)=(CdMax_D2MP10+CdMin_D2MP10)/2;

%Lift Coeff
ClyD2MP4 = interp1(RE100_D2_E2_MP4(:,1),RE100_D2_E2_MP4(:,2),x_21);
ClyD2MP6 = interp1(RE100_D2_E2_MP6(:,1),RE100_D2_E2_MP6(:,2),x_22);
ClyD2MP8 = interp1(RE100_D2_E2_MP8(:,1),RE100_D2_E2_MP8(:,2),x_23);
ClyD2MP10 = interp1(RE100_D2_E2_MP10(:,1),RE100_D2_E2_MP10(:,2),x_24);

Clxdft_yD2MP4 = fft(ClyD2MP4-mean(ClyD2MP4));
Clxdft_yD2MP6 = fft(ClyD2MP6-mean(ClyD2MP6));
Clxdft_yD2MP8 = fft(ClyD2MP8-mean(ClyD2MP8));
Clxdft_yD2MP10 = fft(ClyD2MP10-mean(ClyD2MP10));

[ClYD2MP4,ClID2MP4]=max(abs(Clxdft_yD2MP4));
ClfreqD2MP4=0:Fs/length(ClyD2MP4):Fs/2;
Clfreq(2,1)=ClfreqD2MP4(ClID2MP4);
Cl_D2MP4=mean(RE100_D2_E2_MP4(:,2));
ClMax_D2MP4=max(RE100_D2_E2_MP4(:,2))-Cl_D2MP4;
ClMin_D2MP4=abs(min(RE100_D2_E2_MP4(:,2))-Cl_D2MP4);
Cl(2,1)=Cl_D2MP4;
ClVar(2,1)=ClMax_D2MP4-ClMin_D2MP4;
Cl_Range(2,1)=(ClMax_D2MP4+ClMin_D2MP4);

[ClYD2MP6,ClID2MP6]=max(abs(Clxdft_yD2MP6));
ClfreqD2MP6=0:Fs/length(ClyD2MP6):Fs/2;
Clfreq(2,2)=ClfreqD2MP6(ClID2MP6);
Cl_D2MP6=mean(RE100_D2_E2_MP6(:,2));
ClMax_D2MP6=max(RE100_D2_E2_MP6(:,2))-Cl_D2MP6;
ClMin_D2MP6=abs(min(RE100_D2_E2_MP6(:,2))-Cl_D2MP6);
Cl(2,2)=Cl_D2MP6;
ClVar(2,2)=ClMax_D2MP6-ClMin_D2MP6;
Cl_Range(2,2)=(ClMax_D2MP6+ClMin_D2MP6);

[ClYD2MP8,ClID2MP8]=max(abs(Clxdft_yD2MP8));
ClfreqD2MP8=0:Fs/length(ClyD2MP8):Fs/2;
Clfreq(2,3)=ClfreqD2MP8(ClID2MP8);
Cl_D2MP8=mean(RE100_D2_E2_MP8(:,2));
ClMax_D2MP8=max(RE100_D2_E2_MP8(:,2))-Cl_D2MP8;
ClMin_D2MP8=abs(min(RE100_D2_E2_MP8(:,2))-Cl_D2MP8);
Cl(2,3)=Cl_D2MP8;
ClVar(2,3)=ClMax_D2MP8-ClMin_D2MP8;
Cl_Range(2,3)=(ClMax_D2MP8+ClMin_D2MP8);

[ClYD2MP10,ClID2MP10]=max(abs(Clxdft_yD2MP10));
ClfreqD2MP10=0:Fs/length(ClyD2MP10):Fs/2;
Clfreq(2,4)=ClfreqD2MP10(ClID2MP10);
Cl_D2MP10=mean(RE100_D2_E2_MP10(:,2));
ClMax_D2MP10=max(RE100_D2_E2_MP10(:,2))-Cl_D2MP10;
ClMin_D2MP10=abs(min(RE100_D2_E2_MP10(:,2))-Cl_D2MP10);
Cl(2,4)=Cl_D2MP10;
ClVar(2,4)=ClMax_D2MP10-ClMin_D2MP10;
Cl_Range(2,4)=(ClMax_D2MP10+ClMin_D2MP10);


%% RE100D3E3_Data
RE100_D3_E3_MP4 = dlmread('C:\db_1\sessions\93c73aa6-3273-48ad-b8a8-86f5ca331949\LiftAndDragForce.txt','',1,0);
RE100_D3_E3_MP6 = dlmread('C:\db_1\sessions\9adecb63-91c8-4714-86a5-2d9c9d129212\LiftAndDragForce.txt','',1,0);
RE100_D3_E3_MP8 = dlmread('C:\db_1\sessions\ec41b6aa-13cf-4a09-b036-0851d06ffa12\LiftAndDragForce.txt','',1,0);
RE100_D3_E3_MP10 = dlmread('C:\db_1\sessions\0c6dfa9a-c953-41e2-927b-3088f0770925\LiftAndDragForce.txt','',1,0);
plot(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,3)*2,'k')
ylabel('C_D')
xlabel('t')
axis([0 120 1 1.6])

figure
plot(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,2)*2,'k')
ylabel('C_L')
xlabel('t')
axis([0 120 -0.35 0.35])

A3 = find(RE100_D3_E3_MP4(:,1) >= 90);
B3 = find(RE100_D3_E3_MP6(:,1) >= 90);
C3 = find(RE100_D3_E3_MP8(:,1) >= 90);
D3 = find(RE100_D3_E3_MP10(:,1) >= 90);

RE100_D3_E3_MP4=RE100_D3_E3_MP4(A3,:);
RE100_D3_E3_MP6=RE100_D3_E3_MP6(B3,:);
RE100_D3_E3_MP8=RE100_D3_E3_MP8(C3,:);
RE100_D3_E3_MP10=RE100_D3_E3_MP10(D3,:);

x_D3_MP4 = RE100_D3_E3_MP4(1,1);
x_31=x_D3_MP4:0.001:120;
x_D3_MP6 = RE100_D3_E3_MP6(1,1);
x_32=x_D3_MP6:0.001:120;
x_D3_MP8 = RE100_D3_E3_MP8(1,1);
x_33=x_D3_MP8:0.001:120;
x_D3_MP10 = RE100_D3_E3_MP10(1,1);
x_34=x_D3_MP10:0.001:120;

yD3MP4 = interp1(RE100_D3_E3_MP4(:,1),RE100_D3_E3_MP4(:,3),x_31);
yD3MP6 = interp1(RE100_D3_E3_MP6(:,1),RE100_D3_E3_MP6(:,3),x_32);
yD3MP8 = interp1(RE100_D3_E3_MP8(:,1),RE100_D3_E3_MP8(:,3),x_33);
yD3MP10 = interp1(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,3),x_34);

%figure
%plot(RE100_D3_E3_MP4(:,1),RE100_D3_E3_MP4(:,3),...
%     RE100_D3_E3_MP6(:,1),RE100_D3_E3_MP6(:,3),...
%     RE100_D3_E3_MP8(:,1),RE100_D3_E3_MP8(:,3),...
%     RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,3))
%legend('D3MP4','D3MP6',...
%       'D3MP8','D3MP10')
%title('RE100 DG3E3')

xdft_yD3MP4 = fft(yD3MP4-mean(yD3MP4));
xdft_yD3MP6 = fft(yD3MP6-mean(yD3MP6));
xdft_yD3MP8 = fft(yD3MP8-mean(yD3MP8));
xdft_yD3MP10 = fft(yD3MP10-mean(yD3MP10));

[YD3MP4,ID3MP4]=max(abs(xdft_yD3MP4));
freqD3MP4=0:Fs/length(yD3MP4):Fs/2;
freq(3,1)=freqD3MP4(ID3MP4);
Cd_D3MP4=mean(RE100_D3_E3_MP4(:,3))*2;
CdMax_D3MP4=max(RE100_D3_E3_MP4(:,3))*2-Cd_D3MP4;
CdMin_D3MP4=abs(min(RE100_D3_E3_MP4(:,3))*2-Cd_D3MP4);
Cd(3,1)=Cd_D3MP4;
Var(3,1)=CdMax_D3MP4-CdMin_D3MP4;
Cd_Range(3,1)=(CdMax_D3MP4+CdMin_D3MP4)/2;

[YD3MP6,ID3MP6]=max(abs(xdft_yD3MP6));
freqD3MP6=0:Fs/length(yD3MP6):Fs/2;
freq(3,2)=freqD3MP6(ID3MP6);
Cd_D3MP6=mean(RE100_D3_E3_MP6(:,3))*2;
CdMax_D3MP6=max(RE100_D3_E3_MP6(:,3))*2-Cd_D3MP6;
CdMin_D3MP6=abs(min(RE100_D3_E3_MP6(:,3))*2-Cd_D3MP6);
Cd(3,2)=Cd_D3MP6;
Var(3,2)=CdMax_D3MP6-CdMin_D3MP6;
Cd_Range(3,2)=(CdMax_D3MP6+CdMin_D3MP6)/2;

[YD3MP8,ID3MP8]=max(abs(xdft_yD3MP8));
freqD3MP8=0:Fs/length(yD3MP8):Fs/2;
freq(3,3)=freqD3MP8(ID3MP8);
Cd_D3MP8=mean(RE100_D3_E3_MP8(:,3))*2;
CdMax_D3MP8=max(RE100_D3_E3_MP8(:,3))*2-Cd_D3MP8;
CdMin_D3MP8=abs(min(RE100_D3_E3_MP8(:,3))*2-Cd_D3MP8);
Cd(3,3)=Cd_D3MP8;
Var(3,3)=CdMax_D3MP8-CdMin_D3MP8;
Cd_Range(3,3)=(CdMax_D3MP8+CdMin_D3MP8)/2;

[YD3MP10,ID3MP10]=max(abs(xdft_yD3MP10));
freqD3MP10=0:Fs/length(yD3MP10):Fs/2;
freq(3,4)=freqD3MP10(ID3MP10);
Cd_D3MP10=mean(RE100_D3_E3_MP10(:,3))*2;
CdMax_D3MP10=max(RE100_D3_E3_MP10(:,3))*2-Cd_D3MP10;
CdMin_D3MP10=abs(min(RE100_D3_E3_MP10(:,3))*2-Cd_D3MP10);
Cd(3,4)=Cd_D3MP10;
Var(3,4)=CdMax_D3MP10-CdMin_D3MP10;
Cd_Range(3,4)=(CdMax_D3MP10+CdMin_D3MP10)/2;

%Lift Coeff

ClyD3MP4 = interp1(RE100_D3_E3_MP4(:,1),RE100_D3_E3_MP4(:,2),x_31);
ClyD3MP6 = interp1(RE100_D3_E3_MP6(:,1),RE100_D3_E3_MP6(:,2),x_32);
ClyD3MP8 = interp1(RE100_D3_E3_MP8(:,1),RE100_D3_E3_MP8(:,2),x_33);
ClyD3MP10 = interp1(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,2),x_34);

Clxdft_yD3MP4 = fft(ClyD3MP4-mean(ClyD3MP4));
Clxdft_yD3MP6 = fft(ClyD3MP6-mean(ClyD3MP6));
Clxdft_yD3MP8 = fft(ClyD3MP8-mean(ClyD3MP8));
Clxdft_yD3MP10 = fft(ClyD3MP10-mean(ClyD3MP10));

[ClYD3MP4,ClID3MP4]=max(abs(Clxdft_yD3MP4));
ClfreqD3MP4=0:Fs/length(ClyD3MP4):Fs/2;
Clfreq(3,1)=ClfreqD3MP4(ClID3MP4);
Cl_D3MP4=mean(RE100_D3_E3_MP4(:,2));
ClMax_D3MP4=max(RE100_D3_E3_MP4(:,2))-Cl_D3MP4;
ClMin_D3MP4=abs(min(RE100_D3_E3_MP4(:,2))-Cl_D3MP4);
Cl(3,1)=Cl_D3MP4;
ClVar(3,1)=ClMax_D3MP4-ClMin_D3MP4;
Cl_Range(3,1)=(ClMax_D3MP4+ClMin_D3MP4);

[ClYD3MP6,ClID3MP6]=max(abs(Clxdft_yD3MP6));
ClfreqD3MP6=0:Fs/length(ClyD3MP6):Fs/2;
Clfreq(3,2)=ClfreqD3MP6(ClID3MP6);
Cl_D3MP6=mean(RE100_D3_E3_MP6(:,2));
ClMax_D3MP6=max(RE100_D3_E3_MP6(:,2))-Cl_D3MP6;
ClMin_D3MP6=abs(min(RE100_D3_E3_MP6(:,2))-Cl_D3MP6);
Cl(3,2)=Cl_D3MP6;
ClVar(3,2)=ClMax_D3MP6-ClMin_D3MP6;
Cl_Range(3,2)=(ClMax_D3MP6+ClMin_D3MP6);

[ClYD3MP8,ClID3MP8]=max(abs(Clxdft_yD3MP8));
ClfreqD3MP8=0:Fs/length(ClyD3MP8):Fs/2;
Clfreq(3,3)=ClfreqD3MP8(ClID3MP8);
Cl_D3MP8=mean(RE100_D3_E3_MP8(:,2));
ClMax_D3MP8=max(RE100_D3_E3_MP8(:,2))-Cl_D3MP8;
ClMin_D3MP8=abs(min(RE100_D3_E3_MP8(:,2))-Cl_D3MP8);
Cl(3,3)=Cl_D3MP8;
ClVar(3,3)=ClMax_D3MP8-ClMin_D3MP8;
Cl_Range(3,3)=(ClMax_D3MP8+ClMin_D3MP8);

[ClYD3MP10,ClID3MP10]=max(abs(Clxdft_yD3MP10));
ClfreqD3MP10=0:Fs/length(ClyD3MP10):Fs/2;
Clfreq(3,4)=ClfreqD3MP10(ClID3MP10);
Cl_D3MP10=mean(RE100_D3_E3_MP10(:,2));
ClMax_D3MP10=max(RE100_D3_E3_MP10(:,2))-Cl_D3MP10;
ClMin_D3MP10=abs(min(RE100_D3_E3_MP10(:,2))-Cl_D3MP10);
Cl(3,4)=Cl_D3MP10;
ClVar(3,4)=ClMax_D3MP10-ClMin_D3MP10;
Cl_Range(3,4)=(ClMax_D3MP10+ClMin_D3MP10);



%freq(1,1)='Strouhal Number';
%freq(R+1,C)='DG1E1';
%freq(R+2,C)='DG2E2';
%freq(R+3,C)='DG2E2';
%freq(R,C+1)='MP4';
%freq(R,C+2)='MP6';
%freq(R,C+3)='MP8';
%freq(R,C+4)='MP10';
%freq(R,C+5)='MP11';
%Cd(R,C)='Coefficient of Drag';
%Cd_Range(R,C)='Cd Range';
%Var(R,C)='Variance in Range Values';
%Cl(R,C)='Coefficient of Lift';
%Cl_Range(R,C)='Cl Range';
%freq(R,C)='Frequency in Lift';

%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',freq,'Sheet1','A1')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Cd,'Sheet1','A6')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Var,'Sheet1','A11')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Cd_Range,'Sheet1','A16')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Cl,'Sheet1','A21')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Cl_Range,'Sheet1','A26')
%xlswrite('C:\Users\ayers\Documents\RE100.xlsx',Clfreq,'Sheet1','A31')
figure
plot(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,3)*2,'k')
ylabel('C_D')
xlabel('t')
axis([90 120 1.355 1.385])

figure
plot(RE100_D3_E3_MP10(:,1),RE100_D3_E3_MP10(:,2)*2,'k')
ylabel('C_L')
xlabel('t')
axis([90 120 -0.4 0.4])

freq
Cd
Var
Cd_Range
Cl
Cl_Range
Clfreq
     %x,y,'.-')

%T_1=mean(T(A-1,:));
%B = find(RE100_D2_E2_MP10(:,1) >= 110);
%RE100_D2_E2_MP10=RE100_D2_E2_MP10(B,:);
%L=120-1/fs;

     %x1,y1,'.-')
     %RE100_D2_E2_MP10(:,1),RE100_D2_E2_MP10(:,3),'s')

%legend(...'RE100 D2 E2 MP6',...
       %'RE100 D2 E2 MP10')
 
%xlabel('t*');
%ylabel('Lift Coefficient');
%Title('Strohal Find');
Cd(2,5) = NaN;
Cd(3,5) = NaN;
MP = [688 1548 2752 4300 5170]
plot(MP,Cd(1,:),'-sr',...
     MP,Cd(2,:),'-sb',...
     MP,Cd(3,:),'-sg')
ylabel('C_D')
xlabel('# of elements')
legend('DG1E1','DG2E2','DG3E3')
axis([688 5170 0.9 1.5])
