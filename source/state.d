module state;

import std.string;
import std.stdio;
import std.random;
import character;

// State of the whole game

// TODO: model knowledge of other players
class Player
{
    this(GameState gameState, int playerIndex, string name)
    {
        this.gameState = gameState;
        this.playerIndex = playerIndex;
        this.name = name;
    }

    bool alive = true; // is still in game
    GameState gameState;
    string name;
    int playerIndex;
    CardInstance hand; // held card cachée

    string statusString()
    {
        if (!alive)
            return format("%s has been eliminated", name);
        else
            return format("%s has %s in hand (rank %s)", name, hand.type.getName, hand.type.getRank);
    }
}

static immutable string[5] playerNames = ["Alice", "Bob", "Chris", "Daniel", "Eve"];

class GameState
{
    Player[] players; // players in clock order
    CardInstance[] pioche; // 0 = top of draw
    CardInstance[] cemetary; // defausse
    int currentPlayer = 0; // Alice always starts playing
    int numPlayers;
    int numTurns = 1;

    // start a new game of Startup Nation
    this(int numPlayers)
    {
        this.numPlayers = numPlayers;
        pioche = makeDeck(numPlayers);
        randomShuffle(pioche);       

        foreach(i; 0..numPlayers)
        {
            auto player = new Player(this, i, playerNames[i]);
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

    int playersAlive()
    {
        int r = 0;
        foreach(i; 0..numPlayers)
            if (players[i].alive)
                r++;
        return r;
    }

    bool finished()
    {
        return pioche.length == 0 || playersAlive() <= 1;
    }

    void playATurn()
    {
        writefln("** Turn %s", numTurns);
        assert(!finished);
        CardInstance card = drawOneCard();

        // TODO enumerate choice

  /+      void playerPlayCard(Player player, CardInstance drawnCard)
        {
            // must choose something to do, for now choose randomly
            if (uniform(0, 2) == 0)
            {
                // replace hand with new
                CardInstance toPlay = hand;
                hand = drawnCard;
                gameState.applyCardEffect(this, toPlay);            
            }
            else
            {
                // keep old
                gameState.applyCardEffect(this, drawnCard);            
            }
        } +/

        currentPlayer = (currentPlayer + 1) % numPlayers;
        numTurns++;
    }

    void displayWinners()
    {
        int alive = playersAlive();
        if (alive == 0)
            writeln("END OF GAME: All players have died.");
        else if (alive == 1)
        {
            foreach(i; 0..numPlayers)
                if (players[i].alive)
                {
                    writefln("END OF GAME: %s is the only survivor.", players[i].name);
                    writefln("%s", players[i].statusString);
                }
        }
        else
        {
            writefln("END OF GAME: Several survivors.");
            foreach(i; 0..numPlayers)
                writefln("%s", players[i].statusString);
        }        
    }

    void applyCardEffect(Player currentPlayer, CardInstance instance)
    {
        // TODO
        cemetary ~= instance;
    }
}

// make a deck for N players
CardInstance[] makeDeck(int numPlayers)
{
    CardInstance[] deck;
    assert(numPlayers >= MIN_PLAYERS && numPlayers <= MAX_PLAYERS);
    
    const(int[]) multiplicity = getMultiplicities(numPlayers);

    foreach(int t, const(CharacterType) type; allCharacterTypes)
    {
        foreach(m; 0..multiplicity[t])
            deck ~= new CardInstance(type);
    }
    return deck;
}

