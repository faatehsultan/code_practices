
const getDataFromServer = ()=>{
    var xhttp = new XMLHttpRequest();
    xhttp.open('GET', 'http://localhost/wordpress/wp-json/wp/v2/posts');
    xhttp.onload = ()=> {
        if(xhttp.status >= 200 && xhttp.status <= 400) {
            var data = JSON.parse(xhttp.responseText);
            //data fetching here
            console.log(data);
        } else {
            console.log("Connected, but server returned error!\n");
        }
    }

    xhttp.onerror = ()=> {
        console.log("Connection Error!");
    }

    xhttp.send();
}

getDataFromServer();