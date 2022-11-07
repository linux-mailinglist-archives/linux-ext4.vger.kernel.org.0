Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35C0E61F499
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 14:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiKGNqm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 08:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiKGNql (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 08:46:41 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD312A96;
        Mon,  7 Nov 2022 05:46:40 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 95CA8224A0;
        Mon,  7 Nov 2022 13:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1667828799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKO12PBhU03TLHIn/O1j3mOW/mbxtMieGU63MmsGZ6Y=;
        b=D7Ou35f5okMcax8CdzkElIk/R7f7yaAsWxc5dQz3ExsZgoTffem6MGxHcwh7UBFIVmG5n5
        2FUcTWPHDPNbioqgzD2i/GHsHCp7IZW6duOc9l46Bi7XNAHWJJE14Lc4fA9YjNUAWUXprX
        mSFpclvjzCSOWC/Trt4V8JctStK0oxM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1667828799;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SKO12PBhU03TLHIn/O1j3mOW/mbxtMieGU63MmsGZ6Y=;
        b=PGS5ZIXVi66AJqsysbhoxbMwp9ukbSW7OHgbBVH/uaKxOJMmE24nQ6xsvZVmgPD08JoL9J
        fC3wwMQqpMLVfiBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 71D2B13494;
        Mon,  7 Nov 2022 13:46:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jpu9Gz8MaWNOZQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 07 Nov 2022 13:46:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 916FDA0704; Mon,  7 Nov 2022 14:46:38 +0100 (CET)
Date:   Mon, 7 Nov 2022 14:46:38 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: fix possible memory leak when enable bigalloc
 feature
Message-ID: <20221107134638.iyihe72m2woj6chm@quack3>
References: <20221107015415.2526414-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107015415.2526414-1-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Let me CC Eric who wrote this code...

On Mon 07-11-22 09:54:15, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Syzbot found the following issue:
> BUG: memory leak
> unreferenced object 0xffff8881bde17420 (size 32):
>   comm "rep", pid 2327, jiffies 4295381963 (age 32.265s)
>   hex dump (first 32 bytes):
>     01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace:
>     [<00000000ac6d38f8>] __insert_pending+0x13c/0x2d0
>     [<00000000d717de3b>] ext4_es_insert_delayed_block+0x399/0x4e0
>     [<000000004be03913>] ext4_da_map_blocks.constprop.0+0x739/0xfa0
>     [<00000000885a832a>] ext4_da_get_block_prep+0x10c/0x440
>     [<0000000029b7f8ef>] __block_write_begin_int+0x28d/0x860
>     [<00000000e182ebc3>] ext4_da_write_inline_data_begin+0x2d1/0xf30
>     [<00000000ced0c8a2>] ext4_da_write_begin+0x612/0x860
>     [<000000008d5f27fa>] generic_perform_write+0x215/0x4d0
>     [<00000000552c1cde>] ext4_buffered_write_iter+0x101/0x3b0
>     [<0000000052177ae8>] do_iter_readv_writev+0x19f/0x340
>     [<000000004b9de834>] do_iter_write+0x13b/0x650
>     [<00000000e2401b9b>] iter_file_splice_write+0x5a5/0xab0
>     [<0000000023aa5d90>] direct_splice_actor+0x103/0x1e0
>     [<0000000089e00fc1>] splice_direct_to_actor+0x2c9/0x7b0
>     [<000000004386851e>] do_splice_direct+0x159/0x280
>     [<00000000b567e609>] do_sendfile+0x932/0x1200
> 
> Now, 'ext4_clear_inode' don't cleanup pending tree which will lead to memory
> leak.
> To solve above issue, cleanup pending tree when clear inode.
> 
> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>

So I'd think that by the time we are freeing inode all pending reservations
should be resolved and thus the tree should be empty. In that case you'd be
just masking some other bug where we failed to cleanup pending information
at the right moment. But maybe I'm missing something - that's why I've
added Eric to have a look ;)

								Honza

> ---
>  fs/ext4/extents_status.c | 22 ++++++++++++++++++++++
>  fs/ext4/extents_status.h |  1 +
>  fs/ext4/super.c          |  1 +
>  3 files changed, 24 insertions(+)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index cd0a861853e3..5f6b218464de 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1947,6 +1947,28 @@ void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk)
>  	write_unlock(&ei->i_es_lock);
>  }
>  
> +void ext4_clear_inode_pending(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct pending_reservation *pr;
> +	struct ext4_pending_tree *tree;
> +	struct rb_node *node;
> +
> +	if (EXT4_SB(inode->i_sb)->s_cluster_ratio == 1)
> +		return;
> +
> +	write_lock(&ei->i_es_lock);
> +	tree = &EXT4_I(inode)->i_pending_tree;
> +	node = rb_first(&tree->root);
> +	while (node) {
> +		pr = rb_entry(node, struct pending_reservation, rb_node);
> +		node = rb_next(node);
> +		rb_erase(&pr->rb_node, &tree->root);
> +		kmem_cache_free(ext4_pending_cachep, pr);
> +	}
> +	write_unlock(&ei->i_es_lock);
> +}
> +
>  /*
>   * ext4_is_pending - determine whether a cluster has a pending reservation
>   *                   on it
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 4ec30a798260..25b605309c06 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -248,6 +248,7 @@ extern int __init ext4_init_pending(void);
>  extern void ext4_exit_pending(void);
>  extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
>  extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
> +extern void ext4_clear_inode_pending(struct inode *inode);
>  extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
>  extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  					bool allocated);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 106fb06e24e8..160667dcf09a 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1434,6 +1434,7 @@ void ext4_clear_inode(struct inode *inode)
>  	clear_inode(inode);
>  	ext4_discard_preallocations(inode, 0);
>  	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> +	ext4_clear_inode_pending(inode);
>  	dquot_drop(inode);
>  	if (EXT4_I(inode)->jinode) {
>  		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
