Basically it's a [Tiny Types](http://darrenhobbs.com/2007/04/11/tiny-types/).

# Usage

This way to use is the same for both CNPJ/CPF, so only CPF is documented below.

```delphi
var
  CPF: TCPF;
begin
  // Assignd CPF
  CPF := '999.999.001-00';
  
  // Return unformatted CPF 00000000000
  // implicit
  CPF            
  // or explicit
  CPF.unformatted
  
  
  // Return formatted CPF 000.000.000-00
  // only explicit
  CPF.formatted
  
  
  // Check if CPF is valid
  CPF.IsValid()
end;
```

# "Left Side Cannot Be Assigned To"

The usage of a Record Delphi type as a Property in a Class declaration will produce a compile time error while trying to assign a value to a record's field.

But with implict method in TCPF/TCNPJ class the code bellow works. :D

```delphi
type
  TLeftSide = class
  private
    FCPF: TCPF;
  public
    property CPF: TCPF read FCPF write FCPF;
  end;

procedure Test.TestLeftSideCannotAssignedTo;
var
  LeftSide: TLeftSide;
begin
  LeftSide := TLeftSide.Create();
  try
    LeftSide.CPF := '00000000000';
    CheckFalse(LeftSide.CPF.IsValid, 'Should reject invalid CPF "00000000000"');
  finally
    LeftSide.Free();
  end;
end;
```
