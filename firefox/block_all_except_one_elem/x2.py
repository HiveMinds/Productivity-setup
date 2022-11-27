import requests
from bs4 import BeautifulSoup
import xml.etree.cElementTree as ET


unformatted_filename = "first.xml"
formatted_filename = "first.xml"

# Get XML from url.
resp = requests.get("https://startpagina.nl")
# resp = requests.get('https://stackoverflow.com')
with open(unformatted_filename, "wb") as foutput:
    foutput.write(resp.content)

# Improve XML formatting
with open(unformatted_filename) as fp:
    soup = BeautifulSoup(fp, "xml")

    elements=soup.find_all()  # find all the div element (second argument is optional mentioned to scrape/find only element with attribute value)
    #print([[int(x.text) for x in i.find_all('b')] for i in soup.find_all('div', {'class': 'container'})])  # get list of all div's number list as you require
    #print(f'elements={elements}')

    with open(formatted_filename, "w") as f:
        f.write(soup.prettify())

        # Parse XML
tree = ET.parse(formatted_filename, parser=ET.XMLParser(encoding="utf-8"))
root = tree.getroot()
#print(dir(root))

for child in root:
    child.tag, child.attrib

    

    
#/html/body/div[6]/div[2]/div[1]/div[2]/div/div[2]/form/input[2]
def get_xpaths(elem,path,xpaths):
    if f'{path}/{elem.tag}' not in xpaths:
        print(f'{path}/{elem.tag}')
        xpaths.append(f'{path}/{elem.tag}')
        #for child in elem.getiterator():
        for child in elem.getchildren():
            get_xpaths(child, f"{path}/{child.tag}",xpaths)


sometree = ET.parse(formatted_filename)
for elem in sometree.getiterator():    
    get_xpaths(elem, elem.tag,[])
exit()

    
tree = ET.parse(formatted_filename)
for elem in tree.getiterator():
    if elem.tag:
        print("my name:")
        print("\t" + elem.tag)
    if elem.text:
        print("my text:")
        print("\t" + (elem.text).strip())
    if elem.attrib.items():
        print("my attributes:")
        for key, value in elem.attrib.items():
            print("\t" + "\t" + key + " : " + value)
    if list(elem):  # use elem.getchildren() for python2.6 or before
        print("my no of child: %d" % len(list(elem)))
    else:
        print("No child")
    if elem.tail:
        print("my tail:")
        print("\t" + "%s" % elem.tail.strip())
    print("$$$$$$$$$$")

#<input type="text" class="search-field ui-autocomplete-input" name="query" data-reorder-links="on" data-channel="desktop" data-autocomplete="on" data-section="top" data-header-text="<div style=&quot;text-align: center;&quot;><b>&amp;nbsp;Resultaten geselecteerd door Startpagina.nl</b></div>" data-footer-text="&amp;nbsp;" autocomplete="off" autocorrect="off" autocapitalize="none" spellcheck="false" placeholder="Vul hier je zoekopdracht in">