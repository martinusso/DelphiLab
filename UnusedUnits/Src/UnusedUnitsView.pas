unit UnusedUnitsView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TUnusedUnitsForm = class(TForm)
    Panel1: TPanel;
    ListView1: TListView;
    List: TButton;
    ProjectFile: TEdit;
    Label1: TLabel;
    ProjectDirectory: TEdit;
    Label2: TLabel;
    SearchProjectFile: TSpeedButton;
    SearchProjectDirectory: TSpeedButton;
    procedure ListClick(Sender: TObject);
    procedure SearchProjectDirectoryClick(Sender: TObject);
    procedure SearchProjectFileClick(Sender: TObject);
  private
    procedure ListUnusedFiles();
    procedure AddUnusedUnit(const UnusedUnit: string);
  public
  end;

implementation

uses
  ListUnusedUnits;

{$R *.dfm}

procedure TUnusedUnitsForm.AddUnusedUnit(const UnusedUnit: string);
begin
  ListView1.AddItem(UnusedUnit, nil);
end;

procedure TUnusedUnitsForm.ListClick(Sender: TObject);
begin
  try
    ListView1.Clear();
    Self.ListUnusedFiles();
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TUnusedUnitsForm.ListUnusedFiles;
var
  List: TListUnusedUnits;
  UnusedUnit: string;
begin
  List := TListUnusedUnits.Create(ProjectDirectory.Text, ProjectFile.Text);
  try
    for UnusedUnit in List.UnusedUnits do
      AddUnusedUnit(UnusedUnit);
  finally
    List.Free();
  end;
end;

procedure TUnusedUnitsForm.SearchProjectDirectoryClick(Sender: TObject);
var
  FolderDialog: TCustomFileDialog;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  FolderDialog := TFileOpenDialog.Create(Self);
  try
    FolderDialog.Options := FolderDialog.Options + [fdoPickFolders];
    if FolderDialog.Execute then
      ProjectDirectory.Text := FolderDialog.FileName;
  finally
    FolderDialog.Free;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;

procedure TUnusedUnitsForm.SearchProjectFileClick(Sender: TObject);
var
  FolderDialog: TCustomFileDialog;
begin
  {$WARN SYMBOL_PLATFORM OFF}
  FolderDialog := TFileOpenDialog.Create(Self);
  try
    FolderDialog.Options := FolderDialog.Options + [fdoFileMustExist];
    if FolderDialog.Execute then
    begin
      ProjectFile.Text := FolderDialog.FileName;
      ProjectDirectory.Text := ExtractFileDir(FolderDialog.FileName);
    end;
  finally
    FolderDialog.Free;
  end;
  {$WARN SYMBOL_PLATFORM ON}
end;

end.
