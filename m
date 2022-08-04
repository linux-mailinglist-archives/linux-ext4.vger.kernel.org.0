Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E54589A2F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234442AbiHDJ4v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238750AbiHDJ4q (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:56:46 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0A366110
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:56:44 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a13so21542453ljr.11
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 02:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=vi5L4O5skaXLe2HqWpop5nIZlhV/xJ3RUm8ZFn0JSf0=;
        b=A0dFAt66YJWHLwobML0AtQqsFtbzr9ttcfKd5snkZifLs+M8VDZvWshGv8dpAxZHMI
         qU5qgCtZeyOKqGiCe9JsM3sAl0+bq6aTPcuby5i0ifBXhoUT8smqAqgqyR1yJHmUfpQ2
         BLwcP/IPg5AalA2TjdC7022ml8GjQkbaWjYMdEVj/QwWFvU3LVoNq5OBz4oYvpxjzu0J
         XUQTi09nO/FiXKpV+Au/qroMnAUkRwVLddh0r323zcjU+RvIJYQkeqaKu50sz+K27olK
         GBmVyFTA2PrZ4MFEhVbMVLU/savbTIaUD9cP1HWm0Q8ba+dBdbx903MXv7HlA7IyJZuZ
         CHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=vi5L4O5skaXLe2HqWpop5nIZlhV/xJ3RUm8ZFn0JSf0=;
        b=KS1eVe7dwvGuYXUGPcjvJpdhJZAhUggrE1liQKeRhCpakRGuEZ0u/qEBytbSsgWrWh
         FZNLupzeVYNq5Hw9qAsXV7aVQ09Ajs8RI8qwNnOJ22ZD+OVxghfqBJn4xZ68NETsrhYx
         AHdPuzK5oQVmr7liMMZtKbvmVIGSP34I6fZHLx2z7ROAyD8HCg+cBDDoakKZ2TjndZDM
         otqGAXdXJ5IwqMwbo8ERCWOwTOcmgWpfDrMIRdhBKMjhIO8MhKaZgjidlL9rbigHgHhR
         XOHU3GMdikeXnKW1GWlAdsr2H1YwPqCD0DCcY8OIorVidxVYZQlVGDx80zs4L/dte6Br
         TAbA==
X-Gm-Message-State: ACgBeo3qdaVkFXcm/rRP/N/wv20TXyh8gu8LnYRinr7Yv3jeR/AmXabH
        /Ok4u3AMjJ6icIkV5JVWeZ6K1LKn4ljCBG+BqdA=
X-Google-Smtp-Source: AA6agR584YXf6aHER0jVdBRCYWBBn1RDz9vHfEKfSVOp9TsDWYb8FT9sJUyZeZahYLa1v8Wfk8XZ+A==
X-Received: by 2002:a2e:a801:0:b0:25e:2d02:9d66 with SMTP id l1-20020a2ea801000000b0025e2d029d66mr351032ljq.296.1659607003067;
        Thu, 04 Aug 2022 02:56:43 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b0048b23d08670sm68593lfg.121.2022.08.04.02.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:56:42 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH 4/5] remove an e2fsck context from bh emulation code.
Date:   Thu,  4 Aug 2022 12:56:17 +0300
Message-Id: <20220804095618.887684-4-alexey.lyashkov@gmail.com>
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

In order to generalize a journal handing, remove a e2fsck context
from generic structures like buffer_head, and device.
But fast commit code want a e2fsck context as well, so move it pointer
to journal struct.
---
 e2fsck/journal.c        | 46 ++++++++++++++++++++---------------------
 lib/ext2fs/jfs_compat.h |  2 ++
 lib/support/jfs_user.h  | 12 -----------
 3 files changed, 25 insertions(+), 35 deletions(-)

diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 682d82a4..728f5a24 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -58,7 +58,7 @@ int jbd2_journal_bmap(journal_t *journal, unsigned long block,
 		return 0;
 	}
 
