Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C6F5997B1
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Aug 2022 10:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346799AbiHSIoP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Aug 2022 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347451AbiHSIoN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 19 Aug 2022 04:44:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D205EA2238;
        Fri, 19 Aug 2022 01:44:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6D8EF5CAE2;
        Fri, 19 Aug 2022 08:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1660898649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5tXJcZv4COItgEylzDrHIVXxkXoVVSo3B0NiZmuD0k=;
        b=qb45fxhS/BdpsC6AF0gXSI+sqVVC915+dS8ajwor8QZhNex+OPJyMlRibLAnGOMzQbpZSF
        3fnE1tuZNeeLCRrMeAVnUV+wpFJEtOOcGKX7haW6j7Vd1m4Ibisq8FHYH4dFo9g+13ZeQB
        eNcH+W8qOOxBKF2yfFqLSHOugLF0Hx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1660898649;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H5tXJcZv4COItgEylzDrHIVXxkXoVVSo3B0NiZmuD0k=;
        b=uMKrchLuLw4WKN+ao/oCGvqDeSmpea7YmjYBkl55OtKh4/IWAf2jixCO3LaMJXx0hSfGtb
        kvSD2VOzBDEy+FDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DAF1D2C141;
        Fri, 19 Aug 2022 08:44:08 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 51297A0635; Fri, 19 Aug 2022 10:44:08 +0200 (CEST)
Date:   Fri, 19 Aug 2022 10:44:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, lczerner@redhat.com, enwlinux@gmail.com,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yebin10@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH 2/2] ext4: add inode table check in __ext4_get_inode_loc
 to aovid possible infinite loop
Message-ID: <20220819084408.vh6hdgs2racglg5g@quack3>
References: <20220817132701.3015912-1-libaokun1@huawei.com>
 <20220817132701.3015912-3-libaokun1@huawei.com>
 <20220817143138.7krkxzoa3skruiyx@quack3>
 <20220818144353.q6cq3b7huwkopk5b@riteshh-domain>
 <20220818172316.jfsjb3efohml3yt3@quack3>
 <20220818231541.bgxdistuf7hnepto@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220818231541.bgxdistuf7hnepto@riteshh-domain>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 19-08-22 04:45:41, Ritesh Harjani (IBM) wrote:
