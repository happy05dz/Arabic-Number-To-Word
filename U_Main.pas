unit U_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    memo1: TMemo;
    edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Form1: TForm1;

const
  Separator = (' و ');

  arabic0_19: array[0..19] of string = (
    'صفر','واحد','إثنان','ثلاثة', 'أربعة', 'خمسة', 'ستة', 'سبعة', 'ثمنية', 'تسعة', 'عشرة',
    'أحد عشر','اثنا عشر','ثلاثة عشر','أربعة عشر','خمسة عشر','ستة عشر','سبعة عشر',
    'ثمانية عشر','تسعة عشر');

  arabicFeminine0_19: array[1..19] of string = (
    'إحدى','اثنتان','ثلاث', 'أربع', 'خمس', 'ست', 'سبع', 'ثمان', 'تسع', 'عشر',
    'إحدى عشرة','اثنتا عشرة','ثلاث عشرة','أربع عشرة','خمس عشرة','ست عشرة','سبع عشرة',
    'ثماني عشرة','تسع عشرة');

  arabic10_90: array[2..9] of string = (
    'عشرون','ثلاثون','أربعون', 'خمسون', 'ستون', 'سبعون', 'ثمانون', 'تسعون');

  arabic100_900: array[1..9] of string = (
    'مائة','مئتان','ثلاثمائة', 'أربعمائة', 'خمسمائة', 'ستمائة', 'سبعمائة',
    'ثمانمائة','تسعمائة');

  arabicTwos: array[2..9] of string = (
    'مئتان','ألفان','مليونان', 'ملياران', 'تريليونان', 'كوادريليونان',
    'كوينتليونان', 'سكستيليونان');

  arabicAppendedTwos: array[2..9] of string = (
    'مئتا','ألفا','مليونا', 'مليارا', 'تريليونا', 'كوادريليونا', 'كوينتليونا',
    'سكستيليونا');

  arabicGroup: array[2..9] of string = (
    'مائة','ألف','مليون', 'مليار', 'تريليون', 'كوادريليون','كوينتليون', 'سكستيليون');

  arabicAppendedGroup: array[1..7] of string = (
    'ألفاً','مليوناً','ملياراً', 'تريليوناً', 'كوادريليوناً', 'كوينتليوناً','سكستيليوناً');

  arabicPluralGroups: array[1..7] of string = (
    'آلاف','ملايين','مليارات', 'تريليونات', 'كوادريليونات', 'كوينتليونات','سكستيليونات');


implementation

{$R *.dfm}

function Arabic_Number_To_Word(Number: integer) : string;
var
 NDizaines : integer;
begin
  result := '';

  Case Number of
    0..19 : Result := arabic0_19[Number];
    20..99 :
    begin
     NDizaines := Number div 10;
      if (Number mod 10 = 0) then
        Result := arabic10_90[NDizaines] // Manages cases of 20, 30, 40, 50 ... 90
      else
        Result := arabic0_19[Number - NDizaines * 10] +
                  Separator +
                  arabic10_90[NDizaines];
    end;
    end;
  End;



procedure TForm1.Button1Click(Sender: TObject);
begin
memo1.text := Arabic_Number_To_Word(strtoint(edit1.text));
end;

end.
