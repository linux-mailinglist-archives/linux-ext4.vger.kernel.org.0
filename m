Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0177A5D20
	for <lists+linux-ext4@lfdr.de>; Tue, 19 Sep 2023 10:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjISI5r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 19 Sep 2023 04:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjISI5o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 19 Sep 2023 04:57:44 -0400
Received: from omta002.cacentral1.a.cloudfilter.net (omta002.cacentral1.a.cloudfilter.net [3.97.99.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFF8122
        for <linux-ext4@vger.kernel.org>; Tue, 19 Sep 2023 01:57:36 -0700 (PDT)
Received: from shw-obgw-4001a.ext.cloudfilter.net ([10.228.9.142])
        by cmsmtp with ESMTP
        id iE0mqXQGp6NwhiWWcqy4L1; Tue, 19 Sep 2023 08:56:06 +0000
Received: from webber.adilger.int ([70.77.221.9])
        by cmsmtp with ESMTP
        id iWWVqDGNWHFsOiWWbqzyz8; Tue, 19 Sep 2023 08:56:06 +0000
X-Authority-Analysis: v=2.4 cv=XZqaca15 c=1 sm=1 tr=0 ts=65096226
 a=2Y6h5+ypAxmHcsumz2f7Og==:117 a=2Y6h5+ypAxmHcsumz2f7Og==:17 a=pGLkceISAAAA:8
 a=RPJ6JBhKAAAA:8 a=dfo8dvEvvyXEL6sKrXEA:9 a=fa_un-3J20JGBB2Tu-mn:22
From:   Andreas Dilger <adilger@dilger.ca>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Alexey Lyashkov <alexey.lyashkov@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>
Subject: [PATCH 2/7] [v2] lib: move journal checksum code to libsupport
Date:   Tue, 19 Sep 2023 02:55:47 -0600
Message-Id: <20230919085552.25262-2-adilger@dilger.ca>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230919085552.25262-1-adilger@dilger.ca>
References: <20230919085552.25262-1-adilger@dilger.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfLC4dHEObSP63h++Qr8g/jaiKR45dYgx/kGo5CWq+EdWvNtPWrpEJdjDrnCRUrSA8KgDGCbc6uAqnFdQbzFUPnaBOlrlw9qHF1jbde3Avfv0RgOUYz+C
 a4097tCs99mC8280UlpirojiPxcff7pvb0VaHo+0BWqMSVbrHPfzVV/LLzVUX9FvcO0gfuwyUxYisiqFhMxjZcPIR0JJDGTTRmFjl0SQ7zEQFHF3JswoSGej
 dq1cs8w9Zf/UgO+tktZ7Q3bel0GCmgXw7EGLnKuaz2wkJrQRTj014f+B9MbRd66d
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Alexey Lyashkov <alexey.lyashkov@gmail.com>

e2fsck and debugfs have their own copy journal checksum
functions, kill duplicates and move into support library.

Signed-off-by: Alexey Lyashkov <alexey.lyashkov@gmail.com>
Reviewed-by: Andreas Dilger <adilger@dilger.ca>
---
 debugfs/journal.c       | 50 ----------------------------------
 e2fsck/journal.c        | 60 ++++-------------------------------------
 lib/support/Android.bp  |  1 +
 lib/support/Makefile.in |  4 +++
 lib/support/jbd2_user.h |  6 +++++
 5 files changed, 16 insertions(+), 105 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index 5bac0d3b..bf199699 100644
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
index 26927cde..bc3c699a 100644
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
@@ -1347,8 +1297,8 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 	    jbd2_has_feature_checksum(journal))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
-	if (!e2fsck_journal_verify_csum_type(journal, jsb) ||
-	    !e2fsck_journal_sb_csum_verify(journal, jsb))
+	if (!ext2fs_journal_verify_csum_type(journal, jsb) ||
+	    !ext2fs_journal_sb_csum_verify(journal, jsb))
 		return EXT2_ET_CORRUPT_JOURNAL_SB;
 
 	if (jbd2_journal_has_csum_v2or3(journal))
@@ -1436,7 +1386,7 @@ static void e2fsck_journal_reset_super(e2fsck_t ctx, journal_superblock_t *jsb,
 	for (i = 0; i < 4; i ++)
 		new_seq ^= u.val[i];
 	jsb->s_sequence = htonl(new_seq);
-	e2fsck_journal_sb_csum_set(journal, jsb);
+	ext2fs_journal_sb_csum_set(journal, jsb);
 
 	mark_buffer_dirty(journal->j_sb_buffer);
 	ll_rw_block(REQ_OP_WRITE, 0, 1, &journal->j_sb_buffer);
@@ -1476,7 +1426,7 @@ static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
 		jsb->s_sequence = htonl(journal->j_tail_sequence);
 		if (reset)
 			jsb->s_start = 0; /* this marks the journal as empty */
-		e2fsck_journal_sb_csum_set(journal, jsb);
+		ext2fs_journal_sb_csum_set(journal, jsb);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 	brelse(journal->j_sb_buffer);
@@ -1619,7 +1569,7 @@ no_has_journal:
 		ctx->fs->super->s_state |= EXT2_ERROR_FS;
 		ext2fs_mark_super_dirty(ctx->fs);
 		journal->j_superblock->s_errno = 0;
-		e2fsck_journal_sb_csum_set(journal, journal->j_superblock);
+		ext2fs_journal_sb_csum_set(journal, journal->j_superblock);
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
diff --git a/lib/support/Android.bp b/lib/support/Android.bp
index af9b28df..260f4b31 100644
--- a/lib/support/Android.bp
+++ b/lib/support/Android.bp
@@ -30,6 +30,7 @@ cc_library {
         "quotaio.c",
         "quotaio_tree.c",
         "quotaio_v2.c",
+        "jbd2_user.c"
     ],
     shared_libs: [
         "libext2fs",
diff --git a/lib/support/Makefile.in b/lib/support/Makefile.in
index b6229091..284fde85 100644
--- a/lib/support/Makefile.in
+++ b/lib/support/Makefile.in
@@ -14,6 +14,7 @@ MKDIR_P = @MKDIR_P@
 all::
 
 OBJS=		cstring.o \
+		jbd2_user.o \
 		mkquota.o \
 		plausible.o \
 		profile.o \
@@ -29,6 +30,7 @@ OBJS=		cstring.o \
 
 SRCS=		$(srcdir)/argv_parse.c \
 		$(srcdir)/cstring.c \
+		$(srcdir)/jbd2_user.c \
 		$(srcdir)/mkquota.c \
 		$(srcdir)/parse_qtype.c \
 		$(srcdir)/plausible.c \
@@ -110,6 +112,8 @@ argv_parse.o: $(srcdir)/argv_parse.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/argv_parse.h
 cstring.o: $(srcdir)/cstring.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/cstring.h
+jbd2_user.o: $(srcdir)/jbd2_user.c $(top_builddir)/lib/config.h \
+ $(srcdir)/jbd2_user.h
 mkquota.o: $(srcdir)/mkquota.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/lib/support/jbd2_user.h b/lib/support/jbd2_user.h
index 5928a8a8..22f8cb7e 100644
--- a/lib/support/jbd2_user.h
+++ b/lib/support/jbd2_user.h
@@ -251,6 +251,12 @@ _INLINE_ void jbd2_descriptor_block_csum_set(journal_t *j,
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
2.25.1

