Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A1A620616
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Nov 2022 02:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiKHBbB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Nov 2022 20:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbiKHBal (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Nov 2022 20:30:41 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F18930F56;
        Mon,  7 Nov 2022 17:29:00 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id u7so9347210qvn.13;
        Mon, 07 Nov 2022 17:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DPkaGFcmfm4OZXYL2J0lyOobwvwZFCF6vVLcOUXemis=;
        b=ZY+eHsv/wAQGuytoX7Q5O4Hy0iwkqIhSekqTcT0kA+w8fXfAwWuhjOdOoZb7FCFk1F
         dg32wW8vTSemAdYnmiD9xThFQWwPcwVZnr4s7ZCYRofc9/bB4wRn9XeF+68CsCFTaHI+
         h7eQkJSsatfFzaWjVImkPNQ/FX9LZk7VD2T2d1iearMBsCGKRuWd5edvqz56xuhrQKH2
         1ergSBhCfpqt1lySP0U2nfm7mEoGYCR7+4BBVbvfh4LUy8X3z8Pspgcq45C1mJqiqJ/T
         ZI7Iw+7jgU/1TL4ZqqujfsKH4dz72XgoPtfuneNuhwKSFxsQC9XhpcCnWTfSQ20UGegi
         WHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPkaGFcmfm4OZXYL2J0lyOobwvwZFCF6vVLcOUXemis=;
        b=FniJk4lv52W8eDr8iNCKZZllJpfL78Ez23oHsUY+xhje41p1vVAgvfDy3PbLn0bbGd
         yI6JMe4fq+Ii7dhSRFYEaAb0ofMpHZkPsftzJMYwMVe8Y4vB09M/0Oq9Nq8Tgadfr3bB
         MjBg7/UzKVKHj8SnTkgtZCu7UIt3p7WBG5TlV/oJ5Z+GOka6LM0KfBCGKrCwh28Sq18V
         yF5MRG4JqxKdIwXVPUjIbO38uP82GSj0Ca++yVdqu9ft1JbS6xYLnhIhxtokQP1NPCCS
         yn0XhfEQmV4ufzpbbAp32RZbhQGzDY0GvybEXWw1vVgGDIvdv5TTHZhSCe/5382eZi95
         oMSQ==
X-Gm-Message-State: ACrzQf2OJu6BmZ6I0lLmo8BCRBH14FHRZXo6eHzIvQ1ExAiezt+689mt
        WCy+fHtAJ/OTBkNpTnzSD7xceKxC7+BsKA==
X-Google-Smtp-Source: AMsMyM7VWSGoWMbLm4Dr9nZbNGpvp2sZM+Ga2j6fsmm4GL4T1nRe18OhFj48GnPCrmIfI2N7ZHWwSw==
X-Received: by 2002:a0c:ea91:0:b0:4bb:d550:d06a with SMTP id d17-20020a0cea91000000b004bbd550d06amr834972qvp.131.1667870938444;
        Mon, 07 Nov 2022 17:28:58 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id b3-20020ac87fc3000000b003a56796a764sm7312160qtk.25.2022.11.07.17.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 17:28:57 -0800 (PST)
Date:   Mon, 7 Nov 2022 20:28:55 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     "yebin (H)" <yebin10@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com,
        Eric Whitney <enwlinux@gmail.com>
Subject: Re: [PATCH] ext4: fix possible memory leak when enable bigalloc
 feature
Message-ID: <Y2mw15jYoEfOExgA@debian-BULLSEYE-live-builder-AMD64>
References: <20221107015415.2526414-1-yebin@huaweicloud.com>
 <20221107134638.iyihe72m2woj6chm@quack3>
 <63691697.8010302@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63691697.8010302@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* yebin (H) <yebin10@huawei.com>:
> 
> 
> On 2022/11/7 21:46, Jan Kara wrote:
> > Let me CC Eric who wrote this code...
> > 
> > On Mon 07-11-22 09:54:15, Ye Bin wrote:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > Syzbot found the following issue:
> > > BUG: memory leak
> > > unreferenced object 0xffff8881bde17420 (size 32):
> > >    comm "rep", pid 2327, jiffies 4295381963 (age 32.265s)
> > >    hex dump (first 32 bytes):
> > >      01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >      00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
> > >    backtrace:
> > >      [<00000000ac6d38f8>] __insert_pending+0x13c/0x2d0
> > >      [<00000000d717de3b>] ext4_es_insert_delayed_block+0x399/0x4e0
> > >      [<000000004be03913>] ext4_da_map_blocks.constprop.0+0x739/0xfa0
> > >      [<00000000885a832a>] ext4_da_get_block_prep+0x10c/0x440
> > >      [<0000000029b7f8ef>] __block_write_begin_int+0x28d/0x860
> > >      [<00000000e182ebc3>] ext4_da_write_inline_data_begin+0x2d1/0xf30
> > >      [<00000000ced0c8a2>] ext4_da_write_begin+0x612/0x860
> > >      [<000000008d5f27fa>] generic_perform_write+0x215/0x4d0
> > >      [<00000000552c1cde>] ext4_buffered_write_iter+0x101/0x3b0
> > >      [<0000000052177ae8>] do_iter_readv_writev+0x19f/0x340
> > >      [<000000004b9de834>] do_iter_write+0x13b/0x650
> > >      [<00000000e2401b9b>] iter_file_splice_write+0x5a5/0xab0
> > >      [<0000000023aa5d90>] direct_splice_actor+0x103/0x1e0
> > >      [<0000000089e00fc1>] splice_direct_to_actor+0x2c9/0x7b0
> > >      [<000000004386851e>] do_splice_direct+0x159/0x280
> > >      [<00000000b567e609>] do_sendfile+0x932/0x1200
> > > 
> > > Now, 'ext4_clear_inode' don't cleanup pending tree which will lead to memory
> > > leak.
> > > To solve above issue, cleanup pending tree when clear inode.
> > > 
> > > Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > So I'd think that by the time we are freeing inode all pending reservations
> > should be resolved and thus the tree should be empty. In that case you'd be
> > just masking some other bug where we failed to cleanup pending information
> > at the right moment. But maybe I'm missing something - that's why I've
> > added Eric to have a look ;)
> > 
> > 								Honza
> Yes, this is really a circumvention plan. Maybe we can check here. If the
> pending tree is
> not empty, we still need to clean up resources to prevent memory leaks.
> Let me analyze this process again.

