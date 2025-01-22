Return-Path: <linux-ext4+bounces-6206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5ECA190DC
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 12:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8A6F1887A09
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Jan 2025 11:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C70C212B27;
	Wed, 22 Jan 2025 11:47:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4556A21148E;
	Wed, 22 Jan 2025 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737546447; cv=none; b=cmGXgJUA68WF7RbsT0nhWpAgeLt/gNWhEpPEfEDKNZolIMUoD+Shx1XVbEXdbcBjvu51WiXxglM+BCwuhYjaK6i/IcSxCKbjNczjWEFhSBXT1oZr52xNIqCdKnA61MbHUz+LuTgVWvaGjdJw8C2wZMjzBIHP2CKrpWH5mGaypH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737546447; c=relaxed/simple;
	bh=YeW0kUywAKKuDglnilJncLFJ5vdWlH2wRjLvydybUHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kuhr9yI3eRrByLmWs3iXLfmD7vi1tqINqek4S+161QabH8T+CCh0p8We33e3UXdGLKZg2wNjZ3Uou/wNaK4IzZOUuwjwVTTWzR4fCOiBMWRSLahKXISL5eJkof/0QANqTseqQzMi0ht+hW4r1lsioL3ScFgCKRe7DsWy9DqoUmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YdMkD5zHkz4f3jY1;
	Wed, 22 Jan 2025 19:47:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7394D1A08FC;
	Wed, 22 Jan 2025 19:47:21 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgD3Wl_F2pBn0KiuBg--.48765S7;
	Wed, 22 Jan 2025 19:47:21 +0800 (CST)
From: libaokun@huaweicloud.com
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 3/7] ext4: add ext4_emergency_state() helper function
Date: Wed, 22 Jan 2025 19:41:26 +0800
Message-Id: <20250122114130.229709-4-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250122114130.229709-1-libaokun@huaweicloud.com>
References: <20250122114130.229709-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgD3Wl_F2pBn0KiuBg--.48765S7
X-Coremail-Antispam: 1UD129KBjvAXoW3KF47JF4DCry3XF4UurWkXrb_yoW8XFWxuo
	WFvF12qFyIka9xtayIkw18tFyUX39xCw4rC3s8ZF4qgryYyrn8uw17Aw17W3W3Ww4rXFW3
	J34xJa1UXF4kZrW5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
	AaLaJ3UjIYCTnIWjp_UUUOY7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
	j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
	kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
	jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24lc7CjxV
	Aaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZE
	Xa7VUbqQ6JUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAQBWeQpvMO6wAAsT

From: Baokun Li <libaokun1@huawei.com>

Since both SHUTDOWN and EMERGENCY_RO are emergency states of the ext4 file
system, and they are checked in similar locations, we have added a helper
function, ext4_emergency_state(), to determine whether the current file
system is in one of these two emergency states.

Then, replace calls to ext4_forced_shutdown() with ext4_emergency_state()
in those functions that could potentially trigger write operations.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h      |  9 +++++++++
 fs/ext4/ext4_jbd2.c |  6 ++++--
 fs/ext4/file.c      | 24 ++++++++++++++++-------
 fs/ext4/fsync.c     | 12 ++++--------
 fs/ext4/ialloc.c    |  5 +++--
 fs/ext4/inline.c    |  2 +-
 fs/ext4/inode.c     | 47 ++++++++++++++++++++++++++-------------------
 fs/ext4/mballoc.c   |  4 ++--
 fs/ext4/mmp.c       |  2 +-
 fs/ext4/namei.c     | 20 +++++++++++--------
 fs/ext4/page-io.c   |  2 +-
 fs/ext4/super.c     | 19 +++++++++---------
 12 files changed, 91 insertions(+), 61 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 207510b0b0af..3b0320c32e76 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2250,6 +2250,15 @@ static inline int ext4_emergency_ro(struct super_block *sb)
 	return test_bit(EXT4_FLAGS_EMERGENCY_RO, &EXT4_SB(sb)->s_ext4_flags);
 }
 
+static inline int ext4_emergency_state(struct super_block *sb)
+{
+	if (unlikely(ext4_forced_shutdown(sb)))
+		return -EIO;
+	if (unlikely(ext4_emergency_ro(sb)))
+		return -EROFS;
+	return 0;
+}
+
 /*
  * Default values for user and/or group using reserved blocks
  */
diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index da4a82456383..4e3bd4910f48 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -63,12 +63,14 @@ static void ext4_put_nojournal(handle_t *handle)
  */
 static int ext4_journal_check_start(struct super_block *sb)
 {
+	int ret;
 	journal_t *journal;
 
 	might_sleep();
 
-	if (unlikely(ext4_forced_shutdown(sb)))
-		return -EIO;
+	ret = ext4_emergency_state(sb);
+	if (unlikely(ret))
+		return ret;
 
 	if (WARN_ON_ONCE(sb_rdonly(sb)))
 		return -EROFS;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index a5205149adba..d0c21e6503c6 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -688,10 +688,12 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static ssize_t
 ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
+	int ret;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
 
 #ifdef CONFIG_FS_DAX
 	if (IS_DAX(inode))
@@ -700,7 +702,6 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_ATOMIC) {
 		size_t len = iov_iter_count(from);
-		int ret;
 
 		if (len < EXT4_SB(inode->i_sb)->s_awu_min ||
 		    len > EXT4_SB(inode->i_sb)->s_awu_max)
@@ -803,11 +804,16 @@ static const struct vm_operations_struct ext4_file_vm_ops = {
 
 static int ext4_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	int ret;
 	struct inode *inode = file->f_mapping->host;
 	struct dax_device *dax_dev = EXT4_SB(inode->i_sb)->s_daxdev;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	if (file->f_mode & FMODE_WRITE)
+		ret = ext4_emergency_state(inode->i_sb);
+	else
+		ret = ext4_forced_shutdown(inode->i_sb) ? -EIO : 0;
+	if (unlikely(ret))
+		return ret;
 
 	/*
 	 * We don't support synchronous mappings for non-DAX files and
@@ -881,8 +887,12 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 {
 	int ret;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	if (filp->f_mode & FMODE_WRITE)
+		ret = ext4_emergency_state(inode->i_sb);
+	else
+		ret = ext4_forced_shutdown(inode->i_sb) ? -EIO : 0;
+	if (unlikely(ret))
+		return ret;
 
 	ret = ext4_sample_last_mounted(inode->i_sb, filp->f_path.mnt);
 	if (ret)
diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index b40d3b29f7e5..e476c6de3074 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -132,20 +132,16 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	bool needs_barrier = false;
 	struct inode *inode = file->f_mapping->host;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
 
 	ASSERT(ext4_journal_current_handle() == NULL);
 
 	trace_ext4_sync_file_enter(file, datasync);
 
-	if (sb_rdonly(inode->i_sb)) {
-		/* Make sure that we read updated s_ext4_flags value */
-		smp_rmb();
-		if (ext4_forced_shutdown(inode->i_sb))
-			ret = -EROFS;
+	if (sb_rdonly(inode->i_sb))
 		goto out;
-	}
 
 	if (!EXT4_SB(inode->i_sb)->s_journal) {
 		ret = ext4_fsync_nojournal(file, start, end, datasync,
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 21d228073d79..a5e5c3dc1d70 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -951,8 +951,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	sb = dir->i_sb;
 	sbi = EXT4_SB(sb);
 
-	if (unlikely(ext4_forced_shutdown(sb)))
-		return ERR_PTR(-EIO);
+	ret2 = ext4_emergency_state(sb);
+	if (unlikely(ret2))
+		return ERR_PTR(ret2);
 
 	ngroups = ext4_get_groups_count(sb);
 	trace_ext4_request_inode(dir, mode);
diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 3536ca7e4fcc..1fe8a566ea0b 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -228,7 +228,7 @@ static void ext4_write_inline_data(struct inode *inode, struct ext4_iloc *iloc,
 	struct ext4_inode *raw_inode;
 	int cp_len = 0;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+	if (unlikely(ext4_emergency_state(inode->i_sb)))
 		return;
 
 	BUG_ON(!EXT4_I(inode)->i_inline_off);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 36b1f9fb690a..74f5daac9637 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1149,8 +1149,9 @@ static int ext4_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index;
 	unsigned from, to;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
 
 	trace_ext4_write_begin(inode, pos, len);
 	/*
@@ -2273,7 +2274,7 @@ static int mpage_map_and_submit_extent(handle_t *handle,
 		if (err < 0) {
 			struct super_block *sb = inode->i_sb;
 
-			if (ext4_forced_shutdown(sb))
+			if (ext4_emergency_state(sb))
 				goto invalidate_dirty_pages;
 			/*
 			 * Let the uper layers retry transient errors.
@@ -2599,10 +2600,9 @@ static int ext4_do_writepages(struct mpage_da_data *mpd)
 	 * *never* be called, so if that ever happens, we would want
 	 * the stack trace.
 	 */
-	if (unlikely(ext4_forced_shutdown(mapping->host->i_sb))) {
-		ret = -EROFS;
+	ret = ext4_emergency_state(mapping->host->i_sb);
+	if (unlikely(ret))
 		goto out_writepages;
-	}
 
 	/*
 	 * If we have inline data and arrive here, it means that
@@ -2817,8 +2817,9 @@ static int ext4_writepages(struct address_space *mapping,
 	int ret;
 	int alloc_ctx;
 
-	if (unlikely(ext4_forced_shutdown(sb)))
-		return -EIO;
+	ret = ext4_emergency_state(sb);
+	if (unlikely(ret))
+		return ret;
 
 	alloc_ctx = ext4_writepages_down_read(sb);
 	ret = ext4_do_writepages(&mpd);
@@ -2858,8 +2859,9 @@ static int ext4_dax_writepages(struct address_space *mapping,
 	struct inode *inode = mapping->host;
 	int alloc_ctx;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
 
 	alloc_ctx = ext4_writepages_down_read(inode->i_sb);
 	trace_ext4_writepages(inode, wbc);
@@ -2915,8 +2917,9 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
 	pgoff_t index;
 	struct inode *inode = mapping->host;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	ret = ext4_emergency_state(inode->i_sb);
+	if (unlikely(ret))
+		return ret;
 
 	index = pos >> PAGE_SHIFT;
 
@@ -5228,8 +5231,9 @@ int ext4_write_inode(struct inode *inode, struct writeback_control *wbc)
 	if (WARN_ON_ONCE(current->flags & PF_MEMALLOC))
 		return 0;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	err = ext4_emergency_state(inode->i_sb);
+	if (unlikely(err))
+		return err;
 
 	if (EXT4_SB(inode->i_sb)->s_journal) {
 		if (ext4_journal_current_handle()) {
@@ -5351,8 +5355,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	const unsigned int ia_valid = attr->ia_valid;
 	bool inc_ivers = true;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	error = ext4_emergency_state(inode->i_sb);
+	if (unlikely(error))
+		return error;
 
 	if (unlikely(IS_IMMUTABLE(inode)))
 		return -EPERM;
@@ -5796,9 +5801,10 @@ int ext4_mark_iloc_dirty(handle_t *handle,
 {
 	int err = 0;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb))) {
+	err = ext4_emergency_state(inode->i_sb);
+	if (unlikely(err)) {
 		put_bh(iloc->bh);
-		return -EIO;
+		return err;
 	}
 	ext4_fc_track_inode(handle, inode);
 
@@ -5822,8 +5828,9 @@ ext4_reserve_inode_write(handle_t *handle, struct inode *inode,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
-		return -EIO;
+	err = ext4_emergency_state(inode->i_sb);
+	if (unlikely(err))
+		return err;
 
 	err = ext4_get_inode_loc(inode, iloc);
 	if (!err) {
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index b25a27c86696..a67c52063a42 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5653,7 +5653,7 @@ static inline void ext4_mb_show_pa(struct super_block *sb)
 {
 	ext4_group_t i, ngroups;
 
-	if (ext4_forced_shutdown(sb))
+	if (ext4_emergency_state(sb))
 		return;
 
 	ngroups = ext4_get_groups_count(sb);
@@ -5687,7 +5687,7 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
 	struct super_block *sb = ac->ac_sb;
 
-	if (ext4_forced_shutdown(sb))
+	if (ext4_emergency_state(sb))
 		return;
 
 	mb_debug(sb, "Can't allocate:"
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index d64c04ed061a..af6b3b746fe5 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -162,7 +162,7 @@ static int kmmpd(void *data)
 	memcpy(mmp->mmp_nodename, init_utsname()->nodename,
 	       sizeof(mmp->mmp_nodename));
 
-	while (!kthread_should_stop() && !ext4_forced_shutdown(sb)) {
+	while (!kthread_should_stop() && !ext4_emergency_state(sb)) {
 		if (!ext4_has_feature_mmp(sb)) {
 			ext4_warning(sb, "kmmpd being stopped since MMP feature"
 				     " has been disabled.");
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 536d56d15072..dead385bb164 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3151,8 +3151,9 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	struct ext4_dir_entry_2 *de;
 	handle_t *handle = NULL;
 
-	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
-		return -EIO;
+	retval = ext4_emergency_state(dir->i_sb);
+	if (unlikely(retval))
+		return retval;
 
 	/* Initialize quotas before so that eventual writes go in
 	 * separate transaction */
@@ -3309,8 +3310,9 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 {
 	int retval;
 
-	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
-		return -EIO;
+	retval = ext4_emergency_state(dir->i_sb);
+	if (unlikely(retval))
+		return retval;
 
 	trace_ext4_unlink_enter(dir, dentry);
 	/*
@@ -3376,8 +3378,9 @@ static int ext4_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	struct fscrypt_str disk_link;
 	int retries = 0;
 
-	if (unlikely(ext4_forced_shutdown(dir->i_sb)))
-		return -EIO;
+	err = ext4_emergency_state(dir->i_sb);
+	if (unlikely(err))
+		return err;
 
 	err = fscrypt_prepare_symlink(dir, symname, len, dir->i_sb->s_blocksize,
 				      &disk_link);
@@ -4199,8 +4202,9 @@ static int ext4_rename2(struct mnt_idmap *idmap,
 {
 	int err;
 
-	if (unlikely(ext4_forced_shutdown(old_dir->i_sb)))
-		return -EIO;
+	err = ext4_emergency_state(old_dir->i_sb);
+	if (unlikely(err))
+		return err;
 
 	if (flags & ~(RENAME_NOREPLACE | RENAME_EXCHANGE | RENAME_WHITEOUT))
 		return -EINVAL;
diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
index 31d8963a3fd6..24829b71e05e 100644
--- a/fs/ext4/page-io.c
+++ b/fs/ext4/page-io.c
@@ -198,7 +198,7 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
 	} else {
 		ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
 	}
-	if (ret < 0 && !ext4_forced_shutdown(sb) &&
+	if (ret < 0 && !ext4_emergency_state(sb) &&
 	    io_end->flag & EXT4_IO_END_UNWRITTEN) {
 		ext4_msg(sb, KERN_EMERG,
 			 "failed to convert unwritten extents to written "
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index ca1ecafd48c5..4b089a5b760a 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -819,7 +819,7 @@ void __ext4_error(struct super_block *sb, const char *function,
 	struct va_format vaf;
 	va_list args;
 
-	if (unlikely(ext4_forced_shutdown(sb)))
+	if (unlikely(ext4_emergency_state(sb)))
 		return;
 
 	trace_ext4_error(sb, function, line);
@@ -844,7 +844,7 @@ void __ext4_error_inode(struct inode *inode, const char *function,
 	va_list args;
 	struct va_format vaf;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+	if (unlikely(ext4_emergency_state(inode->i_sb)))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
@@ -879,7 +879,7 @@ void __ext4_error_file(struct file *file, const char *function,
 	struct inode *inode = file_inode(file);
 	char pathname[80], *path;
 
-	if (unlikely(ext4_forced_shutdown(inode->i_sb)))
+	if (unlikely(ext4_emergency_state(inode->i_sb)))
 		return;
 
 	trace_ext4_error(inode->i_sb, function, line);
@@ -959,7 +959,7 @@ void __ext4_std_error(struct super_block *sb, const char *function,
 	char nbuf[16];
 	const char *errstr;
 
-	if (unlikely(ext4_forced_shutdown(sb)))
+	if (unlikely(ext4_emergency_state(sb)))
 		return;
 
 	/* Special case: if the error is EROFS, and we're not already
@@ -1053,7 +1053,7 @@ __acquires(bitlock)
 	struct va_format vaf;
 	va_list args;
 
-	if (unlikely(ext4_forced_shutdown(sb)))
+	if (unlikely(ext4_emergency_state(sb)))
 		return;
 
 	trace_ext4_error(sb, function, line);
@@ -6343,8 +6343,9 @@ static int ext4_sync_fs(struct super_block *sb, int wait)
 	bool needs_barrier = false;
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 
-	if (unlikely(ext4_forced_shutdown(sb)))
-		return -EIO;
+	ret = ext4_emergency_state(sb);
+	if (unlikely(ret))
+		return ret;
 
 	trace_ext4_sync_fs(sb, wait);
 	flush_workqueue(sbi->rsv_conversion_wq);
@@ -6426,7 +6427,7 @@ static int ext4_freeze(struct super_block *sb)
  */
 static int ext4_unfreeze(struct super_block *sb)
 {
-	if (ext4_forced_shutdown(sb))
+	if (ext4_emergency_state(sb))
 		return 0;
 
 	if (EXT4_SB(sb)->s_journal) {
@@ -6582,7 +6583,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 	flush_work(&sbi->s_sb_upd_work);
 
 	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
-		if (ext4_forced_shutdown(sb)) {
+		if (ext4_emergency_state(sb)) {
 			err = -EROFS;
 			goto restore_opts;
 		}
-- 
2.39.2


