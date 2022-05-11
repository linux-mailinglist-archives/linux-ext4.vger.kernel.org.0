Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2952349C
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244079AbiEKNr3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 09:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiEKNrZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 09:47:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A682219367;
        Wed, 11 May 2022 06:47:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D6CEA21A97;
        Wed, 11 May 2022 13:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652276836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itd3Sa1CpZiLCS1ZDb1vqIIXnJVKe6EqK2Q/rkked3Q=;
        b=pLilFkUDuwCHQ06I9/LEHv6rCi0DznqXDGfK76DXFxgw6UNeOzlzVRC6O22yHkc12xN2gf
        lFDgWu+g3C/HkW4H97D8nGjRbi55x9srzwFVYGsS4ZmeXdrQtsearXTyM48hXaoOIcM0ef
        mVDoRMM3N2hj3teqWMdqpHCvBR9k3bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652276836;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=itd3Sa1CpZiLCS1ZDb1vqIIXnJVKe6EqK2Q/rkked3Q=;
        b=oY5XOjAd/sEDKcBkY4b9nI1t+xwGGLaQ0bF5KkiGHjIehtO5DAbknG0TR8VSFuTb6tLsDB
        JsPyrxGlfq6c8gBg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 89D192C141;
        Wed, 11 May 2022 13:47:16 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B9939A062A; Wed, 11 May 2022 15:47:10 +0200 (CEST)
Date:   Wed, 11 May 2022 15:47:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH -next v2] ext4: fix bug_on in ext4_writepages
Message-ID: <20220511134710.4ggvxuxg7dwf7tkp@quack3.lan>
References: <20220510100228.1172227-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510100228.1172227-1-yebin10@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-05-22 18:02:28, Ye Bin wrote:
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
> ---
>  fs/ext4/inline.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 6d253edebf9f..130ed5d83734 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -2002,6 +2002,14 @@ int ext4_convert_inline_data(struct inode *inode)
>  	if (!ext4_has_inline_data(inode)) {
>  		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
>  		return 0;
> +	} else if (test_opt(inode->i_sb, DELALLOC) && !S_ISDIR(inode->i_mode)) {
> +		error = filemap_flush(inode->i_mapping);

This is actually an interesting option and I kind of like it but shouldn't
we restrict this to the situation when EXT4_STATE_MAY_INLINE_DATA is clear?
Otherwise we would be writing out inline data to the inode unnecessarily
for each ext4_convert_inline_data() call.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
