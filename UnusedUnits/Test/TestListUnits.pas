unit TestListUnits;

interface

uses
  TestFramework, ListUnits, Classes,
  CreateTestFiles;

type
  TestTListUnits = class(TTestCase)
  strict private
    FListUnits: TListUnits;
    FCreateTestFiles: TCreateTestFiles;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetAllUnits;
  end;

implementation

procedure TestTListUnits.SetUp;
begin
  FListUnits := TListUnits.Create;
  FCreateTestFiles := TCreateTestFiles.Create();
  FCreateTestFiles.CreateTestFiles();
end;

procedure TestTListUnits.TearDown;
begin
  FCreateTestFiles.DeleteTestFiles();
  FCreateTestFiles.Free();

  FListUnits.Free;
  FListUnits := nil;
end;

procedure TestTListUnits.TestGetAllUnits;
var
  Units: TStrings;
  ReturnValue: TStrings;
begin
  Units := TStringList.Create();
  Units.Add(FCreateTestFiles.FileFolder1_1);
  Units.Add(FCreateTestFiles.FileFolder1_2);
  Units.Add(FCreateTestFiles.FileFolder2_1);
  Units.Add(FCreateTestFiles.FileFolder2_2);
  Units.Add(FCreateTestFiles.Test1);
  Units.Add(FCreateTestFiles.Test2);
  Units.Add(FCreateTestFiles.Test3);

  ReturnValue := FListUnits.GetAllUnits(FCreateTestFiles.TempDir);
  CheckEqualsString(ReturnValue.Text, Units.Text);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTListUnits.Suite);
end.

