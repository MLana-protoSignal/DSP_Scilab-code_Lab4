// 0. Load thư viện IPCV
if ~isdef("imhistequal") then
    atomsInstall("IPCV");
    atomsLoad("IPCV");
end

// 1. ĐỌC ẢNH
path = get_absolute_file_path('Exercise 5.sci'); // Địa chỉ folder chứa ảnh
img = imread(path + "Lena.png"); // Tên_ảnh.Định_dạng_ảnh
gray = rgb2gray(img);

// ============================================================
// 2. FIGURE 1: ẢNH GỐC
// ============================================================
scf(1); clf();
subplot(1,2,1); imshow(img);  title("Anh goc (RGB)");
subplot(1,2,2); imshow(gray); title("Anh xam");

// ============================================================
// 3. FIGURE 2: HISTOGRAM RGB
// ============================================================
scf(2); clf();
R = img(:,:,1); G = img(:,:,2); B = img(:,:,3);
plot(0:255, imhist(R), "r");
plot(0:255, imhist(G), "g");
plot(0:255, imhist(B), "b");
legend(["Red","Green","Blue"]);
title("Histogram RGB");
xlabel("Gia tri Pixel"); ylabel("Tan suat");

// ============================================================
// 4. FIGURE 3: HISTOGRAM EQUALIZATION
// ============================================================
gray_eq = imhistequal(gray);
scf(3); clf();
subplot(2,2,1); imshow(gray);    title("Anh xam goc");
subplot(2,2,2); imshow(gray_eq); title("Sau can bang");
subplot(2,2,3);
bar(0:255, imhist(gray));
a = gca();
a.x_ticks = tlist(["ticks","locations","labels"], [0,64,128,192,255], ["0","64","128","192","255"]);
title("Histogram truoc");
subplot(2,2,4);
bar(0:255, imhist(gray_eq));
a = gca();
a.x_ticks = tlist(["ticks","locations","labels"], [0,64,128,192,255], ["0","64","128","192","255"]);
title("Histogram sau");

// ============================================================
// 5. FIGURE 4: BLUR
// ============================================================
h_gauss = fspecial("gaussian", [5 5], 3);
img_gauss = imfilter(img, h_gauss);
img_median = immedian(img, [9 9]);
scf(4); clf();
subplot(1,3,1); imshow(img);        title("Anh goc");
subplot(1,3,2); imshow(img_gauss);  title("Gaussian Blur");
subplot(1,3,3); imshow(img_median); title("Median Filter");

// ============================================================
// 6. FIGURE 5: WATERMARK - vẽ pixel thẳng vào ảnh
// ============================================================
img_wm = img;
[h, w, c] = size(img_wm);

// Làm tối dải 35px dưới cùng
band_h = 35;
start_row = h - band_h + 1;
img_wm(start_row:h, :, :) = uint8(double(img_wm(start_row:h, :, :)) * 0.40);

// --- Vẽ chữ "HCMUT" bằng pixel 5x7 thủ công ---
// Mỗi chữ cái được định nghĩa bằng ma trận 7 hàng x 5 cột
// 1 = pixel trắng, 0 = trong suốt

H = [1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 1 1 1 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1];
C = [0 1 1 1 0; 1 0 0 0 1; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 0; 1 0 0 0 1; 0 1 1 1 0];
M = [1 0 0 0 1; 1 1 0 1 1; 1 0 1 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1];
U = [1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 1 0 0 0 1; 0 1 1 1 0];
T = [1 1 1 1 1; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0; 0 0 1 0 0];

letters = list(H, C, M, U, T);
scale   = 3;   // phóng to pixel x3 cho dễ nhìn
gap     = 3;   // khoảng cách giữa các chữ (pixel)
char_w  = 5 * scale;
char_h  = 7 * scale;

// Tính vị trí bắt đầu để căn giữa
total_w = 5 * char_w + 4 * gap;
x_start = floor((w - total_w) / 2) + 1;
y_start = h - band_h + floor((band_h - char_h) / 2) + 1;

// Vẽ từng chữ
for k = 1:5
    L = letters(k);
    x0 = x_start + (k-1) * (char_w + gap);
    for row = 1:7
        for col = 1:5
            if L(row, col) == 1 then
                r0 = y_start + (row-1)*scale;
                c0 = x0 + (col-1)*scale;
                // Tô scale x scale pixel
                img_wm(r0:r0+scale-1, c0:c0+scale-1, 1) = uint8(255);
                img_wm(r0:r0+scale-1, c0:c0+scale-1, 2) = uint8(255);
                img_wm(r0:r0+scale-1, c0:c0+scale-1, 3) = uint8(255);
            end
        end
    end
end

// Hiển thị và lưu
scf(5); clf();
imshow(img_wm);
title("Watermark - HCMUT");

// ============================================================
// 7. LƯU ẢNH
// ============================================================
imwrite(gray_eq,   path + "ket_qua_histeq.png");
imwrite(img_gauss, path + "ket_qua_gaussian.png");
imwrite(img_wm,    path + "ket_qua_watermark.png");  // dùng imwrite thay xs2png

disp(">>> Hoan tat! Da luu 3 anh ket qua vao thu muc luu file nay.");
