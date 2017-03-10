
class Consola extends React.Component {

    constructor(props) {
        super(props);

        this.state={}
        this.state.contratistas = undefined
        this.state.zonas = undefined
        this.state.dias = undefined
        this.state.mensual = undefined


        this.resultados = function (x) {

            xcontratistas = x.recolecion_contratistas
            xzonas        = x.recolecion_zonas
            xdias = x.recolecion_dias
            xmensual        = x.recolecion_mensual


            this.setState({contratistas:undefined,zonas:undefined,dias:undefined,contratistas:undefined,mensual:undefined,});
            contratistas  ={}

            contratistas.data = []
            contratistas.labels = []
            contratistas.label  = "Kilos retirados por contratista"

            for (contratista of xcontratistas){
                contratistas.data.push(contratista.sum)
                for (contratista_name of props.contratistas)
                    if ( contratista.contratistas_id == contratista_name.id) {
                        contratistas.labels.push(contratista_name.nombre)
                        break
                    }
            }

            this.setState({contratistas:contratistas});

            contratistas.data = []
            contratistas.labels = []
            contratistas.label  = "Kilos retirados por contratista"

            for (contratista of xcontratistas){
                contratistas.data.push(contratista.sum)
                for (contratista_name of props.contratistas)
                    if ( contratista.contratistas_id == contratista_name.id) {
                        contratistas.labels.push(contratista_name.nombre)
                        break
                    }
            }
            this.setState({contratistas:contratistas});

            dias = {}
            dias.data = []
            dias.labels = []
            dias.label  = "Kilos retirados por dias"

            for (dia  of props.dias) {

                for (xdia of xdias) {
                    if (xdia.dia == dia) {
                        dias.data.push(xdia.sum)
                        dias.labels.push(dia)
                        break
                    }
                }
            }

            this.setState({dias:dias});

            zonas = {}
            zonas.data = []
            zonas.labels = []
            zonas.label  = "Kilos retirados por zonas"


            for (zona of props.zonas)
                for (xzona of xzonas){

                    if ( xzona.zonas_id == zona.id) {
                        for(contratista of props.contratistas)
                            if(contratista.id == zona.contratistas_id){
                                zonas.labels.push("Zona "+zona.zona+" - "+contratista.nombre)
                                zonas.data.push(xzona.sum)

                            }


                    }
            }

            this.setState({zonas:zonas});

            mensual = {}
            mensual.data = []
            mensual.labels = []
            mensual.label  = "Kilos retirados por mes"


            for (mes of xmensual){
               mensual.data.push(mes.sum)
               fecha = new Date(mes.txn_month)
               mensual.labels.push((fecha.getMonth()+1)+"-"+(fecha.getYear()-100))
            }

            console.log(zonas)

            this.setState({mensual:mensual});



        }


    }


    render() {

        contratistas = this.state.contratistas ? <Barras data={ this.state.contratistas}></Barras>: <div></div>
        dias = this.state.dias ? <Barras data={ this.state.dias}></Barras>: <div></div>
        zonas = this.state.zonas ? <Barras data={ this.state.zonas}></Barras>: <div></div>
        mensual = this.state.mensual ? <Barras data={ this.state.mensual}></Barras>: <div></div>


        return <div>
            <div className="layout-content">
                <div className="layout-content-body">
                    <div className="title-bar">
                        <h1 className="title-bar-title">
                            <span className="d-ib">Informe de residuos vecinales</span>

                        </h1>
                        <p className="title-bar-description">
                            <small> </small>
                        </p>
                    </div>

                    <div className="row">
                        <div className="col-md-6">
                            <Mapa zonas={this.props.zonas}></Mapa>

                              </div>
                        <div className="col-md-6">
                            <Buscador resultados={this.resultados.bind(this)} zonas={this.props.zonas} dias={this.props.dias} contratistas={this.props.contratistas} ></Buscador>

                        </div>
                    </div>





                    <div className="row">


                        <div className="col-md-6">
                            {contratistas}
                        </div>
                        <div className="col-md-6">
                            {dias}

                        </div>

                    </div>
                    <div className="row">


                        <div className="col-md-6">
                            {zonas}
                        </div>
                        <div className="col-md-6">
                            {mensual}

                        </div>

                    </div>


                </div>
            </div>
        </div>;
    }
}