unit IntegerList;

interface

uses
  SysUtils;

type
  EListError = class(Exception);

  TIntegerList = class
  private
    FList: array of Integer;
    FCount: Integer;
    function Get(Index: Integer): Integer;
    procedure Put(Index: Integer; const Value: Integer);
    procedure SetCount(const NewCount: Integer);
  public
    constructor Create();
    destructor Destroy; override;

    function Add(const I: Integer): Integer;
    procedure Clear;
    procedure Delete(Index: Integer);
    class procedure Error(const Msg: string; Data: Integer); virtual;
    function IndexOf(Value: Integer): Integer;
    property Count: Integer read FCount;// write SetCount;
    property Items[Index: Integer]: Integer read Get write Put; default;
  end;

implementation

const
  MAX_LIST_SIZE = Maxint div 16;

  LIST_COUNT_ERROR = 'List count out of bounds (%d)';
  LIST_INDEX_ERROR = 'List index out of bounds (%d)';

{ TIntegerList }

function TIntegerList.Add(const I: Integer): Integer;
var
  ListLength: Integer;
begin
  Result := FCount;
  ListLength := Length(FList);
  SetLength(FList, ListLength + 1);
  FList[ListLength] := I;
  SetCount(Result + 1);
end;

procedure TIntegerList.Clear;
begin
  FillChar(FList, SizeOf(FList), 0);
  SetCount(0);
end;

constructor TIntegerList.Create;
begin
  Self.Clear();
end;

procedure TIntegerList.Delete(Index: Integer);
begin
  if Index > High(FList) then Exit;
  if Index < Low(FList) then Exit;
  if Index = High(FList) then
  begin
    SetLength(FList, Length(FList) - 1);
    SetCount(Length(FList));
    Exit;
  end;
  //Finalize(FList[Index]);
  System.Move(FList[Index +1], FList[Index], (Length(FList) - Index -1) * SizeOf(string) + 1);
  SetLength(FList, Length(FList) - 1);
  SetCount(Length(FList));
end;

destructor TIntegerList.Destroy;
begin
  Self.Clear();
  inherited;
end;

class procedure TIntegerList.Error(const Msg: string; Data: Integer);

  function ReturnAddr: Pointer;
  asm
          MOV     EAX,[EBP+4]
  end;

begin
  raise EListError.CreateFmt(Msg, [Data]) at ReturnAddr;
end;


function TIntegerList.Get(Index: Integer): Integer;
begin
  if (Index < 0) or (Index >= FCount) then
    Error(LIST_INDEX_ERROR, Index);

  Result := FList[Index];
end;

function TIntegerList.IndexOf(Value: Integer): Integer;
begin
  Result := 0;
  while (Result < FCount) and (FList[Result] <> Value) do
    Inc(Result);

  if Result = FCount then
    Result := -1;
end;

procedure TIntegerList.Put(Index: Integer; const Value: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    Error(LIST_INDEX_ERROR, Index);

  FList[Index] := Value;
end;

procedure TIntegerList.SetCount(const NewCount: Integer);
begin
  if (NewCount < 0) or (NewCount > MAX_LIST_SIZE) then
    Error(LIST_COUNT_ERROR, NewCount);

  FCount := NewCount;
end;

end.
