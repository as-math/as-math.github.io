import sys
from lxml import etree

if len(sys.argv) != 4:
    print("Invalid input format! Type:")
    print(f"python {sys.argv[0]} input.xml input.xsl output.html")

xslt = etree.XSLT(etree.parse(sys.argv[2]))
xml = etree.parse(sys.argv[1])
output = xslt(xml)

output.write(sys.argv[3], method='html', pretty_print=True, encoding='UTF-8')