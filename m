Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58864796C
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 00:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLHXBW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 18:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbiLHXBV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 18:01:21 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A397DA68;
        Thu,  8 Dec 2022 15:01:20 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id d13so2005322qvj.8;
        Thu, 08 Dec 2022 15:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0yPQ9yeuVpzjbeyRnkuKRSNvZzvcY5CJBpJ2qX+fow=;
        b=M4v85Ad5iBYQnrZrTRG+3ShH5sT4XQgWhFFm87rbvMM1gUzDiAkNXUXVt3Hg2Zl7N1
         uW9JJrWGHCQEvPCT2MJv7fagKsQgbRb8giXXT7JlBIxbBPqWpKK4DNzkLs0mb8OwLElr
         MkzomRChb+jkMmJV7AG/GAKw2gTcMyy9LCp5OcuMV6o3Ct35sss1egPujPWjzEfv5Yxq
         sgI8x75o5M2n5NZ/TWii+sniGoh31unzujvZ9jCMHpAEnyIjNsLR35tE1iY6ploe9e1r
         I6uQKRG0dYPL8xDZgzQu623I+y7ggiZUi0NhRGJG5jw3ufFiv17avUGlRclyqwdqSI3l
         DqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0yPQ9yeuVpzjbeyRnkuKRSNvZzvcY5CJBpJ2qX+fow=;
        b=qb/xDbz6E4jzPNhdvr5InRuUqMltXcXiOG028SIxsoqgIBpFM1mvtWdpR9Q3XDNFIs
         bW0ci2TLPD/GTyU9w4lP4r9sRXYL7Cvw7pn9njs03KXIr+vsU5uOAtHA/L1VUvKkAYv1
         jBKsGXqYbJPRpHPUIFllkiuqpQRc/D885tps11rika1BnWutPJakDe8H/v64kKkBwrB2
         44hF9KX0gRfDS1XIN55hFJPyqZJ/kk3jJ231T6daIolC7TjwHeT3cmGx/Ig/t26aOhmM
         SyJCQ5PEujPsR6FI6nZM5kjT2KrgdaXEx4g9t2smLieXh/61l0Ao8PHyZiGmBUPtJQ3I
         Dmyw==
X-Gm-Message-State: ANoB5plqNdunqz8Btd7LL64HOgpQj8fFDWbN/fC0qDf1ySM2yfbLI8hq
        NmfNR6s1g0dATFzpLN0MXBM=
X-Google-Smtp-Source: AA0mqf6dWOBiTurqmRPES+C7f+OHp/Px6rIMRVSMaH+faYCh/lE7uxOIfyW8QC2px6Ld0f1zq12IIQ==
X-Received: by 2002:a0c:e9c6:0:b0:4c7:6938:4514 with SMTP id q6-20020a0ce9c6000000b004c769384514mr5602899qvo.0.1670540479415;
        Thu, 08 Dec 2022 15:01:19 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id t3-20020a05620a450300b006eea4b5abcesm21238254qkp.89.2022.12.08.15.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 15:01:18 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:01:16 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y5JsvMzx04EcVMHC@debian-BULLSEYE-live-builder-AMD64>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
 <20221208033426.1832460-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208033426.1832460-2-yebin@huaweicloud.com>
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
> EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep:
> 	bg 0: block 5: invalid block bitmap
> EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical
> 	offset 0 with max blocks 32 with error 28
> EXT4-fs (loop0): This should not happen!! Data will be lost
> 
> EXT4-fs (loop0): Total free blocks count 0
> EXT4-fs (loop0): Free/Dirty block details
> EXT4-fs (loop0): free_blocks=0
> EXT4-fs (loop0): dirty_blocks=32
> EXT4-fs (loop0): Block reservation details
> EXT4-fs (loop0): i_reserved_data_blocks=2
> EXT4-fs (loop0): Inode 18 (00000000845cd634):
> 	i_reserved_data_blocks (1) not cleared!
> 
> Above issue happens as follows:
> Assume:
> sbi->s_cluster_ratio = 16
> Step1:
> Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
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
> 		count_rsvd(inode, lblk, ...);
> 	goto out; -> will return but didn't calculate 'reserved'
>  ...
> Step3:
> ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"
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
> -- 

OK, this looks good.

As before, feel free to add:

Reviewed-by: Eric Whitney <enwlinux@gmail.com>

> 2.31.1
> 
