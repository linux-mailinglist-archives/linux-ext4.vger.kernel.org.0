Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E83A1B02EC
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Apr 2020 09:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgDTH1o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 03:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgDTH1n (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 03:27:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF4C061A0C
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 00:27:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so3616070plq.12
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 00:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J++KyoYM3Tc+MG2ujKtupoqBWNZcRWEV/TCAkVbXr24=;
        b=LWzZoJ/fXQ8D6nezYoPZZmGhtfeCExwEEKESnNHxYyHpEevnPrub14SHl0+nNJ/Zl9
         BcAurfi0Eh9iCFtjr9f2vUNncQeEzZGkjbCno8doIHTRIJiP+jBg3K7qrt2VFW36fyt7
         oPFoc/kgXuZqF/uf8dfx1/kJXgGgFO+WLjJxwlecws2a/I7cZ+xVBXVDgo88K3l7hD5H
         09N19ZRKrgM9U1KyR3eCvzzQZcFckCQtmn0Q4LlUg5C34a1vtUsK454Li6ndXUl31a2w
         goKdDv9sxRpJXODnNxZRtMuN7P8r5DVHk2jvsnhNqXAw/+Rv+EQh4VhTpXuAUvP27CMv
         0q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J++KyoYM3Tc+MG2ujKtupoqBWNZcRWEV/TCAkVbXr24=;
        b=s+mkOq1XPLrkl0GSGmkFAefKl51r91Qacp4XnsUSV8pMc5j4PrKPeO5f+QWUEFOUlQ
         jWzfZu0zrcJA61RZZNQjxZ2AfaRROB92eaeolLLd6FBnJCIwOlp8uRp5/XTbIls8ZeN9
         1n4GGmxwsBXW0G8yS71Km3t1IW1FnOr8b6zyTKjoXBpU6LdmTGWwl+2Hk9MChAqsVIT7
         0dLdpg3oqBmLcMtv6VezLFlqjE6Bzg9OnammoGFS07nuXG28HPUKD/28W8aQHyaFhNqp
         Wd3o5SKbqY6WN0GThjCCB86iTIXcZqEbf1QXImnSxcEkwczGciHOZZ2+uLaqU9IrD4i9
         Hm0w==
X-Gm-Message-State: AGi0PuYIVm+8cM48+9QvcjSpTvmtmlEq/6sDNCwaM9NEtlWuAVKEKIbK
        1UlOEbwwG61UOZf7GaaJVSo=
X-Google-Smtp-Source: APiQypLxcjafft0++wJLmNfbodNv2TORWndPhLjtWaOGSOnyLxIm2126q3DO125dKRe9jak3DaAmgw==
X-Received: by 2002:a17:902:44d:: with SMTP id 71mr16250090ple.123.1587367663250;
        Mon, 20 Apr 2020 00:27:43 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s44sm221119pjc.28.2020.04.20.00.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 00:27:42 -0700 (PDT)
Date:   Mon, 20 Apr 2020 15:27:35 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] ext4: validate fiemap iomap begin offset and length value
Message-ID: <20200420072735.krkt2mundqguhqpl@xzhoux.usersys.redhat.com>
References: <20200418233231.z767yvfiupy7hwgp@xzhoux.usersys.redhat.com>
 <20200419015654.F2061A4051@d06av23.portsmouth.uk.ibm.com>
 <20200419044224.GA311394@mit.edu>
 <20200419044612.GB311394@mit.edu>
 <20200419161928.6D6CC5204E@d06av21.portsmouth.uk.ibm.com>
 <20200420025721.ac5ighvy77fffnxf@xzhoux.usersys.redhat.com>
 <20200420041603.89D2C5204F@d06av21.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420041603.89D2C5204F@d06av21.portsmouth.uk.ibm.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Apr 20, 2020 at 09:46:01AM +0530, Ritesh Harjani wrote:
