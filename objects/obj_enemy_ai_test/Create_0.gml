enum StateList {
    DEFAULT,
    ENRAGED,
    DYING
}

enemy = {
    name: "Inimigo",
    state: StateList.DEFAULT,
    hp: 10,
    action_list: [
        { name: "ataque", priority: 0 },
        { name: "defesa", priority: 0 },
        { name: "skill",  priority: 0 }
    ],
	
    change_state: function() {
        switch (self.state) {
            case StateList.DEFAULT:
                if (self.hp < 5) self.state = StateList.ENRAGED;
            break;

            case StateList.ENRAGED:
                if (self.hp <= 0) self.state = StateList.DYING;
            break;

            case StateList.DYING:
                // nada
            break;
        }
    },

    calculate_priority: function() {
        for (var i = 0; i < array_length(self.action_list); i++) {
            self.action_list[i].priority = 0;
        }

        for (var i = 0; i < array_length(self.action_list); i++) {
            var action = self.action_list[i];

            switch (action.name) {
                case "ataque":
                    if (self.state == StateList.DEFAULT) action.priority += 5;
                break;

                case "defesa":
                    if (self.state == StateList.DEFAULT) action.priority += 3;
                break;

                case "skill":
                    if (self.state == StateList.ENRAGED) action.priority += 8;
                break;
            }

            self.action_list[i] = action;
        }
    },

    best_action: { name: "none", priority: -999 },

    choose_best_action: function() {
        self.best_action = { name: "none", priority: -999 };

        for (var i = 0; i < array_length(self.action_list); i++) {
            var a = self.action_list[i];
            if (a.priority > self.best_action.priority) {
                self.best_action = a;
            }
        }

        show_debug_message("Melhor ação: " + string(self.best_action.name));
    }
}