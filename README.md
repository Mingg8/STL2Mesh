# Execution 
1. Write stl filename in make_obj.m file.
2. Adjust the mesh size (mesh_size = n)
3. Run make_obj.m
4. Check the direction of normal vector and if it is wrong, change the value in rearrange_normal
  ex) surface = rearrange_normal(surface, node, 1, [0, 0, 1])  to surface = rearrange_normal(surface, node, 1, [0, 0, -1])
