async function getVisitorCount() {
    
    try{
        let getCall = await fetch('https://0wsq3k4fvk.execute-api.us-east-1.amazonaws.com/test2/test', {
            method: 'GET',
        });
        let data = await getCall.json()
        document.getElementById("count").innerHTML = data;
        console.log(data);
        return data;

    }
    catch (err) {
        console.log('This works!')
        console.error(err);
    }
}

getVisitorCount();