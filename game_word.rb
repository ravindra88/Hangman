class GameWord
  # To change this template use File | Settings | File Templates.

  ############################
  # initialize all constraints
  def initialize
    flag = true
    # Word Length should be greater 3
    begin
      lineNo = rand(109583)
      fileData = IO.readlines('wordsEn.txt')
      @gameWord = fileData[lineNo].chomp
      if(@gameWord.length >= 3)
        # return from loop if word length is 3 or more
        flag = false
      end
    end while flag
  end


  ############################
  def getWordLength
    return @gameWord.length
  end

  ############################
  # return Word
  def getWord
    return @gameWord
  end

  ############################
  #find that character exists or not
  def findCharacter(charToFind, startPosition)
    # Return Position Or nil
    return @gameWord[startPosition, getWordLength].index(charToFind)
  end

end