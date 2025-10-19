Return-Path: <linux-ext4+bounces-10971-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD79BEE362
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC15018994D1
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Oct 2025 10:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69922E2EFC;
	Sun, 19 Oct 2025 10:52:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925192D94A4;
	Sun, 19 Oct 2025 10:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760871176; cv=none; b=ss5J5NcBSOFl+ZMl4SItty6PIYjJurND0PmWmC2L1Z3y7i0fiSv2Mk+qdRQE3rB4BQ11McAqyQpNVP50Z7D5o7yLt+n1ZCFk3+hnl3ibIIUoQ6+ctd5Oja5hk7irizkxmd0UCgyQ/H834bafRkQJgerPtyw7cvaCeroNOZst2yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760871176; c=relaxed/simple;
	bh=IzPXGmr5aAJRTzNaSbLi77CszAJkZ3MYLOqpbDXxV9s=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=qzyWxRaSzdsxlN0KyiB+QpgdNMGwJ13/VVVBzUaB5/etErallDd7fqh35BH/ErXPaWJsHkbAA1IrmOwwNb2tzD+tULgWhGSVUrVlRpXZcDhXnTDy2ek+keECg8JBAOs9ZIEz/rFO/RKafUOjNDRT5LJ2VrwXx/quUB6bLpq8TAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59JAqhuS074625;
	Sun, 19 Oct 2025 19:52:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59JAqgXs074622
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 19 Oct 2025 19:52:43 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
Date: Sun, 19 Oct 2025 19:52:43 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav404.rs.sakura.ne.jp
X-Virus-Status: clean

syzbot is reporting possibility of deadlock due to sharing lock_class_key
for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
two filesystems at the same time, and how locks in journal_t interacts
with other filesystem specific locks can vary depending on filesystems.
Therefore, lockdep should treat locks in journal_t different locks if
the filesystem which allocated the journal_t differs.

Reported-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6e493c165d26d6fcbf72
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Tested-by: syzbot+6e493c165d26d6fcbf72@syzkaller.appspotmail.com
---
Is assigning different lock_class_key for j_abort_mutex etc. correct
when filesystem differs?

Should we ignore possibility of jbd2 being used by filesystems other than
ext4 and ocfs2, and use "bool is_ext4" than "unsigned long fsmagic" ?

 fs/ext4/super.c      |  2 +-
 fs/jbd2/journal.c    | 70 ++++++++++++++++++++++++++++++++------------
 include/linux/jbd2.h |  6 ++--
 3 files changed, 55 insertions(+), 23 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..4e206209a476 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5964,7 +5964,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		return ERR_CAST(bdev_file);
 
 	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
-					j_len, sb->s_blocksize);
+					j_len, sb->s_blocksize, EXT4_SUPER_MAGIC);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		errno = PTR_ERR(journal);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..2f4fbd74cf76 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1517,11 +1517,13 @@ static int journal_load_superblock(journal_t *journal)
  * superblock and initialize the journal_t object.
  */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
+				      unsigned long long start, int len, int blocksize,
+				      unsigned long fsmagic)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
+	static struct lock_class_key jbd2_trans_commit_key_ext4;
+	static struct lock_class_key jbd2_trans_commit_key_ocfs2;
+	static struct lock_class_key jbd2_trans_commit_key_unknown;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1547,20 +1549,49 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	init_waitqueue_head(&journal->j_wait_updates);
 	init_waitqueue_head(&journal->j_wait_reserved);
 	init_waitqueue_head(&journal->j_fc_wait);
-	mutex_init(&journal->j_abort_mutex);
-	mutex_init(&journal->j_barrier);
-	mutex_init(&journal->j_checkpoint_mutex);
-	spin_lock_init(&journal->j_revoke_lock);
-	spin_lock_init(&journal->j_list_lock);
-	spin_lock_init(&journal->j_history_lock);
-	rwlock_init(&journal->j_state_lock);
+	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
+	    fsmagic == EXT4_SUPER_MAGIC) {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	} else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
+		   fsmagic == OCFS2_SUPER_MAGIC) {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	} else {
+		mutex_init(&journal->j_abort_mutex);
+		mutex_init(&journal->j_barrier);
+		mutex_init(&journal->j_checkpoint_mutex);
+		spin_lock_init(&journal->j_revoke_lock);
+		spin_lock_init(&journal->j_list_lock);
+		spin_lock_init(&journal->j_history_lock);
+		rwlock_init(&journal->j_state_lock);
+	}
 
 	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
 	journal->j_min_batch_time = 0;
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
-	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+	if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_EXT4_FS) &&
+	    fsmagic == EXT4_SUPER_MAGIC)
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ext4",
+				 &jbd2_trans_commit_key_ext4, 0);
+	else if (IS_ENABLED(CONFIG_LOCKDEP) && IS_ENABLED(CONFIG_OCFS2_FS) &&
+		 fsmagic == OCFS2_SUPER_MAGIC)
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_ocfs2",
+				 &jbd2_trans_commit_key_ocfs2, 0);
+	else
+		lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle_unknown",
+				 &jbd2_trans_commit_key_unknown, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1631,6 +1662,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  @start: Block nr Start of journal.
  *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
+ *  @fsmagic: filesystem magic number for lockdep annotation
  *
  *  Returns: a newly created journal_t *
  *
@@ -1638,13 +1670,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+				 unsigned long long start, int len, int blocksize,
+				 unsigned long fsmagic)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, fsmagic);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1682,8 +1714,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
-			inode->i_sb->s_blocksize);
+				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
+				      inode->i_sb->s_blocksize, inode->i_sb->s_magic);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..56aa7ae4ec0b 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1523,9 +1523,9 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
-				unsigned long long start, int len, int bsize);
+extern journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+					unsigned long long start, int len, int bsize,
+					unsigned long fsmagic);
 extern journal_t * jbd2_journal_init_inode (struct inode *);
 extern int	   jbd2_journal_update_format (journal_t *);
 extern int	   jbd2_journal_check_used_features
-- 
2.47.3


