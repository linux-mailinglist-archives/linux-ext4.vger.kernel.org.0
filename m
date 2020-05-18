Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A11171D8A6B
	for <lists+linux-ext4@lfdr.de>; Tue, 19 May 2020 00:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgERWIJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 May 2020 18:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726386AbgERWIJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 May 2020 18:08:09 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9F0C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 18 May 2020 15:08:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id a23so3811266qto.1
        for <linux-ext4@vger.kernel.org>; Mon, 18 May 2020 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h4UXVdThCfZBj5z0McxY/W2MejZIkHU4g3whJAMcoZg=;
        b=URsUDEtTtuzztf5FPoMwjegYrVTbLV23kb/L+afaIDfGV6K4wIzqywUPLysW0X9gDi
         PuTZ5yKiwfeET5Td+YJ2W/Zd0THiOmx/JqQnk0S211VgD0DwLoVVPRnryT4hWH5/MvX/
         u4gutym8+vqQtDBiWVH3v+3ApFHR2MOlQ6asSljk2rt+9qG63UdQiL+BauJMYVxbzz9S
         wGCQDh/q35C8ACYe/77ufZnfTghp4NB/8bx/+sr9+YDBDkcLV61HG4uKd5VEppDHJ2G4
         mhYsVWIvLSmcwUcJy4KvRWDn/aK5UW6d4y7PNInSajiniiWCUln+lcdT7IHg3xb+1vqe
         +bfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h4UXVdThCfZBj5z0McxY/W2MejZIkHU4g3whJAMcoZg=;
        b=lGF1vq4efpfuaER4KTFIMMsoaAh1lvdporMnft5EbjoOoDWO3EKRBnpLEdoA/LY2NB
         wAsijeukbG4ogI3S+o8i2XKv7fdty6hC+Zm4GquY1iGo8geAOB+yoYolH545m/U4qZhu
         g3mY2v5uAjC/DP4+oUwXyUUWI6UHviMx5vvXfLeM/xGl0pcEVULpP3vS8b4q9EnZWgGX
         M88mpN9UaEbpWya5GBrMBBdHNPwJeb2dSM/rxokxgzpjEybiIjPTinlChj5f8Q+mhunE
         B2zuHu9rNrsZxqfOwew+2y13Xk0SoMAzVC429zfrDS5NGFj8OeGLlyM0b5NMSD3djIC3
         UcGQ==
X-Gm-Message-State: AOAM5316vY6s3ID9t1FI1yfZXBRMDRZgG0+xu2LJ1uupus1WrvlaCqG+
        4qieDhRGU27p/fgpTPwyXgY=
X-Google-Smtp-Source: ABdhPJzxpsQn7Pp7pvJhhkAP+DlFuEp8ykCRkU6xe/76l7eyrXHW4/iIL1cBqQgihCoU8/zbxju1vA==
X-Received: by 2002:ac8:4d02:: with SMTP id w2mr18665456qtv.170.1589839687319;
        Mon, 18 May 2020 15:08:07 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id h12sm10710382qte.31.2020.05.18.15.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 15:08:06 -0700 (PDT)
Date:   Mon, 18 May 2020 18:08:04 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu, joseph.qi@linux.alibaba.com
Subject: Re: [PATCH RFC] ext4: fix partial cluster initialization when
 splitting extent
Message-ID: <20200518220804.GA20248@localhost.localdomain>
References: <1589444097-38535-1-git-send-email-jefflexu@linux.alibaba.com>
 <20200514222120.GB4710@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514222120.GB4710@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> * Jeffle Xu <jefflexu@linux.alibaba.com>:
