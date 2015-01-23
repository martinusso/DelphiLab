unit ListIntegerTest;

interface

uses
  TestFramework, IntegerList;
  
type
  TestTListInteger = class(TTestCase)
  strict private
    FListInteger: TIntegerList;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestAdd;
    procedure TestClear;
    procedure TestDelete;
    procedure TestIndexOf;
  end;

implementation

procedure TestTListInteger.SetUp;
begin
  FListInteger := TIntegerList.Create;
end;

procedure TestTListInteger.TearDown;
begin
  FListInteger.Free;
  FListInteger := nil;
end;

procedure TestTListInteger.TestAdd;
var
  ReturnValue: Integer;
begin
  ReturnValue := FListInteger.Add(10);
  CheckEquals(ReturnValue, 0, 'Incorrect index. Expected 0');

  ReturnValue := FListInteger.Add(11);
  CheckEquals(ReturnValue, 1, 'Incorrect index. Expected 1');
end;

procedure TestTListInteger.TestClear;
begin
  // Before add anything
  CheckEquals(FListInteger.Count, 0, 'Clear method incorrect');

  // After add integers
  FListInteger.Add(10);
  FListInteger.Add(11);
  FListInteger.Clear;
  CheckEquals(FListInteger.Count, 0, 'Clear method incorrect');
end;

procedure TestTListInteger.TestDelete;
begin
  FListInteger.Add(10);
  FListInteger.Add(11);
  FListInteger.Add(12);
  FListInteger.Add(13);

  FListInteger.Delete(1);
  CheckEquals(FListInteger.Count, 3, 'Delete method incorrect');
  CheckEquals(FListInteger[0], 10, 'item[0] incorrect');
  CheckEquals(FListInteger[1], 12, 'item[1] incorrect');
  CheckEquals(FListInteger[2], 13, 'item[2] incorrect');

  FListInteger.Delete(2);
  CheckEquals(FListInteger.Count, 2, 'Delete method incorrect');
  CheckEquals(FListInteger[0], 10, 'item[0] incorrect');
  CheckEquals(FListInteger[1], 12, 'item[1] incorrect');
end;

procedure TestTListInteger.TestIndexOf;
begin
  FListInteger.Add(10);
  FListInteger.Add(11);
  FListInteger.Add(12);
  FListInteger.Add(13);

  CheckEquals(FListInteger.IndexOf(10), 0, 'IndexOf(10) incorrect');
  CheckEquals(FListInteger.IndexOf(11), 1, 'IndexOf(11) incorrect');
  CheckEquals(FListInteger.IndexOf(12), 2, 'IndexOf(12) incorrect');
  CheckEquals(FListInteger.IndexOf(13), 3, 'IndexOf(13) incorrect');
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTListInteger.Suite);
end.

