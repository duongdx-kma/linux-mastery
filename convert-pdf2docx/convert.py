from pdf2docx import Converter
import sys

input = sys.argv[1]
output = sys.argv[2]

# Keeping the PDF's location in a separate variable
pdf_file = r"{}".format(input)

# Maintaining the Document's path in a separate variable
docx_file = r"{}".format(output)
 
# Using the built-in function, convert the PDF file to a document file by saving it in a variable.
cv = Converter(pdf_file)
 
# Storing the Document in the variable's initialised path
cv.convert(docx_file)

# Conversion closure through the function close()
cv.close()