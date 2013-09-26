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
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\Folder1\file_folder1_1.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\Folder1\file_folder1_2.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\Folder1\Folder2\file_folder2_1.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\Folder1\Folder2\file_folder2_2.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\test1.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\test2.pas');
  UnusedUnits.Add('D:\Dev\DelphiLab\UnusedUnits\Bin\Temp\test3.pas');


  CheckEqualsString(FListUnusedUnits.UnusedUnits.Text, UnusedUnits.Text);
end;

initialization
  // Register any test cases with the test runner
  RegisterTest(TestTListUnusedUnits.Suite);
end.

