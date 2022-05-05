Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AD851C432
	for <lists+linux-ext4@lfdr.de>; Thu,  5 May 2022 17:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380938AbiEEPu4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 May 2022 11:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348488AbiEEPuz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 May 2022 11:50:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E19377F5;
        Thu,  5 May 2022 08:47:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 73ECF1F8D3;
        Thu,  5 May 2022 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1651765634; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3usa/BDzW7WrqfKTRJ3nV/Kk3MUaQaV93qIHyXp35Eg=;
        b=uFWAKVFg9D41wufM/KqDn5o59I/849cM0YEy44QfjVzGFE89im5cYXhmfguWPc0Xp0ZixJ
        nP5rIs5XgaT1n4aqtUeZjjmK1iynF4Z3AN7C6tN2mk6bVNua1wiT9QIvwOmMI7qSrR2bfW
        hMxBaDd2aV8bdk5GDKGCAlbZUGrFIQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1651765634;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3usa/BDzW7WrqfKTRJ3nV/Kk3MUaQaV93qIHyXp35Eg=;
        b=pMjKdhp/bN+0IjyGtt/qVPCcaEiROezTmA+Uyan0JGmnXeaqOBc2BoyyviAHOw3mqAouA8
        dDIKClmWCpBxA8Cw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 510702C142;
        Thu,  5 May 2022 15:47:14 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id EE5DBA0627; Thu,  5 May 2022 17:47:13 +0200 (CEST)
Date:   Thu, 5 May 2022 17:47:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix bug_on in ext4_writepages
Message-ID: <20220505154713.nig6rj76p2gl5mm7@quack3.lan>
References: <20220505135708.2629657-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220505135708.2629657-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 05-05-22 21:57:08, Ye Bin wrote:
> we got issue as follows:
> EXT4-fs error (device loop0): ext4_mb_generate_buddy:1141: group 0, block bitmap and bg descriptor inconsistent: 25 vs 31513 free cls
> ------------[ cut here ]------------
> kernel BUG at fs/ext4/inode.c:2708!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 2 PID: 2147 Comm: rep Not tainted 5.18.0-rc2-next-20220413+ #155
> RIP: 0010:ext4_writepages+0x1977/0x1c10
> RSP: 0018:ffff88811d3e7880 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: ffff88811c098000
> RDX: 0000000000000000 RSI: ffff88811c098000 RDI: 0000000000000002
> RBP: ffff888128140f50 R08: ffffffffb1ff6387 R09: 0000000000000000
> R10: 0000000000000007 R11: ffffed10250281ea R12: 0000000000000001
> R13: 00000000000000a4 R14: ffff88811d3e7bb8 R15: ffff888128141028
> FS:  00007f443aed9740(0000) GS:ffff8883aef00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020007200 CR3: 000000011c2a4000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  do_writepages+0x130/0x3a0
>  filemap_fdatawrite_wbc+0x83/0xa0
>  filemap_flush+0xab/0xe0
>  ext4_alloc_da_blocks+0x51/0x120
>  __ext4_ioctl+0x1534/0x3210
>  __x64_sys_ioctl+0x12c/0x170
>  do_syscall_64+0x3b/0x90
> 
> It may happen as follows:
> 1. write inline_data inode
> vfs_write
>   new_sync_write
>     ext4_file_write_iter
>       ext4_buffered_write_iter
>         generic_perform_write
> 	  ext4_da_write_begin
> 	    ext4_da_write_inline_data_begin -> If inline data size too
> 	    small will allocate block to write, then mapping will has
> 	    dirty page
> 	    	ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
> 2. fallocate
> do_vfs_ioctl
>   ioctl_preallocate
>     vfs_fallocate
>       ext4_fallocate
>         ext4_convert_inline_data
> 	  ext4_convert_inline_data_nolock
> 	    ext4_map_blocks -> fail will goto restore data
> 	    ext4_restore_inline_data
> 	      ext4_create_inline_data
> 	      ext4_write_inline_data
> 	      ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
> 3. writepages
> __ext4_ioctl
>   ext4_alloc_da_blocks
>     filemap_flush
>       filemap_fdatawrite_wbc
>         do_writepages
> 	  ext4_writepages
> 	    if (ext4_has_inline_data(inode))
> 	      BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> 
> To solved this issue, record origin 'EXT4_STATE_MAY_INLINE_DATA' flag, then pass
> value to 'ext4_restore_inline_data', 'ext4_restore_inline_data' will
> decide to if recovery 'EXT4_STATE_MAY_INLINE_DATA' flag according to parameter.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

I think this will get also fixed by a patch from your colleague I've
reviewed here [1], won't it?

[1] https://lore.kernel.org/all/20220428165725.mvjh6mx7gr5vekqe@quack3.lan

								Honza

> ---
>  fs/ext4/inline.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 9c076262770d..407061c79adc 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1125,8 +1125,8 @@ static int ext4_update_inline_dir(handle_t *handle, struct inode *dir,
>  }
>  
>  static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
> -				     struct ext4_iloc *iloc,
> -				     void *buf, int inline_size)
> +				     struct ext4_iloc *iloc, void *buf,
> +				     int inline_size, bool has_data)
>  {
>  	int ret;
>  
> @@ -1138,7 +1138,8 @@ static void ext4_restore_inline_data(handle_t *handle, struct inode *inode,
>  		return;
>  	}
>  	ext4_write_inline_data(inode, iloc, buf, 0, inline_size);
> -	ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> +	if (has_data)
> +		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  }
>  
>  static int ext4_finish_convert_inline_dir(handle_t *handle,
> @@ -1194,6 +1195,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>  	struct buffer_head *data_bh = NULL;
>  	struct ext4_map_blocks map;
>  	int inline_size;
> +	bool has_data;
>  
>  	inline_size = ext4_get_inline_size(inode);
>  	buf = kmalloc(inline_size, GFP_NOFS);
> @@ -1222,6 +1224,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>  	if (error)
>  		goto out;
>  
> +	has_data = !!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> +
>  	map.m_lblk = 0;
>  	map.m_len = 1;
>  	map.m_flags = 0;
> @@ -1262,7 +1266,8 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>  	unlock_buffer(data_bh);
>  out_restore:
>  	if (error)
> -		ext4_restore_inline_data(handle, inode, iloc, buf, inline_size);
> +		ext4_restore_inline_data(handle, inode, iloc, buf,
> +					 inline_size, has_data);
>  
>  out:
>  	brelse(data_bh);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
