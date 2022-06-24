Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3BE5599E5
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Jun 2022 14:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiFXMvg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jun 2022 08:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbiFXMvc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jun 2022 08:51:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401434ECE7
        for <linux-ext4@vger.kernel.org>; Fri, 24 Jun 2022 05:51:31 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D73121A31;
        Fri, 24 Jun 2022 12:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656075082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klkWcB8YXFDUWta4RZ2XPvk2TPvFr+O/8NLNr7voBg4=;
        b=sPgrxGlZUqh/LrvRfi2/0XI9ZtH1G/3cNK9h/Mi7NUGM26tDny1b9LsE3kOHeAVNB8S5v7
        e9KuQRVPCYHIIJoJPhyWFPDWjbvBPhKH2j4spPeqB+Zf8AKRw68H6gGtlYad7oJKwTiCa5
        1BtBkvu3mln+YBjYZazR/mXOXY9bM/4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656075082;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=klkWcB8YXFDUWta4RZ2XPvk2TPvFr+O/8NLNr7voBg4=;
        b=W1CLDjtnEGOgM+COJfSMt9pObXSeuqHp7JJNrWAVuK0/k4TVls2V+/EsnNM7nootYiDntq
        eqrumZo2OLTvpYAA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 921762C220;
        Fri, 24 Jun 2022 12:51:21 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F26C9A062D; Fri, 24 Jun 2022 14:51:17 +0200 (CEST)
Date:   Fri, 24 Jun 2022 14:51:17 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: silence the warning when evicting inode with
 dioread_nolock
Message-ID: <20220624125117.bi5o4ovuhhtgs44x@quack3.lan>
References: <20220624070404.763603-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624070404.763603-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-06-22 15:04:04, Zhang Yi wrote:
> When evicting an inode with default dioread_nolock, it could be raced by
> the unwritten extents converting kworker after writeback some new
> allocated dirty blocks. It convert unwritten extents to written, the
> extents could be merged to upper level and free extent blocks, so it
> could mark the inode dirty again even this inode has been marked
> I_FREEING. But the inode->i_io_list check and warning in
> ext4_evict_inode() missing this corner case. Fortunately,
> ext4_evict_inode() will wait all extents converting finished before this
> check, so it will not lead to inode use-after-free problem, so every
> thing is OK besides this warning, let the WARN_ON_ONCE know the
> dioread_nolock case to silence this warning is fine.
> 
>  ======
>  WARNING: CPU: 7 PID: 1092 at fs/ext4/inode.c:227
>  ext4_evict_inode+0x875/0xc60
>  ...
>  RIP: 0010:ext4_evict_inode+0x875/0xc60
>  ...
>  Call Trace:
>   <TASK>
>   evict+0x11c/0x2b0
>   iput+0x236/0x3a0
>   do_unlinkat+0x1b4/0x490
>   __x64_sys_unlinkat+0x4c/0xb0
>   do_syscall_64+0x3b/0x90
>   entry_SYSCALL_64_after_hwframe+0x46/0xb0
>  RIP: 0033:0x7fa933c1115b
>  ======
> 
> rm                          kworker
>                             ext4_end_io_end()
> vfs_unlink()
>  ext4_unlink()
>                              ext4_convert_unwritten_io_end_vec()
>                               ext4_convert_unwritten_extents()
>                                ext4_map_blocks()
>                                 ext4_ext_map_blocks()
>                                  ext4_ext_try_to_merge_up()
>                                   __mark_inode_dirty()
>                                    check !I_FREEING
>                                    locked_inode_to_wb_and_lock_list()
>  iput()
>   iput_final()
>    evict()
>     ext4_evict_inode()
>      truncate_inode_pages_final() //wait release io_end
>                                     inode_io_list_move_locked()
>                              ext4_release_io_end()
>      trigger WARN_ON_ONCE()
> 
> Fixes: ceff86fddae8 ("ext4: Avoid freeing inodes on dirty list")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Good catch! So for the i_nlink == 0 case below, I'd just remove the
WARN_ON_ONCE altogether. It isn't very useful after your change anyway. But
probably we should add:

	WARN_ON_ONCE(!list_empty(&inode->i_io_list));

to the no_delete: case of ext4_evict_inode()? Race like you mention above
does not seem possible for that case but seeing the complicated
interactions I'd rather have the assertion in place.

								Honza

> ---
>  fs/ext4/inode.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 3dce7d058985..3b64d72416b7 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -220,11 +220,14 @@ void ext4_evict_inode(struct inode *inode)
>  
>  	/*
>  	 * For inodes with journalled data, transaction commit could have
> -	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
> -	 * flag but we still need to remove the inode from the writeback lists.
> +	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
> +	 * extents converting worker could merged extents and also have dirtied
> +	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
> +	 * we still need to remove the inode from the writeback lists.
>  	 */
>  	if (!list_empty_careful(&inode->i_io_list)) {
> -		WARN_ON_ONCE(!ext4_should_journal_data(inode));
> +		WARN_ON_ONCE(!ext4_should_journal_data(inode) &&
> +			     !ext4_should_dioread_nolock(inode));
>  		inode_io_list_del(inode);
>  	}
>  
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
