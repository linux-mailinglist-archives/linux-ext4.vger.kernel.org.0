Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE29531C58
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 22:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiEWTwQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 15:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiEWTwO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 15:52:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D425C846;
        Mon, 23 May 2022 12:52:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id b5so6975127plx.10;
        Mon, 23 May 2022 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+67Adn/X4Qv2QJEWnD5dXsXaafK7hdFumlzgVAWGKMc=;
        b=NQTAlhXtlHDOtt59wxpeJniHTtodaPiIxaMNo26oymVgQ7gbRgKTpMZfmkShnATAHT
         M7caoUvghRWnKtFxWChe0rAHpfhLsbGvwYoG5HBARkhArwuIqrV7ey7if9XFMQx8buGm
         wPpSfSG31fz4G9kDyHecQghDgMYCoq+ZxnXeltBlX/bss29BAtBTcYUGlyRlcUpHCWxl
         e4YL/jK2yd3KfyUiaD9aUjH/SJhjdJN0JJuzNqeRwghScF8DR2LqhVOvYh7DzvvQPBiI
         2HEz2Ly10MVyyLCYoljFg7PeACplnvmdvLReiPXvpqYMPajUzuBds4073pnurSEZEoTd
         6i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+67Adn/X4Qv2QJEWnD5dXsXaafK7hdFumlzgVAWGKMc=;
        b=HzRzspMGBx7vFzaBPyUTfIvv7sur2e0nTIs7c60t9tyyacJGMRCMSD9Bn5xExlM36Y
         lk1idKTEBN9P6VwOZW6oL9TPT4MVrx6sWba+HdWJB49XDO19/j/QCnrwwX9IdO+WdL0K
         3pJIQDD4KFvgWTnBAyC5wtoS9pTwBlbrvpK4y3FVAE7+cbvcGlfLZzQqX01Nt3rPHAN2
         eIQez5GsKdCYggy8JDlWygDq/DfBLfGrED6Cg+1+7BGMX/VfiDhaLIMylSNoutka4t0m
         gHuxYab8byWrJUKTPANhaKzB0lRTRZuLtcdOxhrwbaMLUbFP6Lj+9BJ3m5GPYwCT1ZxR
         RHYQ==
X-Gm-Message-State: AOAM531rm44XbCHYlUfd33diQo/oOV+INucvRFSHDK0gzGZD/WunnHa3
        MZTkznq9F5Ov3XqrEjYsd4k=
X-Google-Smtp-Source: ABdhPJyax4aYpsUzgrwJuxws86W4vUAGgkN+JCO4aLLiZg4PzPYaJ934t7tshezsWzbUXuYy1OHjew==
X-Received: by 2002:a17:902:d481:b0:161:d49e:3015 with SMTP id c1-20020a170902d48100b00161d49e3015mr23857364plg.105.1653335532206;
        Mon, 23 May 2022 12:52:12 -0700 (PDT)
Received: from localhost ([2406:7400:63:4576:78:9648:3f92:a905])
        by smtp.gmail.com with ESMTPSA id z24-20020aa79598000000b0050dc762818csm7667252pfj.102.2022.05.23.12.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 12:52:10 -0700 (PDT)
