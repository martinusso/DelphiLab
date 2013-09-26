unit Shapes;

interface

type
  IHasArea = interface
  ['{7CDC63F7-1903-4E02-B19A-50037EB1E0D3}']
    function GetArea: Extended;
    property Area: Extended read GetArea;
  end;

  TRectangle = class(TInterfacedObject, IHasArea)
  private
    FWidth: Extended;
    FHeight: Extended;
    function GetArea: Extended;
  public
    property Width: Extended read FWidth write FWidth;
    property Height: Extended read FHeight write FHeight;
  end;

  TCircle = class(TInterfacedObject, IHasArea)
  private
    FRadius: Extended;
    function GetArea: Extended;
  public
    property Radius: Extended read FRadius write FRadius;
  end;

implementation

{ TRectangle }

function TRectangle.GetArea: Extended;
begin
  Result := FWidth * FHeight;
end;

{ TCircle }

function TCircle.GetArea: Extended;
begin
  Result := FRadius * FRadius * PI;
end;

end.
