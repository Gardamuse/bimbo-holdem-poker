str = dlmread('hole_strength.txt');
for i = 1:2704
    if str(i) < 0.33
        str(i) = 0;
    end
end
str = reshape(str,[52,52]);

colormap('default');
imagesc(str);
colorbar;