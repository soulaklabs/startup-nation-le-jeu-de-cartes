import std.stdio;

import printed.canvas;
import std.file;

void main()
{
    auto pdfDoc = new PDFDocument();
    auto renderer = cast(IRenderingContext2D) pdfDoc;
    with(renderer)
    {
       
    }

    /// Draw the result of each specific renderer.
    std.file.write("output.pdf", pdfDoc.bytes);
}

