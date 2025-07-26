import uuid


def get_template() -> list[dict]:
    '''
    Get the action template 'input_handler'
    '''
    count_action_id = str(uuid.uuid4())
    conditional_grouping_id = str(uuid.uuid4())
    
    return [
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.count",
        "WFWorkflowActionParameters": {
        "Input": {
            "Value": {
            "Type": "ExtensionInput"
            },
            "WFSerializationType": "WFTextTokenAttachment"
        },
        "UUID": count_action_id
        }
    },
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.conditional",
        "WFWorkflowActionParameters": {
        "GroupingIdentifier": conditional_grouping_id,
        "WFCondition": 0,
        "WFControlFlowMode": 0,
        "WFInput": {
            "Type": "Variable",
            "Variable": {
            "Value": {
                "OutputName": "Count",
                "OutputUUID": count_action_id,
                "Type": "ActionOutput"
            },
            "WFSerializationType": "WFTextTokenAttachment"
            }
        },
        "WFNumberValue": "1"
        }
    },
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.getclipboard",
        "WFWorkflowActionParameters": {
        "UUID": str(uuid.uuid4())
        }
    },
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.conditional",
        "WFWorkflowActionParameters": {
        "GroupingIdentifier": conditional_grouping_id,
        "WFControlFlowMode": 1
        }
    },
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.getvariable",
        "WFWorkflowActionParameters": {
        "WFVariable": {
            "Value": {
            "Type": "ExtensionInput"
            },
            "WFSerializationType": "WFTextTokenAttachment"
        }
        }
    },
    {
        "WFWorkflowActionIdentifier": "is.workflow.actions.conditional",
        "WFWorkflowActionParameters": {
        "GroupingIdentifier": conditional_grouping_id,
        "UUID": str(uuid.uuid4()),
        "WFControlFlowMode": 2
        }
    }
    ]