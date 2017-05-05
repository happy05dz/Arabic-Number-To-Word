unit U_ArabicNTW;
{
Unit: U_ArabicNTW.pas
By: H@PPyZERØ5
E-mail: happy05@programmer.net
}
interface
uses
   System.SysUtils;

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

function Arabic_Number_To_Word(Number: integer) : string;

implementation

function Arabic_Number_To_Word(Number: integer) : string;
var
 NDozens, NHundreds, NThousands, NMillions, NMilliers : integer;
begin
  result := '';

  Case Number of
    {Manages cases of 0, 1, ... 19}
    0..19 : Result := arabic0_19[Number];
    {Manages cases of 20, 21, ... 99}
    20..99 :
    begin
     NDozens := Number div 10;
      if (Number mod 10 = 0) then
        Result := arabic10_90[NDozens] // Manages cases of 10, 20, 30, ... 90
      else
        Result := arabic0_19[Number - NDozens * 10] +
                  Separator +
                  arabic10_90[NDozens];
    end;
    {Manages cases of 100, 101, ... 999}
    100..999 :
    begin
      NHundreds := Number div 100;
      if (Number mod 100 = 0) then
        Result := arabic100_900[NHundreds] // Manages cases of 100, 200, 300, ... 900
      else
        Result := arabic100_900[NHundreds] + Separator
          + Arabic_Number_To_Word(Number - NHundreds * 100);
    end;
    {Manages cases of 1000, 1001, ... 999999}
    1000..999999 :
    begin
      NThousands := Number div 1000;
        case NThousands of
        1 :
        begin
        if (Number mod 1000 = 0) then
         Result := arabicGroup[3] // Manages cases of 1000
        else
         Result := arabicGroup[3]+ Separator +
         Arabic_Number_To_Word(Number - NThousands * 1000);
        end;

        2 :
        begin
        if (Number mod 1000 = 0) then
         Result := arabicTwos[3] // Manages cases of 2000
        else
         Result := arabicTwos[3]+ Separator +
         Arabic_Number_To_Word(Number - NThousands * 1000);
        end;

        3..10 :
        begin
        if (Number mod 1000 = 0) then
         Result := Arabic_Number_To_Word(NThousands) + ' ' + arabicPluralGroups[1] // Manages cases of 3000 ... 10000
        else
         Result := Arabic_Number_To_Word(NThousands) + ' ' + arabicPluralGroups[1] + Separator +
         Arabic_Number_To_Word(Number - NThousands * 1000);
        end;

        11..999 :
        begin
        if (Number mod 1000 = 0) then
         Result := Arabic_Number_To_Word(NThousands) + ' ' + arabicGroup[3] // Manages cases of 11000 ... 999000
        else
         Result := Arabic_Number_To_Word(NThousands) + ' ' + arabicGroup[3] + Separator +
         Arabic_Number_To_Word(Number - NThousands * 1000);
        end;
      end;
    end;
    {Manages cases of 1000000, 1000001, ... 999999999}
    1000000..999999999 :
    begin
      NMillions := Number div 1000000;
        case NMillions of
        1 :
        begin
        if (Number mod 1000000 = 0) then
         Result := arabicGroup[4] // Manages cases of 1000000
        else
         Result := arabicGroup[4]+ Separator +
         Arabic_Number_To_Word(Number - NMillions * 1000000);
        end;

        2 :
        begin
        if (Number mod 1000000 = 0) then
         Result := arabicTwos[4] // Manages cases of 2000000
        else
         Result := arabicTwos[4]+ Separator +
         Arabic_Number_To_Word(Number - NMillions * 1000000);
        end;

        3..10 :
        begin
        if (Number mod 1000000 = 0) then
         Result := Arabic_Number_To_Word(NMillions) + ' ' + arabicPluralGroups[2] // Manages cases of 3000000 ... 10000000
        else
         Result := Arabic_Number_To_Word(NMillions) + ' ' + arabicPluralGroups[2] + Separator +
         Arabic_Number_To_Word(Number - NMillions * 1000000);
        end;

        11..999 :
        begin
        if (Number mod 1000000 = 0) then
         Result := Arabic_Number_To_Word(NMillions) + ' ' + arabicGroup[4] // Manages cases of 11000 ... 999000
        else
         Result := Arabic_Number_To_Word(NMillions) + ' ' + arabicGroup[4] + Separator +
         Arabic_Number_To_Word(Number -NMillions * 1000000);
        end;
      end;
    end;
  end;
End;

end.
