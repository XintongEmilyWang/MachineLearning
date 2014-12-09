vector = zeros(1, 1000);
bound = zeros(1, 1000);
for k = 1 : 1000
    w_t = zeros(1, 11);
    for i = 2 : 11
        w_t(1, i) = rand();
    end
    training = ones(11, 100);
    for i = 1 : 100
        for j = 2 : 11
            training(j, i) = rand() * 2 - 1;
        end
    end
    y = zeros(1, 100);
    for i = 1 : 100
        if (mtimes(w_t, training(:, i)) > 0)
            y(1, i) = 1;
        end
        if (mtimes(w_t, training(:, i)) < 0)
            y(1, i) = -1;
        end
    end
    w_i = zeros(1, 11);
    count = 0;
    temp = zeros(1, 100);
    while(dot(y, temp) ~= 100)
        for i = 1 : 100
            if (mtimes(w_i, training(:, i)) > 0)
                temp(1, i) = 1;
            end
            if (mtimes(w_i, training(:, i)) < 0)
                temp(1, i) = -1;
            end
            if (temp(1, i) ~= y(1, i))
                w_i = w_i + y(1, i) * transpose(training(:, i));
                count = count + 1;
            end
        end
    end
    vector(1, k) = count;
    R = 0;
    rho = 1000000;
    for m = 1 : 100
        R = max(R, norm(training(2:11,m)));
        rho = min(rho, y(1, m)*(mtimes(w_i, training(:, m))));
        bound(1, k) = R.^2 * norm(w_i).^2/rho.^2;
    end 
    plot(k, vector(1, k), 'r');
    hold on;
    plot(k, bound(1, k), 'b');
    hold on;
end
hold off;





