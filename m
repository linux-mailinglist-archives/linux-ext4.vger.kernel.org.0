Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782D9637038
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Nov 2022 03:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiKXCId (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 21:08:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiKXCIc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 21:08:32 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DBE67F59;
        Wed, 23 Nov 2022 18:08:28 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h2so233359ile.11;
        Wed, 23 Nov 2022 18:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y9Umqc0p4JME1dKyjRjZs1+Fx3hhAdJ3Hca9Ue451UI=;
        b=PTKJj8WLLQARvOh1o2kzNnDf+3HVj8c/VbqjrROvNvieAY0thbuSm4k223ikJWN3hj
         JrxrtICPmJAA7X+ldIJu9PCTBNEbNniRxQU6HrzCcARCv3Dxh8ZmnoKK2IQ0pxO5FEim
         H8yUVaGTWgqxF07uMcE3jbWIlCFXf+TsEG3DAQzIwQ+BrvndKisSwZ2cW+fskHPiaQzT
         XD7PgJJZCLwo7H0wVRqjDzRJ5kHybKpVAncpnR0tojpSi/vFo5HZa5cIXAPf1RaPUrDU
         iFadZxkdbjPwtS50KNJIMUhPP/Px8wUSPob65Y+8l9YTVQOBSdsGbjy82AvP1PJBg2x7
         CGUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y9Umqc0p4JME1dKyjRjZs1+Fx3hhAdJ3Hca9Ue451UI=;
        b=YInGemmPgaCYBtUZn05pzT1fG3G+3DODZNhZ7/uVN0kAcdEzgscv/42RG3mHRi1akg
         nY7WAaYzSwXwLJBBiUsr639TPVS5jgzGEM4BNBM0ItEKlrrIxrV8cVisUT628XYNLgji
         bD5d9bIztsLV2MdMz43fiAMinYN3n7dVbtwbyI0t0/TDM8mqRf36MOzSwsg8WNaLmrL1
         pUZqjHqG03dMsEnDytjah2FYTjvtqm1CAAZaff6ElFHGX6435AyQ3w+d8EhGnjXtO8hB
         KA6nYtgu4+jO6YcBDI6XPBIUQ3+UFGwzKlaSQXHt4tjFegUIispHjG9CMjXr7/N/7egY
         88Xg==
X-Gm-Message-State: ANoB5pmXppIcFTqcNrtw2dhZ+JAxAO9abAprc5Ok/VEiyKClDMjlJJcW
        5CrRR8hRGdq2k7VgxQx6uT4=
X-Google-Smtp-Source: AA0mqf7q3qdMTBwsrZAjFhlkAdrnXNwrGv/oGs9OEti9Gy3Jmhit5k9Ufd2R6LEYGeQqlOiyZttBbw==
X-Received: by 2002:a92:7c0c:0:b0:302:efa3:6230 with SMTP id x12-20020a927c0c000000b00302efa36230mr15504ilc.232.1669255708121;
        Wed, 23 Nov 2022 18:08:28 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id q17-20020a02a991000000b00363a4fcd3a8sm6897886jam.5.2022.11.23.18.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 18:08:27 -0800 (PST)
Date:   Wed, 23 Nov 2022 21:08:25 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 3/3] ext4: add check pending tree when evict inode
Message-ID: <Y37SGeUwbcUQOK+V@debian-BULLSEYE-live-builder-AMD64>
References: <20221121121434.1061725-1-yebin@huaweicloud.com>
 <20221121121434.1061725-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121121434.1061725-4-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ye Bin <yebin@huaweicloud.com>:
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
> Above issue fixed by 1b8f787ef547 "ext4: fix warning in 'ext4_da_release_space'"
> in this scene. To make things better add check pending tree when evit inode.
> To avoid possible memleak free pending tree when check tree isn't cleared.
> 
> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/extents_status.c | 28 ++++++++++++++++++++++++++++
>  fs/ext4/extents_status.h |  1 +
>  fs/ext4/super.c          |  3 +++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4684eaea9471..a7a612eb70fe 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1948,6 +1948,34 @@ void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk)
>  	write_unlock(&ei->i_es_lock);
>  }
>  
> +void ext4_check_inode_pending(struct inode *inode)
> +{
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +	struct pending_reservation *pr;
> +	struct ext4_pending_tree *tree;
> +	struct rb_node *node;
> +	int count = 0;
> +
> +	write_lock(&ei->i_es_lock);
> +	tree = &EXT4_I(inode)->i_pending_tree;
> +	node = rb_first(&tree->root);
> +	while (node) {
> +		pr = rb_entry(node, struct pending_reservation, rb_node);
> +		node = rb_next(node);
> +		rb_erase(&pr->rb_node, &tree->root);
> +		kmem_cache_free(ext4_pending_cachep, pr);
> +		count++;
> +	}
> +	write_unlock(&ei->i_es_lock);
> +
> +	if (count)
> +		ext4_error(inode->i_sb,
> +			   "Inode %lu: pending tree has %d not cleared!",
> +			   inode->i_ino, count);
> +
> +	return;
> +}
> +
>  /*
>   * ext4_is_pending - determine whether a cluster has a pending reservation
>   *                   on it
> diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> index 4ec30a798260..631267d45ab2 100644
> --- a/fs/ext4/extents_status.h
> +++ b/fs/ext4/extents_status.h
> @@ -248,6 +248,7 @@ extern int __init ext4_init_pending(void);
>  extern void ext4_exit_pending(void);
>  extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
>  extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
> +extern void ext4_check_inode_pending(struct inode *inode);
>  extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
>  extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
>  					bool allocated);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 3d30007502a4..0498feecf10d 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1390,6 +1390,9 @@ static void ext4_destroy_inode(struct inode *inode)
>  		ext4_error(inode->i_sb, "Inode %lu (%p) i_reserved_data_blocks"
>  			   " (%u) not cleared!", inode->i_ino, EXT4_I(inode),
>  			   EXT4_I(inode)->i_reserved_data_blocks);
> +
> +	if (EXT4_SB(inode->i_sb)->s_cluster_ratio != 1)
> +		ext4_check_inode_pending(inode);
>  }
>  
>  static void init_once(void *foo)

Ye Bin:

I think there's no need to add code that tears down non-empty pending trees
when an inode is destroyed.  If one ever appears, that's an indication of a
bug (and a possibly damaged file system), and the better thing to do is to
simply find and fix that bug.  Code that is never supposed to run, like what
you are proposing, is difficult to test and maintain over time and is prone
to bit rot.

If we do anything here, the better thing to do is to simply log an error
in the event of a non-empty pending tree and let the administrator/user
decide how they want to handle the problem.  That would probably include
filing a bug report so we can fix the problem if it ever occurs.

My suggestion is to add an inline function to extents_status.c that uses
something like this to test for the presence of a non-empty pending
reservation tree (then called from ext4_destroy_inode):

if (RB_EMPTY_ROOT(&EXT4_I(inode)->i_pending_tree.root))
...

Please note that you've been testing a file system configuration that still
needs development work - bigalloc + inline.  From the kernel stacks you've
been posting, that appears to be the case, anyway.  When that work is
complete, we will have done enough testing to be confident we don't have
memory leaks.  Until then, leaks and other bugs are possible.

Eric

> -- 
> 2.31.1
> 
