
class Buscador extends React.Component {

    constructor(props) {
        super(props);
        this.state = {rol: '', rut: '', nombre_social: '', giro: '', direccion: '', avanzado: false};
        this.handleChange = function (name, e) {
            var change = {};
            change[name] = e.target.value;
            this.setState(change);
        }

        this.buscar = function () {
            var $this = $(ReactDOM.findDOMNode(this));
            data={}
            data.inicio = $this.find("#inicio").val()
            data.fin = $this.find("#fin").val()
            data.dias = $this.find("#dias").val()
            data.zonas = $this.find("#zonas").val()

            $.post("/",data,function (data) {
                props.resultados(data)
            })
        }

    }

    componentDidMount() {
        var $this = $(ReactDOM.findDOMNode(this));
        $this.find(".fecha").datepicker();
       $this.find(".js-example-basic-multiple").select2();

    }
    render() {
        contratistas= this.props.contratistas

        zonas = this.props.zonas.map(function (zona,ix) {

            return contratistas.map(function(contratista,jx){

                if (zona.contratistas_id == contratista.id )
                return <option  key={ix*1000+jx} value={zona.id}>Zona {zona.zona} - {contratista.nombre}</option>
            })



        })

        dias =this.props.dias.map(function(dia,jx){
            return <option  key={jx} value={dia}>{dia}</option>
        })


        return <div>
            <h3>Ingresar datos</h3>
            <div className="form form-horizontal">


                <div className="form-group">
                    <label  className="col-sm-2 control-label" htmlFor="form-control-1">Desde</label>

                    <div className="col-sm-10">
                        <input id="inicio" className="form-control fecha" defaultValue={this.state.rol} onChange={this.handleChange.bind(this, 'rol')} type="text" name="local[rol]"  />

                    </div>
                </div>
                <div className="form-group">


                    <label  className="col-sm-2 control-label" htmlFor="form-control-1">Hasta</label>

                    <div className="col-sm-10">
                        <input id="fin" className="form-control fecha" defaultValue={this.state.rut} onChange={this.handleChange.bind(this, 'rut')}  type="text" name="local[rut]"  />

                    </div>
                </div>
                <div className="form-group">
                    <label  className="col-sm-2 control-label" htmlFor="form-control-1">Dias</label>

                    <div className="col-sm-10">

                        <select id="dias" className="form-control js-example-basic-multiple" multiple="multiple">
                            {dias}
                        </select>
                    </div>
                </div>

                <div className="form-group">
                    <label  className="col-sm-2 control-label" htmlFor="form-control-1">Zona</label>

                    <div className="col-sm-10">

                        <select id ="zonas" className="form-control js-example-basic-multiple" multiple="multiple">
                            {zonas}
                        </select>
                    </div>
                </div>

                <div className="form-group">
                    <button className="btn btn-primary btn-block btn-next" type="button" onClick={this.buscar.bind(this)}  >Generar informe</button>
                </div>
            </div>

        </div>;
    }
}