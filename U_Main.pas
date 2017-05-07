unit U_Main;
{
 ----=[    Arabic Number To Word       ]=----
 ----=[      By: H@PPyZERØ5            ]=----
 ----=[ E-mail: happy05@programmer.net ]=----
}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, U_ArabicNTW,
  Vcl.Samples.Spin;

type
  TMain_Form = class(TForm)
    Converters_Button: TButton;
    Words_memo: TMemo;
    Numbers_edit: TEdit;
    Copy_Button: TButton;
    procedure Converters_ButtonClick(Sender: TObject);
    procedure Copy_ButtonClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Main_Form: TMain_Form;


implementation

{$R *.dfm}

procedure TMain_Form.Converters_ButtonClick(Sender: TObject);
begin
    if (Numbers_edit.text <> '') then begin
    Words_memo.text := Arabic_Number_To_Word(strtoint(Numbers_edit.text));
   end;
end;

procedure TMain_Form.Copy_ButtonClick(Sender: TObject);
begin
  Words_memo.SelectAll;
  Words_memo.CopyToClipboard;
end;

end.
