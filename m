Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6078372C8A6
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 16:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235691AbjFLOfj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Jun 2023 10:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237448AbjFLOed (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 12 Jun 2023 10:34:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC782951;
        Mon, 12 Jun 2023 07:34:11 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QfvHt6ySKztQSZ;
        Mon, 12 Jun 2023 22:31:06 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 22:33:34 +0800
Subject: Re: [PATCH] ext4: Make running and commit transaction have their own
 freed_data_list
To:     Jinke Han <hanjinke.666@bytedance.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230612124017.14115-1-hanjinke.666@bytedance.com>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <3f30183c-5b8e-8214-0b6b-b825a944143c@huawei.com>
Date:   Mon, 12 Jun 2023 22:33:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20230612124017.14115-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/6/12 20:40, Jinke Han wrote:
> From: Jinke Han <hanjinke.666@bytedance.com>
> 
> When releasing space in jbd, we traverse s_freed_data_list to get the
> free range belonging to the current commit transaction. In extreme cases,
> the time spent may not be small, and we have observed cases exceeding
> 10ms. This patch makes running and commit transactions manage their own
> free_data_list respectively, eliminating unnecessary traversal.
> 
> And in the callback phase of the commit transaction, no one will touch
> it except the jbd thread itself, so s_md_lock is no longer needed.
> 
> Signed-off-by: Jinke Han <hanjinke.666@bytedance.com>

Thanks for the patch, it looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/ext4.h    |  2 +-
>  fs/ext4/mballoc.c | 19 +++++--------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 813b4da098a0..356905357dc9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1557,7 +1557,7 @@ struct ext4_sb_info {
>  	unsigned int *s_mb_maxs;
>  	unsigned int s_group_info_size;
>  	unsigned int s_mb_free_pending;
> -	struct list_head s_freed_data_list;	/* List of blocks to be freed
> +	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
>  						   after commit completed */
>  	struct list_head s_discard_list;
>  	struct work_struct s_discard_work;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f2a1df98141..8fab5720a979 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3626,7 +3626,8 @@ int ext4_mb_init(struct super_block *sb)
>  
>  	spin_lock_init(&sbi->s_md_lock);
>  	sbi->s_mb_free_pending = 0;
> -	INIT_LIST_HEAD(&sbi->s_freed_data_list);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
>  	INIT_LIST_HEAD(&sbi->s_discard_list);
>  	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
>  	atomic_set(&sbi->s_retry_alloc_pending, 0);
> @@ -3878,21 +3879,11 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	struct ext4_free_data *entry, *tmp;
>  	struct list_head freed_data_list;
> -	struct list_head *cut_pos = NULL;
> +	struct list_head *s_freed_head = &sbi->s_freed_data_list[commit_tid & 1];
>  	bool wake;
>  
>  	INIT_LIST_HEAD(&freed_data_list);
> -
> -	spin_lock(&sbi->s_md_lock);
> -	list_for_each_entry(entry, &sbi->s_freed_data_list, efd_list) {
> -		if (entry->efd_tid != commit_tid)
> -			break;
> -		cut_pos = &entry->efd_list;
> -	}
> -	if (cut_pos)
> -		list_cut_position(&freed_data_list, &sbi->s_freed_data_list,
> -				  cut_pos);
> -	spin_unlock(&sbi->s_md_lock);
> +	list_replace_init(s_freed_head, &freed_data_list);
>  
>  	list_for_each_entry(entry, &freed_data_list, efd_list)
>  		ext4_free_data_in_buddy(sb, entry);
> @@ -6298,7 +6289,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  	}
>  
>  	spin_lock(&sbi->s_md_lock);
> -	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
> +	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
>  	sbi->s_mb_free_pending += clusters;
>  	spin_unlock(&sbi->s_md_lock);
>  }
> 
