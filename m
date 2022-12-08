Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19B1647911
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 23:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbiLHWy4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 17:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiLHWy4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 17:54:56 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F70E6174D;
        Thu,  8 Dec 2022 14:54:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id jr11so1746012qtb.7;
        Thu, 08 Dec 2022 14:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPeObbewzL+ArIfiEhd4XCelf8Nf4DqWPrE3Jxx0E6w=;
        b=n61Bj9lPcY20z7UHZoPbWFmwqi9a5MWFgj/MlALua3fGD6JICCYUic9FMiPAVKSDRU
         SfmU/aBEWHJTi3R/Q6DSGL6w9WHeexgUbpOAGKaQvLDSjt6XMV4ORsXeR5akHwJRIh0l
         ynFfwlqvUkOPMf28V08bFk1L30IIIn+IJO/L4k99CO02shSMlge+k3rdEoJZc6lzCdUL
         pZq/WkJk6xtF92w6axJZpeTyWSNS9GAt9OJ0Af+4kqcyCUfs6BdGId75qYpQyyzzUjip
         6qV9EffAZQSvEP0v2PNKAR76jdjxbQUThYX1JjFEo87KYm0AR5giFjvEoxbnsV5BxbSd
         Gk5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPeObbewzL+ArIfiEhd4XCelf8Nf4DqWPrE3Jxx0E6w=;
        b=msx4pPfhsK+SE7IKaaPiZuRK7lhW6Xbkw02d0wv1tCBSon6PFfAUUz2BZag9TO8Jm+
         r0aDtavbDzSeSRXzBJBFHxi1rpXZGCn2/3tkjuqRo7Wa5a/IXOSUMn9tOCWlFabPAn9e
         wdV/+sQ/fi2uFmzQQGAlZtxgntH+jISaoZAX8PkOKOYSGrTk/5hsoWmDh5izujOxF8gx
         4yC2dXuQsDRuil9FrNe8d28sn5j5qSm2hJdgw6diGQeJlSz9BmvvmsceEqkuE/9Z3wpu
         hOVUSIAOcYVdjm7h9kG6DFRp8/ro6jIQ3pLS28m1Wa8a7QERz0czNx67KOAnfaoo4xhH
         BstQ==
X-Gm-Message-State: ANoB5pljtwUhUyAyvhakOax4+DdCU1bpV6CoZzj89e6kPIm6FuPU208y
        qz+AxDjz3xvoAcWBWlXtJqk=
X-Google-Smtp-Source: AA0mqf4/AQdIW+wW+n1SuI3sJOFJMjNtaCnX23hbxtIg6EKG9q5zM83lvf+OlXFVYbS4wYe85Xl+Og==
X-Received: by 2002:ac8:74d5:0:b0:3a6:8d65:c0fb with SMTP id j21-20020ac874d5000000b003a68d65c0fbmr6039664qtr.52.1670540094294;
        Thu, 08 Dec 2022 14:54:54 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id v15-20020a05620a440f00b006fc2b672950sm21063095qkp.37.2022.12.08.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 14:54:53 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:54:52 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y5JrO36scqCUrdmo@debian-BULLSEYE-live-builder-AMD64>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
 <20221203025941.2661302-2-yebin@huaweicloud.com>
 <Y5EbUpyHTg3q3kNO@debian-BULLSEYE-live-builder-AMD64>
 <Y5Jq5AMFM7uqQwNa@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5Jq5AMFM7uqQwNa@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Eric Whitney <enwlinux@gmail.com>:
> * Eric Whitney <enwlinux@gmail.com>:
> > * Ye Bin <yebin@huaweicloud.com>:
> > > From: Ye Bin <yebin10@huawei.com>
> > > 
> > > Syzbot report issue as follows:
> > > EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep: bg 0: block 5: invalid block bitmap
> > > EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical offset 0 with max blocks 32 with error 28
> > > EXT4-fs (loop0): This should not happen!! Data will be lost
> > > 
> > > EXT4-fs (loop0): Total free blocks count 0
> > > EXT4-fs (loop0): Free/Dirty block details
> > > EXT4-fs (loop0): free_blocks=0
> > > EXT4-fs (loop0): dirty_blocks=32
> > > EXT4-fs (loop0): Block reservation details
> > > EXT4-fs (loop0): i_reserved_data_blocks=2
> > > EXT4-fs (loop0): Inode 18 (00000000845cd634): i_reserved_data_blocks (1) not cleared!
> > > 
> > > Above issue happens as follows:
> > > Assume:
> > > sbi->s_cluster_ratio = 16
> > > Step1: Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
> > > Step2:
> > > ext4_writepages
> > >   mpage_map_and_submit_extent -> return failed
> > >   mpage_release_unused_pages -> to release [0, 30]
> > >     ext4_es_remove_extent -> remove lblk=0 end=30
> > >       __es_remove_extent -> len1=0 len2=31-30=1
> > >  __es_remove_extent:
> > >  ...
> > >  if (len2 > 0) {
> > >   ...
> > > 	  if (len1 > 0) {
> > > 		  ...
> > > 	  } else {
> > > 		es->es_lblk = end + 1;
> > > 		es->es_len = len2;
> > > 		...
> > > 	  }
> > >   	if (count_reserved)
> > > 		count_rsvd(inode, lblk, orig_es.es_len - len1 - len2, &orig_es, &rc);
> > > 	goto out; -> will return but didn't calculate 'reserved'
> > >  ...
> > > Step3: ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"
> > > 
> > > To solve above issue if 'len2>0' call 'get_rsvd()' before goto out.
> > > 
> > > Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> > > Fixes: 8fcc3a580651 ("ext4: rework reserved cluster accounting when invalidating pages")
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > ---
> > >  fs/ext4/extents_status.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> > > index cd0a861853e3..7ada374ff27d 100644
> > > --- a/fs/ext4/extents_status.c
> > > +++ b/fs/ext4/extents_status.c
> > > @@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> > >  		if (count_reserved)
> > >  			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
> > >  				   &orig_es, &rc);
> > > -		goto out;
> > > +		goto out_get_reserved;
> > >  	}
> > >  
> > >  	if (len1 > 0) {
> > > @@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> > >  		}
> > >  	}
> > >  
> > > +out_get_reserved:
> > >  	if (count_reserved)
> > >  		*reserved = get_rsvd(inode, end, es, &rc);
> > >  out:
> > 
> > The length of some lines in the commit description - probably those which are
> > log output - is resulting in a checkpatch warning.  It generally prefers lines
> > to be a maximum of 75 characters (and Ted usually likes them limited to 72
> > characters.  See my comment to patch #3. I'm not sure what Ted would want here,
> > though I'd probably break them at 72 characters or less.
> > 
> > Otherwise, the patch looks good.  Feel free to add:
> > 
> 
> Looks good.  As before, feel free to add:
> 
> > Reviewed-by: Eric Whitney <enwlinux@gmail.com>
> 

Whoops.  Please disregard - wrong patch.

Eric

