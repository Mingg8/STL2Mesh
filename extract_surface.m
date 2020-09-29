function [surface] = extract_surface(element_all)
%EXTRACT_SURFACE 이 함수의 요약 설명 위치
%   자세한 설명 위치
% every triangle
triangles = [];
index = [1, 2, 3; 1, 2, 4; 1, 3, 4; 2, 3, 4];
for i = 1: size(element_all, 2)
    for j = 1:4
        triangles = [triangles; sort(element_all(index(j, :), i))'];
    end
end

% find surface triangle
surface = [];
while size(triangles, 1) > 0 
    arr = triangles(1, :);
    triangles(1, :) = [];
    [ismem, ind] = ismember(arr, triangles, 'rows');
    if ismem
        triangles(ind, :) = [];
    else
        surface = [surface; arr];
    end
end
end