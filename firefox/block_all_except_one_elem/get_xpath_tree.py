att = """
<test:myXML xmlns:test="http://com/my/namespace" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">
<Parent>
  <FirstNode name="FirstNodeName"></FirstNode>
    <Child1>Test from Child1</Child1>
  <SecondNode name="SecondNodeName" type="SecondNodeType">
    <Child2>
      <GrandChild>Test from GrandChild</GrandChild>
    </Child2>
  </SecondNode>
</Parent>
</test:myXML>
"""


from lxml import etree

import requests

r = requests.get("https://startpagina.nl")
# print(r.text)
att = r.text
bef = []
xps = []

xmlDoc = etree.fromstring(att)
root = etree.ElementTree(xmlDoc)

for node in xmlDoc.iter():
    ats = "{"
    for a in range(len(node.keys())):
        mystr = node.keys()[a] + '="' + node.values()[a] + '" '
        ats += mystr
    ats += "}"
    xp = root.getpath(node)
    bef.append(xp)
    ent = ""
    if len(ats) > 2:
        ent += xp
        ent += ats.replace(" }", "}")
    else:
        ent += xp
    xps.append(ent)

for b, f in zip(bef, xps):
    prev = bef.index(b) - 1
    if prev >= 0:
        cur = b.rsplit("/", 1)[0]
        new_cur = f.rsplit("/", 1)[1]
        if bef[prev] == cur:
            new_f = xps[prev] + "/" + new_cur
            xps[prev + 1] = new_f
            print(new_f)
        else:
            print(f)
