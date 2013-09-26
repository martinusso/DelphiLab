unit ListUnusedUnits;

interface

uses
  Classes;

type
  TListUnusedUnits = class
  private
    FProjectDirectory: string;
    FProjectFile: string;
    function GetAllPas: TStrings;
    function GetAllUses: TStrings;
    function GetUnusedUnits: TStrings;
  public
    constructor Create(const ProjectDirectory, ProjectFile: string);
    property UnusedUnits: TStrings read GetUnusedUnits;
  end;

implementation

uses
  SysUtils,
  ListUnits, ListUses;

{ TListUnusedUnits }

constructor TListUnusedUnits.Create(const ProjectDirectory, ProjectFile: string);
begin
  FProjectDirectory := ProjectDirectory;
  FProjectFile := ProjectFile;
end;

function TListUnusedUnits.GetAllPas: TStrings;
var
  List: TListUnits;
begin
  List := TListUnits.Create();
  try
    Result := List.GetAllUnits(FProjectDirectory);
  finally
    List.Free();
  end;
end;

function TListUnusedUnits.GetAllUses: TStrings;
var
  List: TListUses;
begin
  List := TListUses.Create();
  try
    Result := List.GetAllUses(FProjectFile);
  finally
    List.Free();
  end;
end;

function TListUnusedUnits.GetUnusedUnits: TStrings;
var
  AllUses: TStrings;
  AllPas: TStrings;
  PasPath: string;
  Pas: string;
  PasWasDeclared: Boolean;
begin
  Result := TStringList.Create();

  AllUses := Self.GetAllUses;
  AllPas := Self.GetAllPas;
  for PasPath in AllPas do
  begin
    Pas := ExtractFileName(PasPath);
    PasWasDeclared := Pos(Pas, AllUses.Text) = 0;
    if PasWasDeclared then
      Result.Add(PasPath);
  end;
end;

end.
