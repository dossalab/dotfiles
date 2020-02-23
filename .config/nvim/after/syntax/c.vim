" hacky way of highlighting const values
syn match defined "\v\w@<!(\u|_+[A-Z0-9])[A-Z0-9_]*\w@!"
hi defined term=bold ctermfg=Blue

