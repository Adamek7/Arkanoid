unit paletka;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils, allegro, poczatek;

type
paletka_obj = record
	paletka_x:integer;     // pozycja x
	paletka_y:integer;     // pozycja y
        paletka_w:integer;     // szerokosc
        paletka_h:integer;      // wysokosc
	paletka_bm:^AL_BITMAP; // bitmapa
end;

var
   paletka1 : paletka_obj;
   Vp:integer;


procedure init_paletke();
procedure po_porazce_paletka();

implementation

procedure po_porazce_paletka();
begin
  paletka1.paletka_w:=(paletka1.paletka_bm^.w div 4)*3;
  paletka1.paletka_h:=paletka1.paletka_bm^.h;
  paletka1.paletka_x := (800-paletka1.paletka_w) div 2;
  paletka1.paletka_y := wysokosc-paletka1.paletka_h;
  Vp:=6;
end;

procedure init_paletke();
begin
  paletka1.paletka_bm := NIL;
  paletka1.paletka_bm := al_load_bmp( 'paletka.bmp', @al_default_palette);
  if( paletka1.paletka_bm = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  paletka1.paletka_w:=(paletka1.paletka_bm^.w div 4)*3;
  paletka1.paletka_h:=paletka1.paletka_bm^.h;
  paletka1.paletka_x := (800-paletka1.paletka_w) div 2;
  paletka1.paletka_y := wysokosc-paletka1.paletka_h;
  Vp:=6;
end;





end.