Date:   Tue, 24 May 2022 01:21:56 +0530
From:   Ritesh Harjani <ritesh.list@gmail.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <20220523195156.igzyp6nwy67gxnrb@riteshh-domain>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/05/21 09:42PM, Baokun Li wrote:
> Hulk Robot reported a BUG_ON:
> ==================================================================
> kernel BUG at fs/ext4/mballoc.c:3211!
> [...]
> RIP: 0010:ext4_mb_mark_diskspace_used.cold+0x85/0x136f
> [...]
> Call Trace:
>  ext4_mb_new_blocks+0x9df/0x5d30
>  ext4_ext_map_blocks+0x1803/0x4d80
>  ext4_map_blocks+0x3a4/0x1a10
>  ext4_writepages+0x126d/0x2c30
>  do_writepages+0x7f/0x1b0
>  __filemap_fdatawrite_range+0x285/0x3b0
>  file_write_and_wait_range+0xb1/0x140
>  ext4_sync_file+0x1aa/0xca0
>  vfs_fsync_range+0xfb/0x260
>  do_fsync+0x48/0xa0
> [...]
> ==================================================================
>
> Above issue may happen as follows:
> -------------------------------------
> do_fsync
>  vfs_fsync_range
>   ext4_sync_file
>    file_write_and_wait_range
>     __filemap_fdatawrite_range
>      do_writepages
>       ext4_writepages
>        mpage_map_and_submit_extent
>         mpage_map_one_extent
>          ext4_map_blocks
>           ext4_mb_new_blocks
>            ext4_mb_normalize_request
>             >>> start + size <= ac->ac_o_ex.fe_logical
>            ext4_mb_regular_allocator
>             ext4_mb_simple_scan_group
>              ext4_mb_use_best_found
>               ext4_mb_new_preallocation
>                ext4_mb_new_inode_pa
>                 ext4_mb_use_inode_pa
>                  >>> set ac->ac_b_ex.fe_len <= 0
>            ext4_mb_mark_diskspace_used
>             >>> BUG_ON(ac->ac_b_ex.fe_len <= 0);
>
> we can easily reproduce this problem with the following commands:
> 	`fallocate -l100M disk`
> 	`mkfs.ext4 -b 1024 -g 256 disk`
> 	`mount disk /mnt`
> 	`fsstress -d /mnt -l 0 -n 1000 -p 1`

Thanks for sharing the reproducer. Yes, this could easily trigger the bug_on.
We don't even need "-b 1024".


>
> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
> Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
> when the size is truncated. So start should be the start position of
> the group where ac_o_ex.fe_logical is located after alignment.
> In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
> is very large, the value calculated by start_off is more accurate.
>
> Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")

Commit message does say that it can result into allocation request bigger then
the size of the block group. So then, what happens in case of flex_bg feature is
enabled (which by default nowadays).
Shouldn't we consider flex_bg_groups * EXT4_BLOCKS_PER_GROUP as the allocation size request?

>
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index ea653d19f9ec..32410b79b664 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4107,6 +4107,17 @@ ext4_mb_normalize_request(struct ext4_allocation_context *ac,
>  	size = size >> bsbits;
>  	start = start_off >> bsbits;
>
> +	/*
> +	 * Because size must be less than or equal to
> +	 * EXT4_BLOCKS_PER_GROUP,

We should confirm whether in case of flex_bg groups, this assumption
holds correct?

> start should be the start position of
> +	 * the group where ac_o_ex.fe_logical is located after alignment.
> +	 * In addition, when the value of fe_logical or
> +	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
> +	 * by start_off is more accurate.
> +	 */
> +	start = max(start, round_down(ac->ac_o_ex.fe_logical,
> +			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
> +

This does looks like it could solve the problem at hand.
This is because we try to allocate based on the start offset upto size.
As of now we do allocate more space then requested (due to normalization),
but due to the start offset of our preallocation, our allocation request
of ac->ac_o_ex.fe_logical + fe_len doesn't lie in the allocated PA. This happens since
we trim the size of the allocation request to only till blocks_per_group.

So with that if we make the above changes (your patch), it does looks like, that we
will then be allocating the PA such that our allocation request will fall within
the allocated PA (in ext4_mb_use_inode_pa()) and hence we won't hit the bug_on in
ext4_mb_mark_diskspace_used().


One more suggestion - I think we should also add a WARN_ON()/BUG_ON() here.
This makes the start of the problem more visible, rather then waiting till
ext4_mb_mark_diskspace_used() call to hit the bug_on().
Thoughts?

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 252c168454c7..e91d5aeb8efd 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4301,6 +4301,7 @@ static void ext4_mb_use_inode_pa(struct ext4_allocation_context *ac,
        BUG_ON(start < pa->pa_pstart);
        BUG_ON(end > pa->pa_pstart + EXT4_C2B(sbi, pa->pa_len));
        BUG_ON(pa->pa_free < len);
+       WARN_ON(len <= 0);
        pa->pa_free -= len;

        mb_debug(ac->ac_sb, "use %llu/%d from inode pa %p\n", start, len, pa);


-ritesh
