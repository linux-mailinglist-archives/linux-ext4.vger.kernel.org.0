Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B3F6464AA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 00:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLGXBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 18:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiLGXBo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 18:01:44 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F1F31F84;
        Wed,  7 Dec 2022 15:01:42 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c15so17408943qtw.8;
        Wed, 07 Dec 2022 15:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tx6tzhbjO7Gy0+60bbcG9zq6h9cRYxpfj4U6TpS6Q34=;
        b=hM8FP0xxvaDElIP3ZMGmp5fNzTs7FYZrTDw9+NL51rBi7ogkkH/hMjhlXtsEg/6oWs
         QXBekjWyW7dxIOGZ6gHlrjoM1iBM8E4SmQLbMR4fIo/eezRy7mJ6oZnF9rlJQnFYY93f
         ZU49xUQ759Bvrzn3i71zaSzVCuaTh3YJDim7MLSitIJkGBBUCR3GYNtB1p5+e5IT8kBT
         menKuAW1EfHpzDKWKoek3IEA877CfVtSxh9mcVC0J3bj9xABme9hU3a0Mih2c3WYDTui
         RbjnmdBgdM9pdKBcUjrjy6kHJSN1wFNTt+3KvGA02ahHw240oTjuRLwOq+FQPoQoXFSM
         FdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tx6tzhbjO7Gy0+60bbcG9zq6h9cRYxpfj4U6TpS6Q34=;
        b=Qz9cpaqH7nVnwVc3pDWmrutIJsTuk89Q9MXYwUjKHlKHrn36N+Eejgvb8WPPFsd6oT
         mVuXwxscajubGtToJUIGsZGrxb/F9WKIO2zGGPr/FHUN4CrBNl4866iUw33RgwOqXC+U
         SIV4pjgGe1zmX8UxJtSsjKP9SYlkAWaljIQxs0sHuU3RjPEuqTbZrFm0768aHUjqa15C
         m7zVoqx11Ru8BW2d0k5gq3B/IxPB9EMYc06ai6AGzVesnPrsc8vusJ3ofX2porasSxRf
         G56tDkNqsGRbGod6EeABLK0sb+SR8Tus5uP7QJEfDj68dTABryouCPX1rPzHZv8sViGT
         1fwg==
X-Gm-Message-State: ANoB5pmm3hXw9FcSQsUfZTOzODloTbHbWVmnh8rJ3/0zS6KGCbklQDTk
        0PugZ9F9YSRxMOHVXm+V9pI=
X-Google-Smtp-Source: AA0mqf6JidltZI5bgKOSh7kpbYko5pNniYwCovqICIAOmFNXPJZ/PEs1x3xANfCTw/m2pJ1NSTkPUw==
X-Received: by 2002:ac8:4555:0:b0:3a5:60db:4d45 with SMTP id z21-20020ac84555000000b003a560db4d45mr1630567qtn.44.1670454101404;
        Wed, 07 Dec 2022 15:01:41 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id a23-20020ac81097000000b003a5430ee366sm14013473qtj.60.2022.12.07.15.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 15:01:40 -0800 (PST)
Date:   Wed, 7 Dec 2022 18:01:38 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y5EbUpyHTg3q3kNO@debian-BULLSEYE-live-builder-AMD64>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
 <20221203025941.2661302-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203025941.2661302-2-yebin@huaweicloud.com>
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
> Syzbot report issue as follows:
> EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep: bg 0: block 5: invalid block bitmap
> EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical offset 0 with max blocks 32 with error 28
> EXT4-fs (loop0): This should not happen!! Data will be lost
> 
> EXT4-fs (loop0): Total free blocks count 0
> EXT4-fs (loop0): Free/Dirty block details
> EXT4-fs (loop0): free_blocks=0
> EXT4-fs (loop0): dirty_blocks=32
> EXT4-fs (loop0): Block reservation details
> EXT4-fs (loop0): i_reserved_data_blocks=2
> EXT4-fs (loop0): Inode 18 (00000000845cd634): i_reserved_data_blocks (1) not cleared!
> 
> Above issue happens as follows:
> Assume:
> sbi->s_cluster_ratio = 16
> Step1: Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
> Step2:
> ext4_writepages
>   mpage_map_and_submit_extent -> return failed
>   mpage_release_unused_pages -> to release [0, 30]
>     ext4_es_remove_extent -> remove lblk=0 end=30
>       __es_remove_extent -> len1=0 len2=31-30=1
>  __es_remove_extent:
>  ...
>  if (len2 > 0) {
>   ...
> 	  if (len1 > 0) {
> 		  ...
> 	  } else {
> 		es->es_lblk = end + 1;
> 		es->es_len = len2;
> 		...
> 	  }
>   	if (count_reserved)
> 		count_rsvd(inode, lblk, orig_es.es_len - len1 - len2, &orig_es, &rc);
> 	goto out; -> will return but didn't calculate 'reserved'
>  ...
> Step3: ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"
> 
> To solve above issue if 'len2>0' call 'get_rsvd()' before goto out.
> 
> Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> Fixes: 8fcc3a580651 ("ext4: rework reserved cluster accounting when invalidating pages")
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/extents_status.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index cd0a861853e3..7ada374ff27d 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		if (count_reserved)
>  			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
>  				   &orig_es, &rc);
> -		goto out;
> +		goto out_get_reserved;
>  	}
>  
>  	if (len1 > 0) {
> @@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  	}
>  
> +out_get_reserved:
>  	if (count_reserved)
>  		*reserved = get_rsvd(inode, end, es, &rc);
>  out:

The length of some lines in the commit description - probably those which are
log output - is resulting in a checkpatch warning.  It generally prefers lines
to be a maximum of 75 characters (and Ted usually likes them limited to 72
characters.  See my comment to patch #3. I'm not sure what Ted would want here,
though I'd probably break them at 72 characters or less.

Otherwise, the patch looks good.  Feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

> -- 
> 2.31.1
> 
