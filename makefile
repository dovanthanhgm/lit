
all: django datasync_core

.PHONY: django
django:
	cd django && python manage.py runserver

.PHONY: datasync_core
datasync_core:
	cd datasync_core && python main.py

.PHONY: ui
ui:
	cd datasync_ui && yarn start

.PHONY: main_store
main_store:
	curl --location 'http://localhost:8181/api/v1/channel/setup' --header 'Authorization: JWT ' --header 'Content-Type: application/json' --data '{"channel_type": "shopify","channel_url": "https://anthony-shopi-2.myshopify.com","channel_name": "Shopif","user_id": 2,"api": {"password": "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","app_secret": "83d83677834ade7027b878bb01f920c2","shop": "anthony-shopi-2"}}'

