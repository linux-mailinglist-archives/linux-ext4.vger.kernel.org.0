Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9EC3647D8A
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Dec 2022 07:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiLIGDZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 9 Dec 2022 01:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiLIGDY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 9 Dec 2022 01:03:24 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB953A2F7
        for <linux-ext4@vger.kernel.org>; Thu,  8 Dec 2022 22:03:23 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B962tEr000458
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 9 Dec 2022 01:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670565778; bh=NFM/wQqMAvi3IM9/189Cz6SQBFdZ5TTZn5q3GHDwwwQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Om3N2H4D1vxcq2c7ukL1tcfXLz+7AbQh1iWPGtclBuAcqmyxdzcOAZrnphhwGZ3ZV
         MSCw/mNKiKJmLkMB+vAb9diXakz53Ft7C/xLuASFkiowye1WoxLLz5KM52LfaLm9Kc
         NxnaWzYDqkYGubpWR80oaP4aSVEqkHYGaeHZwUwEZB5JysYDBdHuWEGNR9IatNPiix
         sxOgRZnC87kpRQa7HowSrtmj/alKdxeHRyggaLY+9yhYEz7+vLacKsKCY652/YYk5i
         mlANuQmQrsCqxEx/LTeedMAtcnHR4zxXzoKW7xVfaN8qzUee2zwI35cTbMqc/yMz38
         HexoivHA6rHiQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 59DD915C3AE9; Fri,  9 Dec 2022 01:02:55 -0500 (EST)
Date:   Fri, 9 Dec 2022 01:02:55 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v4 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y5LPjy8f1bpQqSTq@mit.edu>
References: <20221208033426.1832460-1-yebin@huaweicloud.com>
 <20221208033426.1832460-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208033426.1832460-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 08, 2022 at 11:34:24AM +0800, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 

Thanks, applied with an edit commit description to make it clearer
what's being fixed.

    ext4: fix reserved cluster accounting in __es_remove_extent()
    
    When bigalloc is enabled, reserved cluster accounting for delayed
    allocation is handled in extent_status.c.  With a corrupted file
    system, it's possible for this accounting to be incorrect,
    dsicovered by Syzbot:
    
	....

In general, it's better to explain what is being changed and why, and
put the big messy Syzbot change after the English description of the
change.  Remember, what's important is that we make ext4 better ---
not that we are getting rid of a Syzbot report.  When someone reads
the commit description later, what they will care about is how the
code has been improved.

Cheers,

					- Ted

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
> 2.31.1
> 
