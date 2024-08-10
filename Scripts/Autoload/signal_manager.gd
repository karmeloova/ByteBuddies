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

#------------------ ANIMAL NEEDS ----------------------------
signal scratch(value)
signal changed_needs()
