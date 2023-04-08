# shepp_logan

this is a function to make simulated data in IVIM, and data is shepp-logan.

After running directly, a folder named IVIM_data will be generated. Under this folder, there will be folders marked by numbers, which contain PF, D, D* and signal data



Corresponding to the data of f, D*, D respectively

![image.png](https://cdn.nlark.com/yuque/0/2023/png/521487/1680858235835-a160d96c-4179-4b8d-a0bc-4f0c47c5a6e5.png)

The numbers in the shepp-logan diagram below represent the parameter settings in the E matrix

```matlab
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
```

![image.png](https://cdn.nlark.com/yuque/0/2023/png/521487/1680942189842-ad2fd8cc-46f0-4b64-9837-fc4973287975.png)

