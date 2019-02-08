module character;



// Base abstract class for character type
class CharacterType
{
    abstract string getName() const;
    abstract int getRank() const;
    abstract string getDescription() const;
}

class Stagiaire : CharacterType
{
    override string getName() const
    {
        return "Stagiaire";
    }
    
    override int getRank() const
    {
        return 0;
    }

    override string getDescription() const
    {
        return `Posez une question de type "Es-tu <tel rôle>?". Si vous trouvez exactement, ce joueur est éliminé de la manche.`;
    }
}

class ChefTechnique : CharacterType
{
    override string getName() const
    {
        return "Chef Technique";
    }

    override int getRank() const
    {
        return 1;
    }

    override string getDescription() const
    {
        return `Choisissez un joueur autour de la table. Il vous montre sa carte cachée.`;
    }
}

class Recruteuse : CharacterType
{
    override string getName() const
    {
        return "Recruteuse";
    }

    override int getRank() const
    {
        return 2;
    }

    override string getDescription() const
    {
        return `Choisissez un joueur autour de la table. Echangez votre carte cachée avec la sienne.`;
    }
}

class Commercial : CharacterType
{
    override string getName() const
    {
        return "Commercial";
    }

    override int getRank() const
    {
        return 3;
    }

    override string getDescription() const
    {
        return `Prenez un jeton Alliance autour de la table. Donnez-le à un joueur qui n'a pas de jeton alliance.`;
    }
}

class Dirigeant : CharacterType
{
    override string getName() const
    {
        return "Dirigeant";
    }

    override int getRank() const
    {
        return 4;
    }

    override string getDescription() const
    {
        return `Accordez une promotion à un joueur, même vous. Le joueur promu joue sa carte cachée sans appliquer l'effet. Il pioche jusqu'à trouver une carte de rang supérieur, puis il replace la pioche dans le même ordre. Si il ne trouve pas de telle carte, il est éliminé de la manche.`;
    }
}

class Investisseur : CharacterType
{
    override string getName() const
    {
        return "Investisseur";
    }

    override int getRank() const
    {
        return 5;
    }

    override string getDescription() const
    {
        return `Accordez une destitution à un joueur, même vous. Le joueur destitué joue sa carte cachée sans appliquer l'effet. Il pioche jusqu'à trouver une carte de rang inférieure, puis il replace la pioche dans le même ordre. Si il ne trouve pas de telle carte, il est éliminé de la manche.`;
    }
}

class Emmanuel : CharacterType
{
    override string getName() const
    {
        return "Emmanuel";
    }

    override int getRank() const
    {
        return 6;
    }

    override string getDescription() const
    {
        return `Si vous jouez la carte Emmanuel en dehors d'une promotion/destitution, vous sortez de la manche.`;
    }
}

class Brigitte : CharacterType
{
    override string getName() const
    {
        return "Brigitte";
    }

    override int getRank() const
    {
        return 7;
    }

    override string getDescription() const
    {
        return `Si vous jouez la carte Brigitte en dehors d'une promotion/destitution, vous sortez de la manche. Si Emmanuel est joué, Brigitte se déclare et meurt.`;
    }
}

static immutable CharacterType[] allCharacterTypes =
[
    new Stagiaire,
    new ChefTechnique,
    new Recruteuse,
    new Commercial,
    new Dirigeant,
    new Investisseur,
    new Emmanuel,
    new Brigitte,
];

enum MIN_PLAYERS = 4;
enum MAX_PLAYERS = 5;

static immutable int[] multiplicity4Players =
[
    4,
    2,
    2,
    2,
    1,
    1,
    1,
    1
];

static immutable int[] multiplicity5Players =
[
    6,
    2,
    2,
    3,
    2,
    2,
    1,
    1
];

const(int[]) getMultiplicities(int numPlayers)
{
    if (numPlayers == 4)
        return multiplicity4Players;
    if (numPlayers == 5)
        return multiplicity5Players;
    throw new Exception("Unsupported number of players");
}

class CardInstance
{
    this(const(CharacterType) type)
    {
        this.type = type;
    }

    const(CharacterType) type;
}
