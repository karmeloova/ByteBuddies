extends Node
# ------------------ MINI GAMES ----------------------------
# UNIVERSAL
signal loseGame()
signal stopGame()
signal startGameAfterPause()
signal restartGame()
signal loseLife()
signal nextLevel()
signal add_point()
signal save_data()

signal fruitColl(what); #właścicielem sygnału jest SignalManager
signal basketColor(color);
signal fruitColor(color);


# GO TO TARGET
signal makeMove(instructions)
signal code_to_make()
signal set_player_pos(position)
signal moveEnd()
signal calculate_score(lines)

# CAT JUMP
signal move_camera()
signal remove_platform(camera_pos)
signal add_platform()
signal generate_coin(last_position, platform_size)

# CODE GAME
signal check_field()
signal added_data_to_field(data : String)
signal removed_data_from_field(data : String)
signal was_drawn()
signal bad_field()

#LOGIC TETRIS
signal grounded()
signal new_blok_needed(current_x_position, current_y_pos)

#------------------ ANIMAL NEEDS ----------------------------
signal scratch(value)
signal changed_needs()
signal add_to_bowl(hungry_points)
signal eat()
signal remove_from_fridge(what : Food_Resource)
signal playing()
signal sleeping(is_sleeping)
signal cleaning(is_cleaning)

#------------------ ANOTHER ---------------------------------
signal change_money()
signal add_to_fridge(item : Food_Resource)
signal add_coin(value)
signal go_to_bowl()
signal eat_end()
signal set_correct_instruction(what)
signal show_next_pop_up()
signal check_buy_possibilities()
signal unlock_achievement(points, category, camera : Camera2D)
signal show_achievement_screen(camera : Camera2D, unlocked_achievmentes : Dictionary, money_prizes : Array, achievements_numbers : Array)
signal check_achievements_unlocked()
signal reoder_child()
signal code_feed()
signal set_cat_name()
signal set_panel_to_hide(panel : Node2D)
signal set_panel_to_show(panel: Node2D)
signal add_fishes()
signal update_fish_counter()
signal add_plan_booster(plan : Plan)
signal add_code_element(code_element : CodeElement)
signal set_current_booster(plan : Plan)
signal add_code_element_to_plan(code_element : CodeElement)
signal start_build_booster(plan : Plan)
signal check_booster_build()
signal check_if_is_good(is_good : bool, code_element : String)
signal use_booster(plan : Plan)
signal decrease_booster_uses()
signal show_description(description: String)
signal hide_description()
signal decrease_plan_counter(plan : Plan)
signal decrease_code_element_counter(code_element : CodeElement)

#------------------ LEVEL -----------------------------------
signal add_exp(value)
