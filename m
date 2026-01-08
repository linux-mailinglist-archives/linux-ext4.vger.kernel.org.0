Return-Path: <linux-ext4+bounces-12620-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6003D00F0F
	for <lists+linux-ext4@lfdr.de>; Thu, 08 Jan 2026 04:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE7263080A9C
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Jan 2026 03:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27D328726D;
	Thu,  8 Jan 2026 03:48:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB521E1C02;
	Thu,  8 Jan 2026 03:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767844118; cv=none; b=JOYxiLXBZhuV3+CqOAkcRdMiufR4N9o+8jPC1gEOh6egCffZTa4tCqh5wZzLBpihkFGt+HGomH+RmpTfwLe++MI1IM4Ko850VSQREycdxSc721V/Fs+fXOdyv9IiPmYW2kLxJTXbX5viDyjdvKRU70aIp2aAU1j7GsUN7SKbYnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767844118; c=relaxed/simple;
	bh=HFWdG+prXDi+ZxKm5ZoMTzH095arEquyb6JKvCatVtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=COprfmrtov1WZjc9ZM5bwcZocDybECM08i8IHe+2AOp5NwgbK7S6iMp+uBnroqFgkijcyFUw6s79RvpwRez3VdG6KI8tZ+vYG/XFoB8mAVWjOAE+JuCVOS43yVBTCu9tu3vKDcn43AFgqS4ZQ/GDhRjZILEjqXR5gauh0ZxrdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dmrV50k6HzYQtsY;
	Thu,  8 Jan 2026 11:48:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 15C2240575;
	Thu,  8 Jan 2026 11:48:32 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgBHqPgMKV9pYIgcDA--.43650S3;
	Thu, 08 Jan 2026 11:48:29 +0800 (CST)
Message-ID: <34671658-297d-4831-bf90-e461edc6f967@huaweicloud.com>
Date: Thu, 8 Jan 2026 11:48:28 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fast commit: make s_fc_lock reclaim-safe
To: Li Chen <me@linux.beauty>, Jan Kara <jack@suse.cz>,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
 linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260106120621.440126-1-me@linux.beauty>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20260106120621.440126-1-me@linux.beauty>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHqPgMKV9pYIgcDA--.43650S3
X-Coremail-Antispam: 1UD129KBjvJXoWfJw4kuFW8Jw1UAry5GF17Jrb_yoWDKr4rpF
	47CF1UZrWrXryDWF4xtr4Uur4a9w409rW7Wr93CFyrCrW2qFyxKFn7XF1xuF4jyrW8uFsY
	qF4jkrWDWw4xK37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 1/6/2026 8:06 PM, Li Chen wrote:
> s_fc_lock can be acquired from inode eviction and thus is
> reclaim unsafe. Since the fast commit path holds s_fc_lock while writing
> the commit log, allocations under the lock can enter reclaim and invert
> the lock order with fs_reclaim. Add ext4_fc_lock()/ext4_fc_unlock()
> helpers which acquire s_fc_lock under memalloc_nofs_save()/restore()
> context and use them everywhere so allocations under the lock cannot
> recurse into filesystem reclaim.
> 
> Fixes: 6593714d67ba ("ext4: hold s_fc_lock while during fast commit")
> Signed-off-by: Li Chen <me@linux.beauty>

