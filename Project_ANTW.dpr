program Project_ANTW;

uses
  Vcl.Forms,
  U_Main in 'U_Main.pas' {Main_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain_Form, Main_Form);
  Application.Run;
end.
