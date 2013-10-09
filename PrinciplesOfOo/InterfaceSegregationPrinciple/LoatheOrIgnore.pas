unit LoatheOrIgnore;

interface

type
  IShape = interface
  ['{F4638ABA-B237-4161-B80D-2B8258BC58FB}']
    function GetArea: Extended;
    property Area: Extended read GetArea;

    function GetDiameter: Extended;
    property Diameter: Extended read GetDiameter;
  end;

  TSquare = class(TInterfacedObject, IShape)
  private
    FSide: Extended;
    function GetArea: Extended;
    function GetDiameter: Extended;
  public
    property Side: Extended read FSide write FSide;
  end;

  TCircle = class(TInterfacedObject, IShape)
  private
    FRadius: Extended;
    function GetArea: Extended;
    function GetDiameter: Extended;
  public
    property Radius: Extended read FRadius write FRadius;
  end;

implementation

uses
  SysUtils;

{ TSquare }

function TSquare.GetArea: Extended;
begin
  Result := FSide * FSide;
end;

function TSquare.GetDiameter: Extended;
begin
  raise Exception.Create('Not implemented');
end;

{ TCircle }

function TCircle.GetArea: Extended;
begin
  Result := PI * (FRadius * FRadius);
end;

function TCircle.GetDiameter: Extended;
begin
  Result := 2 * FRadius;
end;

end.
