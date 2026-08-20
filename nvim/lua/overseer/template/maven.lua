local function find_root()
  return vim.fs.root(0, {
    "mvnw",
  })
end

local maven_tasks = {
  "clean:clean",
  "clean:help",

  "compile exec:java",

  "compiler:compile",
  "compiler:help",
  "compiler:testCompile",

  "deploy:deploy",
  "deploy:deploy-file",
  "deploy:help",

  "install:help",
  "install:install",
  "install:install-file",

  "jar:help",
  "jar:jar",
  "jar:test-jar",

  "resources:copy-resources",
  "resources:help",
  "resources:resources",
  "resources:testResources",

  "site:attach-descriptor",
  "site:deploy",
  "site:effective-site",
  "site:help",
  "site:jar",
  "site:run",
  "site:site",
  "site:stage",
  "site:stage-deploy",

  "surefire:help",
  "surefire:test",

  "spring-boot:build-image",
  "spring-boot:build-image-no-fork",
  "spring-boot:build-info",
  "spring-boot:help",
  "spring-boot:process-aot",
  "spring-boot:process-test-aot",
  "spring-boot:repackage",
  "spring-boot:run",
  "spring-boot:start",
  "spring-boot:stop",
  "spring-boot:test-run",

  "checkstyle:check",
  "checkstyle:checkstyle",
  "checkstyle:help",

  "jacoco:report",
  "jacoco:check",
  "jacoco:prepare-agent",
  "jacoco:prepare-agent-integration",
  "jacoco:help",
}

return {
  name = "Maven",

  condition = {
    callback = function()
      if vim.bo.buftype ~= "" then
        return false
      end

      if vim.bo.filetype == "lazy" then
        return false
      end

      return find_root() ~= nil
    end,
  },

  generator = function(_, callback)
    local root = find_root()

    if not root then
      callback({})
      return
    end

    local templates = {}

    for _, task in ipairs(maven_tasks) do
      table.insert(templates, {
        name = "Maven: " .. task,

        builder = function()
          return {
            cmd = { "./mvnw" },
            -- Split "compile exec:java" into:
            -- { "compile", "exec:java" }
            args = vim.split(task, "%s+", { trimempty = true }),
            cwd = root,
            components = {
              "default",
              "open_output",
            },
          }
        end,
      })
    end

    callback(templates)
  end,
}
