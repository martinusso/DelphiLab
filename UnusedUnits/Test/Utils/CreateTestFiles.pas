unit CreateTestFiles;

interface

uses
  Classes;

type
  TCreateTestFiles = class
  private
    FTempDir: string;
    FFolder1Dir: string;
    FFolder2Dir: string;
    FFileFolder2_2: string;
    FFileFolder2_1: string;
    FFileFolder1_2: string;
    FFileFolder1_1: string;
    FTest2: string;
    FTest3: string;
    FTest1: string;
    FProjectFile: string;
    procedure CreateFile(const Filename: string; const Content: TStrings = nil);
  public
    constructor Create();
    procedure CreateTestFiles();
    procedure DeleteTestFiles();

    property TempDir: string read FTempDir;
    property Folder1Dir: string read FFolder1Dir;
    property Folder2Dir: string read FFolder2Dir;
    property ProjectFile: string read FProjectFile;
    property Test1: string read FTest1;
    property Test2: string read FTest2;
    property Test3: string read FTest3;
    property FileFolder1_1: string read FFileFolder1_1;
    property FileFolder1_2: string read FFileFolder1_2;
    property FileFolder2_1: string read FFileFolder2_1;
    property FileFolder2_2: string read FFileFolder2_2;

  end;

implementation

uses
  SysUtils, ShellAPI, Forms;

{ TCreateTestFiles }

constructor TCreateTestFiles.Create;
begin
  FTempDir := IncludeTrailingPathDelimiter(GetCurrentDir) + 'Temp';
  FFolder1Dir := IncludeTrailingPathDelimiter(FTempDir) + 'Folder1';
  FFolder2Dir := IncludeTrailingPathDelimiter(FFolder1Dir) + 'Folder2';

  FProjectFile := IncludeTrailingPathDelimiter(FTempDir) +  'projectfile.dpr';
  FTest1 := IncludeTrailingPathDelimiter(FTempDir) + 'test1.pas';
  FTest2 := IncludeTrailingPathDelimiter(FTempDir) + 'test2.pas';
  FTest3 := IncludeTrailingPathDelimiter(FTempDir) + 'test3.pas';
  FFileFolder1_1 := IncludeTrailingPathDelimiter(FFolder1Dir) + 'file_folder1_1.pas';
  FFileFolder1_2 := IncludeTrailingPathDelimiter(FFolder1Dir) + 'file_folder1_2.pas';
  FFileFolder2_1 := IncludeTrailingPathDelimiter(FFolder2Dir) + 'file_folder2_1.pas';
  FFileFolder2_2 := IncludeTrailingPathDelimiter(FFolder2Dir) + 'file_folder2_2.pas';
end;

procedure TCreateTestFiles.CreateFile(const Filename: string; const Content: TStrings);
var
  F: TextFile;
begin
  AssignFile(F, Filename);
  try
    Rewrite(F);
    if Assigned(Content) then
      Writeln(F, Content.Text);
  finally
    Closefile(F);
  end;
end;

procedure TCreateTestFiles.CreateTestFiles;
var
  FTempDir, FFolder1Dir, FFolder2Dir: string;
  ProjectFileContent: TStrings;
begin
  // Create folders
  FTempDir := IncludeTrailingPathDelimiter(GetCurrentDir) + 'Temp';
  FFolder1Dir := IncludeTrailingPathDelimiter(FTempDir) + 'Folder1';
  FFolder2Dir := IncludeTrailingPathDelimiter(FFolder1Dir) + 'Folder2';

  ForceDirectories(FTempDir);
  ForceDirectories(FFolder1Dir);
  ForceDirectories(FFolder2Dir);

  // Create project file
  ProjectFileContent := TStringList.Create();
  try
    ProjectFileContent.Add('    > Temp');
    ProjectFileContent.Add('      - projectfile.dpr');
    ProjectFileContent.Add('      - test1.pas');
    ProjectFileContent.Add('      - test2.pas');
    { ProjectFileContent.Add('      - test3.pas // unused'); }
    ProjectFileContent.Add('      > folder1');
    ProjectFileContent.Add('        - file_folder1_1.pas');
    { ProjectFileContent.Add('        - file_folder1_2.pas // unused'); }
    ProjectFileContent.Add('        > folder2');
    { ProjectFileContent.Add('        - file_folder2_1.pas // unused'); }
    ProjectFileContent.Add('        - file_folder2_2.pas');
    ProjectFileContent.SaveToFile(IncludeTrailingPathDelimiter(FTempDir) +  'projectfile.dpr');
  finally
    ProjectFileContent.Free();
  end;

  CreateFile(FProjectFile);
  CreateFile(FTest1);
  CreateFile(FTest2);
  CreateFile(FTest3);

  CreateFile(FFileFolder1_1);
  CreateFile(FFileFolder1_2);

  CreateFile(FFileFolder2_1);
  CreateFile(FFileFolder2_2);
end;

procedure TCreateTestFiles.DeleteTestFiles;
var
  OpStruc: TSHFileOpStruct;
  FromBuffer, ToBuffer: array[0..128] of Char;
begin
  fillChar(OpStruc, Sizeof(OpStruc), 0);
  FillChar(FromBuffer, Sizeof(FromBuffer), 0);
  FillChar(ToBuffer, Sizeof(ToBuffer), 0);
  StrPCopy(FromBuffer, FTempDir);

  with OpStruc do
  begin
    Wnd:= Application.Handle;
    wFunc:=FO_DELETE;
    pFrom:= @FromBuffer;
    pTo:= @ToBuffer;
    fFlags := FOF_NOCONFIRMATION;
    fAnyOperationsAborted := False;
    hNameMappings := nil;
  End;
  ShFileOperation(OpStruc);
end;

end.
