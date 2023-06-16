Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7C77336A3
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Jun 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjFPQwS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 16 Jun 2023 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345822AbjFPQvZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 16 Jun 2023 12:51:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFCC3AAE
        for <linux-ext4@vger.kernel.org>; Fri, 16 Jun 2023 09:51:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 53AD51F8D5;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686934270; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv38hIiui9R2M+axjGOZQcJ7Wc6VZk62M7wqM+8lDxM=;
        b=gzJjWPDb4PqeyYTzzS2amQaANSuwuvvbR9LIlC8YXGyaUkHycnwjEXbwuGIX/R5LX+MRJ/
        ZsVR+cdGxjcy6Sng2WRGhe21T5f4WOPv3rXUqc9diLiA02akpDwpKJqw+LE8oWYBrane/x
        AFHfvfX0tQMpkO0weKmCJDVYEo14YZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686934270;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dv38hIiui9R2M+axjGOZQcJ7Wc6VZk62M7wqM+8lDxM=;
        b=AZ0g322+RH5W1QTBuDbxIDH7nmAJXK4zHg+wjBeQLo/zvC8LKRcIzo9Sd5qXRye7fB2WST
        jMaz7DU3R5JzuJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C1F71391E;
        Fri, 16 Jun 2023 16:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IBnOCf6SjGQtIwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Jun 2023 16:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7C856A0762; Fri, 16 Jun 2023 18:51:09 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/11] ext4: Make ext4_forced_shutdown() take struct super_block
Date:   Fri, 16 Jun 2023 18:50:49 +0200
Message-Id: <20230616165109.21695-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230616164553.1090-1-jack@suse.cz>
References: <20230616164553.1090-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13457; i=jack@suse.cz; h=from:subject; bh=WpiWyva0cfuJKpzwgvufPgHEzvQPR1J9ovuEtlzSvsg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBkjJLpmfCOqW40p5QYWPPixjsyVWKkJmMlyaEQnTE7 FD4OW2eJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZIyS6QAKCRCcnaoHP2RA2dmjCA DA6CRg6TWcglar/ijW9ON0k652YomMctpIIvrYeoKEovxa3tu8mQ2W8wejP5oFdPd9fgFws7URrNWn 62XSb4Qw8i4EQTyVTND7eV31TjYks2zDKImuUbkXkRQU/OKMcKnzFu8Z3PjgMUo9ZlGINlMUcSgbIU keikBz4UX+0paKniL//8za7RRhdBQzKDCLnnFkkDRjKIPAxtu47AOzcWEn+8rcQcBhwbCTmx4eB+Q5 /CMtXQnL8upaFSL/8j3YbFk2wpisTi2fgb4Hglh6OQ0TeXYtEMMSne0p1huPaNGXFw4TOYYnQOXgfn s07NbYvkDZgLkWM+j+KpdBEqoeRZL4
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

Currently ext4_forced_shutdown() takes struct ext4_sb_info but most
callers need to get it from struct super_block anyway. So just pass in
struct super_block to save all callers from some boilerplate code. No
functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h      |  4 ++--
 fs/ext4/ext4_jbd2.c |  2 +-
 fs/ext4/file.c      | 11 +++++------
 fs/ext4/fsync.c     |  2 +-
 fs/ext4/ialloc.c    |  2 +-
 fs/ext4/inline.c    |  2 +-
 fs/ext4/inode.c     | 24 ++++++++++++------------
 fs/ext4/ioctl.c     |  2 +-
 fs/ext4/namei.c     |  8 ++++----
 fs/ext4/page-io.c   |  2 +-
 fs/ext4/super.c     | 14 +++++++-------
 fs/ext4/xattr.c     |  2 +-
 12 files changed, 37 insertions(+), 38 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8104a21b001a..f0b6aa79dcc4 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2163,9 +2163,9 @@ extern int ext4_feature_set_ok(struct super_block *sb, int readonly);
 #define EXT4_FLAGS_SHUTDOWN	1
 #define EXT4_FLAGS_BDEV_IS_DAX	2
 
