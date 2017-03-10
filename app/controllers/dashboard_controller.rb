class DashboardController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    render 'component': 'Consola',props:{'zonas':Zona.where("area is not null").order("id asc").all(),'contratistas': Contratista.all(),dias:@dias}
  end

  def create

    begin
      inicio = Date.strptime(params[:inicio],"%m/%d/%Y")
    rescue
      inicio = "2015-01-01".to_date
    end

    begin
      fin =  Date.strptime(params[:fin],"%m/%d/%Y")
    rescue
      fin = Date.today()
    end





    where = "fecha_salida between '#{inicio}' and  '#{fin}'"

    begin
    dias = params[:dias].join("' or dia = '")
    if dias.length
      where << " and (  dia = '"<<dias<<"')"
    end
    rescue

    end
    begin
    zonas  = params[:zonas].join(" or zonas_id = ")
    if zonas.length
      where << " and (  zonas_id = "<<zonas<<")"
    end

  rescue

  end



  recolecion_mensual = Recoleccion.select("sum(bruto),date_trunc('month', fecha_salida) AS txn_month").where(where).group("txn_month").order("txn_month asc").all()
    recolecion_zonas = Recoleccion.select("sum(bruto),zonas_id").where(where).group("zonas_id").order("zonas_id asc").all()
    recolecion_dias = Recoleccion.select("sum(bruto),dia ").where(where).group("dia").order("dia asc").all()
    recolecion_contratistas = Recoleccion.select("sum(bruto),contratistas_id ").where(where).group("contratistas_id").order("contratistas_id asc").all()


    render json: {'recolecion_mensual':recolecion_mensual,'recolecion_zonas':recolecion_zonas,'recolecion_dias':recolecion_dias,'recolecion_contratistas':recolecion_contratistas}

  end
end
