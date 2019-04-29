# CLASS: Model
#
# Author: Mitul patel, 7851781
#
# REMARKS: Model that simulates the running of the game
#
#-----------------------------------------

require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

class Model


  def initialize(people,places,weapons)
    #------------------------------------------------------
    # initialize
    #
    # PURPOSE:  Constructor
    # PARAMETERS:
    #    people-a set of cards for suspects in the game
    #    places-a set of cards for the places in the game
    #    weapons-a set of cards for the weapons in the game
    #-----------------------------------------------------

    @people=people
    @places=places
    @weapons=weapons
  end


  def setPlayers(players)
    #------------------------------------------------------
    # setPlayers
    #
    # PURPOSE:  initializes the players of the game
    # PARAMETERS:
    #    people-a set of players in the game
    #-----------------------------------------------------


    @players=players
    index=0


    for player in @players

      player.setup(@players.length,index,@people,@places,@weapons)  #setup players in the game
      index+=1

    end

  end



  def setupCards()

    #------------------------------------------------------
    # setupCards
    #
    # PURPOSE:  sets up cards for the players
    #-----------------------------------------------------

    @secret_cards=Array.new
    index=0

    @people=@people.shuffle()     #shuffle the suspects
    printf("\nHere are the names of all the suspects: \n")
    printHelper(@people)
    @secret_cards.push(@people.pop)  #pick the secret suspect




    @places=@places.shuffle()   #shuffle the places
    printf("\nHere are the names of all the places: \n")
    printHelper(@places)
    @secret_cards.push(@places.pop) #pick the secret suspect



    @weapons=@weapons.shuffle()   #shuffle the places
    printf("\nHere are the names of all the weapons: \n")
    printHelper(@weapons)
    @secret_cards.push(@weapons.pop) #pick the secret suspect


    puts "\n\n"

    allCards=@people+@places+@weapons #put all cards in one array
    allCards=allCards.shuffle() #shuffle all cards

    index=0
    length=@players.length()

    for card in allCards   # loop through each card

      player=@players[index%length]
      player.setCard(card)  # distribute the cards
      index+=1

    end

  end


  def printHelper(arr)
    #------------------------------------------------------
    # printHelper
    #
    # PURPOSE:  Helps print the contents
    #-----------------------------------------------------

    index=0

    while index<arr.length

      if index==0
        printf(arr[index].to_s)
      else
        printf(", "+arr[index].to_s)
      end
      index+=1
    end

    printf "."

  end



  def play()
    #------------------------------------------------------
    # play
    #
    # PURPOSE:  simulates the running of the game
    #-----------------------------------------------------

    index=0
    currPlayers=@players.clone


    while true  # while game is not over

      length=currPlayers.length()
      currPlayer=currPlayers[index%length]

      # printing----------------------
      if currPlayer.instance_of?Player
        puts("Current turn #{currPlayer.index}.")
      else
        puts("Its your turn")
      end
      # printing complete-----------------------

      guess=currPlayer.getGuess # asking current player for guess

      if guess.isAccusation   # if guess is an accusation

        puts("Player #{currPlayer.index}: accusation #{guess.to_s}")

        # testing to see if its a guess
        if guess.person==@secret_cards[0]&&guess.place==@secret_cards[1]&&guess.weapon==@secret_cards[2]

          puts("Player #{currPlayer.index} won the game.")
          # player won the game
          break

        else  # bad accusation

          # player out, bad accusation
          currPlayers.delete_at(index%length)

          if currPlayer.instance_of?(Player)
            puts("Player #{currPlayer.index} made a bad accusation and was removed from the game.")
          else
            puts("You, made a bad accusation and are removed from the game.")

          end

          if currPlayers.length==1    # check if num players is 1

            # remaining player won the game
            puts("Player #{currPlayers[0].index} won the game.")
            break
          end
        end

      else  # guess is a guess not accusation

        puts("Player #{currPlayer.index}: suggestion #{guess.to_s}")

        times=@players.length-1  #number of times we will
        askPlayer=nil
        response=nil
        indexI=index

        while times>=0  #go through loop to see for guesses

          askPlayer=@players[indexI%@players.length]

          if askPlayer!=currPlayer

            # asking current player
            puts("Asking player #{askPlayer.index}.")
            response=askPlayer.canAnswer(currPlayer.index,guess)

          end

          if response!=nil  # if response is not nil, we have a response
            break
          end

          times-=1
          indexI+=1
        end

        if response!=nil

          currPlayer.receiveInfo(askPlayer.index,response)  # receive info

          if currPlayer.instance_of?(Player)

            # the player received a response
            puts("Player #{askPlayer.index} answered.")

          else

            puts("Player #{askPlayer.index} refuted your suggestion by showing you #{response.value}.")
            #the human player received a response

          end

        else  #no player answered

          if currPlayer.instance_of?(Player)

            # the player received a response
            puts("No one could answer.")

          else

            puts("No one could refute your suggestion.")
            #the human player received a response
          end
        end
      end

      index+=1  # move on to the next player

    end
  end



end