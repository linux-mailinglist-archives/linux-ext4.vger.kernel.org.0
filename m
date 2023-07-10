Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C83F74D33C
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jul 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjGJKVp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jul 2023 06:21:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGJKVo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jul 2023 06:21:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B133695
        for <linux-ext4@vger.kernel.org>; Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b8ad8383faso31933475ad.0
        for <linux-ext4@vger.kernel.org>; Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1688984502; x=1691576502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oqufQ/p2OjbA3yfpb1YX+Q16BF65bMBJOaY+VuJd1j0=;
        b=U1i4x1nuapnPR8UEZsLtVMVnvY5UK2mHfDtqLVPeMZWxXCVWnPV3nC7c72q+AMENn8
         zWOKzOGExdJCOxrYU4p6SOdgRUcca4BAYHWz15X3NE7WV993vuU/DFXFkr1SWgbbA7Y8
         Z5p0cT9XIpFrSA06XAtSRIfO5eh9AMf7O7yFaH15HNTX3V2nAt6j07Re72JcS6ypFJeh
         fNSNLtXcmU+Z9xoOJ62+GwIrXkpvIHPTyNJqV1aGP0Ei8IJEjWsCrAQesTsS2AIKWEpT
         yaRkZjfxUMV7NTs2Nzf461HsI/lHi7KUhS6rF60xEpU8RN5A8Z9DZAygbZZzI0hJqBXI
         +f+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688984502; x=1691576502;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oqufQ/p2OjbA3yfpb1YX+Q16BF65bMBJOaY+VuJd1j0=;
        b=Ezog4D1SWPqjQBQeJ5VOS4yxD0Bi0zd57I0iv8aV26SBRtDUqkrSXJCbbvUdem+MxW
         dSjkDhQeAhwgSr9F2ZfFx6fairJnBaXrnlNSRsUTInBLsYcFJz4neF2AgfAFrB8nHY8f
         VCd1xKIh6HqZRpRh773+Yrz7MPwKTHgOqR/FqX9Ay7iO+lgwKKLTNBW15XeBJZ9KjpnE
         EudCP5ZhTZ470N4O0uzEV2nULuQcyR47OhALVLEaJa57Lwbli7M0TJvKmhNq4o2Q+3JT
         GYXoCSQQlWjG0ejg0OSABjYsNJyLzvNOptGlvG9lkm4wSh+88q28b6qURX2mCi5bSiUI
         UPdg==
X-Gm-Message-State: ABy/qLakktuMEYFr4Et9I35iOsy1svJ9huHdQiCE4HnMk13Elf6GfUjF
        7C+zzMZENoXio8ghObFjsQ+7pvtQe9IlDotINbg=
X-Google-Smtp-Source: APBJJlEwJm4ABV/SXJklRj9ZSbE14K8I8MwJNH+t/IS63BSGVKmyiro2peJ+5nMUTT/s76cMO38j8Q==
X-Received: by 2002:a17:902:e5c5:b0:1b8:4f92:565e with SMTP id u5-20020a170902e5c500b001b84f92565emr14422055plf.21.1688984502177;
        Mon, 10 Jul 2023 03:21:42 -0700 (PDT)
Received: from [10.254.35.30] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id iz2-20020a170902ef8200b001b523714ed5sm7894167plb.252.2023.07.10.03.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 03:21:41 -0700 (PDT)
Message-ID: <0470814d-a233-0b8c-4d29-ff0cc34e12c4@bytedance.com>
Date:   Mon, 10 Jul 2023 18:21:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] ext4: Make running and commit transaction have their own
 freed_data_list
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230612124017.14115-1-hanjinke.666@bytedance.com>
From:   hanjinke <hanjinke.666@bytedance.com>
In-Reply-To: <20230612124017.14115-1-hanjinke.666@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, Ted

Can you consider this patch？ As it was already Reviewed by Zhang Yi.

Thanks
Jinke

在 2023/6/12 下午8:40, Jinke Han 写道:
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
> ---
>   fs/ext4/ext4.h    |  2 +-
>   fs/ext4/mballoc.c | 19 +++++--------------
>   2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 813b4da098a0..356905357dc9 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1557,7 +1557,7 @@ struct ext4_sb_info {
>   	unsigned int *s_mb_maxs;
>   	unsigned int s_group_info_size;
>   	unsigned int s_mb_free_pending;
> -	struct list_head s_freed_data_list;	/* List of blocks to be freed
> +	struct list_head s_freed_data_list[2];	/* List of blocks to be freed
>   						   after commit completed */
>   	struct list_head s_discard_list;
>   	struct work_struct s_discard_work;
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4f2a1df98141..8fab5720a979 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3626,7 +3626,8 @@ int ext4_mb_init(struct super_block *sb)
>   
>   	spin_lock_init(&sbi->s_md_lock);
>   	sbi->s_mb_free_pending = 0;
> -	INIT_LIST_HEAD(&sbi->s_freed_data_list);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[0]);
> +	INIT_LIST_HEAD(&sbi->s_freed_data_list[1]);
>   	INIT_LIST_HEAD(&sbi->s_discard_list);
>   	INIT_WORK(&sbi->s_discard_work, ext4_discard_work);
>   	atomic_set(&sbi->s_retry_alloc_pending, 0);
> @@ -3878,21 +3879,11 @@ void ext4_process_freed_data(struct super_block *sb, tid_t commit_tid)
>   	struct ext4_sb_info *sbi = EXT4_SB(sb);
>   	struct ext4_free_data *entry, *tmp;
>   	struct list_head freed_data_list;
> -	struct list_head *cut_pos = NULL;
> +	struct list_head *s_freed_head = &sbi->s_freed_data_list[commit_tid & 1];
>   	bool wake;
>   
>   	INIT_LIST_HEAD(&freed_data_list);
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
>   	list_for_each_entry(entry, &freed_data_list, efd_list)
>   		ext4_free_data_in_buddy(sb, entry);
> @@ -6298,7 +6289,7 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>   	}
>   
>   	spin_lock(&sbi->s_md_lock);
> -	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list);
> +	list_add_tail(&new_entry->efd_list, &sbi->s_freed_data_list[new_entry->efd_tid & 1]);
>   	sbi->s_mb_free_pending += clusters;
>   	spin_unlock(&sbi->s_md_lock);
>   }
