module state;

import std.random;
import character;

// State of the whole game

class Player
{
    CardInstance hand; // carte cachée
}

class GameState
{
    Player[] players; // players in clock order
    CardInstance[] pioche; // 0 = top of draw

    // start a new game of Startup Nation
    this(int numPlayers)
    {
        pioche = makeDeck(numPlayers);

        foreach(i; 0..numPlayers)
        {
            auto player = new Player;
            player.hand = drawOneCard();
            players ~= player;
        }
    }

    int numCardsInDraw()
    {
        return cast(int)(pioche.length);
    }

    CardInstance drawOneCard()
    {
        CardInstance card = pioche[0];
        pioche = pioche[1..$];
        return card;
    }

}

// make a deck for N players
CardInstance[] makeDeck(int numPlayers)
{
    CardInstance[] deck;    
    assert(numPlayers == 4 || numPlayers == 5);
    if (numPlayers == 4)
    {
        foreach(int t, const(CharacterType) type; allCharacterTypes)
        {
            foreach(m; 0..multiplicity4Players[t])
                deck ~= new CardInstance(type);
        }
    }
    else if (numPlayers == 5)
    {
        foreach(int t, const(CharacterType) type; allCharacterTypes)
        {
            foreach(m; 0..multiplicity5Players[t])
                deck ~= new CardInstance(type);
        }
    }

    deck.randomShuffle; 
    return deck;
}