-	retval= ext2fs_bmap2(inode->i_ctx->fs, inode->i_ino,
+	retval= ext2fs_bmap2(inode->i_fs, inode->i_ino,
 			     &inode->i_ext2, NULL, 0, (blk64_t) block,
 			     0, &pblk);
 	*phys = pblk;
@@ -70,11 +70,12 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 			   int blocksize)
 {
 	struct buffer_head *bh;
-	int bufsize = sizeof(*bh) + kdev->k_ctx->fs->blocksize -
+	int bufsize = sizeof(*bh) + kdev->k_fs->blocksize -
 		sizeof(bh->b_data);
+	errcode_t retval;
 
-	bh = e2fsck_allocate_memory(kdev->k_ctx, bufsize, "block buffer");
-	if (!bh)
+	retval = ext2fs_get_memzero(bufsize, &bh);
+	if (retval)
 		return NULL;
 
 	if (journal_enable_debug >= 3)
@@ -82,11 +83,11 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
 		  blocknr, blocksize, bh_count);
 
-	bh->b_ctx = kdev->k_ctx;
+	bh->b_fs = kdev->k_fs;
 	if (kdev->k_dev == K_DEV_FS)
-		bh->b_io = kdev->k_ctx->fs->io;
+		bh->b_io = kdev->k_fs->io;
 	else
-		bh->b_io = kdev->k_ctx->fs->journal_io;
+		bh->b_io = kdev->k_fs->journal_io;
 	bh->b_size = blocksize;
 	bh->b_blocknr = blocknr;
 
@@ -98,9 +99,9 @@ int sync_blockdev(kdev_t kdev)
 	io_channel	io;
 
 	if (kdev->k_dev == K_DEV_FS)
-		io = kdev->k_ctx->fs->io;
+		io = kdev->k_fs->io;
 	else
-		io = kdev->k_ctx->fs->journal_io;
+		io = kdev->k_fs->journal_io;
 
 	return io_channel_flush(io) ? -EIO : 0;
 }
@@ -120,7 +121,7 @@ void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
 						     bh->b_blocknr,
 						     1, bh->b_data);
 			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
+				com_err(bh->b_fs->device_name, retval,
 					"while reading block %llu\n",
 					bh->b_blocknr);
 				bh->b_err = (int) retval;
