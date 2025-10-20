Return-Path: <linux-ext4+bounces-10983-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0B6BF0D59
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 13:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BC118A315C
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Oct 2025 11:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E142F99BE;
	Mon, 20 Oct 2025 11:29:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C4F246781;
	Mon, 20 Oct 2025 11:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760959767; cv=none; b=V4nYLTHuV7YaMrQ0G8BiTtQFTSGWrXFqXt9rBq/f69BayQ1qIxdhpX66Dvk3qFXdFRsMop0cFixF3lvbxL1w/9n2Y85z4u19ejvy93xVMgJBhLcH2lN8OkUsPk6N9tjLJ8VrpOHnPSiNXFfNlxZxGUqInWoDXfFxHTBLO9loQr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760959767; c=relaxed/simple;
	bh=OWxLcKqN1AX2fLZFpzOl+AtVxiTVen8Pq2II3d/sPMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=owN+WZjdyhu94A9q624ka9HiAzvqleYw81MpklFb5n9rauqkipszeG0I/sZa+78LCd/ccfMBspQYuZsaF8Z0aYtDFrZqqFxdglzjRIDPWnoWlh+eS6tZEEeH9EMANywbej2wEIzHsV/gDNckf3X2FX4ZzAEL4nTG6Etq/QiVQCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 59KBSvxE051179;
	Mon, 20 Oct 2025 20:28:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 59KBSuro051175
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 20 Oct 2025 20:28:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <93744126-237b-4e36-8a62-a33e1fb52051@I-love.SAKURA.ne.jp>
Date: Mon, 20 Oct 2025 20:28:54 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] jbd2: assign different lock_class_key for different
 filesystem
To: Jan Kara <jack@suse.cz>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <e42f1471-a88a-4938-8743-1d5b171c47ec@I-love.SAKURA.ne.jp>
 <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <fwsxrb7ugi5zeosugo6hyjdbhw36ppa5kekfi6n7we2vvi3r7m@ljrizqoagsg7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp

On 2025/10/20 18:31, Jan Kara wrote:
> On Sun 19-10-25 19:52:43, Tetsuo Handa wrote:
>> syzbot is reporting possibility of deadlock due to sharing lock_class_key
>> for jbd2_handle across ext4 and ocfs2. But one disk partition can't have
>> two filesystems at the same time, and how locks in journal_t interacts
>> with other filesystem specific locks can vary depending on filesystems.
>> Therefore, lockdep should treat locks in journal_t different locks if
>> the filesystem which allocated the journal_t differs.
> 
> Thanks for debugging this. I agree with the idea of your solution but the
> implementation is just ugly. Just let the filesystem pass the lockdep key
> into jbd2_journal_init_dev() / jbd2_journal_init_inode() and make ext4 and
> ocfs2 functions initializing the journal each have its own lock_class_key
> declared and pass it to jbd2 functions. That way changes are much simpler
> and also jbd2 doesn't have to be aware about which filesystems are using
> it.

Well, do you mean something like below diff? If we can assume that only ext4
and ocfs2 are using jbd2, the diff becomes smaller...

 fs/ext4/super.c      |    6 +++-
 fs/jbd2/journal.c    |   68 ++++++++++++++++++++++++++++++++++++---------------
 fs/ocfs2/journal.c   |    6 +++-
 include/linux/jbd2.h |   15 ++++++++---
 4 files changed, 67 insertions(+), 28 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 43b9297fe8a7..184d025341da 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1287,6 +1287,13 @@ struct journal_s
 	int (*j_bmap)(struct journal_s *journal, sector_t *block);
 };
 
+struct jbd2_lock_class_keys {
+	const char *name;
+	struct lock_class_key jbd2_trans_commit_key, j_abort_mutex, j_barrier,
+		j_checkpoint_mutex, j_revoke_lock, j_list_lock, j_history_lock,
+		j_state_lock;
+};
+
 #define jbd2_might_wait_for_commit(j) \
 	do { \
 		rwsem_acquire(&j->j_trans_commit_map, 0, 0, _THIS_IP_); \
@@ -1523,10 +1530,10 @@ extern void	 jbd2_journal_unlock_updates (journal_t *);
 
 void jbd2_journal_wait_updates(journal_t *);
 
-extern journal_t * jbd2_journal_init_dev(struct block_device *bdev,
-				struct block_device *fs_dev,
-				unsigned long long start, int len, int bsize);
-extern journal_t * jbd2_journal_init_inode (struct inode *);
+extern journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+					unsigned long long start, int len, int bsize,
+					struct jbd2_lock_class_keys *keys);
+extern journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys);
 extern int	   jbd2_journal_update_format (journal_t *);
 extern int	   jbd2_journal_check_used_features
 		   (journal_t *, unsigned long, unsigned long, unsigned long);
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d480b94117cd..775c1cfa452a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1506,6 +1506,34 @@ static int journal_load_superblock(journal_t *journal)
 	return 0;
 }
 
