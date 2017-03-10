s = SimpleSpreadsheet::Workbook.read("code/basura.xlsx")
s.selected_sheet = s.sheets.first

ixx =0
s.first_row.upto(s.last_row) do |line|

  if ixx >0
    folio = s.cell(line, 1)
    patente = s.cell(line, 2)
    n_cam = s.cell(line, 3)
    cliente = s.cell(line, 4)
    transporte = s.cell(line, 5)
    p "aca"
    nombre = s.cell(line, 6)
    p "aqui"
    residuo = s.cell(line, 7)
    bruto = s.cell(line, 8)
    tara = s.cell(line, 9)
    neto = s.cell(line, 10)
    begin

      fecha_entrada = s.cell(line, 11).to_s.to_date
    rescue
       p ""

    end

    fecha_salida = s.cell(line, 12).to_s.to_date
    dia = s.cell(line, 13)
    mes = s.cell(line, 14)
    ano = s.cell(line, 15)
    sector = s.cell(line, 16)
    zona = s.cell(line, 17)
    marca = s.cell(line, 18)
    modelo = s.cell(line, 19)
    caja = s.cell(line, 20)
    ano_modelo = s.cell(line, 21)


    if false
      recoleccion = Recoleccion.where(:folio=>folio).first()

      recoleccion.sector=sector


      camion = Camion.where(:patente=> patente, :numero => n_cam).first()
      camion.ano = ano_modelo
      recoleccion.save
      camion.save

    end








    if true


      recoleccion = Recoleccion.new()
    recoleccion.folio = folio
    recoleccion.conductor = nombre
    recoleccion.bruto = bruto
    recoleccion.tara = tara
    recoleccion.neto = neto
    recoleccion.dia = dia
    recoleccion.mes = mes
    recoleccion.ano = ano
    recoleccion.zona = zona
      recoleccion.sector=sector
      recoleccion.fecha_entrada = fecha_entrada
      recoleccion.fecha_salida = fecha_salida



    contratista = Contratista.where(:nombre => transporte).first()

    if contratista == nil
      contratista=Contratista.new()
      contratista.nombre = transporte
      contratista.save()

    end


    recoleccion.contratistas_id=contratista.id
    camion = Camion.where(:patente=> patente, :numero => n_cam).first()

    if camion ==nil
      camion = Camion.new()
      camion.patente = patente
      camion.numero = n_cam
      camion.marca = marca
      camion.modelo = modelo
      camion.caja = caja
      camion.ano = ano_modelo
      camion.contratistas_id=contratista.id
      camion.save()
    end

    recoleccion.camiones_id= camion.id

    zona = Zona.where(:contratistas_id => contratista.id,:zona=> recoleccion.zona ).first()

    if zona == nil
      zona = Zona.new
      zona.zona = recoleccion.zona
    end

    if dia =="martes"
      zona.martes = true

    elsif dia == "miércoles"
      zona.miercoles=true
    elsif dia == "lunes"
      zona.lunes=true
    elsif dia == "jueves"
      zona.jueves=true
    elsif dia == "sábado"
      zona.sabado=true
    elsif dia == "viernes"
      zona.viernes=true
    elsif dia == "domingo"
      zona.domingo=true
    end

    zona.contratistas_id=contratista.id
    zona.save()
    recoleccion.zonas_id=zona.id


    recoleccion.save
    end



  end

  ixx=ixx+1
end