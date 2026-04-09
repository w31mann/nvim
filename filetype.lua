vim.filetype.add({
    extension = {
        Jenkinsfile = "groovy",
    },
    pattern = {
        [".*nginx.*%.conf"] = "nginx",
        [".*nginx.*%.inc"] = "nginx",
    },
})
