(define-module (elefan media-attachments)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 binary-ports)
  #:use-module (rnrs bytevectors)
  #:use-module (web uri)
  #:export (masto-media-upload)
  #:re-export (<mastodon-meta-subtree> masto-meta-subtree? masto-meta-subtree-width
                                                           masto-meta-subtree-height
                                                           masto-meta-subtree-size
                                                           masto-meta-subtree-aspect
                                                           masto-meta-subtree-frame-rate
                                                           masto-meta-subtree-duration
                                                           masto-meta-subtree-bitrate
               <mastodon-meta-focus>   masto-meta-focus?   masto-meta-focus-x
                                                           masto-meta-focus-y
               <mastodon-meta>         masto-meta?         masto-meta-small
                                                           masto-meta-original
                                                           masto-meta-focus
               <mastodon-attachment>   masto-attachment?   masto-attachment-id
                                                           masto-attachment-type
                                                           masto-attachment-url
                                                           masto-attachment-remote-url
                                                           masto-attachment-preview-url
                                                           masto-attachment-text-url
                                                           masto-attachment-meta
                                                           masto-attachment-description
                                                           masto-attachment-blurhash))

(define* (masto-media-upload mastoApp filePath #:key description x y)
  (cond
   [(and (or x y) (not (and x y)))
         (error (string-append
                  "ERROR: In procedure masto-media-upload:\n"
                  "In procedure masto-media-upload: "
                  "Both x and y coordinates are needed for "
                  "focus coordinates"))]
   [(> (string-length description) 420)
         (error (string-append
                  "ERROR: In procedure masto-media-upload:\n"
                  "In procedure masto-media-upload: "
                  "Image description cannot exceed 420 characters"))]
   [else (generate-masto-attachment
           (http 'post
             (string-append (masto-app-domain mastoApp) "/api/v1/media")
             #:body        (let ([fileName (car (last-pair
                                                  (split-and-decode-uri-path filePath)))])
                             (u8-list->bytevector
                               (append
                                 (bytevector->u8-list
                                   (string->utf8
                                     (string-append
                                       "--AaB03x\r\n"
                                       "Content-Disposition: form-data; "
                                       "name=\"file\"; "
                                       "filename=\"" fileName "\"\r\n"
                                       "Content-Type: "
                                       (case (string->symbol
                                               (car (last-pair
                                                      (string-split fileName #\.))))
                                         [(jpeg) "image/jpeg"]
                                         [(jpg)  "image/jpeg"]
                                         [(png)  "image/png"]
                                         [(gif)  "image/gif"]
                                         [else   (error (string-append
                                                          "ERROR: In procedure "
                                                          "masto-media-upload:\n"
                                                          "In procedure "
                                                          "masto-media-upload: "
                                                          "Invalid file-type submitted"))])
                                       "\r\n\r\n")))
                                 (bytevector->u8-list (get-bytevector-all
                                                        (open-file filePath "rb")))
                                 (bytevector->u8-list (string->utf8
                                                        "\r\n--AaB03x--\r\n")))))
             #:token       (masto-app-token mastoApp)
             #:contentType "multipart/form-data; boundary=AaB03x"
             #:queryParams `(("description" ,description)
                             ("focus"       ,(if (and x y)
                                                 (string-append
                                                   (number->string x) ","
                                                   (number->string y))
                                               #f)))))]))

(define* (masto-media-update mastoApp mediaID #:key description x y)
  (cond
   [(and (or x y) (not (and x y)))
         (error (string-append
                  "ERROR: In procedure masto-media-upload:\n"
                  "In procedure masto-media-upload: "
                  "Both x and y coordinates are needed for "
                  "focus coordinates"))]
   [(> (string-length description) 420)
         (error (string-append
                  "ERROR: In procedure masto-media-upload:\n"
                  "In procedure masto-media-upload: "
                  "Image description cannot exceed 420 characters"))]
   [else (generate-masto-attachment
           (http 'put
             (string-append (masto-app-domain mastoApp) "/api/v1/media/" mediaID)
             #:token       (masto-app-token mastoApp)
             #:queryParams `(("description" ,description)
                             ("focus"       ,(if (and x y)
                                                 (string-append
                                                   (number->string x) ","
                                                   (number->string y))
                                               #f)))))]))
