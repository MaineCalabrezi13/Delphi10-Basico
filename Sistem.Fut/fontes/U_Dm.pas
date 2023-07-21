unit U_Dm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, FireDAC.Comp.UI;

type
  Tdm = class(TDataModule)
    conexao: TFDConnection;
    drive: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    tb_jogador: TFDTable;
    tb_jogadorid_jogador: TFDAutoIncField;
    tb_jogadornome: TStringField;
    tb_jogadorapelido: TStringField;
    tb_jogadoridade: TIntegerField;
    tb_jogadordata_nasc: TDateField;
    tb_jogadornacionalidade: TStringField;
    tb_jogadornaturalidade: TStringField;
    tb_jogadorsexo: TStringField;
    tb_jogadorposição: TStringField;
    tb_jogadorcamiseta: TStringField;
    tb_jogadorimagem: TBlobField;
    tb_jogadorTimes: TStringField;
    ds_jogador: TDataSource;
    tb_jogadoraltura: TSingleField;
    tb_jogadorpeso: TSingleField;
    tb_jogadordata_cad: TDateField;
    tb_treinador: TFDTable;
    ds_treinador: TDataSource;
    tb_treinadorid_treinador: TFDAutoIncField;
    tb_treinadornome: TStringField;
    tb_treinadoridade: TIntegerField;
    tb_treinadordata_nasc: TDateField;
    tb_treinadordata_cad: TDateField;
    tb_treinadornacionalidade: TStringField;
    tb_treinadornaturalidade: TStringField;
    tb_treinadorsexo: TStringField;
    tb_treinadorimagem: TBlobField;
    tb_treinadortimes: TStringField;
    sql_con_jogador: TFDQuery;
    ds_con_jogador: TDataSource;
    sql_con_treinador: TFDQuery;
    ds_con_treinador: TDataSource;
    tb_partida: TFDTable;
    ds_partida: TDataSource;
    tb_partidaid_partida: TFDAutoIncField;
    tb_partidanome_camp: TStringField;
    tb_partidadata: TDateField;
    tb_partidatimecasa: TStringField;
    tb_partidatimefora: TStringField;
    sql_con_partida: TFDQuery;
    ds_con_partida: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dm: Tdm;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tdm.DataModuleCreate(Sender: TObject);
begin
conexao.Params.Database:='Futebol_brasileiro';
conexao.Params.UserName:='root';
conexao.Params.Password:='';
drive.VendorLib:=getcurrentdir+'\lib\limysql.dll';
tb_jogador.TableName:='jogadores';
tb_jogador.active:=true;
tb_treinador.TableName:='treinadores';
tb_treinador.active:=true;
tb_partida.TableName:='partida';
tb_treinador.active:=true;

end;

end.
