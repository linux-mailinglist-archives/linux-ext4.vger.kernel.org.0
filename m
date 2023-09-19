Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4DF7A5D3E
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjISJCl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 05:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjISJCk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 05:02:40 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B669114
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 02:02:33 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id iE0mqXQGt6NwhiWcqqy4Wo; Tue, 19 Sep 2023 09:02:32 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWcpqDHfQHFsOiWcpqzzIK; Tue, 19 Sep 2023 09:02:32 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=650963a8
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=LXVQ_-qJVfS9U6ybf7IA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 1/7] [v2] lib: move jfs_user.h into libsupport
Date:   Tue, 19 Sep 2023 03:02:21 -0600
Message-Id: <20230919090227.25363-1-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfFYc3gxTaho3nkmPr1CblqLqqJF3LEPPijSsraY6Y8dVop2yYVKUhegYX+iEDldy+zUPiS9T9EiMCZZMkGzkIy02QXFuKMsZZxdICRr0el0u8GTCWBRs
 6ziNfbvcIAfsAy0qQC2RvwzQ//+9qukFkWXjM+oed/JT7yY3VDuJC6FC1vsEbVQXMzGi8ImUz9Pwk7SHpDHb0rQCHxaA0xYYHTLRAxYz2dPT7VIdWn7F2XT1
 lTE6di4hMydrYnoH6DLBUkMg5InRkLg9GLyyFQxUzGzUwAEeNzv7j2DauEAEzLue
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@gmail.com>

The jfs_user.h header used in both debugfs and e2fsck, so
lib/support is better place for it.
Move a header into new place and rename to jbd2_user.h to
avoid confusion with JFS filesystem files.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/Makefile.in                          | 16 +++++++---------
 debugfs/debugfs.c                            |  2 +-
 debugfs/journal.h                            |  2 +-
 debugfs/logdump.c                            |  2 +-
 e2fsck/Makefile.in                           |  8 ++++----
 e2fsck/journal.c                             |  2 +-
 e2fsck/recovery.c                            |  2 +-
 e2fsck/revoke.c                              |  2 +-
 e2fsck/unix.c                                |  2 +-
 lib/ext2fs/Makefile.in                       | 18 ++++++++----------
 e2fsck/jfs_user.h => lib/support/jbd2_user.h |  0
 misc/Makefile.in                             | 12 +++++-------
 12 files changed, 31 insertions(+), 37 deletions(-)
 rename e2fsck/jfs_user.h => lib/support/jbd2_user.h (100%)

diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
index 67f8d0b6..1ced0c78 100644
--- a/debugfs/Makefile.in
+++ b/debugfs/Makefile.in
@@ -47,9 +47,7 @@ STATIC_DEPLIBS= $(STATIC_LIBEXT2FS) $(DEPSTATIC_LIBSS) \
 		$(DEPSTATIC_LIBCOM_ERR) $(DEPSTATIC_LIBUUID) \
 		$(DEPSTATIC_LIBE2P)
 
-# This nastiness is needed because of jfs_user.h hackery; when we finally
-# clean up this mess, we should be able to drop it
-LOCAL_CFLAGS = -I$(srcdir)/../e2fsck -DDEBUGFS
+LOCAL_CFLAGS = -DDEBUGFS
 DEPEND_CFLAGS = -I$(srcdir)
 
 .c.o:
@@ -186,7 +184,7 @@ debugfs.o: $(srcdir)/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/version.h \
- $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
+ $(top_srcdir)/lib/support/jbd2_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
@@ -277,7 +275,7 @@ logdump.o: $(srcdir)/logdump.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/../misc/create_inode.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h
@@ -382,7 +380,7 @@ quota.o: $(srcdir)/quota.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/journal.h \
- $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_srcdir)/lib/support/jbd2_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
  $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
@@ -390,7 +388,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
@@ -400,7 +398,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
@@ -423,4 +421,4 @@ do_journal.o: $(srcdir)/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
+ $(srcdir)/journal.h $(top_srcdir)/lib/support/jbd2_user.h
diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index 9b6321dc..742bf794 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -37,7 +37,7 @@ extern char *optarg;
 #include <ext2fs/ext2_ext_attr.h>
 
 #include "../version.h"
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #include "support/plausible.h"
 
 #ifndef BUFSIZ
