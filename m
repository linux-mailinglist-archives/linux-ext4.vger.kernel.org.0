Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2589B530D70
	for <lists+linux-ext4@lfdr.de>; Mon, 23 May 2022 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbiEWJ6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 May 2022 05:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233684AbiEWJ6R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 May 2022 05:58:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2AD1940903
        for <linux-ext4@vger.kernel.org>; Mon, 23 May 2022 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653299893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OVQygW/WRePQfq33h+NUTgse8308ziOIB4rNgjq1sRo=;
        b=P+/JQt6KxQD64ndEyQgb2+pwzBtfD7Evbjvevm5pRdwWoXQaORy/qmPCN/Gyfy1XwjKSft
        ubgzSbIlNkq7bCpCS6p0WxCiYfgq/MZRnCx3lgMeMTJ0FSzY5laHgpptEn52Uui9gY0Tio
        +qt/eCAkm3Z5SHu5A3cGi/KnsbgX6zk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-8WMgEsrrPLykg32nwdRpSQ-1; Mon, 23 May 2022 05:58:08 -0400
X-MC-Unique: 8WMgEsrrPLykg32nwdRpSQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A021833961;
        Mon, 23 May 2022 09:58:08 +0000 (UTC)
Received: from fedora (unknown [10.40.194.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2D2D61121314;
        Mon, 23 May 2022 09:58:05 +0000 (UTC)
Date:   Mon, 23 May 2022 11:58:03 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH 1/2] ext4: fix bug_on ext4_mb_use_inode_pa
Message-ID: <20220523095803.gomx2q62ymocrkrz@fedora>
References: <20220521134217.312071-1-libaokun1@huawei.com>
 <20220521134217.312071-2-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521134217.312071-2-libaokun1@huawei.com>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, May 21, 2022 at 09:42:16PM +0800, Baokun Li wrote:
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
> +	 * EXT4_BLOCKS_PER_GROUP, start should be the start position of
> +	 * the group where ac_o_ex.fe_logical is located after alignment.
> +	 * In addition, when the value of fe_logical or
> +	 * EXT4_BLOCKS_PER_GROUP is very large, the value calculated
> +	 * by start_off is more accurate.
> +	 */
> +	start = max(start, round_down(ac->ac_o_ex.fe_logical,
> +			EXT4_BLOCKS_PER_GROUP(ac->ac_sb)));

This does not look right. The second argument in round_down() must be a
power of two, but there is no such restriction on blocks per group.

Also I am not quite sure why do we adjust the start in this way at all?
If we found what seems to be a preallocated extent which we can use and
we're actually going to use 0 lenght extent it seems like the problem is
somewhere else? Can you desribe the problem a bit more in detail?

Maybe I need to look at the ext4_mb_normalize_request() some more.

-Lukas

> +
>  	/* don't cover already allocated blocks in selected range */
>  	if (ar->pleft && start <= ar->lleft) {
>  		size -= ar->lleft + 1 - start;
> -- 
> 2.31.1
> 

