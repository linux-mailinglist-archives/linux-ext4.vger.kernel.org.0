Return-Path: <linux-ext4+bounces-6059-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB63A0B938
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 15:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A98F43A401E
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2025 14:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E550354782;
	Mon, 13 Jan 2025 14:16:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853C74D8CE
	for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736777797; cv=none; b=JQDQXQGIl0s68udU4dXkqH//oDnM25NQuOY5rogpW5oFKhU8dkG0UlzSJ+TV/JO/JFhS0QaY7KGpKIm/D1jLCenmlDZtLYdySoT8qIyNYxXrIUW451dMklyLrQaSbXcd86/EvoFaQxROapx0mG3kWvqHSi0vEyHMg5Rt0Q4BYtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736777797; c=relaxed/simple;
	bh=qbyHS5jKKji5V4jvOJ9e6g4dMyytfrhnpViDEymMCP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=c+eH1nYbJSD4w1xejDQ7m5iCcjF9IjgbCmYC45JLY3jGt+jT8qDV10eejvaBOCixUbE/aF006PTguDC9Z2MNc9LH1pAkQ1wrS6mLTi1xvyTT6FXF2n7KWGRKz3uU9Z35aQn9TBd5m4zgDntwz8Otj6tVvuHuXcob8b6cmyk9qNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4YWvQC0rswz22l4f;
	Mon, 13 Jan 2025 22:14:11 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id B2943140361;
	Mon, 13 Jan 2025 22:16:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 13 Jan
 2025 22:16:30 +0800
Message-ID: <40b04c68-377b-4770-bff1-ecff8afa70e9@huawei.com>
Date: Mon, 13 Jan 2025 22:16:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 9/9] ext4: hold s_fc_lock while during fast commit
To: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
CC: <linux-ext4@vger.kernel.org>, <tytso@mit.edu>, <jack@suse.cz>,
	<harshads@google.com>, Baokun Li <libaokun1@huawei.com>, Yang Erkun
	<yangerkun@huawei.com>
References: <20240818040356.241684-1-harshadshirwadkar@gmail.com>
 <20240818040356.241684-11-harshadshirwadkar@gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20240818040356.241684-11-harshadshirwadkar@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

Hi Harshad,

