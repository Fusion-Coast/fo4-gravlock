{
  FO4Edit script: attach GravLock_CarLockScript to the 64 in-scope vehicles.

  How to use (see docs/build.md, step 7):
    1. Copy this file into FO4Edit's "Edit Scripts" folder.
    2. Close the Creation Kit. Open FO4Edit with FO4GravLock.esp checked.
    3. Right-click FO4GravLock.esp in the left pane > Apply Script > pick
       "GravLock_AttachCarScript" > OK.
    4. Read the messages pane: it lists each vehicle and ends with "64 of 64".
    5. Close FO4Edit and save FO4GravLock.esp when asked.

  Safe to run twice: vehicles that already have the script are skipped.
  Only touches FO4GravLock.esp (copies each vehicle in as an override, the same
  thing the Creation Kit does when you edit a record).
}
unit GravLock_AttachCarScript;

const
  TargetName = 'FO4GravLock.esp';
  SourceName = 'Fallout4.esm';
  ScriptName = 'GravLock_CarLockScript';

var
  vehicles: TStringList;

function FindFile(name: string): IInterface;
var
  i: integer;
begin
  Result := nil;
  for i := 0 to FileCount - 1 do
    if SameText(GetFileName(FileByIndex(i)), name) then begin
      Result := FileByIndex(i);
      Exit;
    end;
end;

function HasOurScript(scripts: IInterface): boolean;
var
  i: integer;
begin
  Result := False;
  for i := 0 to ElementCount(scripts) - 1 do
    if SameText(GetElementEditValues(ElementByIndex(scripts, i), 'ScriptName'), ScriptName) then begin
      Result := True;
      Exit;
    end;
end;

function Initialize: integer;
var
  target, source, group, rec, ovr, vmad, scripts, script: IInterface;
  i, attached, skipped, missing: integer;
  edid: string;
begin
  Result := 0;
  vehicles := TStringList.Create;
  vehicles.CommaText :=
    'CarMini01Prewar,CarMini01,' +
    'CarSedan01,CarSedan02,CarSedan03,CarSedan04,CarSedan05,CarSedan06,CarSedan07,CarSedan08,CarSedan09,CarSedan10,CarSedan11,' +
    'CarSportsCar01,CarSportsCar02,CarSportsCar03,CarSportsCar04,CarSportsCar05,CarSportsCar06,CarSportsCar07,CarSportsCar08,CarSportsCar09,CarSportsCar10,CarSportsCar11,' +
    'CarFusionFlea01Clean,CarFusionFlea01,' +
    'CarCoupe01,CarCoupe02,CarCoupe03,CarCoupe04,CarCoupe05,CarCoupe06,CarCoupe07,CarCoupe08,CarCoupe09,CarCoupe10,CarCoupe11,' +
    'CarStationWagon01,CarStationWagon02,CarStationWagon03,CarStationWagon04,CarStationWagon05,CarStationWagon06,CarStationWagon07,CarStationWagon08,CarStationWagon09,CarStationWagon10,CarStationWagon11,' +
    'PickUpTruck01,PickUpTruck02,PickUpTruck03,PickUpTruck04,PickUpTruck05,PickUpTruck06,PickUpTruck07,PickUpTruck08,PickUpTruck09,PickUpTruck10,PickUpTruck11,' +
    'VaultTecVan01,VaultTecVan02,VaultTecVan01Prewar,VaultTecVan01Blue,VaultTecVan02Blue';

  target := FindFile(TargetName);
  source := FindFile(SourceName);
  if not Assigned(target) then begin
    AddMessage('STOP: ' + TargetName + ' is not loaded. Restart FO4Edit with it checked.');
    Exit;
  end;
  if not Assigned(source) then begin
    AddMessage('STOP: ' + SourceName + ' is not loaded.');
    Exit;
  end;

  group := GroupBySignature(source, 'MSTT');
  attached := 0;
  skipped := 0;
  missing := 0;

  for i := 0 to vehicles.Count - 1 do begin
    edid := vehicles[i];
    rec := MainRecordByEditorID(group, edid);
    if not Assigned(rec) then begin
      AddMessage('MISSING: ' + edid + ' not found in ' + SourceName);
      Inc(missing);
      Continue;
    end;

    ovr := wbCopyElementToFile(rec, target, False, True);
    if not Assigned(ovr) then begin
      AddMessage('FAILED: could not copy ' + edid + ' into ' + TargetName);
      Inc(missing);
      Continue;
    end;

    vmad := ElementBySignature(ovr, 'VMAD');
    if not Assigned(vmad) then
      vmad := Add(ovr, 'VMAD', True);
    SetElementNativeValues(vmad, 'Version', 6);
    SetElementNativeValues(vmad, 'Object Format', 2);

    scripts := ElementByPath(vmad, 'Scripts');
    if not Assigned(scripts) then
      scripts := Add(vmad, 'Scripts', True);

    if HasOurScript(scripts) then begin
      AddMessage('already done: ' + edid);
      Inc(skipped);
      Continue;
    end;

    script := ElementAssign(scripts, HighInteger, nil, False);
    SetElementEditValues(script, 'ScriptName', ScriptName);
    SetElementEditValues(script, 'Flags', 'Local');
    AddMessage('attached: ' + edid);
    Inc(attached);
  end;

  AddMessage('----');
  AddMessage(IntToStr(attached + skipped) + ' of ' + IntToStr(vehicles.Count) + ' vehicles have the script (' +
    IntToStr(attached) + ' new, ' + IntToStr(skipped) + ' already done, ' + IntToStr(missing) + ' problems).');
  if missing = 0 then
    AddMessage('All good. Close FO4Edit and save ' + TargetName + ' when asked.');
end;

function Process(e: IInterface): integer;
begin
  Result := 0;  // all work happens in Initialize
end;

function Finalize: integer;
begin
  Result := 0;
  vehicles.Free;
end;

end.