> 
> 
> On 4/20/20 8:27 AM, Murphy Zhou wrote:
> > On Sun, Apr 19, 2020 at 09:49:27PM +0530, Ritesh Harjani wrote:
> > > Hello Ted,
> > > 
> > > On 4/19/20 10:16 AM, Theodore Y. Ts'o wrote:
> > > 
> > > > ext4_map_block() is returning EFSCORRUPTED when lblk is
> > > > EXT4_MAX_LOGICAL_BLOCK, which is why he's constraining lblk to
> > > > EXT4_MAX_LOGICAL_BLOCK.  I haven't looked into this more closely yet,
> > > 
> > > Yes, I did mention about this case in point 2 in below link though.
> > > But maybe I was only focused on testing syzcaller reproducer, so
> > > couldn't test this reported case.
> > > 
> > > https://www.spinics.net/lists/linux-ext4/msg71387.html
> > > 
> > > 
> > > > On Sun, Apr 19, 2020 at 12:42:24AM -0400, Theodore Y. Ts'o wrote:
> > > > > I think we need to take his patch, and make a simialr change to
> > > > > ext4_iomap_begin().   Ritesh, do you agree?
> > > > 
> > > > For example...
> > > > 
> > > > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > > > index 2a4aae6acdcb..adce3339d697 100644
> > > > --- a/fs/ext4/inode.c
> > > > +++ b/fs/ext4/inode.c
> > > > @@ -3424,8 +3424,10 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > > >    	int ret;
> > > >    	struct ext4_map_blocks map;
> > > >    	u8 blkbits = inode->i_blkbits;
> > > > +	ext4_lblk_t lblk = offset >> blkbits;
> > > > +	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
> > > 
> > > Why play with last_lblk but?
> > > 
> > > 
> > > 
> > > > -	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> > > > +	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
> > > >    		return -EINVAL;
> > > >    	if (WARN_ON_ONCE(ext4_has_inline_data(inode)))
> > > > @@ -3434,9 +3436,15 @@ static int ext4_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> > > >    	/*
> > > >    	 * Calculate the first and last logical blocks respectively.
> > > >    	 */
> > > > -	map.m_lblk = offset >> blkbits;
> > > > -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> > > > -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> > > > +	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > > > +		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > > > +	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > > > +		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > > > +
> > > > +	map.m_lblk = lblk;
> > > > +	map.m_len = last_lblk - lblk + 1;
> > > > +	if (map.m_len == 0 )
> > > > +		map.m_len = 1;
> > > 
> > > Not sure but with above changes map.m_len will never be
> > > 0. Right?
> > 
> > Yes. If it's 0, in ext4_iomap_is_delalloc we will get an "end" that
> > is less then m_lblk, causing another WARN in ext4_es_find_extent_range.
> 
> Sorry lost you. Ok so what I meant above is.
> With your changes made in above code to truncate last_lblk
> and lblk, we may never end up in a situation where map.m_len will be 0.
> So the below check in your code, isn't it redundant?
> I wanted to double confirm this with you.
> 
> +	if (map.m_len == 0 )
> +		map.m_len = 1;

No it's not redundant. I hit and said that wo/ these two lines we will
hit a WARN later.

At first I thought truncating values is enough, but it's not.
generic/013 (fsstress) can hit the WARN in fs/ext4/extents_status.c:266
easily.

By printk values confirmed that at that time  m_len is zero.

Found some debug notes showing how crazy these numbers are:

 offset 80000395000 length 3533d50a37ee6ddb, lblk 80000395 llblk d0a3827b
 lblk 80000395 llblk d0a3827b, m_lblk 80000395 m_len 50a37ee7
 end d0a3827b, m_lblk 80000395 m_len 50a37ee7
 offset d0a3827c000 length 3533cffffffffddb, lblk d0a3827c llblk d0a3827b
 lblk d0a3827c llblk d0a3827b, m_lblk d0a3827c m_len 0
 end d0a3827b, m_lblk d0a3827c m_len 0
 ------------[ cut here ]------------
 WARNING: CPU: 6 PID: 7962 at fs/ext4/extents_status.c:266 __es_find_extent_range+0x102/0x120 [ext4]

