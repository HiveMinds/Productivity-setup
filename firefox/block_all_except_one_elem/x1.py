import requests
from bs4 import BeautifulSoup
import xml.etree.cElementTree as ET
from lxml import etree


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
    with open(formatted_filename, "w") as f:
        f.write(soup.prettify())

def etree_iter_path(node, tag=None, path='.'):
    if tag == "*":
        tag = None
    if tag is None or node.tag == tag:
        yield node, path
    for child in node:
        _child_path = '%s/%s' % (path, child.tag)
        for child, child_path in etree_iter_path(child, tag, path=_child_path):
            yield child, child_path
        

# Parse XML
tree = ET.parse(formatted_filename, parser=ET.XMLParser(encoding="utf-8"))
root = tree.getroot()
for child in root:
    print(f'child={child}')
    print(f'child.tag={child.tag}')
    print(f'child.attrib={child.attrib}')
    child.tag, child.attrib
#
#for elem, path in etree_iter_path(root):
#    print(f'elem.tag={elem.tag}')
#    print(f'elem.attrib={elem.attrib}')
#    print(f'xpath={path}')


for elem in sometree.getiterator():
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
-