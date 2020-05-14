Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323C81D40C8
	for <lists+linux-ext4@lfdr.de>; Fri, 15 May 2020 00:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgENWVY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 18:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728180AbgENWVY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 14 May 2020 18:21:24 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E768CC061A0C
        for <linux-ext4@vger.kernel.org>; Thu, 14 May 2020 15:21:23 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so552954qkh.11
        for <linux-ext4@vger.kernel.org>; Thu, 14 May 2020 15:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7O6TSvtZvNOQBx11XSsuW+aS6rl9O70CF+P5W1LSLak=;
        b=HIJHqta1T1roLNuJB3tv6iaQEOAiK5EqANegAHZq5FYd6M8mB399IrxUOVSzCdFDLI
         5VKgs4aca2+Urhfzwf7psPEb8shG7GCT1yW3eH/3Jg7mk0IxA1cplktXScmEQ5jue7IP
         vx4bH6/lnVSrQebALEC/06qLcH/fDJZXa1lqMWZLzCxxToJQRnDcf72isjPgD8bNW3LZ
         tKbCmeOfLdC69KIlq94EA0BhuaeVRXbtxSJ8kcOEoYCyFiMTEOJzOHazaxcGhZYCxK8j
         KmeEh8vR+EXvaOgeOfyu50t+z2OqQNTaDzDFAAvQiPN4zRw4a7unABOY2DwZnQPhmU3q
         lJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7O6TSvtZvNOQBx11XSsuW+aS6rl9O70CF+P5W1LSLak=;
        b=r8no23ETel+n/VX1XabkmNtjkZ6daWgkOHV/cYzJUEtrIeDg8f9zTFobUdpKLB3CsO
         gm/BkZ+QResDYCre5xxpg/LKZGLzjoVEpF1K9SyMXuoqVq0BvLQPkvEOIc4UUtTTX3Kf
         fCccVZiaKM7VleiID7L+xHkeLAY7t75CW2ErhUMi+nct2pnD2uyjGKYBbzIsGqddJZe1
         FWvMmyitPiCyF9zvBRQrC61t5LsFybG2adoHoDBR+PgKOv7MaPM6pOHilqwbMLUu45p1
         DcXQ+ZB1lMO6q0V7mxyusIV8AamZ8rcbnvY9moWEeFXwY8KwiO8iJvewN8zV2ctCZbjM
         HPFw==
X-Gm-Message-State: AOAM53169lLQYXVFZTXQTyp/z43Z9NtRLYDzx7bLm+y4mHuNwPdYgsob
        5PQmOgVRM1h82zg+EtqewM8=
X-Google-Smtp-Source: ABdhPJzUzoIEpwVDHfpRK2aHl76y3r5FklgH3PQYatApVJkOrEO64LPkbzeCLUhrQKpJs2CjxhEuBg==
X-Received: by 2002:a05:620a:20de:: with SMTP id f30mr549781qka.479.1589494883162;
        Thu, 14 May 2020 15:21:23 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id p22sm439733qte.2.2020.05.14.15.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 15:21:22 -0700 (PDT)
Date:   Thu, 14 May 2020 18:21:20 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     enwlinux@gmail.com, linux-ext4@vger.kernel.org, tytso@mit.edu,
        joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RFC] ext4: fix partial cluster initialization when
 splitting extent
