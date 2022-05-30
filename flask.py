from flask import Flask, jsonify, request
import json
import requests
from requests.structures import CaseInsensitiveDict

#declared an empty variable for reassignment
response = ''

#creating the instance of flask application
app = Flask(__name__)

#route to entertain our post and get request from flutter app
@app.route('/name', methods = ['GET', 'POST'])
def nameRoute():

    #fetching the global response variable to manipulate inside the function
    global response

    if(request.method == 'POST'):
        request_data = request.data 
        request_data = json.loads(request_data.decode('utf-8')) #converting it from json to key value pair
        contract_address = request_data['contract_address'] 
        token_id = request_data['token_id']
        url = "https://api.nftport.xyz/v0/nfts/"+contract_address+"/"+token_id+"?chain=ethereum&refresh_metadata=true"
        headers = CaseInsensitiveDict()
        headers["Authorization"] = "{creds.api_key}"
        headers["Content-Type"] = "application/json"
        resp = requests.get(url, headers=headers)
        def jprint(obj):
            text = json.dumps(obj, sort_keys=True, indent=4)
            print(text)
        x=resp.json()
        y=x["nft"]
        metadata=y["metadata"]
        nft_description=metadata["description"]
        chain = y["chain"]
        nft_url= y["file_url"]
        file_info=y["file_information"]
        response = f'The NFT is on the {chain} chain ' 
        response = f'NFT Size +{str(file_info["height"])}x{str(file_info["width"])}'
        response = f'Description associated with NFT: \n{nft_description} \n file url is {nft_url}'
                 
    else:
        return jsonify({'contract_address' : response}) 

if __name__ == "__main__":
    app.run(debug=True)