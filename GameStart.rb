require './game_word'   # Load File or Class word operation
require './user_details'   # Load File or Class for User Details


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

  # for word Game
  begin

    puts "############################################################"
    puts "#################### Hang Man Game #######################"
    puts 'Hello  ' + @user.getUserName
    puts 'Games Played := '+ @user.getGamesPlayed.to_s
    puts 'Games Won := '+ @user.getGamesWon.to_s
    puts 'Games Lost := '+ @user.getGamesLost.to_s


    if(winGameFlag)
      puts "##############"
      puts "You Won."
      puts "##############"
    end

    if(lostGameFlag)
      puts "##############"
      puts "You Lost."
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
    userGameWord = Array.new(@currentGameWord.getWordLength, '-')
    userWrongInputCount = 0
    previousEntered = Array.new # keep track for previous characters
    charFoundFlag = false

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
      puts "Current Game Word :- "+@currentGameWord.getWord
      puts "Wrong Inputs := " + userWrongInputCount.to_s
      print "Previous Entered Characters :- "


      previousEntered.each do |r|
        print " " + r
      end

      puts ""

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

      printHangman(userWrongInputCount) # print Graphics
      print "your Word :=  "
      userGameWord.each do |r|
        print " " + r
      end

      puts ""
      puts "Please Enter Character :- "
      userChar = (gets.chomp).downcase

      if previousEntered.index(userChar)
        #puts "Already Entered ."
        alreadyEnteredFlag = true
        wordFlag = false
      else
        previousEntered.push(userChar)
        alreadyEnteredFlag = false
        wordFlag = true
      end

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
