program Sistem.fut;

uses
  Vcl.Forms,
  U_principal in 'fontes\U_principal.pas' {Form1},
  U_Cad_Jogar in 'fontes\U_Cad_Jogar.pas' {frm_jogador},
  U_Dm in 'fontes\U_Dm.pas' {dm: TDataModule},
  U_Cad_Treinar in 'fontes\U_Cad_Treinar.pas' {frm_treinador},
  U_Editar_Jogar in 'fontes\U_Editar_Jogar.pas' {frm_editarJogar},
  U_Editar_Treinar in 'fontes\U_Editar_Treinar.pas' {frm_editTreina},
  U_partida in 'fontes\U_partida.pas' {frm_partida},
  U_EditarPart in 'fontes\U_EditarPart.pas' {frm_editPartida};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(Tfrm_jogador, frm_jogador);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfrm_treinador, frm_treinador);
  Application.CreateForm(Tfrm_editarJogar, frm_editarJogar);
  Application.CreateForm(Tfrm_editTreina, frm_editTreina);
  Application.CreateForm(Tfrm_partida, frm_partida);
  Application.CreateForm(Tfrm_editPartida, frm_editPartida);
  Application.Run;
end.
