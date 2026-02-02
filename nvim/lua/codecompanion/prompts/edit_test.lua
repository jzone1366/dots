return {
  display_name = 'Edit<->Test workflow',
  config = {
    strategy = 'workflow',
    description = 'Use a workflow to repeatedly edit then test code',
    opts = {
      index = 5,
      is_default = true,
      short_name = 'et',
    },
    prompts = {
      {
        {
          name = 'Setup Test',
          role = 'user',
          opts = { auto_submit = false },
          content = function()
            local approvals = require('codecompanion.interactions.chat.tools.approvals')
            approvals:toggle_yolo_mode()

            return [[### Instructions

Your instructions here

### Steps to Follow

You are required to write code following the instructions provided above and test the correctness by running the designated test suite. Follow these steps exactly:

1. Update the code in #{buffer} using the @{insert_edit_into_file} tool
2. Then use the @{cmd_runner} tool to run the test suite with `<test_cmd>` (do this after you have updated the code)
3. Make sure you trigger both tools in the same response

We'll repeat this cycle until the tests pass. Ensure no deviations from these steps.]]
          end,
        },
      },
      {
        {
          name = 'Repeat On Failure',
          role = 'user',
          opts = { auto_submit = true },
          condition = function()
            return _G.codecompanion_current_tool == 'cmd_runner'
          end,
          repeat_until = function(chat)
            return chat.tool_registry.flags.testing == true
          end,
          content = 'The tests have failed. Can you edit the buffer and run the test suite again?',
        },
      },
    },
  },
}
