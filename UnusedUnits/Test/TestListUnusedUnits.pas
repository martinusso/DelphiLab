unit TestListUnusedUnits;

interface

uses
  TestFramework, Classes, ListUnusedUnits, CreateTestFiles;

type
  // Test methods for class TListUnusedUnits

  TestTListUnusedUnits = class(TTestCase)
  strict private
    FListUnusedUnits: TListUnusedUnits;
    FCreateTestFiles: TCreateTestFiles;
  public
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestGetUnusedUnits;
  end;

implementation

procedure TestTListUnusedUnits.SetUp;
begin
  FCreateTestFiles := TCreateTestFiles.Create();
  FCreateTestFiles.CreateTestFiles();

  FListUnusedUnits := TListUnusedUnits.Create(FCreateTestFiles.TempDir, FCreateTestFiles.ProjectFile);
end;

procedure TestTListUnusedUnits.TearDown;
begin
  FCreateTestFiles.DeleteTestFiles();
  FCreateTestFiles.Free();

  FListUnusedUnits.Free;
  FListUnusedUnits := nil;
end;

procedure TestTListUnusedUnits.TestGetUnusedUnits;
var
  UnusedUnits: TStrings;
begin
  UnusedUnits := TStringList.Create();
  UnusedUnits.Add(FCreateTestFiles.FileFolder1_1);
  UnusedUnits.Add(FCreateTestFiles.FileFolder1_2);
  UnusedUnits.Add(FCreateTestFiles.FileFolder2_1);
  UnusedUnits.Add(FCreateTestFiles.FileFolder2_2);
  UnusedUnits.Add(FCreateTestFiles.Test1);
  UnusedUnits.Add(FCreateTestFiles.Test2);
  UnusedUnits.Add(FCreateTestFiles.Test3);

  CheckEqualsString(FListUnusedUnits.UnusedUnits.Text, UnusedUnits.Text);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTListUnusedUnits.Suite);
end.

