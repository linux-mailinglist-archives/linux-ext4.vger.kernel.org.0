Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F7C64790D
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 23:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiLHWxb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 17:53:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLHWxa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 17:53:30 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2275FBB9;
        Thu,  8 Dec 2022 14:53:28 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id x28so2336751qtv.13;
        Thu, 08 Dec 2022 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pIAdLJvqEB9nWjy/3JUk8H5hnrBnA5ZeMrfMFX04fp0=;
        b=XOLT+s2P8qaPvDV8yYkhLXfZgtpsZw0ERYD8qpna+3j+nwn5qsWYEJRVgA7pe9KAyH
         blVdXD2yIR6T4lsoPJuyPscV2+Z81sO5FNR3Ebb6hPNTZIk704MF87CR0NL4lM+4b8l2
         VxDGXnN577ea01wAssAm037xrv3EjBrMghVoyGdYJoWiIo3cFV47F0NkJZ5ucenJZhS6
         Fo76+LXmIqKOsARagG/uUcyh83QP7sBFRJxy/qYMVN3dMQ64LSaxn/oX65lrwp5CRqJ/
         kTTfrii9J3jU0c5UxhrBFTzAkaBBLWGHSgnG/wYcFaHohPh+MfIfcz0V/1T0DCb0Jhgv
         SYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIAdLJvqEB9nWjy/3JUk8H5hnrBnA5ZeMrfMFX04fp0=;
        b=wByi/QNDVhEB3S/cwVz9bST7DfeoUD+aAVyaw9hVm7PT5jfEIrJC3kp5+hfaygyYY0
         pRknQW96OFV7SDOoxRn9nkXn3UFTZikmglURJ3fVX/aAquwE3oOR3o8Je/9Wg8W1hIYJ
         ytAHK8Xk8qINSUm1fbaNWe0B0TvUpm5PCKnSk6wHiiMxcep63zOfgqhehs/g67W/ipyQ
         3e47Ul38RH2I4sGvRJTzYEpf/CLKT+qkgI6OBG+hi6cUCkXMR941DsBtNog47KBX5Atj
         VE2T/9mDhX9xLYxDCnnC/KRpzUgsF1pxBE5B1yO9sZqVGIarlyNtRaxC9USEbwF6v85T
         k2ig==
X-Gm-Message-State: ANoB5pnggTwgAI4iACyy1W7FsfJTe9VqGyNJjxiDE93novuwX0qm7oeD
        PxXf/j2ir5nGivj/JBN01Po=
X-Google-Smtp-Source: AA0mqf7r86IhmxqgFtr86XjAQ9t+oi0kPdYQ/0VtlOMPByPQTpkrjtiTcDxxq0Apdz0GE5TpTFB/iQ==
X-Received: by 2002:ac8:5690:0:b0:3a6:93d7:873f with SMTP id h16-20020ac85690000000b003a693d7873fmr4855666qta.49.1670540007568;
        Thu, 08 Dec 2022 14:53:27 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h96-61-90-13.cntcnh.broadband.dynamic.tds.net. [96.61.90.13])
        by smtp.gmail.com with ESMTPSA id y14-20020a37f60e000000b006fbaf9c1b70sm19326983qkj.133.2022.12.08.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 14:53:27 -0800 (PST)
Date:   Thu, 8 Dec 2022 17:53:24 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     Ye Bin <yebin@huaweicloud.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/3] ext4: fix incorrect calculate 'reserved' in
 '__es_remove_extent' when enable bigalloc feature
Message-ID: <Y5Jq5AMFM7uqQwNa@debian-BULLSEYE-live-builder-AMD64>
References: <20221203025941.2661302-1-yebin@huaweicloud.com>
 <20221203025941.2661302-2-yebin@huaweicloud.com>
 <Y5EbUpyHTg3q3kNO@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5EbUpyHTg3q3kNO@debian-BULLSEYE-live-builder-AMD64>
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
> * Ye Bin <yebin@huaweicloud.com>:
> > From: Ye Bin <yebin10@huawei.com>
> > 
> > Syzbot report issue as follows:
> > EXT4-fs error (device loop0): ext4_validate_block_bitmap:398: comm rep: bg 0: block 5: invalid block bitmap
> > EXT4-fs (loop0): Delayed block allocation failed for inode 18 at logical offset 0 with max blocks 32 with error 28
> > EXT4-fs (loop0): This should not happen!! Data will be lost
> > 
> > EXT4-fs (loop0): Total free blocks count 0
> > EXT4-fs (loop0): Free/Dirty block details
> > EXT4-fs (loop0): free_blocks=0
> > EXT4-fs (loop0): dirty_blocks=32
> > EXT4-fs (loop0): Block reservation details
> > EXT4-fs (loop0): i_reserved_data_blocks=2
> > EXT4-fs (loop0): Inode 18 (00000000845cd634): i_reserved_data_blocks (1) not cleared!
> > 
> > Above issue happens as follows:
> > Assume:
> > sbi->s_cluster_ratio = 16
> > Step1: Insert delay block [0, 31] -> ei->i_reserved_data_blocks=2
> > Step2:
> > ext4_writepages
> >   mpage_map_and_submit_extent -> return failed
> >   mpage_release_unused_pages -> to release [0, 30]
> >     ext4_es_remove_extent -> remove lblk=0 end=30
> >       __es_remove_extent -> len1=0 len2=31-30=1
> >  __es_remove_extent:
> >  ...
> >  if (len2 > 0) {
> >   ...
> > 	  if (len1 > 0) {
> > 		  ...
> > 	  } else {
> > 		es->es_lblk = end + 1;
> > 		es->es_len = len2;
> > 		...
> > 	  }
> >   	if (count_reserved)
> > 		count_rsvd(inode, lblk, orig_es.es_len - len1 - len2, &orig_es, &rc);
> > 	goto out; -> will return but didn't calculate 'reserved'
> >  ...
> > Step3: ext4_destroy_inode -> trigger "i_reserved_data_blocks (1) not cleared!"
> > 
> > To solve above issue if 'len2>0' call 'get_rsvd()' before goto out.
> > 
> > Reported-by: syzbot+05a0f0ccab4a25626e38@syzkaller.appspotmail.com
> > Fixes: 8fcc3a580651 ("ext4: rework reserved cluster accounting when invalidating pages")
> > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > ---
> >  fs/ext4/extents_status.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> > index cd0a861853e3..7ada374ff27d 100644
> > --- a/fs/ext4/extents_status.c
> > +++ b/fs/ext4/extents_status.c
> > @@ -1371,7 +1371,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> >  		if (count_reserved)
> >  			count_rsvd(inode, lblk, orig_es.es_len - len1 - len2,
> >  				   &orig_es, &rc);
> > -		goto out;
> > +		goto out_get_reserved;
> >  	}
> >  
> >  	if (len1 > 0) {
> > @@ -1413,6 +1413,7 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
> >  		}
> >  	}
> >  
> > +out_get_reserved:
> >  	if (count_reserved)
> >  		*reserved = get_rsvd(inode, end, es, &rc);
> >  out:
> 
> The length of some lines in the commit description - probably those which are
> log output - is resulting in a checkpatch warning.  It generally prefers lines
> to be a maximum of 75 characters (and Ted usually likes them limited to 72
> characters.  See my comment to patch #3. I'm not sure what Ted would want here,
> though I'd probably break them at 72 characters or less.
> 
> Otherwise, the patch looks good.  Feel free to add:
> 

Looks good.  As before, feel free to add:

> Reviewed-by: Eric Whitney <enwlinux@gmail.com>

> 
> > -- 
> > 2.31.1
> > 
