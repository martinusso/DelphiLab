unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  XMLIntf,
  XMLDoc, XMLDom;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Xml: TXmlDocument;

    Atributo: IXMLNode;
  NodePrincipal: IXMLNode;
  oi: string;
begin
  Xml := TXMLDocument.Create(Application);
  Xml.DOMVendor := GetDOMVendor('MSXML');
  Xml.Options := [doNodeAutoCreate, doAttrNull, doAutoPrefix, doNamespaceDecl];
  Xml.XML.Clear;
  Xml.Active := True;
  Xml.Version := '1.0';
  Xml.Encoding := 'UTF-8';

  xml.DocumentElement := xml.CreateElement('aaaa', 'http://www.virtoo.com');

  Atributo := Xml.CreateNode('versao', ntAttribute, '');
  Atributo.Text := '123';
  Xml.DocumentElement.AttributeNodes.Add(Atributo);

  oi :=  ' ';
  Xml.DocumentElement.AddChild('idLote').NodeValue := '456';
  Xml.DocumentElement.AddChild('indSinc').NodeValue := oi;

  Xml.SaveToFile('hummm.xml');

end;

end.
