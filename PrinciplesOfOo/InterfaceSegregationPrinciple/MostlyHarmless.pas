unit MostlyHarmless;

interface

type
  IHasArea = interface
  ['{E7EBC53C-9294-4492-8A7E-9AFC79088C79}']
    function GetArea: Extended;
    property Area: Extended read GetArea;
  end;

  IHasDiameter = interface
  ['{844888CD-F247-4570-A82C-680FBB4B0629}']
    function GetDiameter: Extended;
    property Diameter: Extended read GetDiameter;
  end;

  TSquare = class(TInterfacedObject, IHasArea)
  private
    FSide: Extended;
    function GetArea: Extended;
  public
    property Side: Extended read FSide write FSide;
  end;

  TCircle = class(TInterfacedObject, IHasArea, IHasDiameter)
  private
    FRadius: Extended;
    function GetArea: Extended;
    function GetDiameter: Extended;
  public
    property Radius: Extended read FRadius write FRadius;
  end;

implementation

{ TSquare }

function TSquare.GetArea: Extended;
begin
  Result := FSide * FSide;
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
