UPDATE espaces_verts
SET geo_shape = REPLACE(geo_shape, '"', '''')