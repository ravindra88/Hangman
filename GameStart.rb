
require './game_word'   # Load File or Class word operation
require './user_details'   # Load File or Class for User Details



   #print hangman
#def hangee(a)
#  case a
#    #when 0
#    #  guy = " \t|--- \n\t| \n\t| \n\t| \n\t| \n\t|_____"
#    #when 1
#    #  guy = " \t|--- \n\t|  O \n\t| \n\t| \n\t|_____"
#    when 0
#      guy = " \t|--- \n\t|  O \n\t|  | \n\t| \n\t|_____"
#    when 1
#      guy = " \t|--- \n\t|  O \n\t|  |/ \n\t| \n\t| \n\t|_____"
#    when 2
#      guy = " \t|--- \n\t|  O \n\t| \\|/ \n\t|\n\t| \n\t|_____"
#    when 3
#      guy = " \t|--- \n\t|  O \n\t| \\|/ \n\t| / \n\t| \n\t|_____"
#    when 4
#      guy = " \t|--- \n\t|--- \n\t|  O \n\t| \\|/ \n\t| /\\ \n\t| \n\t|_____"
#    when 5
#      guy = " \t|--- \n\t|  | \n\t|  O \n\t| \\|/ \n\t| /|\\ \n\t|_____"
#  end
#  puts guy+"\n\n"
#end

# print graphics
def printHangman(a)

    puts "---_-----|"
    if a > 0
      puts "   |     |"
    else
      puts "         |"
    end

    if a > 1
      puts "   O     |"
    else
      puts "         |"
    end

    if a > 2
      print "  /||"
    else
      print "     "
    end

    if a > 3
      puts "\\   |"
    else
      puts "    |"
    end

    if a > 4
      print "   /"
    else
      print "    "
    end

    if a > 5
      puts "\\    |"
    else
      puts "     |"
    end

    puts "---------|"

end

################################################
  @user = UserDetails.new
  newGameFlag = true
  winGameFlag = false
  lostGameFlag = false
  alreadyEnteredFlag = false
  tempGameWord = ""
  # for word Game
  begin

    system('cls')
    #system('clear')

    puts "############################################################"
    puts "#################### Hang Man Game #######################"
    puts 'Hello  ' + @user.getUserName
    puts 'Games Played := '+ @user.getGamesPlayed.to_s
    puts 'Games Won := '+ @user.getGamesWon.to_s
    puts 'Games Lost := '+ @user.getGamesLost.to_s


    if(winGameFlag)
      puts "##############"
      puts "You Won."
      puts "Game Word :- "+ tempGameWord
      puts "##############"
    end

    if(lostGameFlag)
      puts "##############"
      puts "You Lost."
      puts "Game Word :- "+ tempGameWord
      puts "##############"
    end


    puts "Enter 'n' or 'N' to Exit."
    puts "Enter any key to play := "
    userInput = gets.chomp
    gameCompleteFlag = false

    if(userInput == "n" || userInput == 'N')
      exitGameFlag =  false
      newGameFlag = false
      gameCompleteFlag = false
    else
      winGameFlag = false
      lostGameFlag = false
      gameCompleteFlag = true
    end

    @user.updateGamesPlayed
    currentCount = 0
    @currentGameWord = GameWord.new
    tempGameWord = @currentGameWord.getWord
    userGameWord = Array.new(@currentGameWord.getWordLength, '-')
    userWrongInputCount = 0
    previousEntered = Array.new # keep track for previous characters
    charFoundFlag = false
    correctInputFlag = false

    #word Find loop
    ########
    while gameCompleteFlag do

      startPosition = 0
      foundCount = 0 # check character Found or not

      puts "############################################################"
      puts "#################### Hang Man Game #######################"
      puts 'Hello  ' + @user.getUserName
      puts 'Games Played := '+ @user.getGamesPlayed.to_s
      puts 'Games Won := '+ @user.getGamesWon.to_s
      puts 'Games Lost := '+ @user.getGamesLost.to_s

      puts "==========================================================="


      puts "Current Game Data "
      #puts "Current Game Word :- "+@currentGameWord.getWord
      puts "Wrong Inputs := " + userWrongInputCount.to_s
      print "Previous Entered Characters :- "

      previousEntered.each do |r|
        print " " + r
      end

      puts ""


      if correctInputFlag
        puts "###################"
        puts "Please input correct character."
        puts "###################"
        correctInputFlag = false
        #        charFoundFlag = false
      end

      #    #####
      if alreadyEnteredFlag
        puts "###################"
        puts "Already Entered."
        puts "###################"
        charFoundFlag = false
      end

      if charFoundFlag
        puts "###################"
        puts "Character Not Found."
        puts "###################"
      end

      #hangee(userWrongInputCount)
      printHangman(userWrongInputCount) # print Graphics
      print "your Word :=  "

      userGameWord.each do |r|
        print " " + r
      end

      puts ""
      puts "Please Enter Character :- "
      userChar = (gets.chomp).downcase

      # check input is a char or not
      if !( userChar.length == 1 && userChar.match(/^[[:alpha:]]$/))
        correctInputFlag = true
        wordFlag = false
        charFoundFlag = false
        alreadyEnteredFlag = false
      else
        # check if already entered or not
        if previousEntered.index(userChar)
          #puts "Already Entered ."
          alreadyEnteredFlag = true
          wordFlag = false
        else
          previousEntered.push(userChar)
          alreadyEnteredFlag = false
          wordFlag = true
        end
      end

      ## check if already entered or not
      #if previousEntered.index(userChar)
      #  #puts "Already Entered ."
      #  alreadyEnteredFlag = true
      #  wordFlag = false
      #else
      #  previousEntered.push(userChar)
      #  alreadyEnteredFlag = false
      #  wordFlag = true
      #
      #  #        @currentGameWord.allCharacterPosition()
      #
      #end

      while wordFlag do

        charIndex = @currentGameWord.findCharacter(userChar,startPosition)

        #        puts charIndex
        if(charIndex)
          startPosition = startPosition + charIndex + 1
          userGameWord[startPosition - 1] = userChar
          #         print userGameWord
          currentCount += 1
          foundCount += 1
          charFoundFlag = false
        else
          if (foundCount < 1)
            userWrongInputCount += 1
            charFoundFlag = true
          end
          wordFlag = false
        end

        # exit if all correct words
        if(currentCount >= @currentGameWord.getWordLength)
          wordFlag = false
          @user.updateGamesWon
          gameCompleteFlag = false
          winGameFlag = true
        end

        # Exit if count of Wrong Words Ends
        if (userWrongInputCount >= 6)
          @user.updateGamesLost
          lostGameFlag = true
          gameCompleteFlag = false
          wordFlag = false
        end
      end

    end
    #########

  end while newGameFlag
