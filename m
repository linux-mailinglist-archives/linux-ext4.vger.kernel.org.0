Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCFEA55FCFC
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jun 2022 12:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiF2KRw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 06:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbiF2KRw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 06:17:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E963A1AC
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 03:17:50 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7C9F41FEE6;
        Wed, 29 Jun 2022 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656497869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLV1mHJD3a3n2IKNcLDVn6u12vq6Wc7JX8PTEEN6wM4=;
        b=UEbwPbeQD0TFYYpaEKIba+0REb9+CaQjRgoyc2PQajE1Zh+r7Nzfdm8dGF63L/WIvjcQsy
        Vwtja4dvfqLRxo1T5P6zfzBvrDehWBRTcTexDoauedBdWXecklJtTgexzZt+hJWgaBQMyZ
        wIwBan1kYLI02TPRu1yTbrogTBiebnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656497869;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HLV1mHJD3a3n2IKNcLDVn6u12vq6Wc7JX8PTEEN6wM4=;
        b=fA0AiMU+AtYaIXGLg9CyTbUtIsDf5MSYp7cAjC3pCvKpPXHFXVYbP5zl06VC0ExF4JrOXr
        u0cPfxM1EUaUWYDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 65B292C141;
        Wed, 29 Jun 2022 10:17:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 16DEFA062F; Wed, 29 Jun 2022 12:17:49 +0200 (CEST)
Date:   Wed, 29 Jun 2022 12:17:49 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v2 1/2] ext4: silence the warning when evicting inode
 with dioread_nolock
Message-ID: <20220629101749.zljoazab33mb2xqm@quack3>
References: <20220629022940.2855538-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629022940.2855538-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 29-06-22 10:29:39, Zhang Yi wrote:
> When evicting an inode with default dioread_nolock, it could be raced by
> the unwritten extents converting kworker after writeback some new
> allocated dirty blocks. It convert unwritten extents to written, the
> extents could be merged to upper level and free extent blocks, so it
> could mark the inode dirty again even this inode has been marked
> I_FREEING. But the inode->i_io_list check and warning in
> ext4_evict_inode() missing this corner case. Fortunately,
> ext4_evict_inode() will wait all extents converting finished before this
> check, so it will not lead to inode use-after-free problem, every thing
> is OK besides this warning. The WARN_ON_ONCE was originally designed
> for finding inode use-after-free issues in advance, but if we add
> current dioread_nolock case in, it will become not quite useful, so fix
> this warning by just remove this check.
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

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 84c0eb55071d..702cc208689a 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -220,13 +220,13 @@ void ext4_evict_inode(struct inode *inode)
>  
>  	/*
>  	 * For inodes with journalled data, transaction commit could have
> -	 * dirtied the inode. Flush worker is ignoring it because of I_FREEING
> -	 * flag but we still need to remove the inode from the writeback lists.
> +	 * dirtied the inode. And for inodes with dioread_nolock, unwritten
> +	 * extents converting worker could merge extents and also have dirtied
> +	 * the inode. Flush worker is ignoring it because of I_FREEING flag but
> +	 * we still need to remove the inode from the writeback lists.
>  	 */
> -	if (!list_empty_careful(&inode->i_io_list)) {
> -		WARN_ON_ONCE(!ext4_should_journal_data(inode));
> +	if (!list_empty_careful(&inode->i_io_list))
>  		inode_io_list_del(inode);
> -	}
>  
>  	/*
>  	 * Protect us against freezing - iput() caller didn't have to have any
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
