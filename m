Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9107A589A2E
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Aug 2022 11:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239118AbiHDJ4r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Aug 2022 05:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234442AbiHDJ4o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Aug 2022 05:56:44 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2486A6582E
        for <linux-ext4@vger.kernel.org>; Thu,  4 Aug 2022 02:56:43 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so30090685lfr.2
        for <linux-ext4@vger.kernel.org>; Thu, 04 Aug 2022 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=+n+Iw1fWDKphp4rHpYGpmKmtil8tAuGD+3KrOU9sIb8=;
        b=XUMb6NUeW2F5vjD7350XRxuNb61YSagFvG2fqFBUHNgMZ3y31shT+4l69WrGzZLOSb
         7XQ2wUTLRPd4uCWJsWDl9z5vN1W7SltwsY1RDQpAGqIxcSDDqEelf77htqIpErEy212F
         uZ9+1b/sKZQk/VAWmGl+JvPB0/BPQ/K0dAAuZCndaloVvmIGfq6HWiWgO35VHDPLYHfm
         mB6RogcuX9bdKDAuAtd/Ri8kMiuxkrs5WA/2HTXLVVpf3nlfbxTFDFiyhioBJu1F45Kz
         qWFqa1AqFJsf00UqvGlqPOGdRs/uZWbDLm8/eJmgEghqQsfTdg4KDpr8OYQcr8s4DRXA
         5Q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=+n+Iw1fWDKphp4rHpYGpmKmtil8tAuGD+3KrOU9sIb8=;
        b=pY6InYL0vv6oGyUW5OdTA5tuOgE7Q/usPuDXq6w+1MBZi8Wa9KYEYtaZbDXFXtpUMb
         SVNqmi9QNN4E8YYsmPJa3wZl91oOQdcYfNA7oUOGERM/0V3Z7kzVvACYZ5dyIFBVqp5P
         qELpkG+sMM5twJs6CLLLDXFV6zo/3ax4p8Ll1p4+ulABqSHf3qW7/uKHW3fUB/6IFakl
         WHulZDv9BTg/roEZ4g8b19zyHicDVnACFVf0bJYC7u2ib7BCYJBeLvix6oY+cQu+fejh
         uoxM7PZxXCO10VYVAdKZtdVOYU77zuQ6zgvGA1H5Yw8WHAbRGCNS57rvHtzjPJW+7g+2
         WUtQ==
X-Gm-Message-State: ACgBeo1nHzi0Te6L4ooVIn+usHXUpPGmWm4kLrrnLRul6nMUJQAk1HMh
        0NpkRKK/SHqIXmX+rwmikoNMdWjwUPTQBH1q4+s=
X-Google-Smtp-Source: AA6agR7u7Cd7kmaGcXZI8RAxCBXUWnMYWkQwz0dmdPg98QlSLkgKKs+UAXBgrgxWa5cC3o/QaKZzsQ==
X-Received: by 2002:a05:6512:3404:b0:48a:29b9:f069 with SMTP id i4-20020a056512340400b0048a29b9f069mr467060lfr.296.1659607001474;
        Thu, 04 Aug 2022 02:56:41 -0700 (PDT)
Received: from lustre.shadowland ([46.246.86.69])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25fc8000000b0048b23d08670sm68593lfg.121.2022.08.04.02.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 02:56:40 -0700 (PDT)
From:   Alexey Lyashkov <alexey.lyashkov@gmail.com>
To:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger@dilger.ca>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     Alexey Lyashkov <alexey.lyashkov@gmail.com>
Subject: [PATCH 3/5] kill a ctx->journal_io
Date:   Thu,  4 Aug 2022 12:56:16 +0300
Message-Id: <20220804095618.887684-3-alexey.lyashkov@gmail.com>
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

replace a e2fsck own code, with generic one to use
an fs->journal_io.
---
 debugfs/journal.c      | 34 ---------------------------
 e2fsck/e2fsck.c        |  6 +----
 e2fsck/e2fsck.h        |  1 -
 e2fsck/journal.c       | 53 +++++++-----------------------------------
 lib/support/jfs_user.c | 39 +++++++++++++++++++++++++++++++
 lib/support/jfs_user.h |  2 ++
 6 files changed, 50 insertions(+), 85 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index dac17800..202312fe 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -590,40 +590,6 @@ static errcode_t ext2fs_journal_load(journal_t *journal)
 	return 0;
 }
 
