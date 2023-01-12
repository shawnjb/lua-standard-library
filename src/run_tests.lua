local test_files = {"test_stack", "test_queue", "test_priority_queue"}

for i, test_file in ipairs(test_files) do
    local status, err = pcall(require, "tests." .. test_file)
    if not status then
        print("[ERROR] " .. test_file .. ": " .. err)
    end
end
