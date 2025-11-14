// Fake de personagem só pra testar
var fake_char = {
    character_info: {
        name: "Herói",
        level: 5,
        sprite: spr_eric // coloque um sprite válido
    },
    combat_info: {
        hp: 80,
        hp_max: 100,
        mp: 25,
        mp_max: 50,
        status_effects: []
    }
};

ui_status_panel = new UI_StatusBox(50, 200, 150, 120, fake_char);