> > Hi Eric, would you mind explaining why the magic number '2' is used here
> > when calculating the physical cluster number of the partial cluster in
> > commit f4226d9ea400 ("ext4: fix partial cluster initialization") ?
> > 
> > ```
> > +     /*
> > +      * If we're going to split the extent, note that
> > +      * the cluster containing the block after 'end' is
> > +      * in use to avoid freeing it when removing blocks.
> > +      */
> > +     if (sbi->s_cluster_ratio > 1) {
> > +             pblk = ext4_ext_pblock(ex) + end - ee_block + 2;
> > +             partial_cluster =
> > +                     -(long long) EXT4_B2C(sbi, pblk);
> > +     }
> > ```
> > 
> > As far as I understand, there we are initializing the partial cluster
> > describing the beginning of the split extent after 'end'. The
> > corrsponding physical block number of the first block in the split
> > extent should be 'ext4_ext_pblock(ex) + end - ee_block + 1'.
> > 
> > This bug will cause xfstests shared/298 failure on ext4 with bigalloc
> > enabled sometimes. Ext4 error messages indicate that previously freed
> > blocks are being freed again, and the following fsck will fail due to
> > the inconsistency of block bitmap and bg descriptor.
> > 
> > The following is an example case:
> > 
> > 1. First, Initialize a ext4 filesystem with cluster size '16K', block size
> > '4K', in which case, one cluster contains four blocks.
> > 
> > 2. Create one file (e.g., xxx.img) on this ext4 filesystem. Now the extent
> > tree of this file is like:
> > 
> > ...
> > 36864:[0]4:220160
> > 36868:[0]14332:145408
> > 51200:[0]2:231424
> > ...
> > 
> > 3. Then execute PUNCH_HOLE fallocate on this file. The hole range is
> > like:
> > 
> > ..
> > ext4_ext_remove_space: dev 254,16 ino 12 since 49506 end 49506 depth 1
> > ext4_ext_remove_space: dev 254,16 ino 12 since 49544 end 49546 depth 1
> > ext4_ext_remove_space: dev 254,16 ino 12 since 49605 end 49607 depth 1
> > ...
> > 
> > 4. Then the extent tree of this file after punching is like
> > 
> > ...
> > 49507:[0]37:158047
> > 49547:[0]58:158087
> > ...
> > 
> > 5. Detailed procedure of punching hole [49544, 49546]
> > 
> > 5.1. The block address space:
> > ```
> > lblk        ~49505  49506   49507~49543     49544~49546    49547~
> > 	  ---------+------+-------------+----------------+--------
> > 	    extent | hole |   extent	|	hole	 | extent
> > 	  ---------+------+-------------+----------------+--------
> > pblk       ~158045  158046  158047~158083  158084~158086   158087~
> > ```
> > 
> > 5.2. The detailed layout of cluster 39521:
> > ```
> > 		cluster 39521
> > 	<------------------------------->
> > 
> > 		hole		  extent
> > 	<----------------------><--------
> > 
> > lblk      49544   49545   49546   49547
> > 	+-------+-------+-------+-------+
> > 	|	|	|	|	|
> > 	+-------+-------+-------+-------+
> > pblk     158084  1580845  158086  158087
> > ```
> > 
> > 5.3. The ftrace output when punching hole [49544, 49546]:
> > - ext4_ext_remove_space (start 49544, end 49546)
> >   - ext4_ext_rm_leaf (start 49544, end 49546, last_extent [49507(158047), 40], partial [pclu 39522 lblk 0 state 2])
> >     - ext4_remove_blocks (extent [49507(158047), 40], from 49544 to 49546, partial [pclu 39522 lblk 0 state 2]
> >       - ext4_free_blocks: (block 158084 count 4)
> >         - ext4_mballoc_free (extent 1/6753/1)
> > 
> > In this case, the whole cluster 39521 is freed mistakenly when freeing
> > pblock 158084~158086 (i.e., the first three blocks of this cluster),
> > although pblock 158087 (the last remaining block of this cluster) has
> > not been freed yet.
> > 
> > The root cause of this isuue is that, the pclu of the partial cluster is
> > calculated mistakenly in ext4_ext_remove_space(). The correct
> > partial_cluster.pclu (i.e., the cluster number of the first block in the
> > next extent, that is, lblock 49597 (pblock 158086)) should be 39521 rather
> > than 39522.
> > 
> > Fixes: f4226d9ea400 ("ext4: fix partial cluster initialization")
> > Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> > ---
> >  fs/ext4/extents.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index f2b577b..cb74496 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -2828,7 +2828,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
> >  			 * in use to avoid freeing it when removing blocks.
> >  			 */
> >  			if (sbi->s_cluster_ratio > 1) {
> > -				pblk = ext4_ext_pblock(ex) + end - ee_block + 2;
> > +				pblk = ext4_ext_pblock(ex) + end - ee_block + 1;
> >  				partial.pclu = EXT4_B2C(sbi, pblk);
> >  				partial.state = nofree;
> >  			}
> > -- 
> > 1.8.3.1
> > 
> 
> Hi, Jeffle:
> 
> Thanks for the report and the patch.  At first glance I suspect the "2" is
> simply a bug; logically we're just looking for the first block after the
> extent split to set the partial cluster, as you suggest.  I'll post the
> results of my review once I've had a chance to refresh my memory of the
> code and run some more tests.
> 
> Thanks,
> Eric


Hi, Jeffle:

What kernel were you running when you observed your failures?  Does your
patch resolve all observed failures, or do any remain?  Do you have a
simple test script that reproduces the bug?

I've made almost 1000 runs of shared/298 on various bigalloc configurations
using Ted's test appliance on 5.7-rc5 and have not observed a failure.
Several auto group runs have also passed without failures.  Ideally, I'd
like to be able to reproduce your failure to be sure we fully understand
what's going on.  It's still the case that the "2" is wrong, but I think
that code in rm_leaf may be involved in an unexpected way.

Thanks,
Eric

