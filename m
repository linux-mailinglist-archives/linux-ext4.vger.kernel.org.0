Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C70C528330
	for <lists+linux-ext4@lfdr.de>; Mon, 16 May 2022 13:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiEPL0n (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 May 2022 07:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbiEPL0l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 May 2022 07:26:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D4DD138;
        Mon, 16 May 2022 04:26:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B700421FCA;
        Mon, 16 May 2022 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652700398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ91wwKDsTLcXTrXFJlbO/2mmoxPVjMJojxTQ41h7Hc=;
        b=16cR0LVy6NxPyYvuWNsnkXOGOJ86wvxAT4t8nuTsO31gWLaMu+5NVW9LFgqs3E/njvetMu
        ffGwDNmh2ianR0AeNNEn5VcEQOCWsi/X7gXcJo8YheiXGPwW6FhYlKaOL6iL9xKvnbEet8
        +brB7kR+ViF8/sSeBPm2dD1iFf932kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652700398;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wQ91wwKDsTLcXTrXFJlbO/2mmoxPVjMJojxTQ41h7Hc=;
        b=IZtJ2aWsW9hqZwb7LesSV2MSxdvamK3PFNUvz3E6RBk4xOyrnyrV1S8c2dqIrBNu4UJ2/O
        uF4l9b/N88BVKEBA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 73BBD2C142;
        Mon, 16 May 2022 11:26:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id ED87EA062F; Mon, 16 May 2022 13:26:37 +0200 (CEST)
Date:   Mon, 16 May 2022 13:26:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v3] ext4: fix bug_on in ext4_writepages
Message-ID: <20220516112637.ysx7shlqcs5anvp3@quack3.lan>
References: <20220516012752.17241-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516012752.17241-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 16-05-22 09:27:52, Ye Bin wrote:
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
>           ext4_da_write_begin
>             ext4_da_write_inline_data_begin -> If inline data size too
>             small will allocate block to write, then mapping will has
>             dirty page
>                 ext4_da_convert_inline_data_to_extent ->clear EXT4_STATE_MAY_INLINE_DATA
> 2. fallocate
> do_vfs_ioctl
>   ioctl_preallocate
>     vfs_fallocate
>       ext4_fallocate
>         ext4_convert_inline_data
>           ext4_convert_inline_data_nolock
>             ext4_map_blocks -> fail will goto restore data
>             ext4_restore_inline_data
>               ext4_create_inline_data
>               ext4_write_inline_data
>               ext4_set_inode_state -> set inode EXT4_STATE_MAY_INLINE_DATA
> 3. writepages
> __ext4_ioctl
>   ext4_alloc_da_blocks
>     filemap_flush
>       filemap_fdatawrite_wbc
>         do_writepages
>           ext4_writepages
>             if (ext4_has_inline_data(inode))
>               BUG_ON(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
> 
> The root cause of this issue is we destory inline data until call ext4_writepages
> under delay allocation mode. But there maybe already covert from inline to extent.
> To solved this issue, we call filemap_flush firstly.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Thanks for the patch. It looks good now so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just one small comment below:

> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 6d253edebf9f..79a7d5d700f7 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -2002,6 +2002,12 @@ int ext4_convert_inline_data(struct inode *inode)
>  	if (!ext4_has_inline_data(inode)) {
>  		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  		return 0;
> +	} else if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {

Can we perhaps add here a comment like:

		/*
		 * Inode has inline data but EXT4_STATE_MAY_INLINE_DATA is
		 * cleared. This means we are in the middle of moving of
		 * inline data to delay allocated block. Just force
		 * writeout here to finish conversion.
		 */

								Honza

> +		error = filemap_flush(inode->i_mapping);
> +		if (error)
> +			return error;
> +		if (!ext4_has_inline_data(inode))
> +			return 0;
>  	}
>  
>  	needed_blocks = ext4_writepage_trans_blocks(inode);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
