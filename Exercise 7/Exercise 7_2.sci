// --- 1. DU LIEU ---
x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);
M = length(h);
n_axis = 0:N-1;

// --- 2. TINH TOAN (MATRIX METHOD) ---
X_mat = zeros(N, M);
for c = 0:M-1
    for r = 0:N-1
        idx = modulo(r - c, N);
        if idx < 0 then idx = idx + N; end
        X_mat(r+1, c+1) = x(idx+1);
    end
end
y_matrix = (X_mat * h')'; 

// --- 3. NANG LUONG ---
Ex = sum(x.^2);
Eh = sum(h.^2);
Ey = sum(y_matrix.^2);

// --- 4. HIEN THI CONSOLE ---
disp("Matrix Method 1 cycles Result:", y_matrix);
printf("Energy: Ex = %d, Eh = %d, Ey = %d\n", Ex, Eh, Ey);

// --- 5. VE DO THI (DUNG PLOT2D3 THAY CHO STEM) ---
clf(); 
n=-10:10;
offset = length(n)/2+1;
// Ve x(n)
x_dis = zeros(1,length(n));
i = 0;
while i <= length(x)-1
    x_dis(offset + i) = x(i+1); 
    i = i+1;
end
subplot(2,2,1);
plot2d3(n, x_dis);
xtitle("Input Signal x(n)");

// Ve h(n)
h_dis =  zeros(1,length(n));
i = 0;
while i <= length(h)-1
    h_dis(offset + i) = h(i+1); 
    i = i+1;
end
subplot(2,2,2);
plot2d3(n, h_dis); 
xtitle("Impulse Response h(n)");

// Ve y(n)
y_dis =  zeros(1,length(n));
i = -10;
while i <= 10
    idx = modulo(i, N);
    if idx < 0 then idx = idx + N; end
    y_dis(offset + i) = y_matrix(idx + 1); 
    i = i+1;
end
subplot(2,2,3);
plot2d3(n, y_dis); 
xtitle("(Matrix Method) Circular Output y(n)");

// Ve Nang luong
subplot(2,2,4);
bar([Ex, Eh, Ey]); 
xtitle("Energy: Ex, Eh, Ey");

show_window(); // Bat buoc hien thi
