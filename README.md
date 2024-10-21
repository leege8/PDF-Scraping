# PDF Scraping
The process outlines how to scrape and extract multiple tables from PDF documents using the location coordinates of specific strings. Please note assumptions below:
1. The table structure in the PDF documents remains consistent, with fixed column headers and formats, including font, spacing, and padding.
2. The tables in the PDF documents are actual tables, not screenshots.
3. The location of the tables is variable; for instance, the same table might appear on page 2, page 5, or elsewhere in the document. 

## Prerequisites:
```
import re
import PyPDF2 as pdfs
import tabula
from tabula.io import read_pdf
```

## Methodologies
Imagine there are three different tables within the same PDF file, and the task is to extract the product table highlighted in yellow. Note that some tables contain merged cells, while others do not, and they are not always aligned strictly vertically or horizontally.
### Step 1
Assume this PDF document spans multiple pages. The first step is to identify which page contains the product table we are seeking. 
```
P = 'Product'
reader = pdfs.PdfReader(file_path)

for ipage, page in enumerate(reader.pages, start=1):
    text = page.extract_text()
    if re.search(P, text):
        print('Found Product Table on page', ipage)
```
### Step 2
Once the page number is identified, read the specific page. Set the parameter guess=False to ensure the entire page is captured, and use output_format='json' to convert the table into JSON format. 
```
P = 'Product'
reader = pdfs.PdfReader(file_path)

for ipage, page in enumerate(reader.pages, start=1):
    text = page.extract_text()
    if re.search(P, text):
        print('Found Product Table on page', ipage)

        table = tabula.io.read_pdf(file_path,guess=False, stream=True, pages=ipage,columns=(),multiple_tables=True, output_format="json",pandas_options={'header': None})
```
you can view what the data look like in Json structure by using a nested for loop. Each string has 4 keys: top, left, width and height. 
In the case, bottom = top + height; right = left + width
```
for i in table[0].get('data'):
    for j in i:
        print(j)
#outputs: 
#{'top': 87.69, 'left': 104.4, 'width': 28.69988250732422, 'height': 6.75, 'text': 'Name'}
#{'top': 87.69, 'left': 185.76, 'width': 18.799880981445312, 'height': 6.75, 'text': 'Age'}
#{'top': 87.69, 'left': 257.52, 'width': 53.92987060546875, 'height': 6.75, 'text': 'Occupation'}
#{'top': 87.69, 'left': 342.12, 'width': 37.95989990234375, 'height': 6.75, 'text': 'Country'}
#{'top': 87.69, 'left': 400.92, 'width': 33.369842529296875, 'height': 6.75, 'text': 'Capital'}
#{'top': 87.69, 'left': 461.4, 'width': 98.19985961914062, 'height': 6.75, 'text': 'Population (Millions)'}
#{'top': 87.69, 'left': 577.44, 'width': 43.640018463134766, 'height': 6.75, 'text': 'Language'}
#...
```
### Step 3
Within the if statement, check for the 'Top', 'Right', 'Left', and 'Bottom' coordinates by specifying the keywords. Incorporate these four coordinates into the area parameter and scrape the table again. The output will display a final table in a well-structured format.
```
P = 'Product'
reader = pdfs.PdfReader(file_path)

for ipage, page in enumerate(reader.pages, start=1):
    text = page.extract_text()
    if re.search(P, text):
        print('Found Product Table on page', ipage)

        table = tabula.io.read_pdf(file_path,guess=False, stream=True, pages=ipage,columns=(),multiple_tables=True, 
                                               output_format="json",pandas_options={'header': None})
        top_Dict = {}
        bottom_Dict = {}
        right_Dict = {}
        
        for dic in table[0].get('data'):
            for lst in dic:
                if lst['top'] !=0.0:
                    bottom_Dict.update({lst['top']+lst['height']*3:lst['text']})
                    
                if lst['text'] in '4.5' and lst['top'] !=0.0: 
                    right_Dict.update({lst['left']+lst['width']*2:lst['text']})

                if lst['text'] in 'Laptop' and lst['top'] !=0.0:
                    top_Dict.update({lst['top']:lst['text']})
                            
        table_updated = tabula.io.read_pdf(file_path,guess=True, stream=True, pages=ipage,columns=(), 
                                                area=(max(list(top_Dict.keys())),10, max(list(bottom_Dict.keys())), max(list(right_Dict.keys()))),
                                                     pandas_options={'header': None})
        
        table_final = table_updated[0].fillna('')
        display(table_final)
```        

