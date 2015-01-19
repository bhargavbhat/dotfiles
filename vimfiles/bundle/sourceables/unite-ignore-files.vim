call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
\ 'ignore_pattern', join([
\ '.class$', '\.jar$',
\ '\.jpg$', '\.jpeg$', '\.bmp$', '\.png$', '\.gif$',
\ '\.o$', '\.so$', '\.lo$', '\.lib$', '\.out$', '\.obj$', 
\ '\.zip$', '\.tar\.gz$', '\.tar\.bz2$', '\.rar$', '\.tar\.xz$',
\ '\.ac$', '\.cache$', '\.0$' 
\ ], '\|'))
