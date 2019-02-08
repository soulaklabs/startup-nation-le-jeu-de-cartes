module character;



// Base abstract class for character type
class CharacterType
{
    abstract string getName();
    abstract int getRank();
    abstract string getDescription();    
}

class Stagiaire : CharacterType
{
    override string getName()
    {
        return "Stagiaire";
    }
    
    override int getRank()
    {
        return 0;
    }

    override string getDescription()
    {
        return `Posez une question de type "Es-tu <tel rôle>?". Si vous trouvez exactement, ce joueur est éliminé de la manche.`;
    }
}

class ChefTechnique : CharacterType
{
    override string getName()
    {
        return "Chef Technique";
    }

    override int getRank()
    {
        return 1;
    }

    override string getDescription()
    {
        return `Choisissez un joueur autour de la table. Il vous montre sa carte cachée.`;
    }
}

class Recruteuse : CharacterType
{
    override string getName()
    {
        return "Recruteuse";
    }

    override int getRank()
    {
        return 2;
    }

    override string getDescription()
    {
        return `Choisissez un joueur autour de la table. Echangez votre carte cachée avec la sienne.`;
    }
}

class Commercial : CharacterType
{
    override string getName()
    {
        return "Commercial";
    }

    override int getRank()
    {
        return 3;
    }

    override string getDescription()
    {
        return `Prenez un jeton Alliance autour de la table. Donnez-le à un joueur qui n'a pas de jeton alliance.`;
    }
}

class Dirigeant : CharacterType
{
    override string getName()
    {
        return "Dirigeant";
    }

    override int getRank()
    {
        return 4;
    }

    override string getDescription()
    {
        return `Accordez une promotion à un joueur, même vous. Le joueur promu joue sa carte cachée sans appliquer l'effet. Il pioche jusqu'à trouver une carte de rang supérieur, puis il replace la pioche dans le même ordre. Si il ne trouve pas de telle carte, il est éliminé de la manche.`;
    }
}

class Investisseur : CharacterType
{
    override string getName()
    {
        return "Investisseur";
    }

    override int getRank()
    {
        return 5;
    }

    override string getDescription()
    {
        return `Accordez une destitution à un joueur, même vous. Le joueur destitué joue sa carte cachée sans appliquer l'effet. Il pioche jusqu'à trouver une carte de rang inférieure, puis il replace la pioche dans le même ordre. Si il ne trouve pas de telle carte, il est éliminé de la manche.`;
    }
}

class Emmanuel : CharacterType
{
    override string getName()
    {
        return "Emmanuel";
    }

    override int getRank()
    {
        return 6;
    }

    override string getDescription()
    {
        return `Si vous jouez la carte Emmanuel en dehors d'une promotion/destitution, vous sortez de la manche.`;
    }
}

class Brigitte : CharacterType
{
    override string getName()
    {
        return "Brigitte";
    }

    override int getRank()
    {
        return 7;
    }

    override string getDescription()
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

class CardInstance
{
    this(const(CharacterType) type)
    {
        this.type = type;
    }

    const(CharacterType) type;
}
