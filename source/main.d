import std.stdio;
import std.uni;
import std.array;
import std.conv;
import std.file;
import std.string;

import printed.canvas;

import state;
import character;

// goal is to generate part of the rules PDF
// and eventually simulate game from the same code

void main()
{
    printADeck();
}

void printADeck()
{
    // Generate a deck
    CardInstance[] cards = makeDeck(MAX_PLAYERS);

    writefln("Printing a deck of %s cards", cards.length);

    auto pdfDoc = new PDFDocument(210, 297);


    float cardWidth = 63.5f;
    float cardHeight = 88.9f;

    auto context = cast(IRenderingContext2D) pdfDoc;
    context.fontSize = 11.0f;

    const columnsPerPage = 3;
    const rowsPerPage = 3;
    
    const marginLeft = 0.5f * (context.pageWidth - columnsPerPage * cardWidth);
    const marginTop = 0.5f * (context.pageHeight - rowsPerPage * cardHeight);

    int currentColumn = 0;
    int currentRow = 0;
    int currentPage = 0;

    void incrementPosition()
    {
        currentColumn += 1;
        if (currentColumn >= columnsPerPage)
        {
            currentColumn = 0;
            currentRow += 1;
            if (currentRow >= rowsPerPage)
            {
                currentRow = 0;
                context.newPage;
            }
        }
    }

    void drawCard(float x, float y, CardInstance card)
    {
        context.fontFace = "Comic Sans Ms";
        context.fontSize = 11.0f;
        context.fontStyle = FontStyle.normal;

        float left = x + cardWidth * currentColumn;
        float right = left + cardWidth;

        float top = y + cardHeight * currentRow;
        float bottom = top + cardHeight;

        context.fillStyle = Brush("white");
        context.fillRect(x, y, cardWidth, cardHeight);

        context.fillStyle = Brush("black");
        context.fillRect(x + 0.2, y + 0.2, cardWidth - 0.4, cardHeight - 0.4);

        context.fillStyle = Brush("#eee");
        context.fillRect(x + 3, y + 3, cardWidth - 6, cardHeight - 6);

        // text area
        context.fillStyle = Brush("#fff");
        context.fillRect(x + 4, y + 42, cardWidth - 8, cardHeight - 47);

        string name = card.type.getName();
        int rank = card.type.getRank();
        string desc = card.type.getDescription();

        name = to!string(name.asUpperCase.array);

        context.fillStyle = Brush("black");
        context.fillText(name, x + 5, y + 8);
        context.fillText(format("Rang %s", rank), x + cardWidth - 16, y + 8);
    }

    foreach(int cardIndex, card; cards)
    {
        // get position of the card rect
        float left = marginLeft + cardWidth * currentColumn;
        float top = marginTop + cardHeight * currentRow;

        drawCard(left, top, card);

        // not the last card, increment position
        if (cardIndex + 1 < cards.length) 
            incrementPosition;
    }

    auto bytes = pdfDoc.bytes;
    std.file.write("cartes.pdf", bytes);
    writefln("Written %s bytes to cartes.pdf", bytes.length);
}