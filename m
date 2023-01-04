Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A862F65CEBE
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 09:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234542AbjADIvf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 03:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234723AbjADIvN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 03:51:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6FE1E3C4;
        Wed,  4 Jan 2023 00:49:05 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E4B1644BB;
        Wed,  4 Jan 2023 08:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672822143; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhUi6JY1SlAAUBDBWTjbK9W4Y/Fg2W4gAHxeP6wUHIs=;
        b=0BoLQwRmka75T2nSWi3hj6eZzk4Lz+sMXNG3jF5CsAG7lAKHJas+ETrW4B4Fo4KP7eCp8T
        BO5Zvw1IH1H1BU/t8OeHVm8s1l4EOd5roNfOWKjKVj7TTNVj/l/FYYBEVHtNe4YdiAtzLX
        CldGGrQ64cKrt63s2mjSx3WcQXqpB4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672822143;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vhUi6JY1SlAAUBDBWTjbK9W4Y/Fg2W4gAHxeP6wUHIs=;
        b=XTwC+5De0X4Q7h7ZrlacivDaZJiAXjrEDRGioIpKQZDViQLeJpkZHuJJna9LLWvuckxdDd
        RiNQqgDXdqqP2PAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D5D551342C;
        Wed,  4 Jan 2023 08:49:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IuwlNH89tWNUJAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 04 Jan 2023 08:49:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5724BA0742; Wed,  4 Jan 2023 09:49:03 +0100 (CET)
Date:   Wed, 4 Jan 2023 09:49:03 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: fix use-after-free Read in ext4_find_extent for
 bigalloc + inline
Message-ID: <20230104084903.ocrt7mfdehw3sz6n@quack3>
References: <20230104071559.2051847-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230104071559.2051847-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-01-23 15:15:59, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> loop0: detected capacity change from 0 to 2048
> EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
> ==================================================================
> BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
> BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
> Read of size 4 at addr ffff888073644750 by task syz-executor420/5067
> 
> CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>  print_address_description+0x74/0x340 mm/kasan/report.c:306
>  print_report+0x107/0x1f0 mm/kasan/report.c:417
>  kasan_report+0xcd/0x100 mm/kasan/report.c:517
>  ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
>  ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
>  ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
>  ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
>  ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
>  ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
>  ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
>  ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
>  generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
>  ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
>  ext4_file_write_iter+0x1d0/0x18f0
>  call_write_iter include/linux/fs.h:2186 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x7dc/0xc50 fs/read_write.c:584
>  ksys_write+0x177/0x2a0 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f4b7a9737b9
> RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
> RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
> RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> 
> Above issue is happens when enable bigalloc and inline data feature. As
> commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
> bigalloc + inline. But it only resolved issue when has inline data, if
> inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
> before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
> i_data is still store inline data in this scene. Then will trigger UAF
> when find extent.
> To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
> in ext4_clu_mapped().
> 
> Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
> Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 9de1c9d1a13d..ee5acf2bd5e6 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5802,7 +5802,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
>  	 * mapped - no physical clusters have been allocated, and the
>  	 * file has no extents
>  	 */
> -	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> +	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
> +	    ext4_has_inline_data(inode))
>  		return 0;
>  
>  	/* search for the extent closest to the first block in the cluster */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
