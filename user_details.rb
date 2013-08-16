class UserDetails
  # To change this template use File | Settings | File Templates.
  def initialize
    print "Enter Your Name:-"
    @userName = gets.chomp
    @gamesPlayed = 0
    @gamesWon = 0
    @gamesLost = 0
  end

  # Get User Name
  def getUserName
    return @userName
  end

  # return games played total
  def getGamesPlayed
    return @gamesPlayed
  end

  # total games lost
  def getGamesLost
    return @gamesLost
  end

  def getGamesWon
    return @gamesWon
  end

  # update games played by 1
  def updateGamesPlayed
    @gamesPlayed += 1
  end

  # update games Lost by 1
  def updateGamesLost
    @gamesLost += 1
  end

  #update games Won
  def updateGamesWon
    @gamesWon += 1
  end

end