unit ListUnits;

interface

uses
  Classes, SysUtils;

type
  TListUnits = class
  private
    function IsNewDirectory(const SearchFile: TSearchRec): Boolean;
    function IsPas(const Filename: string): Boolean;
  public
    function GetAllUnits(const Directory: string): TStrings;
  end;

implementation

const
  EXT = '\*.*';
  EXT_PAS = '.PAS';

{ TListUnits }

function TListUnits.GetAllUnits(const Directory: string): TStrings;
var
  SearchFile: TSearchRec;
  FindResult: Integer;
  Filename: string;
  UnitsInNewDirectory: TStrings;
begin
  Result := TStringList.Create();

  FindResult := FindFirst(Directory + EXT, faAnyFile, SearchFile);
  try
    while FindResult = 0 do
    begin
      Filename := IncludeTrailingPathDelimiter(Directory) + SearchFile.Name;
      if IsNewDirectory(SearchFile) then
      begin
        UnitsInNewDirectory := Self.GetAllUnits(Filename);
        Result.AddStrings(UnitsInNewDirectory);
      end
      else begin
        if IsPas(Filename) then
          Result.Add(Filename);
      end;
      FindResult := FindNext(SearchFile);
    end;
  finally
    FindClose(SearchFile)
  end;
end;

function TListUnits.IsNewDirectory(const SearchFile: TSearchRec): Boolean;
var
  HasAttr: Boolean;
begin
  HasAttr := SearchFile.Attr and faDirectory = faDirectory;
  Result := HasAttr and (SearchFile.Name <> '.') and (SearchFile.Name <> '..')
end;

function TListUnits.IsPas(const Filename: string): Boolean;
var
  FileExt: string;
begin
  FileExt := ExtractFileExt(Filename);
  Result := UpperCase(FileExt) = EXT_PAS;
end;

end.


