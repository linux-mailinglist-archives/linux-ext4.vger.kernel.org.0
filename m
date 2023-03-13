Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922876B6D4C
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 03:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjCMCHm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 12 Mar 2023 22:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCMCHm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 12 Mar 2023 22:07:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82042B9E3;
        Sun, 12 Mar 2023 19:07:39 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id ja10so1663068plb.5;
        Sun, 12 Mar 2023 19:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678673259;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ETGMCUIeuaC3YdqUsj8bExpKFMxTckVOTqA6XwVpiP4=;
        b=ZRPxkmCscyCNmL6blAdHSFbANU2xTvxVNmUg2rB98nKESw3KMQADcyy61cFE8D4uzv
         ga9MM6cFEh3p2d0Zg+xbZC0nAh2UM9Z7n9E1eSniaONkPL6TTJNfSOE/39qOarFvkh5Q
         q937iNOda0ywuOH6e6QbUKWUu8Z+oARkzr7L3yBb6L9EstgOf+uynOd3oKBfBM2o3H3F
         lgi5gpb0+1yNNUoI3JYxD9P20Q2yAmM29QWXR3RDjwr77ZJTuQdnZ+8PKIl1YdAZ0ZOT
         4iwap9B+eDvPCNLlfR8E+tWa8lIF6T8S5Z/cOTAoxywpG7ZOMG+XEPsP+tsyusCp4nFB
         Lgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678673259;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETGMCUIeuaC3YdqUsj8bExpKFMxTckVOTqA6XwVpiP4=;
        b=j1v7ggtC8ZFnEI7343iot+vy6vDKBeT0kUHX6j+/2VK9dWVknb4OdwXiU2Gyn8fJQ7
         MmZORe3jKUg8Nb/EAIEAap0YY0lfnZo6UFcDV58N2gzPL23u8aACT17hKi0aweHzwo+Z
         ePSdVx3BWuX0vbOfJcggOZGRsgA+O8zAw0HZIOIfBJk149ASUzjfoBcrVTR5dC21UP1t
         7GlbfOpx3us955eAEV+GDiBaNrPcoFOjejoxTbq/IBUr8m6GheJogdq+ereCF0YQdYtV
         FK5b/PYvEIg3wkQh45pFJo3JvblT2O7TPdgo66oop6/6chm7bfyWVZti3YEC6MDKVj7H
         Je+g==
X-Gm-Message-State: AO0yUKUxVlXhP/u+LVpqboNVxti74FUFJxdWopQfPvLuQ68Xd4ICEGBO
        JqesEMI/nkaXJEY5RVkHYSI7wtlurBmxUQ==
X-Google-Smtp-Source: AK7set+l6TfjCrGbYnsl44f0IGPcL5G31+rD9WVKutk4rrFbyB4yvLUoPqwe7y+pyX6hshqtmYakRw==
X-Received: by 2002:a17:902:d492:b0:19c:b7da:fbdf with SMTP id c18-20020a170902d49200b0019cb7dafbdfmr41541264plg.26.1678673259068;
        Sun, 12 Mar 2023 19:07:39 -0700 (PDT)
Received: from rh-tp ([2406:7400:63:469f:1474:7c59:3a57:aab6])
        by smtp.gmail.com with ESMTPSA id kq3-20020a170903284300b0019aaba5c90bsm3473321plb.84.2023.03.12.19.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 19:07:38 -0700 (PDT)
Date:   Mon, 13 Mar 2023 07:37:21 +0530
Message-Id: <87wn3lflpi.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, ojaswin@linux.ibm.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        shikemeng@huaweicloud.com
Subject: Re: [PATCH v3 01/20] ext4: set goal start correctly in ext4_mb_normalize_request
In-Reply-To: <20230303172120.3800725-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> We need to set ac_g_ex to notify the goal start used in
> ext4_mb_find_by_goal. Set ac_g_ex instead of ac_f_ex in
> ext4_mb_normalize_request.
> Besides we should assure goal start is in range [first_data_block,
> blocks_count) as ext4_mb_initialize_context does.

Thanks for looking into the failed test case.
Patch looks good to me. After going through the change, I also feel we
should be updating ac_g_ex instead of ac_f_ex.

Good spotting! Please feel free to add -

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 5b2ae37a8b80..36cd545f5ab4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3993,6 +3993,7 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  				struct ext4_allocation_request *ar)
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> +	struct ext4_super_block *es = sbi->s_es;
>  	int bsbits, max;
>  	ext4_lblk_t end;
>  	loff_t size, start_off;
> @@ -4188,18 +4189,20 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	ac->ac_g_ex.fe_len = EXT4_NUM_B2C(sbi, size);
>
>  	/* define goal start in order to merge */
> -	if (ar->pright && (ar->lright == (start + size))) {
> +	if (ar->pright && (ar->lright == (start + size)) &&
> +	    ar->pright - size >= le32_to_cpu(es->s_first_data_block)) {
>  		/* merge to the right */
>  		ext4_get_group_no_and_offset(ac->ac_sb, ar->pright - size,
> -						&ac->ac_f_ex.fe_group,
> -						&ac->ac_f_ex.fe_start);
> +						&ac->ac_g_ex.fe_group,
> +						&ac->ac_g_ex.fe_start);
>  		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
>  	}
> -	if (ar->pleft && (ar->lleft + 1 == start)) {
> +	if (ar->pleft && (ar->lleft + 1 == start) &&
> +	    ar->pleft + 1 < ext4_blocks_count(es)) {
>  		/* merge to the left */
>  		ext4_get_group_no_and_offset(ac->ac_sb, ar->pleft + 1,
> -						&ac->ac_f_ex.fe_group,
> -						&ac->ac_f_ex.fe_start);
> +						&ac->ac_g_ex.fe_group,
> +						&ac->ac_g_ex.fe_start);
>  		ac->ac_flags |= EXT4_MB_HINT_TRY_GOAL;
>  	}
>
> --
> 2.30.0
