function (pythonExePath = NULL, dllDir = NULL, pythonHome = NULL) 
{
    if (pyIsConnected()) {
        cat("R is already connected to Python!\n")
    }
    else {
        if (.Call("isDllVersion")) {
            py <- autodetectPython(pythonExePath)
            dllName <- py[["dllName"]]
            if (is.null(dllDir)) {
                dllDir <- py[["dllDir"]]
            }
            else {
                if (!any(grepl(dllName, dir(dllDir)))) {
                  stop(sprintf("\"%s\" could not be found at at the specified dllDir:\n\t\"%s\"!", 
                    dllName, dllDir))
                }
            }
            majorVersion <- py[["majorVersion"]]
            pythonHome <- py[["pythonHome"]]
            pyArch <- py[["arch"]]
            silent <- pyConnectWinDll(dllName, dllDir, majorVersion, 
                pythonHome, pyArch)
        }
        else {
            silent <- pyConnectStatic()
        }
        pyImportPythonInR()
        packageStartupMessage(sprintf("\nInitialize Python Version %s\n", 
            pyVersion()))
    }
    invisible(NULL)
}
