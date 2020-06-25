clc
clear
out = input("Enter image name : ", "s");
dimg = imread(out);
pass = input("Enter key : ", "s");

%taking the length of the img
num_rows_img = length(dimg(:, 1, 1));
num_col_img = length(dimg(1, :, 1));

num_col_img = num_col_img - mod(num_col_img, 3);
pixels = num_col_img/3;
x = 1; pix = 1;
A = [];

asciipass = uint8(pass);
value = 0;
for i = 1:length(pass)
    value = value + double(asciipass(i))^i;
end
value = mod(value, 40320);
if (value == 0)
    value = 40320;
end
put = [1,2,3,4,5,6,7,8];
vec = [0 0 0 0 0 0 0 0];
for i = 1:7
    l = value/factorial(8-i);
    r = ceil(l);
    vec(i) = put(r);
    value = value - floor(l)*factorial(8-i);
    put(r) = [];
    if (value == 0)
        break;
    end
end
if (value == 0)
    while(length(put) > 1)
        vec(9-length(put)) = put(1);
        put(1) = [];
    end
end
vec(8) = put(1);



pow = [128 64 32 16 8 4 2 1];

count = 1;
while(true)

    sav = [0 0 0 0 0 0 0 0];
    layer = 1;
    for j = (1 : 8)

         if(j == 4)
            layer = 2;
         elseif(j == 7)
            layer = 3;
         end

         y = (pix-1)*3 + mod(j, 3);
         if(mod(j, 3) == 0)
            y = (pix-1)*3 + 3;
         end

         z = vec(1, j);
         sav(1, z) = mod(dimg(x, y, layer), 2);

    end
    sav = sav.*pow;
    value = sum(sav);
    if(value < 32)
        value = value + 32;
    end
    A = [A; [value]];
    if(mod(dimg(x, (pix-1)*3 + 3, 3), 2) == 1)
         break;
    end
    pix = pix + 1;
    if(pix == pixels+1)
       x = x+1; pix = 1;
    end
end

A = A';
ans = char(A);
disp("Final text message is :-");
disp(ans);