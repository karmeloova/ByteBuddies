extends Node
# ------------------ MINI GAMES ----------------------------
# UNIVERSAL
signal loseGame()
signal stopGame()
signal startGameAfterPause()
signal restartGame()
signal loseLife()
signal nextLevel()

# GO TO TARGET
signal makeMove(instructions)
signal code_to_make()
signal set_player_pos(position)
signal moveEnd()


#------------------ ANIMAL NEEDS ----------------------------
signal scratch(value)
signal changed_needs()