-static void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (fs->flags & EXT2_FLAG_RW) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		ext2fs_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (fs && fs->journal_io) {
-		if (fs->io != fs->journal_io)
-			io_channel_close(fs->journal_io);
-		fs->journal_io = NULL;
-		free(fs->journal_name);
-		fs->journal_name = NULL;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
diff --git a/e2fsck/e2fsck.c b/e2fsck/e2fsck.c
index 1e295e3e..421ef4a9 100644
--- a/e2fsck/e2fsck.c
+++ b/e2fsck/e2fsck.c
@@ -83,11 +83,7 @@ errcode_t e2fsck_reset_context(e2fsck_t ctx)
 		ext2fs_free_icount(ctx->inode_link_info);
 		ctx->inode_link_info = 0;
 	}
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
+
 	if (ctx->fs && ctx->fs->dblist) {
 		ext2fs_free_dblist(ctx->fs->dblist);
 		ctx->fs->dblist = 0;
diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 2db216f5..33334781 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -380,7 +380,6 @@ struct e2fsck_struct {
 	/*
 	 * ext3 journal support
 	 */
-	io_channel	journal_io;
 	char	*journal_name;
 
 	/*
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index 46a9bcb7..682d82a4 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -86,7 +86,7 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	if (kdev->k_dev == K_DEV_FS)
 		bh->b_io = kdev->k_ctx->fs->io;
 	else
-		bh->b_io = kdev->k_ctx->journal_io;
+		bh->b_io = kdev->k_ctx->fs->journal_io;
 	bh->b_size = blocksize;
 	bh->b_blocknr = blocknr;
 
@@ -100,7 +100,7 @@ int sync_blockdev(kdev_t kdev)
 	if (kdev->k_dev == K_DEV_FS)
 		io = kdev->k_ctx->fs->io;
 	else
-		io = kdev->k_ctx->journal_io;
+		io = kdev->k_ctx->fs->journal_io;
 
 	return io_channel_flush(io) ? -EIO : 0;
 }
@@ -156,11 +156,6 @@ void mark_buffer_dirty(struct buffer_head *bh)
 	bh->b_dirty = 1;
 }
 
-static void mark_buffer_clean(struct buffer_head * bh)
-{
-	bh->b_dirty = 0;
-}
-
 void brelse(struct buffer_head *bh)
 {
 	if (bh->b_dirty)
@@ -1011,7 +1006,7 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 		io_ptr = inode_io_manager;
 #else
 		journal->j_inode = j_inode;
-		ctx->journal_io = ctx->fs->io;
+		ctx->fs->journal_io = ctx->fs->io;
 		if ((ret = jbd2_journal_bmap(journal, 0, &start)) != 0) {
 			retval = (errcode_t) (-1 * ret);
 			goto errout;
@@ -1058,12 +1053,12 @@ static errcode_t e2fsck_get_journal(e2fsck_t ctx, journal_t **ret_journal)
 
 
 		retval = io_ptr->open(journal_name, flags,
-				      &ctx->journal_io);
+				      &ctx->fs->journal_io);
 	}
 	if (retval)
 		goto errout;
 
-	io_channel_set_blksize(ctx->journal_io, ctx->fs->blocksize);
+	io_channel_set_blksize(ctx->fs->journal_io, ctx->fs->blocksize);
 
 	if (ext_journal) {
 		blk64_t maxlen;
@@ -1397,38 +1392,6 @@ static errcode_t e2fsck_journal_fix_corrupt_super(e2fsck_t ctx,
 	return 0;
 }
 
-static void e2fsck_journal_release(e2fsck_t ctx, journal_t *journal,
-				   int reset, int drop)
-{
-	journal_superblock_t *jsb;
-
-	if (drop)
-		mark_buffer_clean(journal->j_sb_buffer);
-	else if (!(ctx->options & E2F_OPT_READONLY)) {
-		jsb = journal->j_superblock;
-		jsb->s_sequence = htonl(journal->j_tail_sequence);
-		if (reset)
-			jsb->s_start = 0; /* this marks the journal as empty */
-		ext2fs_journal_sb_csum_set(journal, jsb);
-		mark_buffer_dirty(journal->j_sb_buffer);
-	}
-	brelse(journal->j_sb_buffer);
-
-	if (ctx->journal_io) {
-		if (ctx->fs && ctx->fs->io != ctx->journal_io)
-			io_channel_close(ctx->journal_io);
-		ctx->journal_io = 0;
-	}
-
-#ifndef USE_INODE_IO
-	if (journal->j_inode)
-		ext2fs_free_mem(&journal->j_inode);
-#endif
-	if (journal->j_fs_dev)
-		ext2fs_free_mem(&journal->j_fs_dev);
-	ext2fs_free_mem(&journal);
-}
-
 /*
  * This function makes sure that the superblock fields regarding the
  * journal are consistent.
@@ -1475,7 +1438,7 @@ errcode_t e2fsck_check_ext3_journal(e2fsck_t ctx)
 		    (!fix_problem(ctx, PR_0_JOURNAL_UNSUPP_VERSION, &pctx))))
 			retval = e2fsck_journal_fix_corrupt_super(ctx, journal,
 								  &pctx);
-		e2fsck_journal_release(ctx, journal, 0, 1);
+		ext2fs_journal_release(ctx->fs, journal, 0, 1);
 		return retval;
 	}
 
@@ -1556,7 +1519,7 @@ no_has_journal:
 		mark_buffer_dirty(journal->j_sb_buffer);
 	}
 
-	e2fsck_journal_release(ctx, journal, reset, 0);
+	ext2fs_journal_release(ctx->fs, journal, reset, 0);
 	return retval;
 }
 
@@ -1605,7 +1568,7 @@ errout:
 	jbd2_journal_destroy_revoke(journal);
 	jbd2_journal_destroy_revoke_record_cache();
 	jbd2_journal_destroy_revoke_table_cache();
-	e2fsck_journal_release(ctx, journal, 1, 0);
+	ext2fs_journal_release(ctx->fs, journal, 1, 0);
 	return retval;
 }
 
diff --git a/lib/support/jfs_user.c b/lib/support/jfs_user.c
index 4ff1b5c1..d8a2f842 100644
--- a/lib/support/jfs_user.c
+++ b/lib/support/jfs_user.c
@@ -60,3 +60,42 @@ errcode_t ext2fs_journal_sb_csum_set(journal_t *j,
 	return 0;
 }
 
+
+static void mark_buffer_clean(struct buffer_head * bh)
+{
+	bh->b_dirty = 0;
+}
+
+void ext2fs_journal_release(ext2_filsys fs, journal_t *journal,
+			    int reset, int drop)
+{
+	journal_superblock_t *jsb;
+
+	if (drop)
+		mark_buffer_clean(journal->j_sb_buffer);
+	else if (fs->flags & EXT2_FLAG_RW) {
+		jsb = journal->j_superblock;
+		jsb->s_sequence = htonl(journal->j_tail_sequence);
+		if (reset)
+			jsb->s_start = 0; /* this marks the journal as empty */
+		ext2fs_journal_sb_csum_set(journal, jsb);
+		mark_buffer_dirty(journal->j_sb_buffer);
+	}
+	brelse(journal->j_sb_buffer);
+
+	if (fs && fs->journal_io) {
+		if (fs->io != fs->journal_io)
+			io_channel_close(fs->journal_io);
+		fs->journal_io = NULL;
+		free(fs->journal_name);
+		fs->journal_name = NULL;
+	}
+
+#ifndef USE_INODE_IO
+	if (journal->j_inode)
+		ext2fs_free_mem(&journal->j_inode);
+#endif
+	if (journal->j_fs_dev)
+		ext2fs_free_mem(&journal->j_fs_dev);
+	ext2fs_free_mem(&journal);
+}
diff --git a/lib/support/jfs_user.h b/lib/support/jfs_user.h
index 8bdbf85b..b9c2fa54 100644
--- a/lib/support/jfs_user.h
+++ b/lib/support/jfs_user.h
@@ -217,6 +217,8 @@ int ext2fs_journal_verify_csum_type(journal_t *j, journal_superblock_t *jsb);
 __u32 ext2fs_journal_sb_csum(journal_superblock_t *jsb);
 int ext2fs_journal_sb_csum_verify(journal_t *j, journal_superblock_t *jsb);
 errcode_t ext2fs_journal_sb_csum_set(journal_t *j, journal_superblock_t *jsb);
+void ext2fs_journal_release(ext2_filsys fs, journal_t *journal, int reset,
+			    int drop);
 
 /*
  * Kernel compatibility functions are defined in journal.c
-- 
2.31.1

