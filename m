Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACDC530CED
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 12:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbiEWJ3O (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 05:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbiEWJ3M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 05:29:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5414927C;
        Mon, 23 May 2022 02:29:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 48DE121A57;
        Mon, 23 May 2022 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1653298150; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKSiy0ipOYVbqRPh0+sMS6w58vGVnmR5krmIKhBhvCo=;
        b=rhER0KTpLC+kN7FEVjQD6D5ygjKKlG/FidSbAufFle/t6d05K+2srPjx2V5Ec/NWBqGhss
        lklFclXZMR8sHsK0D1N7g1+tqpbbb3NC9Wuf6obFB/NFdR26vGPNTLq1U2UcvMQ1iRLBrK
        JiOeSW48sRlLrIuWLgCeycrkMzd8J/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1653298150;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yKSiy0ipOYVbqRPh0+sMS6w58vGVnmR5krmIKhBhvCo=;
        b=00foDO6puATmPZsCtmjAr17KPhXXoPethprIX1ioU1ZZc6K2o0pA+ZbMOs5OQmWH7FPwwt
        fFvBdQO7vYv8jvDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DF7B12C141;
        Mon, 23 May 2022 09:29:09 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 671CEA0632; Mon, 23 May 2022 11:29:08 +0200 (CEST)
Date:   Mon, 23 May 2022 11:29:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <20220523092908.2ghn2fvps5dfhyz3@quack3.lan>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-2-libaokun1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 21-05-22 21:42:16, Baokun Li wrote:
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
> 
> The size must be smaller than or equal to EXT4_BLOCKS_PER_GROUP.
> Therefore, "start + size <= ac->ac_o_ex.fe_logical" may occur
> when the size is truncated. So start should be the start position of
> the group where ac_o_ex.fe_logical is located after alignment.
> In addition, when the value of fe_logical or EXT4_BLOCKS_PER_GROUP
> is very large, the value calculated by start_off is more accurate.
> 
> Fixes: cd648b8a8fd5 ("ext4: trim allocation requests to group size")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. I'd just phrase the comment below a bit differently:

> +	/*
> +	 * Because size must be less than or equal to
> +	 * EXT4_BLOCKS_PER_GROUP, start should be the start position of
> +	 * the group where ac_o_ex.fe_logical is located after alignment.
> +	 * In addition, when the value of fe_logical or
> +	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
> +	 * by start_off is more accurate.
> +	 */
> +	start = max(start, round_down(ac->ac_o_ex.fe_logical,
> +			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));
> +

Can we make the comment like:

	/*
	 * For tiny groups (smaller than 8MB) the chosen allocation
	 * alignment may be larger than group size. Make sure the alignment
	 * does not move allocation to a different group which makes mballoc
	 * fail assertions later.
	 */

With that feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
