unit RLFindDialog;

interface

uses
  SysUtils, Contnrs, Classes, 
{$ifdef VCL}
  Windows, Messages, Graphics, Controls, Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, 
{$else}
  Types, QControls, Qt, QButtons, QExtCtrls, QForms, QDialogs, QStdCtrls, QTypes, QGraphics, 
{$endif}
  RLConsts, RLUtils;

type
  TRLFindOption = (foWholeWords, foMatchCase, foFindBackward);
  TRLFindOptions = set of TRLFindOption;

  TRLOnFindEvent = procedure(Sender: TObject; const Text: String; Options: TRLFindOptions; var Found: Boolean) of object; 

  TfrmRLFindDialog = class(TForm)
    LabelTextToFind: TLabel;
    EditTextToFind: TEdit;
    BitBtnFindNext: TBitBtn;
    BitBtnCancel: TBitBtn;
    CheckBoxWholeWords: TCheckBox;
    CheckBoxMatchCase: TCheckBox;
    RadioGroupDirection: TRadioGroup;
    procedure BitBtnCancelClick(Sender: TObject);
    procedure BitBtnFindNextClick(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
  private
    { Private declarations }
    FOnFind: TRLOnFindEvent;
    //
    function GetTextValue: String;
    procedure SetTextValue(const Value: String);
    function GetOptions: TRLFindOptions;
    procedure SetOptions(const Value: TRLFindOptions);
    //
    procedure Init;
  public
    { Public declarations }
    constructor CreateNew(AOwner: TComponent; Dummy: Integer = 0); override;
    destructor Destroy; override;
    //
    property Text: String read GetTextValue write SetTextValue;
    property Options: TRLFindOptions read GetOptions write SetOptions;
    //
    property OnFind: TRLOnFindEvent read FOnFind write FOnFind;
  end;

var
  frmRLFindDialog: TfrmRLFindDialog;

implementation

///{$R *.DFM}

{ TfrmRLFindDialog }

constructor TfrmRLFindDialog.CreateNew(AOwner: TComponent; Dummy: Integer);
begin
  FOnFind := nil;
  //
  inherited;
  //
  Init;
end;

procedure TfrmRLFindDialog.Init;
begin
  BorderIcons := [biSystemMenu];
{$ifdef VCL}
  BorderStyle := bsDialog;
{$else}
  BorderStyle := fbsDialog;
{$endif}
  Caption := 'Procurar';
  ClientHeight := 94;
  ClientWidth := 367;
  Color := clBtnFace;
  Position := poScreenCenter;
  OnDeactivate := FormDeactivate;
  LabelTextToFind := TLabel.Create(Self);
  with LabelTextToFind do
  begin
    Name := 'LabelTextToFind';
    Parent := Self;
    Left := 8;
    Top := 16;
    Width := 30;
    Height := 13;
    Caption := 'Te&xto:';
  end;
  EditTextToFind := TEdit.Create(Self);
  with EditTextToFind do
  begin
    Name := 'EditTextToFind';
    Parent := Self;
    Left := 48;
    Top := 12;
    Width := 229;
    Height := 21;
    TabOrder := 0;
  end;
  BitBtnFindNext := TBitBtn.Create(Self);
  with BitBtnFindNext do
  begin
    Name := 'BitBtnFindNext';
    Parent := Self;
    Left := 284;
    Top := 12;
    Width := 75;
    Height := 21;
    Caption := '&Pr�xima';
    Default := True;
    TabOrder := 1;
    OnClick := BitBtnFindNextClick;
  end;
  BitBtnCancel := TBitBtn.Create(Self);
  with BitBtnCancel do
  begin
    Name := 'BitBtnCancel';
    Parent := Self;
    Left := 284;
    Top := 36;
    Width := 75;
    Height := 21;
    Cancel := True;
    Caption := '&Cancelar';
    TabOrder := 2;
    OnClick := BitBtnCancelClick;
  end;
  CheckBoxWholeWords := TCheckBox.Create(Self);
  with CheckBoxWholeWords do
  begin
    Name := 'CheckBoxWholeWords';
    Parent := Self;
    Left := 8;
    Top := 44;
    Width := 133;
    Height := 17;
    Caption := 'Palavras &inteiras';
    TabOrder := 3;
  end;
  CheckBoxMatchCase := TCheckBox.Create(Self);
  with CheckBoxMatchCase do
  begin
    Name := 'CheckBoxMatchCase';
    Parent := Self;
    Left := 8;
    Top := 64;
    Width := 193;
    Height := 17;
    Caption := 'Diferenciar &mai�sculas e min�sculas';
    TabOrder := 4;
  end;
  RadioGroupDirection := TRadioGroup.Create(Self);
  with RadioGroupDirection do
  begin
    Name := 'RadioGroupDirection';
    Parent := Self;
    Left := 204;
    Top := 36;
    Width := 73;
    Height := 49;
    Caption := ' Dire��o ';
    Items.Text := 'A&cima'#13'A&baixo';
    ItemIndex := 1;
    TabOrder := 5;
  end;
  //
  Caption := LocaleStrings.LS_FindCaptionStr;
  LabelTextToFind.Caption := LocaleStrings.LS_TextToFindStr + ':';
  EditTextToFind.Text := '';
  BitBtnFindNext.Caption := LocaleStrings.LS_FindNextStr;
  BitBtnCancel.Caption := LocaleStrings.LS_CancelStr;
  CheckBoxWholeWords.Caption := LocaleStrings.LS_WholeWordsStr;
  CheckBoxMatchCase.Caption := LocaleStrings.LS_MatchCaseStr;
  RadioGroupDirection.Caption := ' ' + LocaleStrings.LS_DirectionCaptionStr + ' ';
  RadioGroupDirection.Items[0] := LocaleStrings.LS_DirectionUpStr;
  RadioGroupDirection.Items[1] := LocaleStrings.LS_DirectionDownStr;
end;

function TfrmRLFindDialog.GetTextValue: String;
begin
  Result := EditTextToFind.Text;
end;

procedure TfrmRLFindDialog.SetTextValue(const Value: String);
begin
  EditTextToFind.Text := Value;
end;

function TfrmRLFindDialog.GetOptions: TRLFindOptions;
begin
  Result := [];
  if CheckBoxWholeWords.Checked then
    Include(Result, foWholeWords);
  if CheckBoxMatchCase.Checked then
    Include(Result, foMatchCase);
  if RadioGroupDirection.ItemIndex = 0 then
    Include(Result, foFindBackward);
end;

procedure TfrmRLFindDialog.SetOptions(const Value: TRLFindOptions);
begin
  CheckBoxWholeWords.Checked := foWholeWords in Value;
  CheckBoxMatchCase.Checked := foMatchCase in Value;
  RadioGroupDirection.ItemIndex := 1 - Byte(foFindBackward in Value);
end;

procedure TfrmRLFindDialog.BitBtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmRLFindDialog.FormDeactivate(Sender: TObject);
begin
  Close;
end;

procedure TfrmRLFindDialog.BitBtnFindNextClick(Sender: TObject);
var
  found: Boolean;
begin
  found := False;
  if Assigned(FOnFind) then
  begin
    Screen.Cursor := crHourGlass;
    try
      FOnFind(Self, Text, Options, found);
    finally
      Screen.Cursor := crDefault;
    end;
  end; 
  if not found then
    ShowMessage(LocaleStrings.LS_NotFoundStr); 
end;

destructor TfrmRLFindDialog.Destroy;
begin
  inherited;
end;

end.

