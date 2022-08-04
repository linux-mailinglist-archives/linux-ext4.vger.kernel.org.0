Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E5589A2C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiHDJ4n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbiHDJ4l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:56:41 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70126610F
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:56:39 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id z25so30090523lfr.2
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 02:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=De1yl2t1/lIE5cZCKvXdzAXAC9OLthZezqT+11yNBkE=;
        b=A/ep7gx8AhJQShDkIw1qV3e0Z3l3lKMuksTIkG3ARiJs4eiawZn5QV5iRoATakh65E
         l5dbd5MI+fLMQ90KtnOPgQ//tdM/OWKyaBsyzHhcy7MUgkzw6N5HsoQmSnsn3ltL35ly
         nPIm8BHaeYBJEKRD/aGkkJ0VRLsnYmIYOOqCXZj0XT3AT6Jec6ecFhC02e3nZzSyDjix
         5rqf8JXheVjQ/9TYyW04+4HkCrRzg7WWDalHaqvVs7J7AcJkR2txOpHK6q12/quw23Tk
         ykmw640kwmyafnIaMN7e4YFrEg+K0v8YdcEFCkHg8aLHXOITiMDapJ5/xzLt0092twDq
         hHfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=De1yl2t1/lIE5cZCKvXdzAXAC9OLthZezqT+11yNBkE=;
        b=0PXbKM4T2N48xfmOstZ2ifDIm/2F8ZnnYIlxm4eBrEeZbGOiR7JykvNlNymKzKIaFw
         mmm2xDCC17/ZuA9Ap9Wq8WRt0OOxCF+uXIW+OSa5cOKIDetu7rMp3f15wA7risr3c2E+
         ccec8Q9i8wc7eAfULpQxPejSDYxMcEDa2pX4bZkvmHaggUs8FGTLmwkZkmNul25xXS9F
         papkwaBlXXO7QY8Nricgak3x9pUH/xOQiOG5meaFD07n4jqEKuJx+iR4OXC3ufuKe02Q
         iMaI4oPq+4fn2rtC23WZ5V+SZ1BY6iZEO1v8EWzjbhrQvAuElv5bpy7BXJcmnUNyyNbA
         nFiA==
X-Gm-Message-State: ACgBeo3eYxsKyHOECBEA53x+twVZRW4Ta/st6HDe5lffoX6+vW+OFS37
        EQF5LjMxW2XaN3ycjphTFXDx9qFoaOd76Wxgibk=
X-Google-Smtp-Source: AA6agR5lXG+t+HllK0viWJGKtcc+gSU50mVPDZOPx+ZY4fenIV13PcWZ8PPuAx9bFlNgpiM0y0x/xg==
X-Received: by 2002:a05:6512:3d04:b0:48a:f6cf:cf03 with SMTP id d4-20020a0565123d0400b0048af6cfcf03mr436923lfv.539.1659606998183;
        Thu, 04 Aug 2022 02:56:38 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b0048b23d08670sm68593lfg.121.2022.08.04.02.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:56:37 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH 1/5] move a jfs_user.h to better place.
Date:   Thu,  4 Aug 2022 12:56:14 +0300
Message-Id: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jfs_user.h used in the debugfs and e2fsck, so
libsupport is better place for it.
just move a header into new place.
---
 debugfs/Makefile.in                | 16 +++++++---------
 debugfs/debugfs.c                  |  2 +-
 debugfs/journal.h                  |  2 +-
 debugfs/logdump.c                  |  2 +-
 e2fsck/Makefile.in                 |  8 ++++----
 e2fsck/journal.c                   |  2 +-
 e2fsck/recovery.c                  |  2 +-
 e2fsck/revoke.c                    |  2 +-
 e2fsck/unix.c                      |  2 +-
 lib/ext2fs/Makefile.in             | 18 ++++++++----------
 {e2fsck => lib/support}/jfs_user.h |  0
 misc/Makefile.in                   | 12 +++++-------
 12 files changed, 31 insertions(+), 37 deletions(-)
 rename {e2fsck => lib/support}/jfs_user.h (100%)

diff --git a/debugfs/Makefile.in b/debugfs/Makefile.in
index ed4ea8d8..33658eea 100644
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
+ $(top_srcdir)/lib/support/jfs_user.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h $(top_srcdir)/lib/support/plausible.h
 util.o: $(srcdir)/util.c $(top_builddir)/lib/config.h \
@@ -277,7 +275,7 @@ logdump.o: $(srcdir)/logdump.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(srcdir)/../misc/create_inode.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/quotaio.h \
  $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h
