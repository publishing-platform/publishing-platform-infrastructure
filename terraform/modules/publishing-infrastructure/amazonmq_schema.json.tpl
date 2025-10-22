{
  "rabbit_version": "3.6.15",
  "users": [
    {
      "name": "publishing_api",
      "password": "${publishing_amazonmq_passwords["publishing_api"]}",
      "tags": ""
    },
    {
      "name": "search_api",
      "password": "${publishing_amazonmq_passwords["search_api"]}",
      "tags": ""
    }
  ],
  "vhosts": [
    {
      "name": "publishing"
    }
  ],
  "permissions": [
    {
      "user": "search_api",
      "vhost": "publishing",
      "configure": "^(amq\\.gen.*|search_api_published_documents)$",
      "write": "^(amq\\.gen.*|search_api_published_documents)$",
      "read": "^(amq\\.gen.*|search_api_published_documents|published_documents)$"
    },
    {
      "user": "publishing_api",
      "vhost": "publishing",
      "configure": "^amq\\.gen.*$",
      "write": "^(amq\\.gen.*|published_documents)$",
      "read": "^(amq\\.gen.*|published_documents)$"
    },
    {
      "user": "root",
      "vhost": "publishing",
      "configure": ".*",
      "write": ".*",
      "read": ".*"
    }
  ],
  "parameters": [],
  "global_parameters": [
    {
      "name": "cluster_name",
      "value": "${publishing_amazonmq_broker_name}"
    }
  ],
  "policies": [
    {
      "vhost": "publishing",
      "name": "ha-all",
      "pattern": ".*",
      "apply-to": "all",
      "definition": {
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 0
    }
  ],
  "queues": [
    {
      "name": "search_api_published_documents",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    }
  ],
  "exchanges": [
    {
      "name": "published_documents",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    }
  ],
  "bindings": [
    {
      "source": "published_documents",
      "vhost": "publishing",
      "destination": "search_api_published_documents",
      "destination_type": "queue",
      "routing_key": "*.*",
      "arguments": {}
    },
    {
      "source": "published_documents",
      "vhost": "publishing",
      "destination": "search_api_published_documents",
      "destination_type": "queue",
      "routing_key": "*.bulk.search_api_sync",
      "arguments": {}
    }
  ]
}