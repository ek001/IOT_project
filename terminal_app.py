import requests
import requests
import json
import webbrowser
import time
from requests.structures import CaseInsensitiveDict 


contract_add=input("Enter contract address: ")
token_id=input("Enter Token ID: ")
url = "https://api.nftport.xyz/v0/nfts/"+contract_add+"/"+token_id+"?chain=ethereum&refresh_metadata=true"
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
print("\n\n")
print("The NFT is on the "+chain+" chain ")
print("\n\n~ ~ ~ ~ ~ ~ ~\n")
print("NFT Size "+str(file_info["height"])+"x"+str(file_info["width"]))
print("\n\n~ ~ ~ ~ ~ ~ ~\n")
print("Description associated with NFT: \n\n"+nft_description)
time.sleep(5)
webbrowser.open(nft_url)