diff --git a/debugfs/journal.h b/debugfs/journal.h
index 10b638eb..9c11f4f1 100644
--- a/debugfs/journal.h
+++ b/debugfs/journal.h
@@ -12,7 +12,7 @@
  * any later version.
  */
 
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 
 /* journal.c */
 errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 6b0133e0..908a3f35 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -32,7 +32,7 @@ extern char *optarg;
 
 #include "debugfs.h"
 #include "blkid/blkid.h"
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-function"
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index fbb7b156..6034b91e 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -383,7 +383,7 @@ pass5.o: $(srcdir)/pass5.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
- $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h $(srcdir)/e2fsck.h \
+ $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/jbd2_user.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -396,7 +396,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
-recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
+recovery.o: $(srcdir)/recovery.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -410,7 +410,7 @@ recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
+revoke.o: $(srcdir)/revoke.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -464,7 +464,7 @@ unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/problem.h $(srcdir)/jfs_user.h \
+ $(srcdir)/problem.h $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
 dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 8ae89bf7..26927cde 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -23,7 +23,7 @@
 #endif
 
 #define E2FSCK_INCLUDE_INLINE_FUNCS
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #include "problem.h"
 #include "uuid/uuid.h"
 
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 8ca35271..7fff6b80 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -11,7 +11,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/revoke.c b/e2fsck/revoke.c
index fa608788..77d269e3 100644
--- a/e2fsck/revoke.c
+++ b/e2fsck/revoke.c
@@ -78,7 +78,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index 853eb296..947e4ffa 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -55,7 +55,7 @@ extern int optind;
 #include "support/devname.h"
 #include "e2fsck.h"
 #include "problem.h"
-#include "jfs_user.h"
+#include "support/jbd2_user.h"
 #include "../version.h"
 
 /* Command line options */
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index 1b6a74b8..4cee31f5 100644
--- a/lib/ext2fs/Makefile.in
+++ b/lib/ext2fs/Makefile.in
@@ -5,10 +5,8 @@ top_builddir = ../..
 my_dir = lib/ext2fs
 INSTALL = @INSTALL@
 MKDIR_P = @MKDIR_P@
-DEPEND_CFLAGS = -I$(top_srcdir)/debugfs -I$(srcdir)/../../e2fsck -DDEBUGFS
-# This nastiness is needed because of jfs_user.h hackery; when we finally
-# clean up this mess, we should be able to drop it
-DEBUGFS_CFLAGS = -I$(srcdir)/../../e2fsck $(ALL_CFLAGS) -DDEBUGFS
+DEPEND_CFLAGS = -I$(top_srcdir)/debugfs -DDEBUGFS
+DEBUGFS_CFLAGS = $(ALL_CFLAGS) -DDEBUGFS
 
 @MCONFIG@
 
@@ -1229,7 +1227,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/debugfs/../version.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
+ $(top_srcdir)/lib/support/jbd2_user.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
  $(top_srcdir)/lib/support/plausible.h
 util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
@@ -1319,7 +1317,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c $(top_builddir)/lib/config.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/jbd2_user.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h $(srcdir)/fast_commit.h
 htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
@@ -1420,13 +1418,13 @@ create_inode.o: $(top_srcdir)/misc/create_inode.c \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/nls-enable.h
 journal.o: $(top_srcdir)/debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/journal.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/ext2_fs.h \
+ $(top_srcdir)/lib/support/jbd2_user.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
-revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/e2fsck/jfs_user.h \
+revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
@@ -1434,7 +1432,7 @@ revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/e2fsck/jfs_user.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h
-recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/e2fsck/jfs_user.h \
+recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
@@ -1454,4 +1452,4 @@ do_journal.o: $(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
- $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
+ $(top_srcdir)/debugfs/journal.h $(top_srcdir)/lib/support/jbd2_user.h
diff --git a/e2fsck/jfs_user.h b/lib/support/jbd2_user.h
similarity index 100%
rename from e2fsck/jfs_user.h
rename to lib/support/jbd2_user.h
diff --git a/misc/Makefile.in b/misc/Makefile.in
index e5420bbd..0c725521 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -124,10 +124,8 @@ DEPLIBS_E2P= $(LIBE2P) $(DEPLIBCOM_ERR)
 
 COMPILE_ET=	_ET_DIR_OVERRIDE=$(srcdir)/../lib/et/et ../lib/et/compile_et
 
-# This nastiness is needed because of jfs_user.h hackery; when we finally
-# clean up this mess, we should be able to drop it
-JOURNAL_CFLAGS = -I$(srcdir)/../e2fsck $(ALL_CFLAGS) -DDEBUGFS
-DEPEND_CFLAGS = -I$(top_srcdir)/e2fsck
+JOURNAL_CFLAGS = -I $(ALL_CFLAGS) -DDEBUGFS
+DEPEND_CFLAGS =
 
 .c.o:
 	$(E) "	CC $<"
@@ -879,7 +877,7 @@ check_fuzzer.o: $(srcdir)/check_fuzzer.c $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_srcdir)/lib/ext2fs/bitops.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
- $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
+ $(top_srcdir)/lib/support/jbd2_user.h $(top_srcdir)/e2fsck/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -892,7 +890,7 @@ journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -906,7 +904,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/support/jbd2_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
-- 
2.25.1

