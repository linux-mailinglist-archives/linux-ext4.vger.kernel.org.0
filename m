Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A3A64797B
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 00:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiLHXIe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 18:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiLHXId (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 18:08:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268492FBEB;
        Thu,  8 Dec 2022 15:08:32 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id fu10so2411145qtb.0;
        Thu, 08 Dec 2022 15:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jHOWRvXkj3EmGikKamhDv4mSDpov288UVpJ5NdoF1Yg=;
        b=eJl2ZoV4Yk9mU8KJYr/tRoSTp/nTw20zC9XOIlq36xmn0NAqu7gynnm+Jhyzt4j+Iz
         9qUpezXHl6WbX5XHAlOM78cfhpUOvFIm96coBKb7LioYWbPf3iHWiv9fGyz8afDjci59
         Z37ro286sSs8CrO1YIQm7e2dWdVhnpvRZWG3X+rUH0VWKxnBqRcyiNoEQmAmurlCC2IG
         HTAjczGJNfU4eVWqWI2IKFw51ePyEemnMsHEKNME+2mHamup/W94zjHO80pla6bGkCM4
         gC9fd/wQP+zWo8Vtb/yj5n4Hj42p1UfoXKEeGgF/2gs9kR8I2xI3XW0FRbvGeHLyirzj
         L6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jHOWRvXkj3EmGikKamhDv4mSDpov288UVpJ5NdoF1Yg=;
        b=SG8r9kpaiJddqzQ7dXs35OVaKsxbD+v5L7a0llMm340jVj1NPATC6i4lSTRZAs/zIT
         AKzu1kfolSCx0UzUY+EXyd7uTTtqEutTgVIN36DQYhRo+QmhcOrlQIVWsNTtJzYjMdag
         pu1JQ2Y9c1vIptc50Lp1v56cCU2jk+2/Oc78ZL7/CQcg1ljDyhoPEYakMsU2ReE7KFbE
         P2ogQnktSoXg/l4GIvAyI7UX1j8ArTleRiPEAN28hvhVZYFMNPVozQIoUujgtH8ubucj
         DnqRF6BFt6gbjuSje3hXHI6RQARFAzX/ybbn2NHWtD6WR2mgibVrJhKj89YExkkVCQve
         Xb8A==
X-Gm-Message-State: ANoB5pmuYGhFsUPMW5PamTqrfsg8IafjzzJ+o1MNPpPF46JMBjXFB8SU
        Yu7jHJtbaCNxmYPVi22JaPE=
X-Google-Smtp-Source: AA0mqf44cGKJuPI9V6XJ3SAzqO5jAyE0CqIhRu8cRP72pFzT6LyGMuGXrQWcyMBQSu7aziu3rLlz/w==
X-Received: by 2002:ac8:5508:0:b0:39c:da20:688 with SMTP id j8-20020ac85508000000b0039cda200688mr5953388qtq.43.1670540911311;
        Thu, 08 Dec 2022 15:08:31 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id f40-20020a05622a1a2800b003a7f4c69334sm3245716qtb.24.2022.12.08.15.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:08:30 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:08:29 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 3/3] ext4: add check pending tree when evict inode
Message-ID: <Y5JubamuduQ8oUex@debian-BULLSEYE-live-builder-AMD64>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
 <20221208033426.1832460-4-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208033426.1832460-4-yebin@huaweicloud.com>
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
> Above issue fixed by
> commit 1b8f787ef547 ("ext4: fix warning in 'ext4_da_release_space'")
> in this scene. To make things better add check pending tree when evict
> inode.
> According to Eric Whitney's suggestion, bigalloc + inline is still in
> development so we just add test for this situation, there isn't need to
> add code to free pending tree entry.
> 
> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 4b2d257d3845..15b6634975e7 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1391,6 +1391,11 @@ static void ext4_destroy_inode(struct inode *inode)
>  			   "Inode %lu (%p): i_reserved_data_blocks (%u) not cleared!",
>  			   inode->i_ino, EXT4_I(inode),
>  			   EXT4_I(inode)->i_reserved_data_blocks);
> +
> +	if (!RB_EMPTY_ROOT(&EXT4_I(inode)->i_pending_tree.root))
> +		ext4_error(inode->i_sb,
> +			   "Inode %lu (%p): i_pending_tree not empty!",
> +			   inode->i_ino, EXT4_I(inode));
>  }
>  
>  static void init_once(void *foo)
> -- 

Looks good.  Feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

> 2.31.1
> 
