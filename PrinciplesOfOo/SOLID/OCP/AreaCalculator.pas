unit AreaCalculator;

interface

uses
  Shapes;

type
  TAreaCalculator = class
  public
    function SumArea(const Shapes: array of IHasArea): Extended;
  end;

implementation

{ TAreaCalculator }

function TAreaCalculator.SumArea(const Shapes: array of IHasArea): Extended;
var
  Shape: IHasArea;
begin
  Result := 0;

  for Shape in Shapes do
    Result := Result + Shape.Area;
end;

end.
