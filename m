Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BBA6162FD
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Nov 2022 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiKBMrp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Nov 2022 08:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKBMro (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Nov 2022 08:47:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004BEDEDE;
        Wed,  2 Nov 2022 05:47:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9DB6F21BED;
        Wed,  2 Nov 2022 12:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667393262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiWl0jF5U/zUQuNc2Wl28ctjyqVsVFmTEe4p3WgFvMk=;
        b=f6UHRjtaDUTzKdqFWoUt7d9qBg6YC/SBrHYAAZ9nldc4xFUBNaFMhcdtrY6DlKumbS+0Z6
        6t5M9+5KIiW6roOrIHolj2PSxflBcKZ2P3rA7sf34duLEuR72eRyUr5IJtrH2yw0Iw1ij3
        5dveiEd6pO4BswvTXPWS+B+h2dxH6KA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667393262;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BiWl0jF5U/zUQuNc2Wl28ctjyqVsVFmTEe4p3WgFvMk=;
        b=CLHkSybrtHMRZ8xe7MZmGqOHbdbGB/DVIG/odMoki/NRTIiEYesWJIYQrf6lZ/J6u4pc+A
        52EEscRtRYUN8sDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7494113AE0;
        Wed,  2 Nov 2022 12:47:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TCJlHO5mYmPqIAAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 02 Nov 2022 12:47:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 46F95A0700; Wed,  2 Nov 2022 13:47:41 +0100 (CET)
Date:   Wed, 2 Nov 2022 13:47:41 +0100
From:   Jan Kara <jack@suse.cz>
To:     Baokun Li <libaokun1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, ritesh.list@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: fix use-after-free in ext4_orphan_cleanup
Message-ID: <20221102124741.jbnfp47fqdqykv4x@quack3>
References: <20221102080633.1630225-1-libaokun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102080633.1630225-1-libaokun1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 02-11-22 16:06:33, Baokun Li wrote:
> I caught a issue as follows:
> ==================================================================
>  BUG: KASAN: use-after-free in __list_add_valid+0x28/0x1a0
>  Read of size 8 at addr ffff88814b13f378 by task mount/710
> 
>  CPU: 1 PID: 710 Comm: mount Not tainted 6.1.0-rc3-next #370
>  Call Trace:
>   <TASK>
>   dump_stack_lvl+0x73/0x9f
>   print_report+0x25d/0x759
>   kasan_report+0xc0/0x120
>   __asan_load8+0x99/0x140
>   __list_add_valid+0x28/0x1a0
>   ext4_orphan_cleanup+0x564/0x9d0 [ext4]
>   __ext4_fill_super+0x48e2/0x5300 [ext4]
>   ext4_fill_super+0x19f/0x3a0 [ext4]
>   get_tree_bdev+0x27b/0x450
>   ext4_get_tree+0x19/0x30 [ext4]
>   vfs_get_tree+0x49/0x150
>   path_mount+0xaae/0x1350
>   do_mount+0xe2/0x110
>   __x64_sys_mount+0xf0/0x190
>   do_syscall_64+0x35/0x80
>   entry_SYSCALL_64_after_hwframe+0x63/0xcd
>   </TASK>
>  [...]
> ==================================================================
> 
> Above issue may happen as follows:
> -------------------------------------
> ext4_fill_super
>   ext4_orphan_cleanup
>    --- loop1: assume last_orphan is 12 ---
>     list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan)
>     ext4_truncate --> return 0
>       ext4_inode_attach_jinode --> return -ENOMEM
>     iput(inode) --> free inode<12>
>    --- loop2: last_orphan is still 12 ---
>     list_add(&EXT4_I(inode)->i_orphan, &EXT4_SB(sb)->s_orphan);
>     // use inode<12> and trigger UAF
> 
> To solve this issue, we need to propagate the return value of
> ext4_inode_attach_jinode() appropriately.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Nice catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>
	
								Honza

> ---
>  fs/ext4/inode.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index fca47470c85a..e7e7561f0baa 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4224,7 +4224,8 @@ int ext4_truncate(struct inode *inode)
>  
>  	/* If we zero-out tail of the page, we have to create jinode for jbd2 */
>  	if (inode->i_size & (inode->i_sb->s_blocksize - 1)) {
> -		if (ext4_inode_attach_jinode(inode) < 0)
> +		err = ext4_inode_attach_jinode(inode);
> +		if (err)
>  			goto out_trace;
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
