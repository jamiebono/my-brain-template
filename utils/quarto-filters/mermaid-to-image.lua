-- mermaid-to-image.lua
-- Converts ```mermaid code blocks to images for PDF/DOCX output
-- For HTML, blocks are left as-is (handled by client-side JS)

local counter = 0

function CodeBlock(block)
  if block.classes[1] ~= "mermaid" then
    return nil
  end

  -- For HTML output, leave as-is (JS will handle rendering)
  if FORMAT:match("html") or FORMAT:match("html5") then
    return nil
  end

  counter = counter + 1

  -- Choose output format based on target
  -- DOCX needs PNG; typst/PDF work well with SVG
  local ext = "svg"
  if FORMAT:match("docx") or FORMAT:match("odt") or FORMAT:match("rtf") then
    ext = "png"
  end

  local input_file = "mermaid_temp_" .. counter .. ".mmd"
  local output_file = "mermaid_temp_" .. counter .. "." .. ext

  -- Write mermaid content to temp file
  local f = io.open(input_file, "w")
  if not f then
    io.stderr:write("ERROR: Could not create temp file: " .. input_file .. "\n")
    return nil
  end
  f:write(block.text)
  f:close()

  -- Run mermaid-cli to generate image
  -- Use -s 2 for higher resolution PNG, -b white for solid background
  local bg = (ext == "png") and "white" or "transparent"
  local scale = (ext == "png") and "-s 2" or ""
  local cmd = string.format('npx mmdc -i "%s" -o "%s" -b %s %s 2>&1',
    input_file, output_file, bg, scale)

  local handle = io.popen(cmd)
  local result = handle:read("*a")
  local success = handle:close()

  if not success then
    io.stderr:write("ERROR: mermaid-cli failed: " .. result .. "\n")
    os.remove(input_file)
    return nil
  end

  -- Check if output file exists
  local check = io.open(output_file, "r")
  if not check then
    io.stderr:write("ERROR: mermaid-cli did not create output file\n")
    os.remove(input_file)
    return nil
  end
  check:close()

  -- Clean up input file
  os.remove(input_file)

  -- Return image element
  return pandoc.Para({pandoc.Image({}, output_file, "")})
end

return {{CodeBlock = CodeBlock}}