@@ -382,7 +380,7 @@ quota.o: $(srcdir)/quota.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/journal.h \
- $(srcdir)/../e2fsck/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
+ $(top_srcdir)/lib/support/jfs_user.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
  $(top_srcdir)/lib/ext2fs/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(top_srcdir)/lib/ext2fs/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
@@ -390,7 +388,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -399,7 +397,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/kernel-jbd.h \
  $(top_srcdir)/lib/ext2fs/jfs_compat.h $(top_srcdir)/lib/ext2fs/kernel-list.h \
  $(top_srcdir)/lib/ext2fs/compiler.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -421,4 +419,4 @@ do_journal.o: $(srcdir)/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/journal.h $(srcdir)/../e2fsck/jfs_user.h
+ $(srcdir)/journal.h $(top_srcdir)/lib/support/jfs_user.h
diff --git a/debugfs/debugfs.c b/debugfs/debugfs.c
index b67a88bc..00b261ac 100644
--- a/debugfs/debugfs.c
+++ b/debugfs/debugfs.c
@@ -37,7 +37,7 @@ extern char *optarg;
 #include <ext2fs/ext2_ext_attr.h>
 
 #include "../version.h"
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #include "support/plausible.h"
 
 #ifndef BUFSIZ
diff --git a/debugfs/journal.h b/debugfs/journal.h
index 10b638eb..4d889834 100644
--- a/debugfs/journal.h
+++ b/debugfs/journal.h
@@ -12,7 +12,7 @@
  * any later version.
  */
 
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 
 /* journal.c */
 errcode_t ext2fs_open_journal(ext2_filsys fs, journal_t **j);
diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index 4154ef2a..f5427d5c 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -32,7 +32,7 @@ extern char *optarg;
 
 #include "debugfs.h"
 #include "blkid/blkid.h"
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #if __GNUC_PREREQ (4, 6)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wunused-function"
diff --git a/e2fsck/Makefile.in b/e2fsck/Makefile.in
index 71ac3cf5..a6e11417 100644
--- a/e2fsck/Makefile.in
+++ b/e2fsck/Makefile.in
@@ -383,7 +383,7 @@ pass5.o: $(srcdir)/pass5.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(srcdir)/problem.h
 journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
- $(top_builddir)/lib/dirpaths.h $(srcdir)/jfs_user.h $(srcdir)/e2fsck.h \
+ $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -396,7 +396,7 @@ journal.o: $(srcdir)/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(srcdir)/problem.h
-recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
+recovery.o: $(srcdir)/recovery.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -410,7 +410,7 @@ recovery.o: $(srcdir)/recovery.c $(srcdir)/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/revoke.c $(srcdir)/jfs_user.h \
+revoke.o: $(srcdir)/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -464,7 +464,7 @@ unix.o: $(srcdir)/unix.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio_tree.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
- $(srcdir)/problem.h $(srcdir)/jfs_user.h \
+ $(srcdir)/problem.h $(top_srcdir)/lib/support/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h $(top_srcdir)/version.h
 dirinfo.o: $(srcdir)/dirinfo.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/e2fsck.h \
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 2e867234..d3002a62 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -23,7 +23,7 @@
 #endif
 
 #define E2FSCK_INCLUDE_INLINE_FUNCS
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #include "problem.h"
 #include "uuid/uuid.h"
 
diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index 8ca35271..c7328cc5 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -11,7 +11,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/revoke.c b/e2fsck/revoke.c
index fa608788..1d5f910b 100644
--- a/e2fsck/revoke.c
+++ b/e2fsck/revoke.c
@@ -78,7 +78,7 @@
  */
 
 #ifndef __KERNEL__
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #else
 #include <linux/time.h>
 #include <linux/fs.h>
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index ae231f93..474dde2d 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -54,7 +54,7 @@ extern int optind;
 #include "support/plausible.h"
 #include "e2fsck.h"
 #include "problem.h"
-#include "jfs_user.h"
+#include "support/jfs_user.h"
 #include "../version.h"
 
 /* Command line options */
diff --git a/lib/ext2fs/Makefile.in b/lib/ext2fs/Makefile.in
index f6a050a2..5fa9693a 100644
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
 
@@ -1231,7 +1229,7 @@ debugfs.o: $(top_srcdir)/debugfs/debugfs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/debugfs/../version.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/kernel-jbd.h \
+ $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
  $(top_srcdir)/lib/support/plausible.h
 util.o: $(top_srcdir)/debugfs/util.c $(top_builddir)/lib/config.h \
