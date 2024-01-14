#define scr_behavior_walk
{
    var ahead, left, right; //boolean variables
    if ( !place_snapped(32,32) ) exit;
    if (vspeed == 0) // if true, moving on x-axis
    {
        ahead = place_free(x+hspeed,y);
        left = place_free(x,y+4);
        right = place_free(x,y-4);
        if (!ahead && !left && !right) {direction += 180; exit;}
        while (true) // forever
        {
            if (ahead && random(3)< 1) {exit;}
            if (left && random(3)< 1) {direction = 270; exit;}
            if (right && random(3)< 1) {direction = 90; exit;}
        }
    }
    else // moving on y-axis
    {
        ahead = place_free(x,y+vspeed);
        left = place_free(x+4,y);
        right = place_free(x-4,y);
        if (!ahead && !left && !right) {vspeed = -vspeed; exit;}
        while (true) // forever
        {
            if (ahead && random(3)<1) {exit;}
            if (left && random(3)<1) {direction = 0; exit;}
            if (right && random(3)<1) {direction = 180; exit;}
        }
    }
}

#define scr_behavior_towards
{
    if ( !place_snapped(32,32) ) exit;
    // find explorer’s position relative to mummy
    var dir;
    dir = point_direction(x,y,obj_explorer.x,obj_explorer.y);
    dir = round(dir/90);
    if (dir == 4) dir = 0;
    // 4 rules to move the mummy toward the explorer
    if (dir == 0 && direction != 180 && place_free(x+4,y))
    { direction = 0; exit; }
    if (dir == 1 && direction != 270 && place_free(x,y-4))
    { direction = 90; exit; }
    if (dir == 2 && direction != 0 && place_free(x-4,y))
    { direction = 180; exit; }
    if (dir == 3 && direction != 90 && place_free(x,y+4))
    { direction = 270; exit; }
    // otherwise do the normal walking behavior
    scr_behavior_walk();
}

