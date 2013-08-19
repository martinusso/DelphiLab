unit DocsBR;

interface

type
  TCNPJ = record
  private
    FUnformatted: string;
    FFormatted: string;
  public
    class operator Implicit(const CNPJ: string): TCNPJ;
    class operator Implicit(const CNPJ: TCNPJ): string;
    function IsValid(): Boolean;
    property Unformatted: string read FUnformatted;
    property Formatted: string read FFormatted;
  end;

  TCPF = record
  private
    FUnformatted: string;
    FFormatted: string;
  public
    class operator Implicit(const CPF: string): TCPF;
    class operator Implicit(const CPF: TCPF): string;
    function IsValid(): Boolean;
    property Unformatted: string read FUnformatted;
    property Formatted: string read FFormatted;
  end;

implementation

uses
  MaskUtils, StrUtils, SysUtils;

function Clear(const Doc: string): string;
var
  Letter: Char;
begin
  Result := '';
  for Letter in Doc do
  begin
    if Letter in ['0'..'9'] then
      Result := Result + Letter;
  end;
end;

function FormatCNPJ(const CNPF: string): string;
begin
  Result := MaskUtils.FormatMaskText('00.000.000/0000-00;0; ', CNPF);
end;

function FormatCPF(const CPF: string): string;
begin
  Result := MaskUtils.FormatMaskText('000.000.000-00;0; ', CPF);
end;

{ TCNPJ }

class operator TCNPJ.Implicit(const CNPJ: string): TCNPJ;
begin
  Result.FUnformatted := Clear(CNPJ);
  Result.FFormatted := FormatCNPJ(CNPJ);
end;

class operator TCNPJ.Implicit(const CNPJ: TCNPJ): string;
begin
  Result := CNPJ.FUnformatted;
end;

function TCNPJ.IsValid: Boolean;
const
  BLACKLIST: array[0..9] of string = ('00000000000000',
                                      '11111111111111',
                                      '22222222222222',
                                      '33333333333333',
                                      '44444444444444',
                                      '55555555555555',
                                      '66666666666666',
                                      '77777777777777',
                                      '88888888888888',
                                      '99999999999999');
var
  IsInvalidSize: Boolean;
  IsBlacklisted: Boolean;
  I: Integer;
  D1, D2: Integer;
begin
  IsInvalidSize := Length(FUnformatted) <> 14;
  IsBlacklisted := AnsiIndexStr(FUnformatted, BLACKLIST) >= 0;
  
  if IsInvalidSize or IsBlacklisted then
  begin
    Result := False;
  end
  else begin
    D1 := 0;
    for I := 1 to 12 do
    begin
      if I < 5 then
        D1 := D1 + (StrToInt(FUnformatted[I]) * (6 - I))
      else
        D1 := D1 + (StrToInt(FUnformatted[I]) * (14 - I));
    end;
    D1 := 11 - (D1 mod 11);
    if D1 >= 10 then
      D1 := 0;

    D2:= D1 * 2;
    for I := 1 to 12 do
    begin
      if I < 6 then
        D2 := D2 + (StrToInt(FUnformatted[I]) * (7 - I))
      else
        D2 := D2 + (StrToInt(FUnformatted[I]) * (15 - I));
    end;
    D2 := 11 - (D2 mod 11);
    if D2 >= 10 then D2 :=0;

    Result := (IntToStr(D1) + IntToStr(D2)) = Copy(FUnformatted, 13, 2);
  end;
end;

{ TCPF }

class operator TCPF.Implicit(const CPF: string): TCPF;
begin
  Result.FUnformatted := Clear(CPF);
  Result.FFormatted := FormatCPF(Result.FUnformatted);
end;

class operator TCPF.Implicit(const CPF: TCPF): string;
begin
  Result := CPF.FUnformatted;
end;

function TCPF.IsValid: Boolean;
const
  BLACKLIST: array[0..9] of string = ('00000000000',
                                      '11111111111',
                                      '22222222222',
                                      '33333333333',
                                      '44444444444',
                                      '55555555555',
                                      '66666666666',
                                      '77777777777',
                                      '88888888888',
                                      '99999999999');
var
  IsInvalidSize: Boolean;
  IsBlacklisted: Boolean;
  I: Integer;
  D1, D2: Integer;
begin
  IsInvalidSize := Length(FUnformatted) <> 11;
  IsBlacklisted := AnsiIndexStr(FUnformatted, BLACKLIST) >= 0;

  if IsInvalidSize or IsBlacklisted then
  begin
    Result := False;
  end
  else begin
    D1 := 0;
    for I := 1 to 9 do
      D1 := D1 + (StrToInt(FUnformatted[I]) * (11 - I));
    D1 := 11 - (D1 mod 11);
    if D1 >= 10 then
      D1 := 0;

    D2 := D1 * 2;
    for I := 1 to 9 do
      D2 := D2 + (StrToInt(FUnformatted[I]) * (12 - I));
    D2 := 11 - (D2 mod 11);
    if D2 >= 10 then
      D2 :=0;

    Result := (IntToStr(D1) + IntToStr(D2)) = Copy(FUnformatted, 10, 2);
  end;
end;

end.
