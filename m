Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A2664638A
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 22:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiLGV75 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 16:59:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLGV75 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 16:59:57 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEF7F8A7;
        Wed,  7 Dec 2022 13:59:55 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id m5so9473296qkg.0;
        Wed, 07 Dec 2022 13:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6RB4YyLBTzg2a7bTnYNxIdFoZiFwBEVrkJsMUmNneZ0=;
        b=OyBCKG4FoUjA1L+8nd43Nx1Dy6g3K3daEcyLGePloTQnVMgf7XXred8sqXJiLld9xv
         RUa7YEAUAlfNXv9lxgWqBADcG6nwXWhjOeLzdTZHLGv8gORwkiUAsw3un/4bE1KEA+8p
         wou6cPzugYtQ56AQS23Bo/JPgiy6pnkW6RilZESa44WlbsvzVkNOeF+lJHNO3V5i3qWF
         2igq5numzHoGqoqmXkI56s4pL1VftZnOLtfGF3CsfGBnfJYxRlL31kSzrNvt0SGjjVC7
         b9ePxfsT6HgHwRlmRW+JaSAgUkABIIt7vRcxv7K9sDSOymL5WUl83u39c4q0XKXUbgWi
         8FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6RB4YyLBTzg2a7bTnYNxIdFoZiFwBEVrkJsMUmNneZ0=;
        b=VO7ZXqf3F3z3DoJHZ6uI68WZ4l/9TJIgRo/XYA0xXqTpH02SuX2YOuiiiTsPkKUSwY
         Fedxy1iTmgF+4BZFnLPrVR4oPG0zXV/+uGbJdNEFv2kbKVfiw8+cr5O6hSf4b7gyBm5/
         2TbCgMK/lLHsKDxqku6K/V1+7TZ5uy9WXpxuuUdHNfhdarhZUUe4h8+FgrJLYEiQpGrs
         OJTNQcSld0AXiFbM6vCl5q5sJr0sEjOEUUMw153J7NgJfeooaRVPFy5YNyZ6Pq7yeS1R
         IVfKnbp2cQjuKLbIGtIYDjGrIHN0QppSa9dBPLssHWyMYiZlm8pdJhBzVA/bBXjiLtbC
         InKQ==
X-Gm-Message-State: ANoB5pk+h+0upZrFcwmbpC5op2JeRnNX7dvMx0zD7a09Rtv3l3xWBQNn
        WOdvTxJpe/kt0ULyyZDn8t4=
X-Google-Smtp-Source: AA0mqf6Q7oskLLDBMlDHQ9HgdhjrDfo1m6v1t5ElAT7xXTw6hex6OSU9TsQ+PV06f2p7sV+tfuRkPQ==
X-Received: by 2002:a05:620a:cd3:b0:6fc:7566:e077 with SMTP id b19-20020a05620a0cd300b006fc7566e077mr41048545qkj.418.1670450394300;
        Wed, 07 Dec 2022 13:59:54 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id n16-20020ac86750000000b003a50248b89esm13925122qtp.26.2022.12.07.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 13:59:53 -0800 (PST)
Date:   Wed, 7 Dec 2022 16:59:51 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 3/3] ext4: add check pending tree when evict inode
Message-ID: <Y5EM14vjsinP9RZx@debian-BULLSEYE-live-builder-AMD64>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
 <20221203025941.2661302-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203025941.2661302-4-yebin@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

`* Ye Bin <yebin@huaweicloud.com>:
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
> According to Eric Whitney's suggestion, bigalloc + inline is still in development
> so we just add test for this situation, there isn't need to add code to free
> pending tree entry.
> 
> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 41413338c05b..2e2fbc4a832c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1391,6 +1391,11 @@ static void ext4_destroy_inode(struct inode *inode)
>  			"Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			inode->i_ino, EXT4_I(inode),
>  			EXT4_I(inode)->i_reserved_data_blocks);
> +
> +	if (!RB_EMPTY_ROOT(&EXT4_I(inode)->i_pending_tree.root))
> +		ext4_error(inode->i_sb,
> +			"Inode %lu (%p): i_pending_tree not empty!",
> +			inode->i_ino, EXT4_I(inode));
>  }
>

It's always a good idea to run ./scripts/checkpatch.pl on your patches before
submitting them.  It's complaining that the lines in your commit description
are too long (it wants a maximum of 75 characters per line, but Ted prefers
a maximum of 72 for ext4 patches, IIRC).  Also, it wants parentheses around
the title of the patch mentioned in the commit message:
ie: commit 1b8f787ef547 ("ext4: fix warning in 'ext4_da_release_space'")

Also, typical ext4 practice is to align arguments to a function on following
lines to the beginning of the first argument, as can be seen earlier in
ext4_destroy_inode.  Indenting as you've done here passes checkpatch, but
it's different from most ext4 code (which also passes checkpatch).

Otherwise, it looks okay.

Eric


>  static void init_once(void *foo)
> -- 
> 2.31.1
> 
