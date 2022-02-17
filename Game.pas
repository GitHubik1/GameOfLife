uses GraphABC;

var m1, m2: array[1..514, 1..514] of integer;

procedure start();
begin
  for var y:integer:= 2 to 513 do
    for var x:integer:= 2 to 513 do
      if Random(100) < 60 then
        m1[y, x]:= 1
      else
        m1[y, x]:= 0;
  //m1[100, 100]:= 1;
  //m1[101, 100]:= 1;
  //m1[102, 100]:= 1;
end;

procedure swap2();
begin
  for var y: integer := 2 to 513 do
    for var x: integer := 2 to 513 do
      m1[y, x] := m2[y, x];
end;

procedure UpdateLife();
begin
  var a: integer;
  for var y: integer := 2 to 513 do
    for var x: integer := 2 to 513 do begin
      a := (m1[y + 1, x + 1] + 
            m1[y + 1, x] + 
            m1[y + 1, x - 1] + 
            m1[y, x - 1] + 
            m1[y - 1, x - 1] + 
            m1[y - 1, x] + 
            m1[y - 1, x + 1] + 
            m1[y, x + 1]);
      if m1[y, x] = 0 then begin
        if a = 3 then
          m2[y, x] := 1;
      end else begin
        if a < 2 then
          m2[y, x] := 0;
        if a > 3 then
          m2[y, x] := 0;
        if (a = 2) or (a = 3) then
          m2[y, x] := 1;
      end;
    end;
    swap2;
end;

procedure drawlife();
begin
  for var y: integer := 2 to 513 do
    for var x: integer := 2 to 513 do
      if m1[y, x] = 1 then
        SetPixel(x, y, clBlack)
      else
        SetPixel(x, y, clWhite);
end;

procedure Update();
begin
  LockDrawing;
  while true do begin
    Drawlife();
    Redraw();
    UpdateLife;
    //Sleep(20);
  end;
end;

begin
  SetWindowSize(512, 512);
  start();
  Update();
end.