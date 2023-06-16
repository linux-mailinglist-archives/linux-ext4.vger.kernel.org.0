Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 131E57336A2
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345772AbjFPQwQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344192AbjFPQvX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:23 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4083D3AB6
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B60201F8D7;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bUnbunwCGijXqe0VRSM9RTLCmM3q7K2J14avJSKTUo=;
        b=NukdnnuKxkYLewGAElwvYfTKRqoV4gatG9BDGD4w0dV/RdOliJJ+SvPIOl4xO2EJxW4dCw
        AscDMSYLpus3xqNGTe8i9D92ElzsF/FZMGC2W54zNRe+2clQDt0LzHm8k+ROF6BVJEK+Sn
        skRwh9SWZAjaDvKKi3x5WKQpCyzIINA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bUnbunwCGijXqe0VRSM9RTLCmM3q7K2J14avJSKTUo=;
        b=ga4DL8Ht6AOiMJZH1sKNKdKTs5dBTTnndkfQDYR+et650klgR0o4fw14w6HZQ37q51IJvL
        PfszvWDEALXRkrDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A6FCD1391E;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id G8zGKP6SjGQ/IwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 86F59A0764; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 05/11] ext4: Drop EXT4_MF_FS_ABORTED flag
Date:   Fri, 16 Jun 2023 18:50:51 +0200
Message-Id: <20230616165109.21695-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5352; i=jack@suse.cz; h=from:subject; bh=BqkH9H98A5x9i/yAzxim0Rw2hDEOSo546fQGnUWRtqI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLrQPCp1fg0FNKNIdO0hZ6WWG75z6lCtPTMszsv V4W9DzmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS6wAKCRCcnaoHP2RA2bJrB/ 9BJfGAG7qIdAPEdpWK2tm/pTdBrjmErFT1t/LtGAo16+Lh5440FugrW1wrGEsf+uEixqnLvTtvbO/A fgEagmLXe0Sv20BtB/tBfwKs1bTopXn1OyrY385A77/aNwLidzopWFkFWD2+CXnFIBo6p2R9iBSK18 2CgZZUi68mtZAlVpjqjiAc7ywcG5/LDjHGJY7DDxkfxzPIWvJW3wpYrJfxl+j8VcO9+oCBprYP2oI4 wjcMPl8Qej5RCHYzWiipH8Efsk4c4ur4r4NbsQe4ACScYRC9GJjYmL0AkFS76HmxnKH2V3dTk5dje0 OxPNrYP8VkLT3oG4/djf1+Cn8KqyDK
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

EXT4_MF_FS_ABORTED flag has practically the same intent as
EXT4_FLAGS_SHUTDOWN flag. The shutdown flag is checked in many more
places than the aborted flag which is mostly the historical artifact
where we were relying on SB_RDONLY checks instead of the aborted flag
checks. There are only three places - ext4_sync_file(),
__ext4_remount(), and mballoc debug code - which check aborted flag and
not shutdown flag and this is arguably a bug. Avoid these
inconsistencies by removing EXT4_MF_FS_ABORTED flag and using
EXT4_FLAGS_SHUTDOWN everywhere.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 1 -
 fs/ext4/fsync.c   | 7 +++----
 fs/ext4/inode.c   | 8 +++-----
 fs/ext4/mballoc.c | 4 ++--
 fs/ext4/super.c   | 4 ++--
 5 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index ae0c3a148c7b..46d359f5615d 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1740,7 +1740,6 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
  */
 enum {
 	EXT4_MF_MNTDIR_SAMPLED,
-	EXT4_MF_FS_ABORTED,	/* Fatal error detected */
 	EXT4_MF_FC_INELIGIBLE	/* Fast commit ineligible */
 };
 
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 958bcaedcff6..b8e15b9f86c8 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -138,7 +138,6 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	int ret = 0, err;
 	bool needs_barrier = false;
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
 	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
@@ -148,9 +147,9 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	trace_ext4_sync_file_enter(file, datasync);
 
 	if (sb_rdonly(inode->i_sb)) {
-		/* Make sure that we read updated s_mount_flags value */
+		/* Make sure that we read updated s_ext4_flags value */
 		smp_rmb();
-		if (ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))
+		if (ext4_forced_shutdown(inode->i_sb))
 			ret = -EROFS;
 		goto out;
 	}
@@ -164,7 +163,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  Metadata is in the journal, we wait for proper transaction to
 	 *  commit here.
 	 */
-	if (!sbi->s_journal)
+	if (!EXT4_SB(inode->i_sb)->s_journal)
 		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
 	else
 		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index da3aaaea5f1c..fc6abafcc3fc 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2237,8 +2237,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		if (err < 0) {
 			struct super_block *sb = inode->i_sb;
 
-			if (ext4_forced_shutdown(sb) ||
-			    ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
+			if (ext4_forced_shutdown(sb))
 				goto invalidate_dirty_pages;
 			/*
 			 * Let the uper layers retry transient errors.
@@ -2560,14 +2559,13 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	 * If the filesystem has aborted, it is read-only, so return
 	 * right away instead of dumping stack traces later on that
 	 * will obscure the real source of the problem.  We test
-	 * EXT4_MF_FS_ABORTED instead of sb->s_flag's SB_RDONLY because
+	 * fs shutdown state instead of sb->s_flag's SB_RDONLY because
 	 * the latter could be true if the filesystem is mounted
 	 * read-only, and in that case, ext4_writepages should
 	 * *never* be called, so if that ever happens, we would want
 	 * the stack trace.
 	 */
-	if (unlikely(ext4_forced_shutdown(mapping->host->i_sb) ||
-		     ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))) {
+	if (unlikely(ext4_forced_shutdown(mapping->host->i_sb))) {
 		ret = -EROFS;
 		goto out_writepages;
 	}
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 20f67a260df5..5bcccf6908ea 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5341,7 +5341,7 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 {
 	ext4_group_t i, ngroups;
 
-	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
+	if (ext4_forced_shutdown(sb))
 		return;
 
 	ngroups = ext4_get_groups_count(sb);
@@ -5375,7 +5375,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
 
-	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
+	if (ext4_forced_shutdown(sb))
 		return;
 
 	mb_debug(sb, "Can't allocate:"
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index d57b135c8e54..f883f3fce066 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -657,7 +657,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 		WARN_ON_ONCE(1);
 
 	if (!continue_fs && !sb_rdonly(sb)) {
-		ext4_set_mount_flag(sb, EXT4_MF_FS_ABORTED);
+		set_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
 		if (journal)
 			jbd2_journal_abort(journal, -EIO);
 	}
@@ -6465,7 +6465,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	flush_work(&sbi->s_error_work);
 
 	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
-		if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED)) {
+		if (ext4_forced_shutdown(sb)) {
 			err = -EROFS;
 			goto restore_opts;
 		}
-- 
2.35.3

