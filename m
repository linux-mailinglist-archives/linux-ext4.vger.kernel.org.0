Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F5778EF8B
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Aug 2023 16:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjHaOZh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 31 Aug 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjHaOZh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 31 Aug 2023 10:25:37 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15520CF;
        Thu, 31 Aug 2023 07:25:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68a3cae6d94so733469b3a.0;
        Thu, 31 Aug 2023 07:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693491932; x=1694096732; darn=vger.kernel.org;
        h=in-reply-to:subject:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cs5Smo3QLeW2HAIH1ZIf/t0Tm8fHGvK+Q5R/+Rj3aIU=;
        b=iFlZtBfgYgXKLyQcvH2D8K1YBOnAR9+mh0aPxZHQF6JY+SCUrB98p8nxc2W84F0xRD
         toxKygwt5XxubxyBqmTKJnB5wyuozmq8b62sN/tcJxZKPjvFIr2fUosZpQFdi6Ho8Xfq
         Nd0VJHQBmy0jq/0IuVDsh54tKgGQ8ZZcevVFLJyx0b9o1PUY8pNl3+TVaOKvRiy+e1b8
         /RaeP0eRJRFkD9GrVvHHWXxniPUMxbY8PR3OA5XkLxuBDbcyj214btl+9J/T8qReaiKz
         2v6GeGe0uDDcwNg/uJ8MSPEISadw1T5jUj6KgjAw4UiV6mI107OKOFz7FK3Tu45BY7Qa
         dDsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693491932; x=1694096732;
        h=in-reply-to:subject:to:from:message-id:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cs5Smo3QLeW2HAIH1ZIf/t0Tm8fHGvK+Q5R/+Rj3aIU=;
        b=ew2V4FyzDK0M9VBaufhpWt11OTzs74/M+7oQdsaCA8ZVtqPQsJleA+8SFK1Ck9GDRH
         F99v/lm31cEw3JeNdqdyUuThzWwB+ubojwyYlVRxlaGsle3dVNqTwicBCR33GgSscqir
         L90yIwvYi0RWH8J+O7VcBqNQ9PSACH55euLRb3yyfDqeBcdOHHW2PgcQ8h67UNvU/fBU
         WJYJNzMpwleGq9xMdVfZ0hNi4LAPUSAwHXuA1rcCZJDJgz1Vql0YpkXFfFr9Ej0G3J9K
         iANR77gTtlqnRpz3ZvOOxG9UgBLQxE57Es7NRyDYd0xZVmsxuIdAVqzfnAa89Oca4aBy
         9KXA==
X-Gm-Message-State: AOJu0YwVNJnYINCBlN9Wkl7YuCH5nvOERtYFbrq8gFPzwixJ5oq9LMJ8
        nRsIGPeyCuap0tsD4nMRs6KJyGeaeh8=
X-Google-Smtp-Source: AGHT+IEvSd/oR1pqgQD+Dk9OaruNmblEC8LGIV9f/sbJIeCDkWh1gqoR40TShpl9pRubsYYWdwyHxg==
X-Received: by 2002:a05:6a20:2585:b0:132:bdba:5500 with SMTP id k5-20020a056a20258500b00132bdba5500mr6146013pzd.39.1693491931891;
        Thu, 31 Aug 2023 07:25:31 -0700 (PDT)
Received: from dw-tp ([49.207.223.191])
        by smtp.gmail.com with ESMTPSA id a22-20020a637f16000000b005697e8cc5f3sm1407544pgd.22.2023.08.31.07.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 07:25:31 -0700 (PDT)
Date:   Thu, 31 Aug 2023 19:55:27 +0530
Message-Id: <87jztb8f1k.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 02/11] ext4: call ext4_mb_mark_context in ext4_free_blocks_simple
In-Reply-To: <20230826155028.4019470-3-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Kemeng Shi <shikemeng@huaweicloud.com> writes:

> call ext4_mb_mark_context in ext4_free_blocks_simple to:
> 1. remove repeat code
> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
> 3. add missing ext4_lock_group/ext4_unlock_group protection.
>
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/mballoc.c | 35 +++--------------------------------
>  1 file changed, 3 insertions(+), 32 deletions(-)

Looks good to me. Please feel free to add - 

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

(One small comment below for previous patch)

>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e2be572deb75..c803f74aaf63 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6414,43 +6414,14 @@ ext4_mb_free_metadata(handle_t *handle, struct ext4_buddy *e4b,
>  static void ext4_free_blocks_simple(struct inode *inode, ext4_fsblk_t block,
>  					unsigned long count)
>  {
> -	struct buffer_head *bitmap_bh;
> +	struct ext4_mark_context mc;
>  	struct super_block *sb = inode->i_sb;
> -	struct ext4_group_desc *gdp;
> -	struct buffer_head *gdp_bh;
>  	ext4_group_t group;
>  	ext4_grpblk_t blkoff;
> -	int already_freed = 0, err, i;
>  
> +	ext4_mb_prepare_mark_context(&mc, sb, 0);

It looks like we always use 0 or 1 as the state for struct
ext4_mark_context. In that case we can keep state member of this struct
as bool instead of int. 


>  	ext4_get_group_no_and_offset(sb, block, &group, &blkoff);
> -	bitmap_bh = ext4_read_block_bitmap(sb, group);
> -	if (IS_ERR(bitmap_bh)) {
> -		pr_warn("Failed to read block bitmap\n");
> -		return;
> -	}
> -	gdp = ext4_get_group_desc(sb, group, &gdp_bh);
> -	if (!gdp)
> -		goto err_out;
> -
> -	for (i = 0; i < count; i++) {
> -		if (!mb_test_bit(blkoff + i, bitmap_bh->b_data))
> -			already_freed++;
> -	}
> -	mb_clear_bits(bitmap_bh->b_data, blkoff, count);
> -	err = ext4_handle_dirty_metadata(NULL, NULL, bitmap_bh);
> -	if (err)
> -		goto err_out;
> -	ext4_free_group_clusters_set(
> -		sb, gdp, ext4_free_group_clusters(sb, gdp) +
> -		count - already_freed);
> -	ext4_block_bitmap_csum_set(sb, gdp, bitmap_bh);
> -	ext4_group_desc_csum_set(sb, group, gdp);
> -	ext4_handle_dirty_metadata(NULL, NULL, gdp_bh);
> -	sync_dirty_buffer(bitmap_bh);
> -	sync_dirty_buffer(gdp_bh);
> -
> -err_out:
> -	brelse(bitmap_bh);
> +	ext4_mb_mark_context(&mc, group, blkoff, count);
>  }
>  
>  /**
> -- 
> 2.30.0
