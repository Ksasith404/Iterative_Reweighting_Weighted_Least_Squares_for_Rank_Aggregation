function tau = kendall_tau(r1, r2)
% Compute Kendall's tau between two rankings

r1 = r1(:)';
r2 = r2(:)';
n  = length(r1);

con = 0;
dis = 0;

for i = 1:n-1
    for j = i+1:n
        if (r1(i)-r1(j))*(r2(i)-r2(j)) > 0
            con = con + 1;
        elseif (r1(i)-r1(j))*(r2(i)-r2(j)) < 0
            dis = dis + 1;
        end
    end
end

tau = (con - dis) / (0.5*n*(n-1));
end
