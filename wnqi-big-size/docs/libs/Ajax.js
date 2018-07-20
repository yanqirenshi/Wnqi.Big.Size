function dump (o) {console.log(o);}

class Ajax {
    constructor(protcol, host, port, cors, credentials) {
        this.protcol = protcol;
        this.host = host;
        this.port = port;
        this.cors = cors ? cors : false;
        this.credentials = credentials ? credentials : null;
    }
    makeUri (path) {
        var port = '';
        if (this.port)
            port = ':' + this.port;

        return this.protcol + '://'
            + this.host
            + port
            + path;
    }
    error401 () {
        location.href = '/sign-in.html';
        return {};
    }
    errorCase (response) {
        if (response==401)
            return this.error401();

        // Other Error Case
        console.log('Error!' + uri);

        return {};
    }
    makeData (method, body) {
        var data =  {
            method: method ? method : 'GET',
            headers: {
                'Accept' : 'application/json'
            }
        };

        if (method=='POST') {
            data.headers['Content-Type'] = 'application/x-www-form-urlencoded';

            if (body)
                data.body = JSON.stringify(body);
        }

        if (this.cors)
            data.mode = 'cors';

        if (this.credentials)
            data.credentials = this.credentials;

        return data;
    }
    get (path, callback) {
        var uri = this.makeUri(path);
        fetch(uri, this.makeData())
            .then(function (response) {
                if (response.ok)
                    return response.json();
                else
                    return this.errorCase(response);
            }.bind(this))
            .then(callback)
            .catch(function(error) {
                dump(error);
            });
    }
    post (path, data, callback) {
        var uri = this.makeUri(path);
        fetch(uri, this.makeData('POST', data))
            .then(function (response) {
                if(response.ok)
                    return response.json();
                else
                    return this.errorCase(response);
            })
            .then(callback);
    }
    put (path, data, callback) {
        var uri = this.makeUri(path);
        fetch(uri, this.makeData('PUT', data))
            .then(function (response) {
                if(response.ok)
                    return response.json();
                else
                    return this.errorCase(response);
            })
            .then(callback);
    }
}
