/// @description Insert description here
// You can write your code in this editor

timer++;

switch (state) {
    case "fade_in":
        alpha += 0.08;
        if (alpha >= 1) {
            alpha = 1;
            state = "hold";
            timer = 0;
        }
        break;

    case "hold":
        if (timer >= duration) {
            state = "fade_out";
        }
        break;

    case "fade_out":
        alpha -= 0.08;
        if (alpha <= 0) {
            instance_destroy(self);
        }
        break;
}

