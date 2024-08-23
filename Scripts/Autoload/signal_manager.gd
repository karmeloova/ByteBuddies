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


# GO TO TARGET
signal makeMove(instructions)
signal code_to_make()
signal set_player_pos(position)
signal moveEnd()

# CAT JUMP
signal move_camera()
signal remove_platform(camera_pos)
signal add_platform()
signal generate_coin(last_position, platform_size)

#------------------ ANIMAL NEEDS ----------------------------
signal scratch(value)
signal changed_needs()
signal add_to_bowl(hungry_points)
signal eat()
signal remove_from_fridge(what : Food_Resource)

#------------------ ANOTHER ---------------------------------
signal change_money()
signal add_to_fridge(item : Food_Resource)
signal add_coin(value)
signal go_to_bowl()
signal eat_end()
