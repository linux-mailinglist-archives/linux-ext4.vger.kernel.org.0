Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA78063FA6F
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 23:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiLAWVV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 17:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiLAWVV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 17:21:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C832BEC71;
        Thu,  1 Dec 2022 14:21:20 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id h24so2834076qta.9;
        Thu, 01 Dec 2022 14:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dtuK8V62z4nQ/wvboBDg49+ltn3jzQsxAoe6JquW0Fc=;
        b=LFDymU9Zi7C+HpknRXemqA2HiA31xGI7uULrWRsMIn4XSimz802+sFl20tLmGMJldv
         bB8w+UYwXfbEeATss5PmTQdHo/B3KDPcHevT/oeYxD1Oe8rn/BR/ImympIs6lLYOJgs+
         oFZXl36iKWTAyzo7SsmlHHwYHb95rahPzoTWUcuR9B231AcOoEYWW/flQgFRBoDnsdeq
         v4cuh3P9hUtWJo79NqZvOhHsIK7uet/tctbzSm98LwV8AI7in3xZdIPs3ZIsxgcMM0jE
         rv3rPRJf365Iu9qCVs110VJZvmEPpo5jFPYgbEY7r8sQKbd8BHj6Un12E07M7ndCkCue
         VShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dtuK8V62z4nQ/wvboBDg49+ltn3jzQsxAoe6JquW0Fc=;
        b=tulZHpFgnwtuaO7puVUn+2Hbv1mpycUDxijEad1Lm6b9tvHTn4tSYx2XNjDMLz630r
         Z/y46CQYDku2qPpmdUsqYZe8WsQRUyY9/eLZvQIanBGSuSAfEvYXY7kwiSVMIe/7Ewxk
         En3jbXC7jnooCvjAqqdAQzYrhROjqM52IQK7irWQ6+Mw1SBz5AHfoFaSAE57V9ovTeNN
         Nfk53MFZSSAxGy6B/46AAJJY8gx8/MQqgfM20/mJAlgNhGa3rCV8Q9OdOPaqI4PlyU/V
         qzTwWLdmNG56UxEZE/dSh+qmzj96oAlryR3nGj/6tWfRaR6c2Vr2OhKS6RZyXcHx/oYY
         ATZQ==
X-Gm-Message-State: ANoB5pmwu+GY4L97RzBeTT7rWkCZNRHRLNs7dZ6K7vjkPufDEevmPDKo
        9fxZiHj+gBMzsRzl2aufMz0=
X-Google-Smtp-Source: AA0mqf7DI7QwBXkNGwZiAya0rJAwi2+RGbpCta0eajbdIdbwFhGYbDi9CowM3Oz8W9OsS19J7t3lww==
X-Received: by 2002:a37:aec6:0:b0:6f9:f247:8934 with SMTP id x189-20020a37aec6000000b006f9f2478934mr62468056qke.90.1669933279695;
        Thu, 01 Dec 2022 14:21:19 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id dt4-20020a05620a478400b006fc9847d207sm4136355qkb.79.2022.12.01.14.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:21:19 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:21:16 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v2 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y4ko3OL57iyiRC0W@debian-BULLSEYE-live-builder-AMD64>
References: <20221121121434.1061725-1-yebin@huaweicloud.com>
 <20221121121434.1061725-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121121434.1061725-2-yebin@huaweicloud.com>
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
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/extents_status.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index cd0a861853e3..4684eaea9471 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		if (count_reserved)
>  			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
>  				   &orig_es, &rc);
> -		goto out;
> +		goto count;
>  	}
>  
>  	if (len1 > 0) {
> @@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  		}
>  	}
>  
> +count:
>  	if (count_reserved)
>  		*reserved = get_rsvd(inode, end, es, &rc);
>  out:
> -- 
> 2.31.1
> 

I'm unable to find the sysbot report for this patch, so I can't verify that
this fix works.  The more serious problem would be whatever is causing
the invalid block bitmap and delayed allocation failure messages before the
i_reserved_data_blocks message.  Perhaps that's simply what syzkaller set
up, but it's not clear from this posting.  Have you looked for the cause
of those first two messages?

However, by inspection this patch should fix an obvious bug causing that last
message, introduced by 8fcc3a580651 ("ext4: rework reserved cluster accounting
when invalidating pages").  A Fixes tag should be added to the patch.  Also,
the readability of the code should be improved by changing the label "count" to
the more descriptive "out_get_reserved".

With those two changes, feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

Eric