@@ -1321,7 +1319,7 @@ logdump.o: $(top_srcdir)/debugfs/logdump.c $(top_builddir)/lib/config.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(top_srcdir)/debugfs/../misc/create_inode.h $(top_srcdir)/lib/e2p/e2p.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
- $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/../../e2fsck/jfs_user.h \
+ $(top_srcdir)/lib/support/quotaio_tree.h $(top_srcdir)/lib/support/jfs_user.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h $(srcdir)/fast_commit.h
 htree.o: $(top_srcdir)/debugfs/htree.c $(top_builddir)/lib/config.h \
@@ -1422,20 +1420,20 @@ create_inode.o: $(top_srcdir)/misc/create_inode.c \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/nls-enable.h
 journal.o: $(top_srcdir)/debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/debugfs/journal.h \
- $(srcdir)/../../e2fsck/jfs_user.h $(srcdir)/ext2_fs.h \
+ $(top_srcdir)/lib/support/jfs_user.h $(srcdir)/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(srcdir)/ext2fs.h \
  $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h $(srcdir)/ext2_io.h \
  $(top_builddir)/lib/ext2fs/ext2_err.h $(srcdir)/ext2_ext_attr.h \
  $(srcdir)/hashmap.h $(srcdir)/bitops.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h
-revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/e2fsck/jfs_user.h \
+revoke.o: $(top_srcdir)/e2fsck/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
  $(srcdir)/ext2_ext_attr.h $(srcdir)/hashmap.h $(srcdir)/bitops.h \
  $(srcdir)/kernel-jbd.h $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h \
  $(srcdir)/compiler.h
-recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/e2fsck/jfs_user.h \
+recovery.o: $(top_srcdir)/e2fsck/recovery.c $(top_srcdir)/lib/support/jfs_user.h \
  $(srcdir)/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(srcdir)/ext2fs.h $(srcdir)/ext3_extents.h $(top_srcdir)/lib/et/com_err.h \
  $(srcdir)/ext2_io.h $(top_builddir)/lib/ext2fs/ext2_err.h \
@@ -1454,4 +1452,4 @@ do_journal.o: $(top_srcdir)/debugfs/do_journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/support/quotaio.h $(top_srcdir)/lib/support/dqblk_v2.h \
  $(top_srcdir)/lib/support/quotaio_tree.h $(srcdir)/kernel-jbd.h \
  $(srcdir)/jfs_compat.h $(srcdir)/kernel-list.h $(srcdir)/compiler.h \
- $(top_srcdir)/debugfs/journal.h $(srcdir)/../../e2fsck/jfs_user.h
+ $(top_srcdir)/debugfs/journal.h $(top_srcdir)/lib/support/jfs_user.h
diff --git a/e2fsck/jfs_user.h b/lib/support/jfs_user.h
similarity index 100%
rename from e2fsck/jfs_user.h
rename to lib/support/jfs_user.h
diff --git a/misc/Makefile.in b/misc/Makefile.in
index 4db59cdf..2d4c8087 100644
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
@@ -878,7 +876,7 @@ check_fuzzer.o: $(srcdir)/check_fuzzer.c $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_srcdir)/lib/ext2fs/bitops.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
- $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
+ $(top_srcdir)/lib/support/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
  $(top_srcdir)/lib/ext2fs/ext2_fs.h $(top_builddir)/lib/ext2fs/ext2_types.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/lib/ext2fs/ext3_extents.h \
  $(top_srcdir)/lib/et/com_err.h $(top_srcdir)/lib/ext2fs/ext2_io.h \
@@ -891,7 +889,7 @@ journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
+revoke.o: $(srcdir)/../e2fsck/revoke.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
@@ -905,7 +903,7 @@ revoke.o: $(srcdir)/../e2fsck/revoke.c $(srcdir)/../e2fsck/jfs_user.h \
  $(top_srcdir)/lib/ext2fs/fast_commit.h $(top_srcdir)/lib/ext2fs/jfs_compat.h \
  $(top_srcdir)/lib/ext2fs/kernel-list.h $(top_srcdir)/lib/ext2fs/compiler.h \
  $(top_srcdir)/lib/ext2fs/kernel-jbd.h
-recovery.o: $(srcdir)/../e2fsck/recovery.c $(srcdir)/../e2fsck/jfs_user.h \
+recovery.o: $(srcdir)/../e2fsck/recovery.c $(top_srcdir)/lib/support/jfs_user.h \
  $(top_builddir)/lib/config.h $(top_builddir)/lib/dirpaths.h \
  $(srcdir)/../e2fsck/e2fsck.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
-- 
2.31.1