Message-ID: <20200514222120.GB4710@localhost.localdomain>
References: <1589444097-38535-1-git-send-email-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589444097-38535-1-git-send-email-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Jeffle Xu <jefflexu@linux.alibaba.com>:
> Hi Eric, would you mind explaining why the magic number '2' is used here
> when calculating the physical cluster number of the partial cluster in
> commit f4226d9ea400 ("ext4: fix partial cluster initialization") ?
> 
> ```
> +     /*
> +      * If we're going to split the extent, note that
> +      * the cluster containing the block after 'end' is
> +      * in use to avoid freeing it when removing blocks.
> +      */
> +     if (sbi->s_cluster_ratio > 1) {
> +             pblk = ext4_ext_pblock(ex) + end - ee_block + 2;
> +             partial_cluster =
> +                     -(long long) EXT4_B2C(sbi, pblk);
> +     }
> ```
> 
> As far as I understand, there we are initializing the partial cluster
> describing the beginning of the split extent after 'end'. The
> corrsponding physical block number of the first block in the split
> extent should be 'ext4_ext_pblock(ex) + end - ee_block + 1'.
> 
> This bug will cause xfstests shared/298 failure on ext4 with bigalloc
> enabled sometimes. Ext4 error messages indicate that previously freed
> blocks are being freed again, and the following fsck will fail due to
> the inconsistency of block bitmap and bg descriptor.
> 
> The following is an example case:
> 
> 1. First, Initialize a ext4 filesystem with cluster size '16K', block size
> '4K', in which case, one cluster contains four blocks.
> 
> 2. Create one file (e.g., xxx.img) on this ext4 filesystem. Now the extent
> tree of this file is like:
> 
> ...
> 36864:[0]4:220160
> 36868:[0]14332:145408
> 51200:[0]2:231424
> ...
> 
> 3. Then execute PUNCH_HOLE fallocate on this file. The hole range is
> like:
> 
> ..
> ext4_ext_remove_space: dev 254,16 ino 12 since 49506 end 49506 depth 1
> ext4_ext_remove_space: dev 254,16 ino 12 since 49544 end 49546 depth 1
> ext4_ext_remove_space: dev 254,16 ino 12 since 49605 end 49607 depth 1
> ...
> 
> 4. Then the extent tree of this file after punching is like
> 
> ...
> 49507:[0]37:158047
> 49547:[0]58:158087
> ...
> 
> 5. Detailed procedure of punching hole [49544, 49546]
> 
> 5.1. The block address space:
> ```
> lblk        ~49505  49506   49507~49543     49544~49546    49547~
> 	  ---------+------+-------------+----------------+--------
> 	    extent | hole |   extent	|	hole	 | extent
> 	  ---------+------+-------------+----------------+--------
> pblk       ~158045  158046  158047~158083  158084~158086   158087~
> ```
> 
> 5.2. The detailed layout of cluster 39521:
> ```
> 		cluster 39521
> 	<------------------------------->
> 
> 		hole		  extent
> 	<----------------------><--------
> 
> lblk      49544   49545   49546   49547
> 	+-------+-------+-------+-------+
> 	|	|	|	|	|
> 	+-------+-------+-------+-------+
> pblk     158084  1580845  158086  158087
> ```
> 
> 5.3. The ftrace output when punching hole [49544, 49546]:
> - ext4_ext_remove_space (start 49544, end 49546)
>   - ext4_ext_rm_leaf (start 49544, end 49546, last_extent [49507(158047), 40], partial [pclu 39522 lblk 0 state 2])
>     - ext4_remove_blocks (extent [49507(158047), 40], from 49544 to 49546, partial [pclu 39522 lblk 0 state 2]
>       - ext4_free_blocks: (block 158084 count 4)
>         - ext4_mballoc_free (extent 1/6753/1)
> 
> In this case, the whole cluster 39521 is freed mistakenly when freeing
> pblock 158084~158086 (i.e., the first three blocks of this cluster),
> although pblock 158087 (the last remaining block of this cluster) has
> not been freed yet.
> 
> The root cause of this isuue is that, the pclu of the partial cluster is
> calculated mistakenly in ext4_ext_remove_space(). The correct
> partial_cluster.pclu (i.e., the cluster number of the first block in the
> next extent, that is, lblock 49597 (pblock 158086)) should be 39521 rather
> than 39522.
> 
> Fixes: f4226d9ea400 ("ext4: fix partial cluster initialization")
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/ext4/extents.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index f2b577b..cb74496 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2828,7 +2828,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  			 * in use to avoid freeing it when removing blocks.
>  			 */
>  			if (sbi->s_cluster_ratio > 1) {
> -				pblk = ext4_ext_pblock(ex) + end - ee_block + 2;
> +				pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
>  				partial.pclu = EXT4_B2C(sbi, pblk);
>  				partial.state = nofree;
>  			}
> -- 
> 1.8.3.1
> 

Hi, Jeffle:

Thanks for the report and the patch.  At first glance I suspect the "2" is
simply a bug; logically we're just looking for the first block after the
extent split to set the partial cluster, as you suggest.  I'll post the
results of my review once I've had a chance to refresh my memory of the
code and run some more tests.

Thanks,
Eric
