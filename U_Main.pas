unit U_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TMain_Form = class(TForm)
    Converters_Button: TButton;
    Words_memo: TMemo;
    Numbers_edit: TEdit;
    Copy_Button: TButton;
    procedure Converters_ButtonClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Main_Form: TMain_Form;

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
 NDizaines,NCentaines,NMille : integer;
begin
  result := '';

  Case Number of
    0..19 : Result := arabic0_19[Number];
    20..99 :
    begin
     NDizaines := Number div 10;
      if (Number mod 10 = 0) then
        Result := arabic10_90[NDizaines] // Manages cases of 10, 20, 30, ... 90
      else
        Result := arabic0_19[Number - NDizaines * 10] +
                  Separator +
                  arabic10_90[NDizaines];
    end;
    100..999 :
    begin
      NCentaines := Number div 100;
      if (Number mod 100 = 0) then
        Result := arabic100_900[NCentaines] // Manages cases of 100, 200, 300, ... 900
      else
        Result := arabic100_900[NCentaines] + Separator
          + Arabic_Number_To_Word(Number - NCentaines * 100);
    end;
    1000..999999 :
    begin
      NMille := Number div 1000;
        case NMille of
        1 :
        begin
        if (Number mod 1000 = 0) then
         Result := arabicGroup[3] // Manages cases of 1000
        else
         Result := arabicGroup[3]+ Separator +
         Arabic_Number_To_Word(Number - NMille * 1000);
        end;

        2 :
        begin
        if (Number mod 1000 = 0) then
         Result := arabicTwos[3] // Manages cases of 2000
        else
         Result := arabicTwos[3]+ Separator +
         Arabic_Number_To_Word(Number - NMille * 1000);
        end;

        3..10 :
        begin
        if (Number mod 1000 = 0) then
         Result := Arabic_Number_To_Word(NMille) + ' ' + arabicPluralGroups[1] // Manages cases of 3000 ... 10000
        else
         Result := Arabic_Number_To_Word(NMille) + ' ' + arabicPluralGroups[1] + Separator +
         Arabic_Number_To_Word(Number - NMille * 1000);
        end;

        11..999 :
        begin
        if (Number mod 1000 = 0) then
         Result := Arabic_Number_To_Word(NMille) + ' ' + arabicGroup[3] // Manages cases of 11000 ... 999000
        else
         Result := Arabic_Number_To_Word(NMille) + ' ' + arabicGroup[3] + Separator +
         Arabic_Number_To_Word(Number - NMille * 1000);
        end;

      end;

    end;
  end;
End;

procedure TMain_Form.Converters_ButtonClick(Sender: TObject);
begin
Words_memo.text := Arabic_Number_To_Word(strtoint(Numbers_edit.text));
end;

end.
