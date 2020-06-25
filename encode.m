clc
clear

%reading the image and key
inp = input("Enter input image name : ", "s");
newimg = imread(inp);
pass = input("Enter key : ", "s");

%taking message input
mess = input("Enter message : ", "s");
inp = strtrim(mess);

%length of the message or required points
len_mes = length(inp)*8;

%changing the value of string to numerical
Ascii_values = uint8(inp);

%changing ascii values to the binary number
binary_str = dec2bin(Ascii_values, 8);

%having the coloumn length of binary
num_row_bin = length(binary_str(:, 1));
num_col_bin = 8;

%taking the length of the img
num_rows_img = length(newimg(:, 1, 1));
num_col_img = length(newimg(1, :, 1));

num_col_img = num_col_img - mod(num_col_img, 3);
pixels = num_col_img/3;
x = 1; pix = 1;
img = newimg;

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

if(pixels*num_rows_img < num_row_bin)
    disp("Message too long for this image :(");
    exit;
end

for i = (1 : num_row_bin)
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
         if(binary_str(i, z) == "0")
            img(x, y, layer) = img(x, y, layer) - mod(img(x, y, layer), 2);
         else
            if(mod(img(x, y, layer), 2) == 0)
              img(x, y, layer) = img(x, y, layer) + 1;
            end
         end
    end
    img(x, (pix-1)*3 + 3, 3) = img(x, (pix-1)*3 + 3, 3) - mod(img(x, (pix-1)*3 + 3, 3), 2);
    if(i == num_row_bin)
      img(x, (pix-1)*3 + 3, 3) = img(x, (pix-1)*3 + 3, 3) + 1;
    end
    pix = pix+1;
    if(pix == pixels+1)
        pix = 1; x = x+1;
    end
end

out = input("Enter output image name : ", "s");
imwrite(img, out);