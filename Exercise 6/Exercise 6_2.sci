function [total] = energyOf (xn)
    i = 1;
    total = 0;
    while i <= length(xn)
        total = total + xn(i)*xn(i);
        i = i+1;
    end
endfunction

n=-10:10;
offset = length(n)/2+1;
//x(n) signal
x = zeros(1,length(n));
x(offset)= 1;
x(offset+1)= 2;
x(offset+2)= -3;
x(offset+3)= 2;
x(offset+4)= 1;
//h(n) signal
h =  zeros(1,length(n));
h(offset)= 1;
h(offset+1)= 0;
h(offset+2)= -1;
// the number elements of y(n)
numy = length(x) + length(h) - 1;
//h(n) -> Toeplitz matrix
H = zeros(numy, length(x));
i = 1;
while i <= numy
    j = 1;
    while j <= length(x)
        if (i-j+1 > 0 & i-j+1 <= length(h)) then
            H(i,j) = h(i-j+1);
        end
        j = j + 1;
    end
    i = i + 1;
end
// x(n) -> X
X = x';
// Y = H.X
Y = H*X;
// Y -> y(n)
y = zeros(1, numy);
i = 1;
while i <= numy
    y(i) = Y(i,1);
    i = i + 1;
end
n_y = 1 : numy;
n_y = n_y - round(numy/2);
//Energy
x_energy = energyOf (x);
h_energy = energyOf (h);
y_energy = energyOf (y);
//Display
clf();
//x(n) plot
subplot(3, 1, 1);
plot2d3(n,x);
xlabel("n");
ylabel("x(n)");
title("x(n) = [1↑,2,-3,2,1] | Energy of x(n): Ex = " + string(x_energy));
//h(n) plot
subplot(3, 1, 2);
plot2d3(n,h);
xlabel("n");
ylabel("h(n)");
title("h(n) = [1↑,0,-1] | Energy of h(n): Eh = " + string(h_energy));
//y(n) plot
subplot(3, 1, 3);
plot2d3(n_y,y);
xlabel("n");
ylabel("y(n)");
title("y(n) = h(n)*x(n) | Energy of y(n): Ey = " + string(y_energy));
