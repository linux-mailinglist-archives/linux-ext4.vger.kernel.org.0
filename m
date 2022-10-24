Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D56B960AFAF
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Oct 2022 17:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbiJXPzN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Oct 2022 11:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJXPyw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Oct 2022 11:54:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72D8B1BBC;
        Mon, 24 Oct 2022 07:50:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F0DF321DFC;
        Mon, 24 Oct 2022 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1666621527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKSKKEXRT13VyPCUMubU98y2UTQPsLL1vU2coKxB3OM=;
        b=w2ds0OTZ0WKW2UN4YltaA8lpw4z3OhmENsq6uAXNlZXDnhH6/d4KZGjOdqudikPOHY6WDl
        0LKuLCunC3qCXU2ewQE7i0b5mEHmkI67QW/o1I6InhlGYf7UsquaaralOniz6sH1ikYl4x
        5400hv/4GcY8vUVTGRZgo0CmJ56hFXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1666621527;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aKSKKEXRT13VyPCUMubU98y2UTQPsLL1vU2coKxB3OM=;
        b=J64CpO4Fq6G+NZ+1MHNASxs20iYB6i1/hrg5wylEX49annp0RppLCjvHTDjZSdNaUewUdu
        AehktCdWp7bjCRBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1B7313A79;
        Mon, 24 Oct 2022 14:25:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wf3kNlegVmPvHgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 24 Oct 2022 14:25:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 749CFA06F6; Mon, 24 Oct 2022 16:25:27 +0200 (CEST)
Date:   Mon, 24 Oct 2022 16:25:27 +0200
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH v2 2/2] ext4: fix bug_on in __es_tree_search caused by
 wrong boot loader inode
Message-ID: <20221024142527.avwgiztqvzmeo4se@quack3>
References: <20221021040731.4180649-1-libaokun1@huawei.com>
 <20221021040731.4180649-3-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021040731.4180649-3-libaokun1@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 21-10-22 12:07:31, Baokun Li wrote:
> We got a issue as fllows:
> ==================================================================
>  kernel BUG at fs/ext4/extents_status.c:203!
>  invalid opcode: 0000 [#1] PREEMPT SMP
>  CPU: 1 PID: 945 Comm: cat Not tainted 6.0.0-next-20221007-dirty #349
>  RIP: 0010:ext4_es_end.isra.0+0x34/0x42
>  RSP: 0018:ffffc9000143b768 EFLAGS: 00010203
>  RAX: 0000000000000000 RBX: ffff8881769cd0b8 RCX: 0000000000000000
>  RDX: 0000000000000000 RSI: ffffffff8fc27cf7 RDI: 00000000ffffffff
>  RBP: ffff8881769cd0bc R08: 0000000000000000 R09: ffffc9000143b5f8
>  R10: 0000000000000001 R11: 0000000000000001 R12: ffff8881769cd0a0
>  R13: ffff8881768e5668 R14: 00000000768e52f0 R15: 0000000000000000
>  FS: 00007f359f7f05c0(0000)GS:ffff88842fd00000(0000)knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 00007f359f5a2000 CR3: 000000017130c000 CR4: 00000000000006e0
>  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>  Call Trace:
>   <TASK>
>   __es_tree_search.isra.0+0x6d/0xf5
>   ext4_es_cache_extent+0xfa/0x230
>   ext4_cache_extents+0xd2/0x110
>   ext4_find_extent+0x5d5/0x8c0
>   ext4_ext_map_blocks+0x9c/0x1d30
>   ext4_map_blocks+0x431/0xa50
>   ext4_mpage_readpages+0x48e/0xe40
>   ext4_readahead+0x47/0x50
>   read_pages+0x82/0x530
>   page_cache_ra_unbounded+0x199/0x2a0
>   do_page_cache_ra+0x47/0x70
>   page_cache_ra_order+0x242/0x400
>   ondemand_readahead+0x1e8/0x4b0
>   page_cache_sync_ra+0xf4/0x110
>   filemap_get_pages+0x131/0xb20
>   filemap_read+0xda/0x4b0
>   generic_file_read_iter+0x13a/0x250
>   ext4_file_read_iter+0x59/0x1d0
>   vfs_read+0x28f/0x460
>   ksys_read+0x73/0x160
>   __x64_sys_read+0x1e/0x30
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
> ==================================================================
> 
> In the above issue, ioctl invokes the swap_inode_boot_loader function to
> swap inode<5> and inode<12>. However, inode<5> contain incorrect imode and
> disordered extents, and i_nlink is set to 1. The extents check for inode in
> the ext4_iget function can be bypassed bacause 5 is EXT4_BOOT_LOADER_INO.
> While links_count is set to 1, the extents are not initialized in
> swap_inode_boot_loader. After the ioctl command is executed successfully,
> the extents are swapped to inode<12>, in this case, run the `cat` command
> to view inode<12>. And Bug_ON is triggered due to the incorrect extents.
> 
> When the boot loader inode is not initialized, its imode can be one of the
> following:
> 1) the imode is a bad type, which is marked as bad_inode in ext4_iget and
>    set to S_IFREG.
> 2) the imode is good type but not S_IFREG.
> 3) the imode is S_IFREG.
> 
> The BUG_ON may be triggered by bypassing the check in cases 1 and 2.
> Therefore, when the boot loader inode is bad_inode or its imode is not
> S_IFREG, initialize the inode to avoid triggering the BUG.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Grepping for calls to ext4_iget() in the ext4 code shows there are many
more places that will get unhappy (and crash) when ext4_iget() returns a
bad inode. In fact, I didn't find a place when returning bad inode would be
useful for anything. So why don't we just return EFSCORRUPTED instead of
returning a bad inode?

								Honza

> ---
>  fs/ext4/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index ded535535b27..c41210706ea7 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -425,7 +425,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	/* Protect extent tree against block allocations via delalloc */
>  	ext4_double_down_write_data_sem(inode, inode_bl);
>  
> -	if (inode_bl->i_nlink == 0) {
> +	if (is_bad_inode(inode_bl) || !S_ISREG(inode_bl->i_mode)) {
>  		/* this inode has never been used as a BOOT_LOADER */
>  		set_nlink(inode_bl, 1);
>  		i_uid_write(inode_bl, 0);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
