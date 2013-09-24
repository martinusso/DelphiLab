unit TestAreaCalculator;

interface

uses
  TestFramework, AreaCalculator, Shapes;
type
  TestTAreaCalculator = class(TTestCase)
  strict private
    FAreaCalculator: TAreaCalculator;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestNoShapes;
    procedure TestOneRectangle;
    procedure TestTwoRectangles;
    procedure TestOneCircle;
    procedure TestTwoCircles;
    procedure TestMixedShapes;
  end;

implementation

procedure TestTAreaCalculator.SetUp;
begin
  FAreaCalculator := TAreaCalculator.Create;
end;

procedure TestTAreaCalculator.TearDown;
begin
  FAreaCalculator.Free;
  FAreaCalculator := nil;
end;

procedure TestTAreaCalculator.TestMixedShapes;
var
  ReturnValue: Extended;
  R: TRectangle;
  C: TCircle;
begin
  R := TRectangle.Create;
  R.Width := 4;
  R.Height := 5;

  C := TCircle.Create;
  C.Radius := 7;

  ReturnValue := FAreaCalculator.SumArea([R, C]);
  CheckEquals(20 + (49 * PI), ReturnValue);
end;

procedure TestTAreaCalculator.TestNoShapes;
var
  ReturnValue: Extended;
begin
  ReturnValue := FAreaCalculator.SumArea([]);
  CheckEquals(0, ReturnValue);
end;

procedure TestTAreaCalculator.TestOneCircle;
var
  ReturnValue: Extended;
  C: TCircle;
begin
  C := TCircle.Create;
  C.Radius := 7;

  ReturnValue := FAreaCalculator.SumArea([C]);
  CheckEquals(49 * PI, ReturnValue);
end;

procedure TestTAreaCalculator.TestOneRectangle;
var
  ReturnValue: Extended;
  R: TRectangle;
begin
  R := TRectangle.Create;
  R.Width := 4;
  R.Height := 5;

  ReturnValue := FAreaCalculator.SumArea([R]);
  CheckEquals(20, ReturnValue);
end;

procedure TestTAreaCalculator.TestTwoCircles;
var
  ReturnValue: Extended;
  C1, C2: TCircle;
begin
  C1 := TCircle.Create;
  C1.Radius := 7;

  C2 := TCircle.Create;
  C2.Radius := 8;

  ReturnValue := FAreaCalculator.SumArea([C1, C2]);
  CheckEquals((49 * PI) + (64 * PI), ReturnValue);
end;

procedure TestTAreaCalculator.TestTwoRectangles;
var
  ReturnValue: Extended;
  R1, R2: TRectangle;
begin
  R1 := TRectangle.Create;
  R1.Width := 4;
  R1.Height := 5;

  R2 := TRectangle.Create;
  R2.Width := 2;
  R2.Height := 3;

  ReturnValue := FAreaCalculator.SumArea([R1, R2]);
  CheckEquals(26, ReturnValue);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTAreaCalculator.Suite);
end.
