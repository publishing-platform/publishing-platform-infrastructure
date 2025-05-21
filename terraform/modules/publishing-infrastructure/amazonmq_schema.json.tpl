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
      "configure": "^(amq\\.gen.*|search_api_to_be_indexed|search_api_publishing_platform_index)$",
      "write": "^(amq\\.gen.*|search_api_to_be_indexed|search_api_publishing_platform_index)$",
      "read": "^(amq\\.gen.*|search_api_to_be_indexed|search_api_publishing_platform_index|search_api_bulk_reindex|published_documents)$"
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
      "name": "search_api_to_be_indexed_retry",
      "pattern": "^search_api_to_be_indexed$",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_to_be_indexed_retry_dlx",
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
    {
      "vhost": "publishing",
      "name": "search_api_to_be_indexed_wait_to_retry_discarded",
      "pattern": "^search_api_to_be_indexed_wait_to_retry$",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_to_be_indexed_discarded_dlx",
        "message-ttl": 60000,
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
    {
      "vhost": "publishing",
      "name": "search_api_publishing_platform_index_retry",
      "pattern": "^search_api_publishing_platform_index$",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_publishing_platform_index_retry_dlx",
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
    {
      "vhost": "publishing",
      "name": "search_api_publishing_platform_index_wait_to_retry_discarded",
      "pattern": "search_api_publishing_platform_index_wait_to_retry",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_publishing_platform_index_discarded_dlx",
        "message-ttl": 60000,
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
    {
      "vhost": "publishing",
      "name": "search_api_bulk_reindex_retry",
      "pattern": "^search_api_bulk_reindex$",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_bulk_reindex_retry_dlx",
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
    {
      "vhost": "publishing",
      "name": "search_api_bulk_reindex_wait_to_retry_discarded",
      "pattern": "search_api_bulk_reindex_wait_to_retry",
      "apply-to": "queues",
      "definition": {
        "dead-letter-exchange": "search_api_bulk_reindex_discarded_dlx",
        "message-ttl": 60000,
        "ha-mode": "all",
        "ha-sync-mode": "automatic"
      },
      "priority": 1
    },
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
      "name": "search_api_to_be_indexed",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    },
    {
      "name": "search_api_to_be_indexed_wait_to_retry",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    },
    {
      "name": "search_api_bulk_reindex",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    },
    {
      "name": "search_api_bulk_reindex_wait_to_retry",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    },
    {
      "name": "search_api_publishing_platform_index",
      "vhost": "publishing",
      "durable": true,
      "auto_delete": false,
      "arguments": {}
    },
    {
      "name": "search_api_publishing_platform_index_wait_to_retry",
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
    },
    {
      "name": "search_api_to_be_indexed_discarded_dlx",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    },
    {
      "name": "search_api_to_be_indexed_retry_dlx",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    },
    {
      "name": "search_api_publishing_platform_index_discarded_dlx",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    },
    {
      "name": "search_api_publishing_platform_index_retry_dlx",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    },
      {
      "name": "search_api_bulk_reindex_discarded_dlx",
      "vhost": "publishing",
      "type": "topic",
      "durable": true,
      "auto_delete": false,
      "internal": false,
      "arguments": {}
    },
    {
      "name": "search_api_bulk_reindex_retry_dlx",
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
      "destination": "search_api_publishing_platform_index",
      "destination_type": "queue",
      "routing_key": "*.*",
      "arguments": {}
    },
    {
      "source": "search_api_publishing_platform_index_discarded_dlx",
      "vhost": "publishing",
      "destination": "search_api_publishing_platform_index",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    },
    {
      "source": "search_api_publishing_platform_index_retry_dlx",
      "vhost": "publishing",
      "destination": "search_api_publishing_platform_index_wait_to_retry",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    },
    {
      "source": "published_documents",
      "vhost": "publishing",
      "destination": "search_api_bulk_reindex",
      "destination_type": "queue",
      "routing_key": "*.bulk.reindex",
      "arguments": {}
    },
    {
      "source": "search_api_bulk_reindex_discarded_dlx",
      "vhost": "publishing",
      "destination": "search_api_bulk_reindex",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    },
    {
      "source": "search_api_bulk_reindex_retry_dlx",
      "vhost": "publishing",
      "destination": "search_api_bulk_reindex_wait_to_retry",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    },
    {
      "source": "published_documents",
      "vhost": "publishing",
      "destination": "search_api_to_be_indexed",
      "destination_type": "queue",
      "routing_key": "*.links",
      "arguments": {}
    },
    {
      "source": "search_api_to_be_indexed_discarded_dlx",
      "vhost": "publishing",
      "destination": "search_api_to_be_indexed",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    },
    {
      "source": "search_api_to_be_indexed_retry_dlx",
      "vhost": "publishing",
      "destination": "search_api_to_be_indexed_wait_to_retry",
      "destination_type": "queue",
      "routing_key": "#",
      "arguments": {}
    }
  ]
}