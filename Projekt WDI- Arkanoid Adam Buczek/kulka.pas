unit kulka;

{$mode objfpc}{$H+}

interface


uses
  Classes, SysUtils,allegro,poczatek,paletka,crt,panel;


type
kulka_obj = record
	kulka_x:integer;     // pozycja x
	kulka_y:integer;     // pozycja y
        kulka_w:integer;     // szerokosc
        kulka_h:integer;      // wysokosx
	kulka_bm:^AL_BITMAP; // bitmapa
end;


var
   kulka1 : kulka_obj;
   z_x,z_y: Integer; //  z_x - zmiana x, z_y - zmiana y
   Vk:integer;
   sterowanie:boolean;


procedure init_kulka();
procedure wys_kulka_start();
procedure wys_kulka_ruch();
function zderzenie_paletka():boolean;
function zderzenie_sciana():boolean;
procedure po_porazce_kulka();
procedure odbicie_sciana(var z_x:integer; var z_y:integer);
procedure odbicie_paletka(var z_x:integer; var z_y:integer);



implementation

procedure po_porazce_kulka();
begin
  sterowanie:=false;
  kulka1.kulka_w:=kulka1.kulka_bm^.w;
  kulka1.kulka_h:=kulka1.kulka_bm^.h;
  kulka1.kulka_x := (800-kulka1.kulka_w) div 2;
  kulka1.kulka_y := wysokosc-paletka1.paletka_h-kulka1.kulka_h;
  Vk := 6;
  zycie:=zycie-1;


end;

procedure init_kulka();
begin
  sterowanie:=false;
  Vk := 6;
  kulka1.kulka_bm := NIL;
  kulka1.kulka_bm := al_load_bmp( 'kulka.bmp', @al_default_palette);
  if( kulka1.kulka_bm = NIL ) then
  begin
    al_set_gfx_mode( AL_GFX_TEXT, 0, 0, 0, 0 );
    al_message( 'nie mogę załadować obrazka !' );
    al_exit();
    exit();
  end;
  kulka1.kulka_w:=kulka1.kulka_bm^.w;
  kulka1.kulka_h:=kulka1.kulka_bm^.h;
  kulka1.kulka_x := (800-kulka1.kulka_w) div 2;
  kulka1.kulka_y := wysokosc-paletka1.paletka_h-kulka1.kulka_h;
end;

procedure wys_kulka_start();
begin
  delay(6);
  //kulka1.kulka_x:=paletka1.paletka_x+(paletka1.paletka_w - kulka1.kulka_w) div 2;
  al_masked_blit(kulka1.kulka_bm, bufor, 0, 0, kulka1.kulka_x, kulka1.kulka_y, kulka1.kulka_w, kulka1.kulka_h);
end;

function zderzenie_paletka():boolean;
begin
  if (kulka1.kulka_y+kulka1.kulka_h >= wysokosc-paletka1.paletka_h) AND (kulka1.kulka_x+kulka1.kulka_w div 2 >= paletka1.paletka_x) AND (kulka1.kulka_x+kulka1.kulka_w div 2 <= paletka1.paletka_x+paletka1.paletka_w) then
    zderzenie_paletka := true
  else zderzenie_paletka := false;
end;

function zderzenie_sciana():boolean;
begin
  if(kulka1.kulka_y <= 0) OR (kulka1.kulka_x <= 0) OR (kulka1.kulka_x >= 800-kulka1.kulka_w) then zderzenie_sciana := true
  else zderzenie_sciana := false;
end;


procedure odbicie_paletka(var z_x:integer; var z_y:integer);
var a,b:real;
begin
  a:=Vk*((kulka1.kulka_x-paletka1.paletka_x-(paletka1.paletka_w-kulka1.kulka_w) div 2) / sqrt((kulka1.kulka_x-paletka1.paletka_x-(paletka1.paletka_w-kulka1.kulka_w) div 2)*(kulka1.kulka_x-paletka1.paletka_x-(paletka1.paletka_w-kulka1.kulka_w) div 2)+(paletka1.paletka_w div 4)*(paletka1.paletka_w div 4)));
  b:=Vk*((paletka1.paletka_w div 4) / sqrt((kulka1.kulka_x-paletka1.paletka_x-(paletka1.paletka_w-kulka1.kulka_w) div 2)*(kulka1.kulka_x-paletka1.paletka_x-(paletka1.paletka_w-kulka1.kulka_w) div 2)+(paletka1.paletka_w div 4)*(paletka1.paletka_w div 4)));
  z_x:=trunc(a);
  z_y:=trunc(b);
end;

procedure odbicie_sciana(var z_x:integer; var z_y:integer);
begin
  if(kulka1.kulka_x <= 0) OR (kulka1.kulka_x >= 790) then z_x := -z_x;
  if(kulka1.kulka_y <= 0) then z_y := -z_y;
end;

procedure wys_kulka_ruch();
begin
  al_masked_blit(kulka1.kulka_bm, bufor, 0, 0, kulka1.kulka_x, kulka1.kulka_y, kulka1.kulka_w , kulka1.kulka_h);

  if(zderzenie_sciana()) then odbicie_sciana(z_x, z_y);
  if(zderzenie_paletka()) then odbicie_paletka(z_x,z_y);
  kulka1.kulka_x := kulka1.kulka_x + z_x;
  kulka1.kulka_y := kulka1.kulka_y - z_y;
  delay(6);


end;

end.

