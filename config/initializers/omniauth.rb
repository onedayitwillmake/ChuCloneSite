Rails.application.config.middleware.use OmniAuth::Builder do
	provider :twitter, 'mGryA7Lb5Ic5a2Tbo1gA', '5QXNFAcbGpmWkcrlvZfIy1mW9stnjrEcACPOI79Cw'
	provider :facebook, '259985977355039', '44ab9ca204b0ad5d7f0e9f61270c2807'
end