On 2024/8/18 12:03, Harshad Shirwadkar wrote:
> Leaving s_fc_lock in between during commit in ext4_fc_perform_commit()
> function leaves room for subtle concurrency bugs where ext4_fc_del() may
> delete an inode from the fast commit list, leaving list in an inconsistent
> state. Also, this patch converts s_fc_lock to mutex type so that it can be
> held when kmem_cache_* functions are called.
>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>   fs/ext4/ext4.h        |  2 +-
>   fs/ext4/fast_commit.c | 91 +++++++++++++++++--------------------------
>   fs/ext4/super.c       |  2 +-
>   3 files changed, 38 insertions(+), 57 deletions(-)
>
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 4ecb63f95..a1acd34ff 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1748,7 +1748,7 @@ struct ext4_sb_info {
>   	 * following fields:
>   	 * ei->i_fc_list, s_fc_dentry_q, s_fc_q, s_fc_bytes, s_fc_bh.
>   	 */
> -	spinlock_t s_fc_lock;
> +	struct mutex s_fc_lock;
>   	struct buffer_head *s_fc_bh;
>   	struct ext4_fc_stats s_fc_stats;
>   	tid_t s_fc_ineligible_tid;
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 7525450f1..c3627efd9 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -236,9 +236,9 @@ void ext4_fc_del(struct inode *inode)
>   	if (ext4_fc_disabled(inode->i_sb))
>   		return;
>   
> -	spin_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +	mutex_lock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>   	if (list_empty(&ei->i_fc_list) && list_empty(&ei->i_fc_dilist)) {
> -		spin_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
> +		mutex_unlock(&EXT4_SB(inode->i_sb)->s_fc_lock);
>   		return;
>   	}
>   
> @@ -266,7 +266,7 @@ void ext4_fc_del(struct inode *inode)
>   	 * dentry create references, since it is not needed to log it anyways.
>   	 */
>   	if (list_empty(&ei->i_fc_dilist)) {
> -		spin_unlock(&sbi->s_fc_lock);
> +		mutex_unlock(&sbi->s_fc_lock);
>   		return;
>   	}
>   
> @@ -276,7 +276,7 @@ void ext4_fc_del(struct inode *inode)
>   	list_del_init(&fc_dentry->fcd_dilist);
>   
>   	WARN_ON(!list_empty(&ei->i_fc_dilist));
> -	spin_unlock(&sbi->s_fc_lock);
> +	mutex_unlock(&sbi->s_fc_lock);
>   
>   	if (fc_dentry->fcd_name.name &&
>   		fc_dentry->fcd_name.len > DNAME_INLINE_LEN)
> @@ -306,10 +306,10 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>   				sbi->s_journal->j_running_transaction->t_tid : 0;
>   		read_unlock(&sbi->s_journal->j_state_lock);
>   	}
> -	spin_lock(&sbi->s_fc_lock);
> +	mutex_lock(&sbi->s_fc_lock);
>   	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
>   		sbi->s_fc_ineligible_tid = tid;
> -	spin_unlock(&sbi->s_fc_lock);
> +	mutex_unlock(&sbi->s_fc_lock);
>   	WARN_ON(reason >= EXT4_FC_REASON_MAX);
>   	sbi->s_fc_stats.fc_ineligible_reason_count[reason]++;
>   }
> @@ -349,14 +349,14 @@ static int ext4_fc_track_template(
>   	if (!enqueue)
>   		return ret;
>   
> -	spin_lock(&sbi->s_fc_lock);
> +	mutex_lock(&sbi->s_fc_lock);
>   	if (list_empty(&EXT4_I(inode)->i_fc_list))
>   		list_add_tail(&EXT4_I(inode)->i_fc_list,
>   				(sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>   				 sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING) ?
>   				&sbi->s_fc_q[FC_Q_STAGING] :
>   				&sbi->s_fc_q[FC_Q_MAIN]);
> -	spin_unlock(&sbi->s_fc_lock);
> +	mutex_unlock(&sbi->s_fc_lock);
>   
>   	return ret;
>   }
> @@ -414,7 +414,8 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>   	}
>   	node->fcd_name.len = dentry->d_name.len;
>   	INIT_LIST_HEAD(&node->fcd_dilist);
> -	spin_lock(&sbi->s_fc_lock);
> +	INIT_LIST_HEAD(&node->fcd_list);
> +	mutex_lock(&sbi->s_fc_lock);
>   	if (sbi->s_journal->j_flags & JBD2_FULL_COMMIT_ONGOING ||
>   		sbi->s_journal->j_flags & JBD2_FAST_COMMIT_ONGOING)
>   		list_add_tail(&node->fcd_list,
> @@ -435,7 +436,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>   		WARN_ON(!list_empty(&ei->i_fc_dilist));
>   		list_add_tail(&node->fcd_dilist, &ei->i_fc_dilist);
>   	}
> -	spin_unlock(&sbi->s_fc_lock);
> +	mutex_unlock(&sbi->s_fc_lock);
>   	spin_lock(&ei->i_fc_lock);
>   
>   	return 0;
> @@ -955,15 +956,15 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
>   	struct ext4_inode_info *ei;
>   	int ret = 0;
>   
> -	spin_lock(&sbi->s_fc_lock);
> +	mutex_lock(&sbi->s_fc_lock);
>   	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
> -		spin_unlock(&sbi->s_fc_lock);
> +		mutex_unlock(&sbi->s_fc_lock);
>   		ret = jbd2_submit_inode_data(journal, ei->jinode);
>   		if (ret)
>   			return ret;
> -		spin_lock(&sbi->s_fc_lock);
> +		mutex_lock(&sbi->s_fc_lock);
>   	}
> -	spin_unlock(&sbi->s_fc_lock);
> +	mutex_unlock(&sbi->s_fc_lock);
>   
We're also seeing a similar race condition here. This issue was encountered
while running `kvm-xfstests -c ext4/adv -C 500 generic/241`:

     P1                |         P2
----------------------------------------------------
                            evict
                             ext4_evict_inode
                              ext4_free_inode
                               ext4_clear_inode
                                ext4_fc_del(inode)
ext4_sync_file
  ext4_fsync_journal
   ext4_fc_commit
    ext4_fc_perform_commit
     ext4_fc_submit_inode_data_all
      -- spin_lock(&sbi->s_fc_lock);
       list_for_each_entry(i_fc_list)
         -- spin_unlock(&sbi->s_fc_lock);
                                -- spin_lock(&sbi->s_fc_lock)
                                  if (!list_empty(&ei->i_fc_list))
list_del_init(&ei->i_fc_list);
                                -- spin_unlock(&sbi->s_fc_lock);
jbd2_free_inode(EXT4_I(inode)->jinode)
                                EXT4_I(inode)->jinode = NULL
          jbd2_submit_inode_data
           journal->j_submit_inode_data_buffers
            ext4_journal_submit_inode_data_buffers
             ext4_should_journal_data(jinode->i_vfs_inode)
              // a. jinode may use-after-free !!!
              ext4_inode_journal_mode(inode)
               EXT4_JOURNAL(inode)
                (inode)->i_sb
                 // b. inode may null-ptr-deref !!!
         -- spin_lock(&sbi->s_fc_lock);
      -- spin_unlock(&sbi->s_fc_lock);

By the way, the WARN_ON added in patch 5 can detect this issue without
enabling KASAN, but patch 5 also introduced softlocks and other UAFs.


Regards,
Baokun


