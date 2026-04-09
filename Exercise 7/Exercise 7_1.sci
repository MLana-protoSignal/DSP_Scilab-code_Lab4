// --- 1. DU LIEU ---
x = [1, 2, -3, 2, 1];
h = [1, 0, -1, -1, 1];
N = length(x);
M = length(h);
n_axis = 0:N-1;

// --- 2. TINH TOAN (FOLDING & SHIFTING) ---
y_fold = zeros(1, N);
for n = 0:N-1
    for k = 0:M-1
        idx = modulo(n - k, N);
        if idx < 0 then idx = idx + N; end 
        y_fold(n+1) = y_fold(n+1) + h(k+1) * x(idx+1);
    end
end

// --- 3. NANG LUONG ---
Ex = sum(x.^2);
Eh = sum(h.^2);
Ey = sum(y_fold.^2);

// --- 4. HIEN THI CONSOLE ---
disp("Folding & Shifting 1 cycles Result:", y_fold);
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
    y_dis(offset + i) = y_fold(idx + 1); 
    i = i+1;
end
subplot(2,2,3);
plot2d3(n, y_dis); 
xtitle("(Folding & Shifting) Circular Output y(n)");

// Ve Nang luong
subplot(2,2,4);
bar([Ex, Eh, Ey]); 
xtitle("Energy: Ex, Eh, Ey");

show_window(); // Bat buoc hien thi
