class Mapa extends React.Component {
    static markersMap;
    static change;
    static resultados;

    constructor(props) {
        super(props);
        change = true;
        zonas_basura =  this.props.zonas



    }



    componentDidMount() {
        var $this = $(ReactDOM.findDOMNode(this));
        googleMapWithMarkersExample = function () {

            var $markersMap = $this.find('#demo-map-buscardor');
            if ($markersMap.length) {
                markersMap = new GMaps({
                    div: $markersMap[0],
                    height: '560px',
                    lat: -33.595424,
                    lng: -70.5968087,
                    zoom: 12
                });




            }



            for(zona of zonas_basura) {
                var p = []

                for (poli of zona.area.replace("POLYGON ((", "").replace("))", "").split(",")) {
                    p.push(poli.split(" ").reverse());
                }
                markersMap.drawPolygon({
                    fillColor: '#3fb7ff',
                    fillOpacity: 0.35,
                    paths: p,
                    strokeColor: '#3fb7ff',
                    strokeOpacity: 0.8,
                    strokeWeight: 2
                });

            }
            /*         GMaps.on('click', markersMap.map, function(event) {
             var lat = event.latLng.lat();
             var lng = event.latLng.lng();
             cerca(lat,lng);
             });*/


        }
        googleMapWithMarkersExample()
    }


    render() {



        return <div>
            <div id="demo-map-buscardor"></div>



        </div>;
    }
}