Jan is right.  If there are pending reservations remaining by the time we
get to ext4_clear_inode(), something's broken somewhere else.  The code is
designed to clean up any and all pending reservations when a file is truncated,
and that should happen in ext4_evict_inode() before ext4_clear_inode() is
called.  (It's probably unnecessary as a result, but the call to
ext4_es_remove_extent() in ext4_clear_inode() should free any stray pending
reservations via __es_remove_extent() and get_rsvd() unless they're somehow not
consistent with the extents in the status tree.)

If there are leaking pending reservations, it may be that the cluster
accounting isn't working correctly.  So, the better thing to do is to find
the root cause of the leak and fix it at its source.

I can guess what the general cause of the breakage might be.  The presence of
ext4_da_write_inline_data_begin() on the stack suggests that the inline_data
option is being used with bigalloc here.  If so, that combination is unlikely
to work well.  To my knowledge, the cluster accounting code has not yet been
deliberately integrated with or well tested with inline.

Eric


> > > ---
> > >   fs/ext4/extents_status.c | 22 ++++++++++++++++++++++
> > >   fs/ext4/extents_status.h |  1 +
> > >   fs/ext4/super.c          |  1 +
> > >   3 files changed, 24 insertions(+)
> > > 
> > > diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> > > index cd0a861853e3..5f6b218464de 100644
> > > --- a/fs/ext4/extents_status.c
> > > +++ b/fs/ext4/extents_status.c
> > > @@ -1947,6 +1947,28 @@ void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk)
> > >   	write_unlock(&ei->i_es_lock);
> > >   }
> > > +void ext4_clear_inode_pending(struct inode *inode)
> > > +{
> > > +	struct ext4_inode_info *ei = EXT4_I(inode);
> > > +	struct pending_reservation *pr;
> > > +	struct ext4_pending_tree *tree;
> > > +	struct rb_node *node;
> > > +
> > > +	if (EXT4_SB(inode->i_sb)->s_cluster_ratio == 1)
> > > +		return;
> > > +
> > > +	write_lock(&ei->i_es_lock);
> > > +	tree = &EXT4_I(inode)->i_pending_tree;
> > > +	node = rb_first(&tree->root);
> > > +	while (node) {
> > > +		pr = rb_entry(node, struct pending_reservation, rb_node);
> > > +		node = rb_next(node);
> > > +		rb_erase(&pr->rb_node, &tree->root);
> > > +		kmem_cache_free(ext4_pending_cachep, pr);
> > > +	}
> > > +	write_unlock(&ei->i_es_lock);
> > > +}
> > > +
> > >   /*
> > >    * ext4_is_pending - determine whether a cluster has a pending reservation
> > >    *                   on it
> > > diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
> > > index 4ec30a798260..25b605309c06 100644
> > > --- a/fs/ext4/extents_status.h
> > > +++ b/fs/ext4/extents_status.h
> > > @@ -248,6 +248,7 @@ extern int __init ext4_init_pending(void);
> > >   extern void ext4_exit_pending(void);
> > >   extern void ext4_init_pending_tree(struct ext4_pending_tree *tree);
> > >   extern void ext4_remove_pending(struct inode *inode, ext4_lblk_t lblk);
> > > +extern void ext4_clear_inode_pending(struct inode *inode);
> > >   extern bool ext4_is_pending(struct inode *inode, ext4_lblk_t lblk);
> > >   extern int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
> > >   					bool allocated);
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 106fb06e24e8..160667dcf09a 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -1434,6 +1434,7 @@ void ext4_clear_inode(struct inode *inode)
> > >   	clear_inode(inode);
> > >   	ext4_discard_preallocations(inode, 0);
> > >   	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
> > > +	ext4_clear_inode_pending(inode);
> > >   	dquot_drop(inode);
> > >   	if (EXT4_I(inode)->jinode) {
> > >   		jbd2_journal_release_jbd_inode(EXT4_JOURNAL(inode),
> > > -- 
> > > 2.31.1
> > > 
> 
