function [yn] = shiftAndFold (xn, k)
    yn = zeros(1,length(xn));
    i = 1;
    while i <= length(xn)
        if(i + k < 1) then
            yn(i) = 0;
        elseif(i + k > length(xn)) then
            yn(i) = 0;
        else
            yn(i) = xn(i + k);
        end
        i = i+1;
    end
    offset_y = length(yn)/2+1;
    i = -10;
    while i <= 0
        temp = yn(offset_y - i);
        yn(offset_y - i) = yn(offset_y + i);
        yn(offset_y + i) = temp;
        i = i + 1;
    end
endfunction

function [total] = energyOf (xn)
    i = 1;
    total = 0;
    while i <= length(xn)
        total = total + xn(i)*xn(i);
        i = i+1;
    end
endfunction

n=-10:10;
offset1 = length(n)/2+1;
//x(n) signal
x = zeros(1,length(n));
x(offset1)= 1;
x(offset1+1)= 2;
x(offset1+2)= -3;
x(offset1+3)= 2;
x(offset1+4)= 1;
//h(n) signal
h =  zeros(1,length(n));
h(offset1)= 1;
h(offset1+1)= 0;
h(offset1+2)= -1;
//Convulution
y =  zeros(1,length(n)*2-1);
offset2 = length(y)/2+1;
i = -length(n)+1;
while i <= length(n)-1
    x_neg_shift = shiftAndFold (x, i);
    y_first = x_neg_shift.*h;
    total = 0;
    j=1;
    while j<=length(y_first)
        total = total + y_first(j);
        j=j+1;
    end
    y(offset2+i) = total;
    i=i+1;
end
n_y = -length(n)+1 : length(n)-1;
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
