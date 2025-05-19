$fn = 200;
// The length of connector
depth = 35;
// The maximum diameter of the outer connector
outer_connector_max_diameter = 35.2;
// The minimum diameter of the outer connector
outer_connector_min_diameter = 34.4;

// The maximum diameter of the inner connector
inner_connector_max_diameter = 32.1;
// The minimum diameter of the inner connector
inner_connector_min_diameter = 31.5;
// The thickness of the the wall of connector
thickness = 2.6;

generate_support = true;

module connector()
{
    length_of_connection = 10;
    wall_thickness = thickness *2 ;
    
    difference()
    {
        cylinder(depth, d1 = outer_connector_max_diameter + wall_thickness, d2 = outer_connector_min_diameter + wall_thickness);
        cylinder(depth, d1 = outer_connector_max_diameter, d2 = outer_connector_min_diameter);
    }
    translate([0, 0, depth])
    {
        difference()
        {
            cylinder(length_of_connection, d1 = outer_connector_min_diameter + wall_thickness, d2 = inner_connector_max_diameter);
            cylinder(length_of_connection, d1 = outer_connector_min_diameter, d2 = inner_connector_max_diameter - wall_thickness);
        }
    }
    translate([0, 0, depth + length_of_connection])
    {
        difference()
        {
            cylinder(depth, d1 = inner_connector_max_diameter, d2 = inner_connector_min_diameter);
            cylinder(depth, d1 = inner_connector_max_diameter - wall_thickness, d2 = inner_connector_min_diameter - wall_thickness);
        }
    }
    support(length_of_connection);
}

module support(length_of_connection)
{
    length = 8;
    tolerance = 0.1;
    if (generate_support)
    {
        translate([-outer_connector_max_diameter/2 - thickness, -outer_connector_max_diameter/2 - thickness, -length - tolerance])
            cube([outer_connector_max_diameter + thickness * 2, length, length]);
        
        translate([-outer_connector_max_diameter/2 - thickness, -outer_connector_max_diameter/2 - thickness, tolerance + length_of_connection + depth * 2])
            cube([outer_connector_max_diameter + thickness * 2, length, length]);
    }
}


connector();

