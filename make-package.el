;; make-package.el ---   -*- lexical-binding: t; -*-

;; Copyright © 2021 Ewen Grosjean

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file is not part of GNU Emacs.

(require 'package-x)

(defmacro comment (&rest body)
  "Comment out one or more s-expressions."
  nil)

(defvar local-archive
  (expand-file-name "packages/" "~/EwenG.github.io")
  "Location of the package archive.")
(setq package-archive-upload-base local-archive)

(defun make-package (project-directory lib-name version)
  (let* ((default-directory "~/")
         (lib-name (format "%s-%s" lib-name version)))
    (print (format "COPYFILE_DISABLE=1 tar -cvf %s.tar --exclude=\"%s/.*\" --exclude=\"%s/packages\" %s/"
                                   lib-name lib-name lib-name lib-name))
    (shell-command (format "cp -R %s %s" project-directory lib-name))
    (shell-command (format "COPYFILE_DISABLE=1 tar -cvf %s.tar --exclude=\"%s/.*\" --exclude=\"%s/packages\" %s/"
                           lib-name lib-name lib-name lib-name))
    (shell-command (format "rm -r ~/%s" lib-name))
    (package-upload-file (format "~/%s.tar" lib-name))
    (shell-command (format "rm ~/%s.tar" lib-name))))

(comment
 (make-package "replique.el" "replique" "1.1.0")
 (make-package "clj-data.el" "clj-data" "0.0.3")
 )

;; package-upload-file

(provide 'make-package)
