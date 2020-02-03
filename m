Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B21150099
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Feb 2020 03:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgBCCh5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 2 Feb 2020 21:37:57 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:41773 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726971AbgBCCh5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 2 Feb 2020 21:37:57 -0500
Received: by mail-qk1-f201.google.com with SMTP id r145so8521926qke.8
        for <linux-ext4@vger.kernel.org>; Sun, 02 Feb 2020 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=/A62wtchxxr6pmGDNo5M680m/zAULxQ5Kw2nST+QzPA=;
        b=DMZGrQbm8vhUIJUOUN3UJgAPFrCwVKGj0Ac/kNnwpe9/Xj4VjALEbM/dM+70sD4xcY
         U0FsMqyIneY1aIyJyzuHcK65GQ3O49A2bTmMB6TmdKHJuTYKLXBvumYvz++Ek6nvxYg6
         YnN5JlxAoFVZM190WHLWjpep3PSV1MKnNWabvF8PYR+BT3FRM41K0O8cPix9EmFD6F3K
         HJiDpy2ga5PeNxDpRjC7p+rNaPRuRSxqnNdBU9fHVEtNmAxY2FtwebT3h/G3I6zbw1Lm
         NVILO5IlXvVvaE+LRDnda2eZ2k7m7lyMJlN4chRVYaKhKaIcfz/EWAC7/fG7RKoYEnh+
         VPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=/A62wtchxxr6pmGDNo5M680m/zAULxQ5Kw2nST+QzPA=;
        b=n6DHvhTtUbQAuW2BIog+upYb3heKUdyjPwyWF7GHUUsjxVqPjKt9IJ05ZtK2VxhPS9
         OQVArwuH1XP7BR2Apk/w9bgcSCdWNOVzmKijpLbvUFSOfrNUnuJRE5YOtv9i+YX4gjFn
         PckQd7z+crTxLvEZynjIdIcJzcRdiq0X9pekE+NG/wAR4og8qTH8m5KY+NbNZaIAe+8B
         QJDKcyJyd8O1fJ4vPigEMTYcpH9984ARS48uO4sGDBCG3Ig4Vi+IomkjcE+1AN7y5a74
         VuXtmgd9F80ck5B/0LYjaxFvCpYabwLVUxQfvgJO5Felq1u1lyF6oITj8Z1P+iRpYLX9
         0haQ==
X-Gm-Message-State: APjAAAVLBk9L8WlSXazsyilTEkRBwJD4AH7xfx+Vwp2cDVH7rWtqb10F
        qAhEjMY8KqsftjtBpkDSfxYbv8oXZLFXVCb2iOtgN2+zAiJCUJ3zfXzyxbL7LUuryM2S+FZEpNy
        yIv0S/zLOq7biOkQcdc0VB/9CV2w4q3Ic8bzU+CbA7aCLhsVL60jezR+kM8LAjYVEJDcYh3SYSW
        Ptdes0mXk=
X-Google-Smtp-Source: APXvYqxnhKEs4p5hbOaWR8DNV5GUG81wOqewvAzEaM51XKro/Q6c4diA6Yn/K5KqjI1rLawYmk9t5hAV9oax5YEMnGE=
X-Received: by 2002:ac8:7501:: with SMTP id u1mr21964184qtq.149.1580697474395;
 Sun, 02 Feb 2020 18:37:54 -0800 (PST)
Date:   Mon,  3 Feb 2020 13:37:41 +1100
Message-Id: <20200203023741.218441-1-jeremyvisser@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH] chattr.1: improve attribute formatting with labels and
 indented paragraphs
From:   Jeremy Visser <jeremyvisser@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     Jeremy Visser <jeremyvisser@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

By convention, lists of options in man pages use a label followed by an
indented description, such as this example from the Options section:

     -R     Recursively change attributes of directories and
            their contents.

But the Attributes section places the available attributes mid-sentence,
which makes it visually more difficult to parse:

     A file with the 'a' attribute set can only be opened
     in append mode for writing.  [...]

     When a file with the 'A' attribute set is accessed, its
     atime record is not modified.  [...]

This patch places a label beside each attribute description, which (in
my opinion) improves readability, especially when visually skimming the
list.  For example:

     a      A file with the 'a' attribute set can only be
            opened in append mode for writing.

     A      When a file with the 'A' attribute set is accessed,
            its atime record is not modified.

Signed-off-by: Jeremy Visser <jeremyvisser@google.com>
---
 misc/chattr.1.in | 59 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/misc/chattr.1.in b/misc/chattr.1.in
index 66e791db..71e910c9 100644
--- a/misc/chattr.1.in
+++ b/misc/chattr.1.in
@@ -79,20 +79,25 @@ Set the file's version/generation number.
 .BI \-p " project"
 Set the file's project number.
 .SH ATTRIBUTES
+.TP
+.B a
 A file with the 'a' attribute set can only be opened in append mode for
 writing.  Only the superuser or a process possessing the
 CAP_LINUX_IMMUTABLE capability can set or clear this attribute.
-.PP
+.TP
+.B A
 When a file with the 'A' attribute set is accessed, its atime record is
 not modified.  This avoids a certain amount of disk I/O for laptop
 systems.
