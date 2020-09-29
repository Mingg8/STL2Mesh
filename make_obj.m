mesh_size = 8;
% file = 'STL/07_Environment_Hole_Fine.STL';
file = 'STL/03_Plug_Cylinder_Fine.STL';

%%
model_tmp = createpde;
importGeometry(model_tmp, file);
mesh = generateMesh(model_tmp, 'GeometricOrder', 'linear','Hmax',mesh_size);
element = mesh.Elements;
node = mesh.Nodes;
N_node = size(node.',1);
%%
surface = extract_surface(element);
if file == "STL/07_Environment_Hole_Fine.STL"
    surface = rearrange_normal(surface, node,  1, [0, 0, -1]);
else
    surface = rearrange_normal(surface, node,  1, [0, 0, 1]);
end
%%
pnts = []; normal = [];
for i = 1:size(surface, 1)
    p = (node(:, surface(i, 1)) + node(:, surface(i, 2)) + ...
        node(:, surface(i, 3)))/3;
    n = cross(node(:,surface(i, 2)) - node(:,surface(i, 1)), ...
        node(:,surface(i, 3)) - node(:,surface(i, 1)));
    n = n/ norm(n);
    pnts = [pnts p];
    normal = [normal n];
end

figure(1);
trimesh(surface, node(1, :), node(2, :), node(3, :), 'FaceColor', 'b', 'FaceAlpha', 0.3); hold on;
quiver3(pnts(1,:), pnts(2, :), pnts(3, :), normal(1,:), normal(2, :), normal(3, :));

%%
vertex_normal = zeros(3, N_node);
for i = 1:N_node
    normal_i = zeros(3, 1);
    for j = 1:size(surface, 1)
        index = find(i == surface(j, :));
        if numel(index) > 0
            normal_i = normal_i + normal(:, j);
        end
    end
    vertex_normal(:, i) = normal_i / norm(normal_i);        
end

%%
figure(2);
trimesh(surface, node(1, :), node(2, :), node(3, :), 'FaceColor', 'b', 'FaceAlpha', 0.3); hold on;
quiver3(node(1,:), node(2, :), node(3, :), vertex_normal(1,:), vertex_normal(2, :), vertex_normal(3, :));