> On 22/08/18 07:23PM, Jan Kara wrote:
> > On Thu 18-08-22 20:13:53, Ritesh Harjani (IBM) wrote:
> > > On 22/08/17 04:31PM, Jan Kara wrote:
> > > > On Wed 17-08-22 21:27:01, Baokun Li wrote:
> > > > > In do_writepages, if the value returned by ext4_writepages is "-ENOMEM"
> > > > > and "wbc->sync_mode == WB_SYNC_ALL", retry until the condition is not met.
> > > > >
> > > > > In __ext4_get_inode_loc, if the bh returned by sb_getblk is NULL,
> > > > > the function returns -ENOMEM.
> > > > >
> > > > > In __getblk_slow, if the return value of grow_buffers is less than 0,
> > > > > the function returns NULL.
> > > > >
> > > > > When the three processes are connected in series like the following stack,
> > > > > an infinite loop may occur:
> > > > >
> > > > > do_writepages					<--- keep retrying
> > > > >  ext4_writepages
> > > > >   mpage_map_and_submit_extent
> > > > >    mpage_map_one_extent
> > > > >     ext4_map_blocks
> > > > >      ext4_ext_map_blocks
> > > > >       ext4_ext_handle_unwritten_extents
> > > > >        ext4_ext_convert_to_initialized
> > > > >         ext4_split_extent
> > > > >          ext4_split_extent_at
> > > > >           __ext4_ext_dirty
> > > > >            __ext4_mark_inode_dirty
> > > > >             ext4_reserve_inode_write
> > > > >              ext4_get_inode_loc
> > > > >               __ext4_get_inode_loc		<--- return -ENOMEM
> > > > >                sb_getblk
> > > > >                 __getblk_gfp
> > > > >                  __getblk_slow			<--- return NULL
> > > > >                   grow_buffers
> > > > >                    grow_dev_page		<--- return -ENXIO
> > > > >                     ret = (block < end_block) ? 1 : -ENXIO;
> > > > >
> > > > > In this issue, bg_inode_table_hi is overwritten as an incorrect value.
> > > > > As a result, `block < end_block` cannot be met in grow_dev_page.
> > > > > Therefore, __ext4_get_inode_loc always returns '-ENOMEM' and do_writepages
> > > > > keeps retrying. As a result, the writeback process is in the D state due
> > > > > to an infinite loop.
> > > > >
> > > > > Add a check on inode table block in the __ext4_get_inode_loc function by
> > > > > referring to ext4_read_inode_bitmap to avoid this infinite loop.
> > > > >
> > > > > Signed-off-by: Baokun Li <libaokun1@huawei.com>
> > > >
> > > > Thanks for the fixes. Normally, we check that inode table is fine in
> > > > ext4_check_descriptors() (and those checks are much stricter) so it seems
> > > > unnecessary to check it again here. I understand that in your case it was
> > > > resize that corrupted the group descriptor after the filesystem was mounted
> > > > which is nasty but there's much more metadata that can be corrupted like
> > > > this and it's infeasible to check each metadata block before we use it.
> > > >
> > > > IMHO a proper fix to this class of issues would be for sb_getblk() to
> > > > return proper error so that we can distinguish ENOMEM from other errors.
> > > > But that will be a larger undertaking...
> > > >
> > >
> > > Hi Jan,
> > >
> > > How about adding a wrapper around sb_getblk() which will do the basic block
> > > bound checks for ext4. Then we can carefully convert all the callers of
> > > sb_getblk() in ext4 to call ext4_sb_getblk().
> > >
> > > ext4_sb_getblk() will then return either of below -
> > > 1. ERR_PTR(-EFSCORRUPTED)
> > > 2. NULL
> > > 3. struct buffer_head*
> > >
> > > It's caller can then implement the proper error handling.
> > >
> > > Folding a small patch to implement the simple bound check. Is this the right
> > > approach?
> >
> > Yep, looks sensible to me. Maybe I'd just make ext4_sb_getblk() return bh
> > or ERR_PTR so something like ERR_PTR(-EFSCORRUPTED), ERR_PTR(-ENXIO), or bh
> > pointer.
> 
> Sure, Thanks Jan. Will do that once I clear some confusion w.r.t
> 	"start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)"
> 
> At some places this is checked with "<= s_first_data_block"
> 	e.g. fs/ext4/ialloc.c, ext4_sb_block_valid()
> 
> while at some places I see it to be "< s_first_data_block"
> 	e.g. fs/ext4/mballoc.c, fs/ext4/mmp.c

Well, superblock is stored at s_first_data_block offset. So strictly
speaking the check should be < s_first_data_block because that block is a
valid filesystem block. OTOH in most places you are not supposed to look at
block with the superblock so stricter <= s_first_data_block is fine.

> Will spend sometime to understand why the difference and if there is anything
> I might miss here for off-by-one check.
> 
> Adding more to the confusion would be difference w.r.t blocksize = 1024 v/s
> other blocksizes. Based on the blocksize value I guess, s_first_data_block can
> be different (0/1??). Or can bigalloc can change this...
> ...Will look more into this.

That's what we discussed on our ext4 call yesterday. Normally,
s_first_data_block is 1 for blocksize 1k and 0 for blocksize > 1k. So for
1k blocksize the first group begins with block 1 and not block 0.
Effectively the whole filesystem is shifted by 1 block with 1k blocksize.
When bigalloc comes to play and blocksize is 1k, things are even more
interesting because there, the first group starts at block 0 while
s_first_data_block is still 1, because superblock is stored in block 1 of
cluster 0.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
