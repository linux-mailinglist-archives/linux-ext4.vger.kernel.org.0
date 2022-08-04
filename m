Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06185589A2D
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHDJ4n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231982AbiHDJ4n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:56:43 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8176166110
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:56:41 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id u1so19799656lfq.4
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 02:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pZ1zLAA0a+bfGH02IQILCmxXHSMxiazto2Ln07vr/eo=;
        b=bixotYi9GpbAv0e6U3W9NoBRr8t0PP8JA7Eh1rtjjun33ErkHcAGQtm4M6fjIvQael
         KwO//dZpcSD9L7GJnwXJyeOV9s80Qd5dpxxPGP5EpHfBIVye8LLPH+DGM64u+cQGXYAa
         xdYiJhVB/L0je8iRulKc29RCJ0f+MT6OBIrdxuXRicEJHpA62GdFrq5Svy/Y79ean9za
         lnLuXE0WYlGm67wsk9nIrtkG6uUd34X22m4Se6gOVFwjLGcI6C2qcj/Lp6PxLeu+hb2a
         CEziObEMvvNQOETtvM+GzRP0T5jrrjKS7hpfeBk45eTUgfZSMSRs7iDk+AHT6SSm2Ae9
         FXCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pZ1zLAA0a+bfGH02IQILCmxXHSMxiazto2Ln07vr/eo=;
        b=sb6S15uXCrVyRbM5Rx4cH9/do+tzB/+4rGyfl8jWT/vUZyUKnwvSh+3wZSI5ng4nxr
         9bOZqNxajsTPDuqdHo//tcAdxZj+0zmL4zYBSsCj3uVbJjKubp/EbJuU/eCXQabKAgi4
         ZEhrLd1AfWMA69+HO+InydN3bmB6qGa6W+0OrN7ZB7cmhKEwSp4GNwohT1pydIgbLp9W
         eIap58RXzqLTlNnxf1BMEG+w7W4wlk8JVdjhqWpPNJxAhAFsv0ssn/txWAB71OqMeO/+
         kdW0QBYbiGGby6EG3SbUjE2+zKW0OQaIUoq5mpnlZpgK5MWeMyWaRG0+zkvnzDeIExoE
         xoFQ==
X-Gm-Message-State: ACgBeo1gMJgtxoDZuXYXWceRCnYZ5XR3c7GuibNboeA05vXR9wNPbKdD
        RRauFSJoyj8ZLRxrQ1RPeyvb/hqlvCqAwKD63AI=
X-Google-Smtp-Source: AA6agR7SYo8zeAeiDWMRbKKbFpfndEX4+XwElpHtrVcft2FxZP9oktwjngUnivMZhY46Y8iyFPFBCA==
X-Received: by 2002:a19:6510:0:b0:47f:baaf:e3be with SMTP id z16-20020a196510000000b0047fbaafe3bemr459372lfb.139.1659606999813;
        Thu, 04 Aug 2022 02:56:39 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b0048b23d08670sm68593lfg.121.2022.08.04.02.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:56:39 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH 2/5] move a journal checksum code into common place
Date:   Thu,  4 Aug 2022 12:56:15 +0300
Message-Id: <20220804095618.887684-2-alexey.lyashkov@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
References: <20220804095618.887684-1-alexey.lyashkov@gmail.com>
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

e2fsck and debugfs have own copy a journal checksum functions,
kill duplicates and move into support library.
---
 debugfs/journal.c       | 50 ---------------------------------
 e2fsck/journal.c        | 60 ++++-----------------------------------
 lib/support/Android.bp  |  1 +
 lib/support/Makefile.in |  7 +++--
 lib/support/jfs_user.c  | 62 +++++++++++++++++++++++++++++++++++++++++
 lib/support/jfs_user.h  |  6 ++++
 6 files changed, 79 insertions(+), 107 deletions(-)
 create mode 100644 lib/support/jfs_user.c

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 095fff00..dac17800 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -43,56 +43,6 @@ static int bh_count = 0;
  */
 #undef USE_INODE_IO
 
