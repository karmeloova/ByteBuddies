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

#------------------ ANOTHER ---------------------------------
signal change_money()
signal add_to_fridge(item : Food_Resource)
signal add_coin(value)
signal go_to_bowl()
signal eat_end()
signal set_correct_instruction(what)
signal show_next_pop_up()
signal check_buy_possibilities()

#------------------ LEVEL -----------------------------------
signal add_exp(value)