Thanks.
> 
> 
> > 
> > > 
> > > Ok, so the problem mainly is coming since ext4_map_blocks()
> > > is returning -EFSCORRUPTED in case if lblk >= EXT4_MAX_LOGICAL_BLOCK.
> > > 
> > > So why change last_lblk?
> > 
> > I guess because we need to make sure a sane length value. In the loop
> > in iomap_fiemap, start and length are not checked, assuming be checked
> > by caller. If length get overflowed, the start value for the next loop
> > can also be affected, which makes lblk last_lblk and m_len to go crazy.
> 
> Sorry I didn't it explain it right maybe. So if we are anyway changing
> lblk by truncating it and making sure map.m_len is not getting
> overflowed (as we did in my previous patch), then we need not play with
> last_lblk anyways.
> 
> And FWIW, instead of truncating lblk just so that ext4_map_blocks()
> doesn't WARN, we can as well just return -ENOENT for
> lblk >= EXT4_MAX_LOGICAL_BLOCK. ENOENT makes more sense to me,
> but please feel free to correct me here.
> 
> Thoughts?
> 
> Meanwhile, I will also play this change (-ENOENT) a bit to at least get
> few of the known test cases covered.
> 
> 
> Also I do had this question for ext4.
> EXT4_MAX_BLOCKS explaination says that's the max *number* of logical
> blocks in a file. So since it is the number of blocks, it is equivalent
> of length. Whereas the EXT4_MAX_LOGICAL_BLOCK says the max logical block
> of a file, which is equivalent of offset.
> Considering the logical offset starts from 0, so as Ted was saying
> having both values same doesn't make sense. Ideally maybe
> EXT4_MAX_LOGICAL_BLOCK should be 0xFFFFFFFFE.
> 
> But that may also require some careful checking of all bounds of length
> and offset across the code. So maybe we can revisit this later.
> /*
>  * Maximum number of logical blocks in a file; ext4_extent's ee_block is
>  * __le32.
>  */
> #define EXT_MAX_BLOCKS	0xffffffff
> 
> 
> /* Max logical block we can support */
> #define EXT4_MAX_LOGICAL_BLOCK		0xFFFFFFFF
> 
> 
> -ritesh
> 
> > 
> > Thanks.
> > 
> > > Shouldn't we just change the logic to return -ENOENT in case
> > > if (lblk >= EXT4_MAX_LOGICAL_BLOCK)? ENOENT can be handled by
> > > IOMAP APIs to abort the loop properly.
> > > This along with the map.m_len overlflow patch which I had submitted
> > > before. (since the overflow patch is anyway a valid fix which we anyways
> > > need).
> > > 
> > > -ritesh
> > > 
> > > 
> > > >    	if (flags & IOMAP_WRITE)
> > > >    		ret = ext4_iomap_alloc(inode, &map, flags);
> > > > @@ -3524,8 +3532,10 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> > > >    	bool delalloc = false;
> > > >    	struct ext4_map_blocks map;
> > > >    	u8 blkbits = inode->i_blkbits;
> > > > +	ext4_lblk_t lblk = offset >> blkbits;
> > > > +	ext4_lblk_t last_lblk = (offset + length - 1) >> blkbits;
> > > > -	if ((offset >> blkbits) > EXT4_MAX_LOGICAL_BLOCK)
> > > > +	if (lblk > EXT4_MAX_LOGICAL_BLOCK)
> > > >    		return -EINVAL;
> > > >    	if (ext4_has_inline_data(inode)) {
> > > > @@ -3540,9 +3550,15 @@ static int ext4_iomap_begin_report(struct inode *inode, loff_t offset,
> > > >    	/*
> > > >    	 * Calculate the first and last logical block respectively.
> > > >    	 */
> > > > -	map.m_lblk = offset >> blkbits;
> > > > -	map.m_len = min_t(loff_t, (offset + length - 1) >> blkbits,
> > > > -			  EXT4_MAX_LOGICAL_BLOCK) - map.m_lblk + 1;
> > > > +	if (last_lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > > > +		last_lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > > > +	if (lblk >= EXT4_MAX_LOGICAL_BLOCK)
> > > > +		lblk = EXT4_MAX_LOGICAL_BLOCK - 1;
> > > > +
> > > > +	map.m_lblk = lblk;
> > > > +	map.m_len = last_lblk - lblk + 1;
> > > > +	if (map.m_len == 0 )
> > > > +		map.m_len = 1;
> > > >    	/*
> > > >    	 * Fiemap callers may call for offset beyond s_bitmap_maxbytes.
> > > > 
> > > 
> > 
> 

-- 
Murphy