-.PP
+.TP
+.B c
 A file with the 'c' attribute set is automatically compressed on the disk
 by the kernel.  A read from this file returns uncompressed data.  A write to
 this file compresses data before storing them on the disk.  Note: please
 make sure to read the bugs and limitations section at the end of this
 document.
-.PP
+.TP
+.B C
 A file with the 'C' attribute set will not be subject to copy-on-write
 updates.  This flag is only supported on file systems which perform
 copy-on-write.  (Note: For btrfs, the 'C' flag should be
@@ -101,42 +106,50 @@ data blocks, it is undefined when the blocks assigned to the file will
 be fully stable.  If the 'C' flag is set on a directory, it will have no
 effect on the directory, but new files created in that directory will
 have the No_COW attribute set.)
-.PP
+.TP
+.B d
 A file with the 'd' attribute set is not a candidate for backup when the
 .BR dump (8)
 program is run.
-.PP
+.TP
+.B D
 When a directory with the 'D' attribute set is modified,
 the changes are written synchronously to the disk; this is equivalent to
 the 'dirsync' mount option applied to a subset of the files.
-.PP
+.TP
+.B e
 The 'e' attribute indicates that the file is using extents for mapping
 the blocks on disk.  It may not be removed using
 .BR chattr (1).
-.PP
+.TP
+.B E
 A file, directory, or symlink with the 'E' attribute set is encrypted by the
 filesystem.  This attribute may not be set or cleared using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
-.PP
+.TP
+.B F
 A directory with the 'F' attribute set indicates that all the path
 lookups inside that directory are made in a case-insensitive fashion.
 This attribute can only be changed in empty directories on file systems
 with the casefold feature enabled.
-.PP
+.TP
+.B i
 A file with the 'i' attribute cannot be modified: it cannot be deleted or
 renamed, no link can be created to this file, most of the file's
 metadata can not be modified, and the file can not be opened in write mode.
 Only the superuser or a process possessing the CAP_LINUX_IMMUTABLE
 capability can set or clear this attribute.
-.PP
+.TP
+.B I
 The 'I' attribute is used by the htree code to indicate that a directory
 is being indexed using hashed trees.  It may not be set or cleared using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
-.PP
+.TP
+.B j
 A file with the 'j' attribute has all of its data written to the ext3 or
 ext4 journal before being written to the file itself, if the file system
 is mounted with the "data=ordered" or "data=writeback" options and the
@@ -144,14 +157,16 @@ file system has a journal.  When the filesystem is mounted with the
 "data=journal" option all file data is already journalled and this
 attribute has no effect.  Only the superuser or a process possessing the
 CAP_SYS_RESOURCE capability can set or clear this attribute.
-.PP
+.TP
+.B N
 A file with the 'N' attribute set indicates that the file has data
 stored inline, within the inode itself. It may not be set or cleared
 using
 .BR chattr (1),
 although it can be displayed by
 .BR lsattr (1).
-.PP
+.TP
+.B P
 A directory with the 'P' attribute set will enforce a hierarchical
 structure for project id's.  This means that files and directory created
 in the directory will inherit the project id of the directory, rename
@@ -159,22 +174,26 @@ operations are constrained so when a file or directory is moved into
 another directory, that the project id's much match.  In addition, a
 hard link to file can only be created when the project id for the file
 and the destination directory match.
-.PP
+.TP
+.B s
 When a file with the 's' attribute set is deleted, its blocks are zeroed
 and written back to the disk.  Note: please make sure to read the bugs
 and limitations section at the end of this document.
-.PP
+.TP
+.B S
 When a file with the 'S' attribute set is modified,
 the changes are written synchronously to the disk; this is equivalent to
 the 'sync' mount option applied to a subset of the files.
-.PP
+.TP
+.B t
 A file with the 't' attribute will not have a partial block fragment at
 the end of the file merged with other files (for those filesystems which
 support tail-merging).  This is necessary for applications such as LILO
 which read the filesystem directly, and which don't understand tail-merged
 files.  Note: As of this writing, the ext2, ext3, and ext4 filesystems do
 not support tail-merging.
-.PP
+.TP
+.B T
 A directory with the 'T' attribute will be deemed to be the top of
 directory hierarchies for the purposes of the Orlov block allocator.
 This is a hint to the block allocator used by ext3 and ext4 that the
@@ -184,12 +203,14 @@ idea to set the 'T' attribute on the /home directory, so that /home/john
 and /home/mary are placed into separate block groups.  For directories
 where this attribute is not set, the Orlov block allocator will try to
 group subdirectories closer together where possible.
-.PP
+.TP
+.B u
 When a file with the 'u' attribute set is deleted, its contents are
 saved.  This allows the user to ask for its undeletion.  Note: please
 make sure to read the bugs and limitations section at the end of this
 document.
-.PP
+.TP
+.B V
 A file with the 'V' attribute set has fs-verity enabled.  It cannot be
 written to, and the filesystem will automatically verify all data read
 from it against a cryptographic hash that covers the entire file's
-- 
2.25.0.341.g760bfbb309-goog

