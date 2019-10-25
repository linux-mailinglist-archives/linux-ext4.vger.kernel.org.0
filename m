Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 370F4E438D
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2019 08:28:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391788AbfJYG2a (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Oct 2019 02:28:30 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:51999 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389669AbfJYG2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Oct 2019 02:28:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Tg86W42_1571984887;
Received: from 30.5.113.164(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0Tg86W42_1571984887)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Oct 2019 14:28:23 +0800
Subject: Re: [PATCH v3 11/13] ext4: add support for asynchronous fast commits
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
References: <20191001074101.256523-1-harshadshirwadkar@gmail.com>
 <20191001074101.256523-12-harshadshirwadkar@gmail.com>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Message-ID: <d5d6f55e-6637-6d10-5228-0a7e6d885b9e@linux.alibaba.com>
Date:   Fri, 25 Oct 2019 14:28:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001074101.256523-12-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

> Until this patch, fast commits could only be invoked by jbd2 thread.
> This patch allows file system to perform fast commit in an async manner
> without involving jbd2 thread. This makes fast commits even faster as
> it gets rid of the time spent in context switching to jbd2 thread. In
> order to avoid race between jbd2 thread and async fast commits, we add
> new jbd2 APIs that allow file systems to indicate their intent of
> performing an async fast commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/ext4.h        |  3 ++
>   fs/ext4/ext4_jbd2.c   | 74 +++++++++++++++++++++++++++++++++++++++++++
>   fs/ext4/fsync.c       |  7 ++--
>   fs/jbd2/commit.c      | 11 +++++++
>   fs/jbd2/journal.c     | 59 ++++++++++++++++++++++++++++++++++
>   fs/jbd2/transaction.c |  2 ++
>   include/linux/jbd2.h  | 10 ++++++
>   7 files changed, 164 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index cd5b567d8ca8..a8a481c5ffa4 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2716,6 +2716,9 @@ extern int ext4_group_extend(struct super_block *sb,
>   extern int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count);
>   
>   /* super.c */
> +int ext4_fc_async_commit(journal_t *journal, tid_t commit_tid,
> +			 tid_t commit_subtid, struct inode *inode,
> +			 struct dentry *dentry);
>   extern struct buffer_head *ext4_sb_bread(struct super_block *sb,
>   					 sector_t block, int op_flags);
>   extern int ext4_seq_options_show(struct seq_file *seq, void *offset);
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index 12d6e70bf676..cf796268322b 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -1144,6 +1144,80 @@ static int ext4_journal_fc_replay_cb(journal_t *journal, struct buffer_head *bh,
>   	return ret;
>   }
>   
> +int ext4_fc_async_commit(journal_t *journal, tid_t commit_tid,
> +			 tid_t commit_subtid, struct inode *inode,
> +			 struct dentry *dentry)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct super_block *sb = inode->i_sb;
> +	struct buffer_head *bh;
> +	int ret;
> +
> +	if (!ext4_should_fast_commit(sb))
> +		return jbd2_complete_transaction(journal, commit_tid);
> +
> +	read_lock(&ei->i_fc.fc_lock);
> +	if (ei->i_fc.fc_tid != commit_tid) {
> +		read_unlock(&ei->i_fc.fc_lock);
> +		return 0;
> +	}
> +	read_unlock(&ei->i_fc.fc_lock);
> +
> +	if (ext4_is_inode_fc_ineligible(inode))
> +		return jbd2_complete_transaction(journal, commit_tid);
> +
> +	if (jbd2_commit_check(journal, commit_tid, commit_subtid))
> +		return 0;
> +
> +	ret = jbd2_start_async_fc(journal, commit_tid);
> +	if (ret)
> +		return jbd2_fc_complete_commit(journal, commit_tid,
> +					       commit_subtid);
> +
> +	trace_ext4_journal_fc_commit_cb_start(sb);
> +
> +	ret = jbd2_submit_inode_data(journal, ei->jinode);
> +	if (ret)
> +		goto out;
> +
> +	ret = jbd2_map_fc_buf(journal, &bh);
> +	if (ret) {
> +		jbd2_stop_async_fc(journal, commit_tid);
> +		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "map_fc_buf");
> +		return jbd2_complete_transaction(journal, commit_tid);
> +
> +	}
> +
> +	ret = ext4_fc_write_inode(journal, bh, inode, commit_tid,
> +				  commit_subtid, 1, dentry);
> +
> +	if (ret < 0) {
> +		brelse(bh);
> +		jbd2_stop_async_fc(journal, commit_tid);
> +		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "fc_write_inode");
> +		return jbd2_complete_transaction(journal, commit_tid);
> +	}
> +	lock_buffer(bh);
> +	clear_buffer_dirty(bh);
> +	set_buffer_uptodate(bh);
> +	bh->b_end_io = ext4_end_buffer_io_sync;
> +	submit_bh(REQ_OP_WRITE, REQ_SYNC, bh);
> +
> +	jbd2_stop_async_fc(journal, commit_tid);
> +	wait_on_buffer(bh);
> +	if (unlikely(!buffer_uptodate(bh))) {
> +		trace_ext4_journal_fc_commit_cb_stop(sb, 0, "IO");
> +		return -EIO;
> +	}
> +
> +out:
> +	trace_ext4_journal_fc_commit_cb_stop(sb,
> +					     ret < 0 ? 0 : ret,
> +					     ret >= 0 ? "success" : "fail");
> +	wake_up(&journal->j_wait_async_fc);
> +	return ret;
> +}
> +
>   void ext4_init_fast_commit(struct super_block *sb, journal_t *journal)
>   {
>   	if (ext4_should_fast_commit(sb)) {
> diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
> index 5508baa11bb6..5bbfc55e1756 100644
> --- a/fs/ext4/fsync.c
> +++ b/fs/ext4/fsync.c
> @@ -98,7 +98,7 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>   	struct ext4_inode_info *ei = EXT4_I(inode);
>   	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>   	int ret = 0, err;
> -	tid_t commit_tid;
> +	tid_t commit_tid, commit_subtid;
>   	bool needs_barrier = false;
>   
>   	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
> @@ -148,10 +148,13 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
>   	}
>   
>   	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
> +	commit_subtid = datasync ? ei->i_datasync_subtid : ei->i_sync_subtid;
> +
>   	if (journal->j_flags & JBD2_BARRIER &&
>   	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
>   		needs_barrier = true;
> -	ret = jbd2_complete_transaction(journal, commit_tid);
> +	ret = ext4_fc_async_commit(journal, commit_tid, commit_subtid,
> +				   inode, file->f_path.dentry);
>   	if (needs_barrier) {
>   	issue_flush:
>   		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index e85f51e1cc70..18cb70fa2421 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -452,6 +452,17 @@ void jbd2_journal_commit_transaction(journal_t *journal, bool *fc)
>   
>   	write_lock(&journal->j_state_lock);
>   	full_commit = journal->j_do_full_commit;
> +	journal->j_running_transaction->t_async_fc_allowed = false;
> +	while (journal->j_running_transaction->t_async_fc_ongoing) {
> +		DEFINE_WAIT(wait);
> +
> +		prepare_to_wait(&journal->j_wait_async_fc, &wait,
> +				TASK_UNINTERRUPTIBLE);
> +		write_unlock(&journal->j_state_lock);
> +		schedule();
> +		write_lock(&journal->j_state_lock);
> +		finish_wait(&journal->j_wait_async_fc, &wait);
> +	}
>   	write_unlock(&journal->j_state_lock);
>   
>   	/* Let file-system try its own fast commit */
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e0684212384d..81daa2cff67f 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -794,6 +794,64 @@ int jbd2_commit_check(journal_t *journal, tid_t tid, tid_t subtid)
>   	return 0;
>   }
>   
> +int jbd2_start_async_fc(journal_t *journal, tid_t tid)
> +{
> +	transaction_t *txn;
> +	int ret = -EINVAL;
> +
> +	if (!journal->j_running_transaction)
> +		return ret;
> +
> +	if (journal->j_running_transaction->t_tid != tid)
> +		return ret;
> +
> +	txn = journal->j_running_transaction;
> +	write_lock(&journal->j_state_lock);
> +	while (txn->t_state == T_RUNNING) {
> +		DEFINE_WAIT(wait);
> +
> +		if (txn->t_async_fc_allowed) {
> +			if (!txn->t_async_fc_ongoing) {
> +				txn->t_async_fc_ongoing = true;
> +				ret = 0;
> +				break;
> +			}
> +			prepare_to_wait(&journal->j_wait_async_fc,
> +					&wait, TASK_UNINTERRUPTIBLE);
> +			write_unlock(&journal->j_state_lock);
> +			schedule();
> +			write_lock(&journal->j_state_lock);
> +			finish_wait(&journal->j_wait_async_fc, &wait);
It seems that above code logic will prevent concurrent fsync operations using fast
commit feature?

Regards,
Xiaoguang Wang

> +		} else {
> +			ret = -ECANCELED;
> +			break;
> +		}
> +	}
> +	write_unlock(&journal->j_state_lock);
> +
> +	return ret;
> +}
> +
> +int jbd2_stop_async_fc(journal_t *journal, tid_t tid)
> +{
> +	transaction_t *txn;
> +
> +	if (!journal->j_running_transaction)
> +		return -EINVAL;
> +
> +	if (journal->j_running_transaction->t_tid != tid)
> +		return -EINVAL;
> +
> +	txn = journal->j_running_transaction;
> +	write_lock(&journal->j_state_lock);
> +	J_ASSERT(txn->t_state == T_RUNNING);
> +	txn->t_async_fc_ongoing = false;
> +	txn->t_subtid++;
> +	write_unlock(&journal->j_state_lock);
> +	return 0;
> +
> +}
> +
>   /* Return 1 when transaction with given tid has already committed. */
>   int jbd2_transaction_committed(journal_t *journal, tid_t tid)
>   {
> @@ -1308,6 +1366,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>   	init_waitqueue_head(&journal->j_wait_commit);
>   	init_waitqueue_head(&journal->j_wait_updates);
>   	init_waitqueue_head(&journal->j_wait_reserved);
> +	init_waitqueue_head(&journal->j_wait_async_fc);
>   	mutex_init(&journal->j_barrier);
>   	mutex_init(&journal->j_checkpoint_mutex);
>   	spin_lock_init(&journal->j_revoke_lock);
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index ce7f03cfd90b..f17f813b5610 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -103,6 +103,8 @@ static void jbd2_get_transaction(journal_t *journal,
>   	transaction->t_max_wait = 0;
>   	transaction->t_start = jiffies;
>   	transaction->t_requested = 0;
> +	transaction->t_async_fc_allowed = true;
> +	transaction->t_async_fc_ongoing = false;
>   }
>   
>   /*
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 312103fc9581..5610f16de919 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -604,6 +604,7 @@ struct transaction_s
>   		T_FINISHED
>   	}			t_state;
>   
> +	bool t_async_fc_allowed, t_async_fc_ongoing;
>   	/*
>   	 * Where in the log does this transaction's commit start? [no locking]
>   	 */
> @@ -869,6 +870,13 @@ struct journal_s
>   	 */
>   	wait_queue_head_t	j_wait_reserved;
>   
> +	/**
> +	 * @j_wait_async_fc:
> +	 *
> +	 * Wait queue to wait for completion of async fast commits.
> +	 */
> +	wait_queue_head_t	j_wait_async_fc;
> +
>   	/**
>   	 * @j_checkpoint_mutex:
>   	 *
> @@ -1594,6 +1602,8 @@ int jbd2_complete_transaction(journal_t *journal, tid_t tid);
>   int jbd2_log_do_checkpoint(journal_t *journal);
>   int jbd2_trans_will_send_data_barrier(journal_t *journal, tid_t tid);
>   int jbd2_fc_complete_commit(journal_t *journal, tid_t tid, tid_t subtid);
> +int jbd2_start_async_fc(journal_t *journal, tid_t tid);
> +int jbd2_stop_async_fc(journal_t *journal, tid_t tid);
>   
>   void __jbd2_log_wait_for_space(journal_t *journal);
>   extern void __jbd2_journal_drop_transaction(journal_t *, transaction_t *);
> 