-/* Checksumming functions */
-static int ext2fs_journal_verify_csum_type(journal_t *j,
-					   journal_superblock_t *jsb)
-{
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
-}
-
-static __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
-{
-	__u32 crc, old_crc;
-
-	old_crc = jsb->s_checksum;
-	jsb->s_checksum = 0;
-	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
-			       sizeof(journal_superblock_t));
-	jsb->s_checksum = old_crc;
-
-	return crc;
-}
-
-static int ext2fs_journal_sb_csum_verify(journal_t *j,
-					 journal_superblock_t *jsb)
-{
-	__u32 provided, calculated;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
-	calculated = ext2fs_journal_sb_csum(jsb);
-
-	return provided == calculated;
-}
-
-static errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
-					    journal_superblock_t *jsb)
-{
-	__u32 crc;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 0;
-
-	crc = ext2fs_journal_sb_csum(jsb);
-	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
-	return 0;
-}
-
 /* Kernel compatibility functions for handling the journal.  These allow us
  * to use the recovery.c file virtually unchanged from the kernel, so we
  * don't have to do much to keep kernel and user recovery in sync.
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index d3002a62..46a9bcb7 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -38,56 +38,6 @@ static int bh_count = 0;
  */
 #undef USE_INODE_IO
 
-/* Checksumming functions */
-static int e2fsck_journal_verify_csum_type(journal_t *j,
-					   journal_superblock_t *jsb)
-{
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
-}
-
-static __u32 e2fsck_journal_sb_csum(journal_superblock_t *jsb)
-{
-	__u32 crc, old_crc;
-
-	old_crc = jsb->s_checksum;
-	jsb->s_checksum = 0;
-	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
-			       sizeof(journal_superblock_t));
-	jsb->s_checksum = old_crc;
-
-	return crc;
-}
-
-static int e2fsck_journal_sb_csum_verify(journal_t *j,
-					 journal_superblock_t *jsb)
-{
-	__u32 provided, calculated;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 1;
-
-	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
-	calculated = e2fsck_journal_sb_csum(jsb);
-
-	return provided == calculated;
-}
-
-static errcode_t e2fsck_journal_sb_csum_set(journal_t *j,
-					    journal_superblock_t *jsb)
-{
-	__u32 crc;
-
-	if (!jbd2_journal_has_csum_v2or3(j))
-		return 0;
-
-	crc = e2fsck_journal_sb_csum(jsb);
-	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
-	return 0;
-}
-
 /* Kernel compatibility functions for handling the journal.  These allow us
  * to use the recovery.c file virtually unchanged from the kernel, so we
  * don't have to do much to keep kernel and user recovery in sync.
@@ -1330,8 +1280,8 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	    jbd2_has_feature_checksum(journal))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
-	if (!e2fsck_journal_verify_csum_type(journal, jsb) ||
-	    !e2fsck_journal_sb_csum_verify(journal, jsb))
+	if (!ext2fs_journal_verify_csum_type(journal, jsb) ||
+	    !ext2fs_journal_sb_csum_verify(journal, jsb))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
 	if (jbd2_journal_has_csum_v2or3(journal))
@@ -1419,7 +1369,7 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	for (i = 0; i < 4; i ++)
 		new_seq ^= u.val[i];
 	jsb->s_sequence = htonl(new_seq);
-	e2fsck_journal_sb_csum_set(journal, jsb);
+	ext2fs_journal_sb_csum_set(journal, jsb);
 
 	mark_buffer_dirty(journal->j_sb_buffer);
 	ll_rw_block(REQ_OP_WRITE, 0, 1, &journal->j_sb_buffer);
@@ -1459,7 +1409,7 @@ static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
 		jsb->s_sequence = htonl(journal->j_tail_sequence);
 		if (reset)
 			jsb->s_start = 0; /* this marks the journal as empty */
-		e2fsck_journal_sb_csum_set(journal, jsb);
+		ext2fs_journal_sb_csum_set(journal, jsb);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 	brelse(journal->j_sb_buffer);
@@ -1602,7 +1552,7 @@ no_has_journal:
 		ctx->fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(ctx->fs);
 		journal->j_superblock->s_errno = 0;
