unit ListUses;

interface

uses
  Classes;

type
  TListUses = class
  public
    function GetAllUses(const DprFilename: string): TStrings;
  end;

implementation

{ TListUses }

function TListUses.GetAllUses(const DprFilename: string): TStrings;
begin
  Result := TStringList.Create();
  Result.LoadFromFile(DprFilename);
end;

end.
