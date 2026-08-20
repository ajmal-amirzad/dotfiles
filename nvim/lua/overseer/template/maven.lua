local function find_root()
  return vim.fs.root(0, {
    "mvnw",
  })
end

local maven_tasks = {
  -- Lifecycle
  "clean",
  "validate",
  "compile",
  "test",
  "package",
  "verify",
  "install",
  "deploy",
  "clean compile",
  "clean install",
  "clean package",
  "clean verify",
  "clean test",
  "clean compile -DskipTests",
  "clean compile -Dmaven.test.skip=true",
  "clean install -DskipTests",
  "clean install -Dmaven.test.skip=true",
  "clean package -DskipTests",
  "clean package -Dmaven.test.skip=true",
  "clean verify jacoco:report",

  -- Compiler
  "test-compile",
  "compiler:compile",
  "compiler:testCompile",
  "compile exec:java",
  "compiler:help",

  -- Resources
  "resources:resources",
  "resources:testResources",
  "resources:copy-resources",
  "resources:help",

  -- Surefire / Failsafe (unit & integration tests)
  "surefire:test",
  "surefire:help",
  "failsafe:integration-test",
  "failsafe:verify",
  "failsafe:help",

  -- Jar / War
  "jar:jar",
  "jar:test-jar",
  "jar:help",
  "war:war",
  "war:exploded",
  "war:help",

  -- Dependency
  "dependency:tree",
  "dependency:analyze",
  "dependency:resolve",
  "dependency:sources",
  "dependency:resolve-plugins",
  "dependency:go-offline",
  "dependency:copy-dependencies",
  "dependency:purge-local-repository",
  "dependency:help",

  -- Versions / Releases
  "versions:display-dependency-updates",
  "versions:display-plugin-updates",
  "versions:display-property-updates",
  "versions:set",
  "versions:use-latest-releases",
  "versions:help",

  -- Spring Boot
  "spring-boot:run",
  "spring-boot:run -Dspring-boot.run.profiles=local",
  "spring-boot:run -Dspring-boot.run.profiles=dev",
  "spring-boot:run -Dspring-boot.run.profiles=test",
  "spring-boot:start",
  "spring-boot:stop",
  "spring-boot:repackage",
  "spring-boot:build-image",
  "spring-boot:build-image-no-fork",
  "spring-boot:build-info",
  "spring-boot:process-aot",
  "spring-boot:process-test-aot",
  "spring-boot:test-run",
  "spring-boot:help",

  -- Code quality / Coverage
  "checkstyle:check",
  "checkstyle:checkstyle",
  "checkstyle:help",
  "jacoco:prepare-agent",
  "jacoco:prepare-agent-integration",
  "jacoco:report",
  "jacoco:check",
  "jacoco:help",
  "spotbugs:check",
  "spotbugs:gui",
  "pmd:check",
  "pmd:pmd",
  "enforcer:enforce",

  -- Site / Documentation
  "site",
  "site:site",
  "site:run",
  "site:jar",
  "site:deploy",
  "site:stage",
  "site:stage-deploy",
  "site:attach-descriptor",
  "site:effective-site",
  "site:help",

  -- Install / Deploy helpers
  "install:install",
  "install:install-file",
  "install:help",
  "deploy:deploy",
  "deploy:deploy-file",
  "deploy:help",

  -- Help / Info
  "help:effective-pom",
  "help:effective-settings",
  "help:describe",
  "help:evaluations",
  "help:system",
  "help:all-profiles",
  "help:active-profiles",
  "help:help",

  -- Other useful ones
  "clean:clean",
  "clean:help",
  "exec:java",
  "exec:exec",
  "antrun:run",
  "build-helper:add-source",
  "build-helper:add-test-source",
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
          -- Show a simple cmdline-style input popup
          local extra = vim.fn.input({
            prompt = "Additional args: ",
            default = "",
          })

          local base_args = vim.split(task, "%s+", { trimempty = true })
          local extra_args = {}

          if extra and extra ~= "" then
            extra_args = vim.split(extra, "%s+", { trimempty = true })
          end

          return {
            cmd = { "./mvnw" },
            args = vim.list_extend(base_args, extra_args),
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