+#ifndef CONFIG_RT
+/* This change goes to include/linux/spinlock.h */
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define spin_lock_init_with_key(lock, key)				\
+	__raw_spin_lock_init(spinlock_check(lock), #lock, key, LD_WAIT_CONFIG)
+#else
+#define spin_lock_init_with_key(lock, key) do { spin_lock_init(lock); (void)(key); } while (0)
+#endif
+#else
+/* This change goes to include/linux/spinlock_rt.h */
+#define spin_lock_init_with_key(slock, key) __spin_lock_init(slock, #slock, key, false)
+#endif
+
+#ifndef CONFIG_RT
+/* This change goes to include/linux/rwlock.h */
+#ifdef CONFIG_DEBUG_SPINLOCK
+#define rwlock_init_with_key(lock, key) __rwlock_init((lock), #lock, key)
+#else
+#define rwlock_init_with_key(lock, key) do { rwlock_init(lock); (void)(key); } while (0)
+#endif
+#else
+/* This change goes to include/linux/rwlock_rt.h */
+#define rwlock_init_with_key(rwl, key)			\
+	do {						\
+		init_rwbase_rt(&(rwl)->rwbase);		\
+		__rt_rwlock_init(rwl, #rwl, key);	\
+	} while (0)
+#endif
 
 /*
  * Management for journal control blocks: functions to create and
@@ -1517,11 +1545,10 @@ static int journal_load_superblock(journal_t *journal)
  * superblock and initialize the journal_t object.
  */
 
-static journal_t *journal_init_common(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+static journal_t *journal_init_common(struct block_device *bdev, struct block_device *fs_dev,
+				      unsigned long long start, int len, int blocksize,
+				      struct jbd2_lock_class_keys *keys)
 {
-	static struct lock_class_key jbd2_trans_commit_key;
 	journal_t *journal;
 	int err;
 	int n;
@@ -1547,20 +1574,20 @@ static journal_t *journal_init_common(struct block_device *bdev,
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
+	mutex_init_with_key(&journal->j_abort_mutex, &keys->j_abort_mutex);
+	mutex_init_with_key(&journal->j_barrier, &keys->j_barrier);
+	mutex_init_with_key(&journal->j_checkpoint_mutex, &keys->j_checkpoint_mutex);
+	spin_lock_init_with_key(&journal->j_revoke_lock, &keys->j_revoke_lock);
+	spin_lock_init_with_key(&journal->j_list_lock, &keys->j_list_lock);
+	spin_lock_init_with_key(&journal->j_history_lock, &keys->j_history_lock);
+	rwlock_init_with_key(&journal->j_state_lock, &keys->j_state_lock);
 
 	journal->j_commit_interval = (HZ * JBD2_DEFAULT_MAX_COMMIT_AGE);
 	journal->j_min_batch_time = 0;
 	journal->j_max_batch_time = 15000; /* 15ms */
 	atomic_set(&journal->j_reserved_credits, 0);
-	lockdep_init_map(&journal->j_trans_commit_map, "jbd2_handle",
-			 &jbd2_trans_commit_key, 0);
+	lockdep_init_map(&journal->j_trans_commit_map, keys->name,
+			 &keys->jbd2_trans_commit_key, 0);
 
 	/* The journal is marked for error until we succeed with recovery! */
 	journal->j_flags = JBD2_ABORT;
@@ -1631,6 +1658,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  @start: Block nr Start of journal.
  *  @len:  Length of the journal in blocks.
  *  @blocksize: blocksize of journalling device
+ *  @keys: Pointer to struct jbd2_lock_class_keys for lockdep annotation
  *
  *  Returns: a newly created journal_t *
  *
@@ -1638,13 +1666,13 @@ static journal_t *journal_init_common(struct block_device *bdev,
  *  range of blocks on an arbitrary block device.
  *
  */
-journal_t *jbd2_journal_init_dev(struct block_device *bdev,
-			struct block_device *fs_dev,
-			unsigned long long start, int len, int blocksize)
+journal_t *jbd2_journal_init_dev(struct block_device *bdev, struct block_device *fs_dev,
+				 unsigned long long start, int len, int blocksize,
+				 struct jbd2_lock_class_keys *keys)
 {
 	journal_t *journal;
 
-	journal = journal_init_common(bdev, fs_dev, start, len, blocksize);
+	journal = journal_init_common(bdev, fs_dev, start, len, blocksize, keys);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
@@ -1664,7 +1692,7 @@ journal_t *jbd2_journal_init_dev(struct block_device *bdev,
  * the journal.  The inode must exist already, must support bmap() and
  * must have all data blocks preallocated.
  */
-journal_t *jbd2_journal_init_inode(struct inode *inode)
+journal_t *jbd2_journal_init_inode(struct inode *inode, struct jbd2_lock_class_keys *keys)
 {
 	journal_t *journal;
 	sector_t blocknr;
@@ -1682,8 +1710,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
 		  inode->i_sb->s_blocksize_bits, inode->i_sb->s_blocksize);
 
 	journal = journal_init_common(inode->i_sb->s_bdev, inode->i_sb->s_bdev,
-			blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
-			inode->i_sb->s_blocksize);
+				      blocknr, inode->i_size >> inode->i_sb->s_blocksize_bits,
+				      inode->i_sb->s_blocksize, keys);
 	if (IS_ERR(journal))
 		return ERR_CAST(journal);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 699c15db28a8..fc93a2ef5c2d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -60,6 +60,8 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/ext4.h>
 
+static struct jbd2_lock_class_keys jbd2_ext4_lock_class_keys = { .name = "jbd2_ext4_handle" };
+
 static struct ext4_lazy_init *ext4_li_info;
 static DEFINE_MUTEX(ext4_li_mtx);
 static struct ratelimit_state ext4_mount_msg_ratelimit;
@@ -5851,7 +5853,7 @@ static journal_t *ext4_open_inode_journal(struct super_block *sb,
 	if (IS_ERR(journal_inode))
 		return ERR_CAST(journal_inode);
 
-	journal = jbd2_journal_init_inode(journal_inode);
+	journal = jbd2_journal_init_inode(journal_inode, &jbd2_ext4_lock_class_keys);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "Could not load journal inode");
 		iput(journal_inode);
@@ -5956,7 +5958,7 @@ static journal_t *ext4_open_dev_journal(struct super_block *sb,
 		return ERR_CAST(bdev_file);
 
 	journal = jbd2_journal_init_dev(file_bdev(bdev_file), sb->s_bdev, j_start,
-					j_len, sb->s_blocksize);
+					j_len, sb->s_blocksize, &jbd2_ext4_lock_class_keys);
 	if (IS_ERR(journal)) {
 		ext4_msg(sb, KERN_ERR, "failed to create device journal");
 		errno = PTR_ERR(journal);
diff --git a/fs/ocfs2/journal.c b/fs/ocfs2/journal.c
index e5f58ff2175f..e92746e3cb0b 100644
--- a/fs/ocfs2/journal.c
+++ b/fs/ocfs2/journal.c
@@ -43,6 +43,8 @@
 
 DEFINE_SPINLOCK(trans_inc_lock);
 
+static struct jbd2_lock_class_keys jbd2_ocfs2_lock_class_keys = { .name = "jbd2_ocfs2_handle" };
+
 #define ORPHAN_SCAN_SCHEDULE_TIMEOUT 300000
 
 static int ocfs2_force_read_journal(struct inode *inode);
@@ -968,7 +970,7 @@ int ocfs2_journal_init(struct ocfs2_super *osb, int *dirty)
 				 OCFS2_I(inode)->ip_clusters);
 
 	/* call the kernels journal init function now */
-	j_journal = jbd2_journal_init_inode(inode);
+	j_journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
 	if (IS_ERR(j_journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
 		status = PTR_ERR(j_journal);
@@ -1759,7 +1761,7 @@ static int ocfs2_replay_journal(struct ocfs2_super *osb,
 		goto done;
 	}
 
-	journal = jbd2_journal_init_inode(inode);
+	journal = jbd2_journal_init_inode(inode, &jbd2_ocfs2_lock_class_keys);
 	if (IS_ERR(journal)) {
 		mlog(ML_ERROR, "Linux journal layer error\n");
 		status = PTR_ERR(journal);


