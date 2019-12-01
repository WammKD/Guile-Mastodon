(define-module (elefan media-attachments)
  #:use-module (elefan auth)
  #:use-module (elefan entities)
  #:use-module (elefan utils)
  #:use-module (ice-9 binary-ports)
  #:use-module (ice-9 receive)
  #:use-module (json)
  #:use-module (rnrs bytevectors)
  #:use-module (srfi srfi-26)
  #:use-module (web client)
  #:use-module (web uri)
  #:export (masto-media-upload))

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
   [else (receive (header body)
             (http-post
               (string-append (masto-app-domain mastoApp) "/api/v1/media"
                              (if (or description (and x y)) "?" "")
                              (if description
                                  (string-append "description=" description)
                                "")
                              (if (and description x y) "&" "")
                              (if (and x y)
                                  (string-append "focus=" (number->string x)
                                                 ","      (number->string y))
                                ""))
               #:body    (let ([fileName (car (last-pair
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
               #:headers `((Authorization . ,(string-append
                                               "Bearer "
                                               (masto-app-token mastoApp)))
                           (Content-Type  . "multipart/form-data; boundary=AaB03x")))
           (if-let ([bodySCM (cut assoc-ref <> "error") (json-string->scm
                                                          (utf8->string body))])
               (error (assoc-ref bodySCM "error"))
             (generate-masto-attachment bodySCM)))]))
