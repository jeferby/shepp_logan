% function [Signals] = shepp_logan_ivim(size_image, b , number)
% illustrate of input parameters
% 
%  *size_image is size of shepp logan image, such as (74,74)
% 
%  *b is a array of b value , such as (0, 25, 50, 75, 100, 150, 300, 800, 1000)
% 
%  *number is the number of output type data 
% scope is [GM, WM, HGG, LGG, Min,Max]
size_image = 256;
number = 7;
b = [0, 25, 50, 75, 100, 150, 300, 800, 1000];
%% parameter configuration 
load('E.mat')
f_mean_scope = [0.041, 0.024, 0.11, 0.033, 0.01,0.15];
D1_mean_scope = [9E-3, 6E-3, 14.42E-3, 12.07E-3, 3E-3, 30E-3];
D_mean_scope = [0.82E-3, 0.75E-3, 0.94E-3, 1.26E-3, 0.1E-3, 2E-3];

f_standard_scope= [0.007, 0.0002, 0.021, 0.016];
D1_standard_scope= [7.1E-3, 2.1E-3, 8.87E-3, 9.74E-3];
D_standard_scope= [0.22E-3, 0.2E-3, 0.1E-3, 0.37E-3];

%% make random data
%  r = a + (b-a).*rand(N,1)
for t = 1:number
    f_random_scope = f_mean_scope;
    D1_random_scope = f_mean_scope;
    D_random_scope = f_mean_scope;
    f_random_scope(1:4) = (f_mean_scope(1:4) - f_standard_scope) + 2*f_standard_scope.*rand(1,1);
    D1_random_scope(1:4) = (D1_mean_scope(1:4) - D1_standard_scope) + 2*D1_standard_scope.*rand(1,1);
    D_random_scope(1:4) = (D_mean_scope(1:4) - D_standard_scope) + 2*D_standard_scope.*rand(1,1);
    %% mean PF 
    E(1,1)=f_random_scope(6);%max skull
    E(2,1)=-(f_random_scope(6)-f_random_scope(1));%set GM
    E(3,1)=-(f_random_scope(1)-f_random_scope(2));%set WM
    E(4,1)=-(f_random_scope(1)-f_random_scope(2));%set WM
    E(5,1)=-(f_random_scope(1)-f_random_scope(4));%set LGG
    E(6,1)=-(f_random_scope(1)-f_random_scope(4));%set LGG
    E(7,1)=-(f_random_scope(1)-f_random_scope(4));%set LGG
    E(8,1)=(f_random_scope(3)-f_random_scope(1));%set HGG
    E(9,1)=(f_random_scope(3)-f_random_scope(1));%set HGG
    E(10,1)=(f_random_scope(3)-f_random_scope(1));%set HGG
    PF= phantom(E,size_image);

    %% mean D1 
    E(1,1)=D1_random_scope(6);%max skull
    E(2,1)=-(D1_random_scope(6)-D1_random_scope(1));%set GM
    E(3,1)=-(D1_random_scope(1)-D1_random_scope(2));%set WM
    E(4,1)=-(D1_random_scope(1)-D1_random_scope(2));%set WM
    E(5,1)=-(D1_random_scope(1)-D1_random_scope(4));%set LGG
    E(6,1)=-(D1_random_scope(1)-D1_random_scope(4));%set LGG
    E(7,1)=-(D1_random_scope(1)-D1_random_scope(4));%set LGG
    E(8,1)=(D1_random_scope(3)-D1_random_scope(1));%set HGG
    E(9,1)=(D1_random_scope(3)-D1_random_scope(1));%set HGG
    E(10,1)=(D1_random_scope(3)-D1_random_scope(1));%set HGG
    D1 = phantom(E,size_image);

    %% mean D
    E(1,1)=D_random_scope(6);%max skull
    E(2,1)=-(D_random_scope(6)-D_random_scope(1));%set GM
    E(3,1)=-(D_random_scope(1)-D_random_scope(2));%set WM
    E(4,1)=-(D_random_scope(1)-D_random_scope(2));%set WM
    E(5,1)=-(D_random_scope(1)-D_random_scope(4));%set LGG
    E(6,1)=-(D_random_scope(1)-D_random_scope(4));%set LGG
    E(7,1)=-(D_random_scope(1)-D_random_scope(4));%set LGG
    E(8,1)=(D_random_scope(3)-D_random_scope(1));%set HGG
    E(9,1)=(D_random_scope(3)-D_random_scope(1));%set HGG
    E(10,1)=(D_random_scope(3)-D_random_scope(1));%set HGG
    D = phantom(E,size_image);

    %% IVIM fit
    S0 = 500;
    size_b = size(b,2);
    Signals = zeros(size_b,size_image,size_image);
    for i = 1:size_b
    Signals(i,:,:) = S0 * (PF * exp(-b(i) * D1) + (1 - PF) * exp(-b(i) * D));
    end
    %% save data
    mkdir('IVIM_data',int2str(t));
    filepath = ['.\IVIM_data\',int2str(t)];
    cd(filepath);
    save(['signals','.npy'],'Signals');
    save(['PF','.npy'],'PF');
    save(['D1','.npy'],'D1');
    save(['D','.npy'],'D');
    cd ../../
end
% end