@@ -135,7 +136,7 @@ void ll_rw_block(int rw, int op_flags EXT2FS_ATTR((unused)), int nr,
 						      bh->b_blocknr,
 						      1, bh->b_data);
 			if (retval) {
-				com_err(bh->b_ctx->device_name, retval,
+				com_err(bh->b_fs->device_name, retval,
 					"while writing block %llu\n",
 					bh->b_blocknr);
 				bh->b_err = (int) retval;
@@ -223,7 +224,7 @@ static int process_journal_block(ext2_filsys fs,
 static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
 				int off, tid_t expected_tid)
 {
-	e2fsck_t ctx = j->j_fs_dev->k_ctx;
+	e2fsck_t ctx = j->j_ctx;
 	struct e2fsck_fc_replay_state *state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_add_range ext;
@@ -796,7 +797,7 @@ static int ext4_fc_handle_del_range(e2fsck_t ctx, __u8 *val)
 static int ext4_fc_replay(journal_t *journal, struct buffer_head *bh,
 				enum passtype pass, int off, tid_t expected_tid)
 {
-	e2fsck_t ctx = journal->j_fs_dev->k_ctx;
+	e2fsck_t ctx = journal->j_ctx;
 	struct e2fsck_fc_replay_state *state = &ctx->fc_replay_state;
 	int ret = JBD2_FC_REPLAY_CONTINUE;
 	struct ext4_fc_tl tl;
@@ -924,10 +925,11 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 	}
 	dev_journal = dev_fs+1;
 
-	dev_fs->k_ctx = dev_journal->k_ctx = ctx;
+	dev_fs->k_fs = dev_journal->k_fs = ctx->fs;
 	dev_fs->k_dev = K_DEV_FS;
 	dev_journal->k_dev = K_DEV_JOURNAL;
 
+	journal->j_ctx = ctx;
 	journal->j_dev = dev_journal;
 	journal->j_fs_dev = dev_fs;
 	journal->j_inode = NULL;
@@ -945,7 +947,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 			goto errout;
 		}
 
-		j_inode->i_ctx = ctx;
+		j_inode->i_fs = ctx->fs;
 		j_inode->i_ino = sb->s_journal_inum;
 
 		if ((retval = ext2fs_read_inode(ctx->fs,
@@ -1186,9 +1188,8 @@ static errcode_t e2fsck_journal_fix_bad_inode(e2fsck_t ctx,
 }
 
 #define V1_SB_SIZE	0x0024
-static void clear_v2_journal_fields(journal_t *journal)
+static void clear_v2_journal_fields(e2fsck_t ctx, journal_t *journal)
 {
-	e2fsck_t ctx = journal->j_dev->k_ctx;
 	struct problem_context pctx;
 
 	clear_problem_context(&pctx);
@@ -1203,9 +1204,8 @@ static void clear_v2_journal_fields(journal_t *journal)
 }
 
 
-static errcode_t e2fsck_journal_load(journal_t *journal)
+static errcode_t e2fsck_journal_load(e2fsck_t ctx, journal_t *journal)
 {
-	e2fsck_t ctx = journal->j_dev->k_ctx;
 	journal_superblock_t *jsb;
 	struct buffer_head *jbh = journal->j_sb_buffer;
 	struct problem_context pctx;
@@ -1231,14 +1231,14 @@ static errcode_t e2fsck_journal_load(journal_t *journal)
 		    jsb->s_feature_incompat ||
 		    jsb->s_feature_ro_compat ||
 		    jsb->s_nr_users)
-			clear_v2_journal_fields(journal);
+			clear_v2_journal_fields(ctx, journal);
 		break;
 
 	case JBD2_SUPERBLOCK_V2:
 		journal->j_format_version = 2;
 		if (ntohl(jsb->s_nr_users) > 1 &&
 		    uuid_is_null(ctx->fs->super->s_journal_uuid))
-			clear_v2_journal_fields(journal);
+			clear_v2_journal_fields(ctx, journal);
 		if (ntohl(jsb->s_nr_users) > 1) {
 			fix_problem(ctx, PR_0_JOURNAL_UNSUPP_MULTIFS, &pctx);
 			return EXT2_ET_JOURNAL_UNSUPP_VERSION;
@@ -1425,7 +1425,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		return retval;
 	}
 
-	retval = e2fsck_journal_load(journal);
+	retval = e2fsck_journal_load(ctx, journal);
 	if (retval) {
 		if ((retval == EXT2_ET_CORRUPT_JOURNAL_SB) ||
 		    ((retval == EXT2_ET_UNSUPP_FEATURE) &&
@@ -1543,7 +1543,7 @@ static errcode_t recover_ext3_journal(e2fsck_t ctx)
 	if (retval)
 		return retval;
 
-	retval = e2fsck_journal_load(journal);
+	retval = e2fsck_journal_load(ctx, journal);
 	if (retval)
 		goto errout;
 
diff --git a/lib/ext2fs/jfs_compat.h b/lib/ext2fs/jfs_compat.h
index e11cf494..bfafae12 100644
--- a/lib/ext2fs/jfs_compat.h
+++ b/lib/ext2fs/jfs_compat.h
@@ -41,6 +41,7 @@ typedef struct kdev_s *kdev_t;
 
 struct buffer_head;
 struct inode;
+struct e2fsck_struct;
 
 typedef unsigned int gfp_t;
 #define GFP_KERNEL	0
@@ -98,6 +99,7 @@ struct journal_s
 	struct jbd2_revoke_table_s *j_revoke_table[2];
 	tid_t			j_failed_commit;
 	__u32			j_csum_seed;
+	struct e2fsck_struct *	j_ctx;
 	int (*j_fc_replay_callback)(struct journal_s *journal,
 				    struct buffer_head *bh,
 				    enum passtype pass, int off,
diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
index b9c2fa54..bb392811 100644
--- a/lib/support/jfs_user.h
+++ b/lib/support/jfs_user.h
@@ -40,11 +40,7 @@
 #endif
 
 struct buffer_head {
-#ifdef DEBUGFS
 	ext2_filsys	b_fs;
-#else
-	e2fsck_t	b_ctx;
-#endif
 	io_channel	b_io;
 	int		b_size;
 	int		b_err;
@@ -55,21 +51,13 @@ struct buffer_head {
 };
 
 struct inode {
-#ifdef DEBUGFS
 	ext2_filsys	i_fs;
-#else
-	e2fsck_t	i_ctx;
-#endif
 	ext2_ino_t	i_ino;
 	struct ext2_inode i_ext2;
 };
 
 struct kdev_s {
-#ifdef DEBUGFS
 	ext2_filsys	k_fs;
-#else
-	e2fsck_t	k_ctx;
-#endif
 	int		k_dev;
 };
 
-- 
2.31.1