-static inline int ext4_forced_shutdown(struct ext4_sb_info *sbi)
+static inline int ext4_forced_shutdown(struct super_block *sb)
 {
-	return test_bit(EXT4_FLAGS_SHUTDOWN, &sbi->s_ext4_flags);
+	return test_bit(EXT4_FLAGS_SHUTDOWN, &EXT4_SB(sb)->s_ext4_flags);
 }
 
 /*
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index 77f318ec8abb..b72a22a57d20 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -67,7 +67,7 @@ static int ext4_journal_check_start(struct super_block *sb)
 
 	might_sleep();
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return -EIO;
 
 	if (sb_rdonly(sb))
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index d101b3b0c7da..2a8a780c856b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -131,7 +131,7 @@ static ssize_t ext4_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	if (!iov_iter_count(to))
@@ -697,7 +697,7 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 #ifdef CONFIG_FS_DAX
@@ -795,10 +795,9 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
-	struct dax_device *dax_dev = sbi->s_daxdev;
+	struct dax_device *dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 
-	if (unlikely(ext4_forced_shutdown(sbi)))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	/*
@@ -874,7 +873,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	ret = ext4_sample_last_mounted(inode->i_sb, filp->f_path.mnt);
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 2a143209aa0c..958bcaedcff6 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -140,7 +140,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	struct inode *inode = file->f_mapping->host;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (unlikely(ext4_forced_shutdown(sbi)))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	ASSERT(ext4_journal_current_handle() == NULL);
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 754f961cd9fd..060630c0b0ca 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -950,7 +950,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	sb = dir->i_sb;
 	sbi = EXT4_SB(sb);
 
-	if (unlikely(ext4_forced_shutdown(sbi)))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return ERR_PTR(-EIO);
 
 	ngroups = ext4_get_groups_count(sb);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 5854bd5a3352..2aa3ecbdbb9f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -228,7 +228,7 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 	struct ext4_inode *raw_inode;
 	int cp_len = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 02de439bf1f0..da3aaaea5f1c 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1130,7 +1130,7 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index;
 	unsigned from, to;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	trace_ext4_write_begin(inode, pos, len);
@@ -2237,7 +2237,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		if (err < 0) {
 			struct super_block *sb = inode->i_sb;
 
-			if (ext4_forced_shutdown(EXT4_SB(sb)) ||
+			if (ext4_forced_shutdown(sb) ||
 			    ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
 				goto invalidate_dirty_pages;
 			/*
@@ -2566,7 +2566,7 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	 * *never* be called, so if that ever happens, we would want
 	 * the stack trace.
 	 */
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(mapping->host->i_sb)) ||
+	if (unlikely(ext4_forced_shutdown(mapping->host->i_sb) ||
 		     ext4_test_mount_flag(inode->i_sb, EXT4_MF_FS_ABORTED))) {
 		ret = -EROFS;
 		goto out_writepages;
@@ -2785,7 +2785,7 @@ static int ext4_writepages(struct address_space *mapping,
 	int ret;
 	int alloc_ctx;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return -EIO;
 
 	alloc_ctx = ext4_writepages_down_read(sb);
@@ -2824,16 +2824,16 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	int ret;
 	long nr_to_write = wbc->nr_to_write;
 	struct inode *inode = mapping->host;
-	struct ext4_sb_info *sbi = EXT4_SB(mapping->host->i_sb);
 	int alloc_ctx;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
 	trace_ext4_writepages(inode, wbc);
 
-	ret = dax_writeback_mapping_range(mapping, sbi->s_daxdev, wbc);
+	ret = dax_writeback_mapping_range(mapping,
+					  EXT4_SB(inode->i_sb)->s_daxdev, wbc);
 	trace_ext4_writepages_result(inode, wbc, ret,
 				     nr_to_write - wbc->nr_to_write);
 	ext4_writepages_up_read(inode->i_sb, alloc_ctx);
@@ -2883,7 +2883,7 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index;
 	struct inode *inode = mapping->host;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	index = pos >> PAGE_SHIFT;
@@ -5161,7 +5161,7 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	    sb_rdonly(inode->i_sb))
 		return 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	if (EXT4_SB(inode->i_sb)->s_journal) {
@@ -5281,7 +5281,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const unsigned int ia_valid = attr->ia_valid;
 	bool inc_ivers = true;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	if (unlikely(IS_IMMUTABLE(inode)))
@@ -5702,7 +5702,7 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 {
 	int err = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb)))) {
+	if (unlikely(ext4_forced_shutdown(inode->i_sb))) {
 		put_bh(iloc->bh);
 		return -EIO;
 	}
@@ -5728,7 +5728,7 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	err = ext4_get_inode_loc(inode, iloc);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a430152063..c07417986ed6 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -807,7 +807,7 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 	if (flags > EXT4_GOING_FLAGS_NOLOGFLUSH)
 		return -EINVAL;
 
-	if (ext4_forced_shutdown(sbi))
+	if (ext4_forced_shutdown(sb))
 		return 0;
 
 	ext4_msg(sb, KERN_ALERT, "shut down requested (%d)", flags);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 45b579805c95..437d76e98c0a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3142,7 +3142,7 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
 	/* Initialize quotas before so that eventual writes go in
@@ -3301,7 +3301,7 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int retval;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
 	trace_ext4_unlink_enter(dir, dentry);
@@ -3369,7 +3369,7 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct fscrypt_str disk_link;
 	int retries = 0;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
 	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
@@ -4202,7 +4202,7 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(old_dir->i_sb))))
+	if (unlikely(ext4_forced_shutdown(old_dir->i_sb)))
 		return -EIO;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 3621f29ec671..dfdd7e5cf038 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -184,7 +184,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 
 	io_end->handle = NULL;	/* Following call will use up the handle */
 	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
-	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
+	if (ret < 0 && !ext4_forced_shutdown(inode->i_sb)) {
 		ext4_msg(inode->i_sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
 			 "extents -- potential data loss!  "
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8c843ceb3cbb..d4978e705718 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -758,7 +758,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 	struct va_format vaf;
 	va_list args;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return;
 
 	trace_ext4_error(sb, function, line);
@@ -783,7 +783,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 	va_list args;
 	struct va_format vaf;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
@@ -818,7 +818,7 @@ void __ext4_error_file(struct file *file, const char *function,
 	struct inode *inode = file_inode(file);
 	char pathname[80], *path;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
@@ -898,7 +898,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 	char nbuf[16];
 	const char *errstr;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return;
 
 	/* Special case: if the error is EROFS, and we're not already
@@ -992,7 +992,7 @@ __acquires(bitlock)
 	struct va_format vaf;
 	va_list args;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(sb))))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return;
 
 	trace_ext4_error(sb, function, line);
@@ -6261,7 +6261,7 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 	bool needs_barrier = false;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (unlikely(ext4_forced_shutdown(sbi)))
+	if (unlikely(ext4_forced_shutdown(sb)))
 		return 0;
 
 	trace_ext4_sync_fs(sb, wait);
@@ -6344,7 +6344,7 @@ static int ext4_freeze(struct super_block *sb)
  */
 static int ext4_unfreeze(struct super_block *sb)
 {
-	if (ext4_forced_shutdown(EXT4_SB(sb)))
+	if (ext4_forced_shutdown(sb))
 		return 0;
 
 	if (EXT4_SB(sb)->s_journal) {
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 321e3a888c20..5ba42b1a3d46 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -701,7 +701,7 @@ ext4_xattr_get(struct inode *inode, int name_index, const char *name,
 {
 	int error;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
 		return -EIO;
 
 	if (strlen(name) > 255)
-- 
2.35.3