Thank you for the fix, it looks good to me too.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
> 
> RFC->v1:  create helper functions for acquiring / releasing the lock as suggested by Jan Kara.
> 
> RFC: https://patchwork.ozlabs.org/project/linux-ext4/patch/20251223131342.287864-1-me@linux.beauty/
> 
>  fs/ext4/ext4.h        | 16 ++++++++++++++
>  fs/ext4/fast_commit.c | 51 ++++++++++++++++++++++++-------------------
>  2 files changed, 44 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 57087da6c7be..933297251f66 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1771,6 +1771,10 @@ struct ext4_sb_info {
>  	 * Main fast commit lock. This lock protects accesses to the
>  	 * following fields:
>  	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
> +	 *
> +	 * s_fc_lock can be taken from reclaim context (inode eviction) and is
> +	 * thus reclaim unsafe. Use ext4_fc_lock()/ext4_fc_unlock() helpers
> +	 * when acquiring / releasing the lock.
>  	 */
>  	struct mutex s_fc_lock;
>  	struct buffer_head *s_fc_bh;
> @@ -1815,6 +1819,18 @@ static inline void ext4_writepages_up_write(struct super_block *sb, int ctx)
>  	percpu_up_write(&EXT4_SB(sb)->s_writepages_rwsem);
>  }
>  
> +static inline int ext4_fc_lock(struct super_block *sb)
> +{
> +	mutex_lock(&EXT4_SB(sb)->s_fc_lock);
> +	return memalloc_nofs_save();
> +}
> +
> +static inline void ext4_fc_unlock(struct super_block *sb, int ctx)
> +{
> +	memalloc_nofs_restore(ctx);
> +	mutex_unlock(&EXT4_SB(sb)->s_fc_lock);
> +}
> +
>  static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
>  {
>  	return ino == EXT4_ROOT_INO ||
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 5727ff4e9273..2f28a089fc7e 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -231,16 +231,16 @@ static bool ext4_fc_disabled(struct super_block *sb)
>  void ext4_fc_del(struct inode *inode)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> -	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	struct ext4_fc_dentry_update *fc_dentry;
>  	wait_queue_head_t *wq;
> +	int alloc_ctx;
>  
>  	if (ext4_fc_disabled(inode->i_sb))
>  		return;
>  
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(inode->i_sb);
>  	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
> -		mutex_unlock(&sbi->s_fc_lock);
> +		ext4_fc_unlock(inode->i_sb, alloc_ctx);
>  		return;
>  	}
>  
> @@ -275,9 +275,9 @@ void ext4_fc_del(struct inode *inode)
>  #endif
>  		prepare_to_wait(wq, &wait.wq_entry, TASK_UNINTERRUPTIBLE);
>  		if (ext4_test_inode_state(inode, EXT4_STATE_FC_FLUSHING_DATA)) {
> -			mutex_unlock(&sbi->s_fc_lock);
> +			ext4_fc_unlock(inode->i_sb, alloc_ctx);
>  			schedule();
> -			mutex_lock(&sbi->s_fc_lock);
> +			alloc_ctx = ext4_fc_lock(inode->i_sb);
>  		}
>  		finish_wait(wq, &wait.wq_entry);
>  	}
> @@ -288,7 +288,7 @@ void ext4_fc_del(struct inode *inode)
>  	 * dentry create references, since it is not needed to log it anyways.
>  	 */
>  	if (list_empty(&ei->i_fc_dilist)) {
> -		mutex_unlock(&sbi->s_fc_lock);
> +		ext4_fc_unlock(inode->i_sb, alloc_ctx);
>  		return;
>  	}
>  
> @@ -298,7 +298,7 @@ void ext4_fc_del(struct inode *inode)
>  	list_del_init(&fc_dentry->fcd_dilist);
>  
>  	WARN_ON(!list_empty(&ei->i_fc_dilist));
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(inode->i_sb, alloc_ctx);
>  
>  	release_dentry_name_snapshot(&fc_dentry->fcd_name);
>  	kmem_cache_free(ext4_fc_dentry_cachep, fc_dentry);
> @@ -315,6 +315,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  	tid_t tid;
>  	bool has_transaction = true;
>  	bool is_ineligible;
> +	int alloc_ctx;
>  
>  	if (ext4_fc_disabled(sb))
>  		return;
> @@ -329,12 +330,12 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  			has_transaction = false;
>  		read_unlock(&sbi->s_journal->j_state_lock);
>  	}
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>  	if (has_transaction && (!is_ineligible || tid_gt(tid, sbi->s_fc_ineligible_tid)))
>  		sbi->s_fc_ineligible_tid = tid;
>  	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  	WARN_ON(reason >= EXT4_FC_REASON_MAX);
>  	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
>  }
> @@ -358,6 +359,7 @@ static int ext4_fc_track_template(
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
>  	tid_t tid = 0;
> +	int alloc_ctx;
>  	int ret;
>  
>  	tid = handle->h_transaction->t_tid;
> @@ -373,14 +375,14 @@ static int ext4_fc_track_template(
>  	if (!enqueue)
>  		return ret;
>  
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(inode->i_sb);
>  	if (list_empty(&EXT4_I(inode)->i_fc_list))
>  		list_add_tail(&EXT4_I(inode)->i_fc_list,
>  				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>  				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>  				&sbi->s_fc_q[FC_Q_STAGING] :
>  				&sbi->s_fc_q[FC_Q_MAIN]);
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(inode->i_sb, alloc_ctx);
>  
>  	return ret;
>  }
> @@ -402,6 +404,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
>  	struct inode *dir = dentry->d_parent->d_inode;
>  	struct super_block *sb = inode->i_sb;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	int alloc_ctx;
>  
>  	spin_unlock(&ei->i_fc_lock);
>  
> @@ -425,7 +428,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
>  	take_dentry_name_snapshot(&node->fcd_name, dentry);
>  	INIT_LIST_HEAD(&node->fcd_dilist);
>  	INIT_LIST_HEAD(&node->fcd_list);
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>  		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
>  		list_add_tail(&node->fcd_list,
> @@ -446,7 +449,7 @@ static int __track_dentry_update(handle_t *handle, struct inode *inode,
>  		WARN_ON(!list_empty(&ei->i_fc_dilist));
>  		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>  	}
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  	spin_lock(&ei->i_fc_lock);
>  
>  	return 0;
> @@ -1051,18 +1054,19 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	struct blk_plug plug;
>  	int ret = 0;
>  	u32 crc = 0;
> +	int alloc_ctx;
>  
>  	/*
>  	 * Step 1: Mark all inodes on s_fc_q[MAIN] with
>  	 * EXT4_STATE_FC_FLUSHING_DATA. This prevents these inodes from being
>  	 * freed until the data flush is over.
>  	 */
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>  		ext4_set_inode_state(&iter->vfs_inode,
>  				     EXT4_STATE_FC_FLUSHING_DATA);
>  	}
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  
>  	/* Step 2: Flush data for all the eligible inodes. */
>  	ret = ext4_fc_flush_data(journal);
> @@ -1072,7 +1076,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	 * any error from step 2. This ensures that waiters waiting on
>  	 * EXT4_STATE_FC_FLUSHING_DATA can resume.
>  	 */
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>  		ext4_clear_inode_state(&iter->vfs_inode,
>  				       EXT4_STATE_FC_FLUSHING_DATA);
> @@ -1089,7 +1093,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	 * prepare_to_wait() in ext4_fc_del().
>  	 */
>  	smp_mb();
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  
>  	/*
>  	 * If we encountered error in Step 2, return it now after clearing
> @@ -1106,12 +1110,12 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	 * previous handles are now drained. We now mark the inodes on the
>  	 * commit queue as being committed.
>  	 */
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
>  		ext4_set_inode_state(&iter->vfs_inode,
>  				     EXT4_STATE_FC_COMMITTING);
>  	}
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  	jbd2_journal_unlock_updates(journal);
>  
>  	/*
> @@ -1122,6 +1126,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  		blkdev_issue_flush(journal->j_fs_dev);
>  
>  	blk_start_plug(&plug);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	/* Step 6: Write fast commit blocks to disk. */
>  	if (sbi->s_fc_bytes == 0) {
>  		/*
> @@ -1139,7 +1144,6 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	}
>  
>  	/* Step 6.2: Now write all the dentry updates. */
> -	mutex_lock(&sbi->s_fc_lock);
>  	ret = ext4_fc_commit_dentry_updates(journal, &crc);
>  	if (ret)
>  		goto out;
> @@ -1161,7 +1165,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
>  	ret = ext4_fc_write_tail(sb, crc);
>  
>  out:
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  	blk_finish_plug(&plug);
>  	return ret;
>  }
> @@ -1295,6 +1299,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_inode_info *ei;
>  	struct ext4_fc_dentry_update *fc_dentry;
> +	int alloc_ctx;
>  
>  	if (full && sbi->s_fc_bh)
>  		sbi->s_fc_bh = NULL;
> @@ -1302,7 +1307,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  	trace_ext4_fc_cleanup(journal, full, tid);
>  	jbd2_fc_release_bufs(journal);
>  
> -	mutex_lock(&sbi->s_fc_lock);
> +	alloc_ctx = ext4_fc_lock(sb);
>  	while (!list_empty(&sbi->s_fc_q[FC_Q_MAIN])) {
>  		ei = list_first_entry(&sbi->s_fc_q[FC_Q_MAIN],
>  					struct ext4_inode_info,
> @@ -1361,7 +1366,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full, tid_t tid)
>  
>  	if (full)
>  		sbi->s_fc_bytes = 0;
> -	mutex_unlock(&sbi->s_fc_lock);
> +	ext4_fc_unlock(sb, alloc_ctx);
>  	trace_ext4_fc_stats(sb);
>  }
>  