-		e2fsck_journal_sb_csum_set(journal, journal->j_superblock);
+		ext2fs_journal_sb_csum_set(journal, journal->j_superblock);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
diff --git a/lib/support/Android.bp b/lib/support/Android.bp
index a0b064dd..efa0f955 100644
--- a/lib/support/Android.bp
+++ b/lib/support/Android.bp
@@ -29,6 +29,7 @@ cc_library {
         "quotaio.c",
         "quotaio_tree.c",
         "quotaio_v2.c",
+        "jfs_user.c"
     ],
     shared_libs: [
         "libext2fs",
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index f3c7981e..04fbcf31 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -23,7 +23,8 @@ OBJS=		cstring.o \
 		quotaio.o \
 		quotaio_v2.o \
 		quotaio_tree.o \
-		dict.o
+		dict.o \
+		jfs_user.o
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
@@ -36,7 +37,9 @@ SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/quotaio.c \
 		$(srcdir)/quotaio_tree.c \
 		$(srcdir)/quotaio_v2.c \
-		$(srcdir)/dict.c
+		$(srcdir)/dict.c \
+		$(srcdir)/jfs_user.c
+		
 
 LIBRARY= libsupport
 LIBDIR= support
diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
new file mode 100644
index 00000000..4ff1b5c1
--- /dev/null
+++ b/lib/support/jfs_user.c
@@ -0,0 +1,62 @@
+#define DEBUGFS
+#include "jfs_user.h"
+
+/*
+ * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
+ * This creates a larger static binary, and a smaller binary using
+ * shared libraries.  It's also probably slightly less CPU-efficient,
+ * which is why it's not on by default.  But, it's a good way of
+ * testing the functions in inode_io.c and fileio.c.
+ */
+#undef USE_INODE_IO
+
+/* Checksumming functions */
+int ext2fs_journal_verify_csum_type(journal_t *j,
+				    journal_superblock_t *jsb)
+{
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 1;
+
+	return jsb->s_checksum_type == JBD2_CRC32C_CHKSUM;
+}
+
+__u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb)
+{
+	__u32 crc, old_crc;
+
+	old_crc = jsb->s_checksum;
+	jsb->s_checksum = 0;
+	crc = ext2fs_crc32c_le(~0, (unsigned char *)jsb,
+			       sizeof(journal_superblock_t));
+	jsb->s_checksum = old_crc;
+
+	return crc;
+}
+
+int ext2fs_journal_sb_csum_verify(journal_t *j,
+				  journal_superblock_t *jsb)
+{
+	__u32 provided, calculated;
+
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 1;
+
+	provided = ext2fs_be32_to_cpu(jsb->s_checksum);
+	calculated = ext2fs_journal_sb_csum(jsb);
+
+	return provided == calculated;
+}
+
+errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
+				     journal_superblock_t *jsb)
+{
+	__u32 crc;
+
+	if (!jbd2_journal_has_csum_v2or3(j))
+		return 0;
+
+	crc = ext2fs_journal_sb_csum(jsb);
+	jsb->s_checksum = ext2fs_cpu_to_be32(crc);
+	return 0;
+}
+
diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
index 4ad2005a..8bdbf85b 100644
--- a/lib/support/jfs_user.h
+++ b/lib/support/jfs_user.h
@@ -212,6 +212,12 @@ _INLINE_ void jbd2_descriptor_block_csum_set(journal_t *j,
 #undef _INLINE_
 #endif
 
+/* Checksumming functions */
+int ext2fs_journal_verify_csum_type(journal_t *j, journal_superblock_t *jsb);
+__u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb);
+int ext2fs_journal_sb_csum_verify(journal_t *j, journal_superblock_t *jsb);
+errcode_t ext2fs_journal_sb_csum_set(journal_t *j, journal_superblock_t *jsb);
+
 /*
  * Kernel compatibility functions are defined in journal.c
  */
-- 
2.31.1

