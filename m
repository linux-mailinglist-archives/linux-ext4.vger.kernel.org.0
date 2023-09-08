Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCB1798433
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Sep 2023 10:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbjIHIiP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 8 Sep 2023 04:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjIHIiN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 8 Sep 2023 04:38:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EB91BEA;
        Fri,  8 Sep 2023 01:38:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 411C51F749;
        Fri,  8 Sep 2023 08:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694162286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYZC8KSjcuZZL10rELoUr1REGIG//dFrn+q4IYIpiUs=;
        b=F+YWTZ3vyRZrVivT7b2tKfjlMfFaDMe67xW7+8mivCbWRz5RaIsrQXHTNTUq6ap/5XVLL/
        Lhb1JrpbiNNR035s9dEnokepTxGqzv7PxTdvjCRVflp3Wtimye6MQB8PdVc8ZV+H87vu5Z
        HJyQrEP1OZzNknW5+6F5AyniSKT80/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694162286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cYZC8KSjcuZZL10rELoUr1REGIG//dFrn+q4IYIpiUs=;
        b=pB7O6PpotK3WC5+/29wIseu8pZUNwIIdeJ4XrO3vSJ/UwrjegGUYfhRhnMFIrbwtlAzXU7
        vPuAvx4Ki/jolhAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2B7EF131FD;
        Fri,  8 Sep 2023 08:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H1aaCm7d+mQANwAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 08 Sep 2023 08:38:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AFCD3A0774; Fri,  8 Sep 2023 10:38:05 +0200 (CEST)
Date:   Fri, 8 Sep 2023 10:38:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/1] ext4: Mark buffer new if it is unwritten to avoid
 stale data exposure
Message-ID: <20230908083805.mm4dc65zthpposyt@quack3>
References: <cover.1693909504.git.ojaswin@linux.ibm.com>
 <c307579df7e109eb4eedaaf07ebdc98b15d8b7ff.1693909504.git.ojaswin@linux.ibm.com>
 <20230905135629.wdjl2b6s3pzh7idg@quack3>
 <ZPl9gAImu85zEbXP@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
 <20230907114630.2y3kxm5vkr3bun5q@quack3>
 <ZPolj/36lDyd9+8R@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPolj/36lDyd9+8R@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 08-09-23 01:03:35, Ojaswin Mujoo wrote:
> On Thu, Sep 07, 2023 at 01:46:30PM +0200, Jan Kara wrote:
> > On Thu 07-09-23 13:06:56, Ojaswin Mujoo wrote:
> > > On Tue, Sep 05, 2023 at 03:56:29PM +0200, Jan Kara wrote:
> > > > On Tue 05-09-23 15:58:01, Ojaswin Mujoo wrote:
> > > > > ** Short Version **
> > > > > 
> > > > > In ext4 with dioread_nolock, we could have a scenario where the bh returned by
> > > > > get_blocks (ext4_get_block_unwritten()) in __block_write_begin_int() has
> > > > > UNWRITTEN and MAPPED flag set. Since such a bh does not have NEW flag set we
> > > > > never zero out the range of bh that is not under write, causing whatever stale
> > > > > data is present in the folio at that time to be written out to disk. To fix this
> > > > > mark the buffer as new in _ext4_get_block(), in case it is unwritten.
> > > > > 
> > > > > -----
> > > > > ** Long Version **
> > > > > 
> > > > > The issue mentioned above was resulting in two different bugs:
> > > > > 
> > > > > 1. On block size < page size case in ext4, generic/269 was reliably
> > > > > failing with dioread_nolock. The state of the write was as follows:
> > > > > 
> > > > >   * The write was extending i_size.
> > > > >   * The last block of the file was fallocated and had an unwritten extent
> > > > >   * We were near ENOSPC and hence we were switching to non-delayed alloc
> > > > >     allocation.
> > > > > 
> > > > > In this case, the back trace that triggers the bug is as follows:
> > > > > 
> > > > >   ext4_da_write_begin()
> > > > >     /* switch to nodelalloc due to low space */
> > > > >     ext4_write_begin()
> > > > >       ext4_should_dioread_nolock() // true since mount flags still have delalloc
> > > > >       __block_write_begin(..., ext4_get_block_unwritten)
> > > > >         __block_write_begin_int()
> > > > >           for(each buffer head in page) {
> > > > >             /* first iteration, this is bh1 which contains i_size */
> > > > >             if (!buffer_mapped)
> > > > >               get_block() /* returns bh with only UNWRITTEN and MAPPED */
> > > > >             /* second iteration, bh2 */
> > > > >               if (!buffer_mapped)
> > > > >                 get_block() /* we fail here, could be ENOSPC */
> > > > >           }
> > > > >           if (err)
> > > > >             /*
> > > > >              * this would zero out all new buffers and mark them uptodate.
> > > > >              * Since bh1 was never marked new, we skip it here which causes
> > > > >              * the bug later.
> > > > >              */
> > > > >             folio_zero_new_buffers();
> > > > >       /* ext4_wrte_begin() error handling */
> > > > >       ext4_truncate_failed_write()
> > > > >         ext4_truncate()
> > > > >           ext4_block_truncate_page()
> > > > >             __ext4_block_zero_page_range()
> > > > 	>               if(!buffer_uptodate())
> > > > >                 ext4_read_bh_lock()
> > > > >                   ext4_read_bh() -> ... ext4_submit_bh_wbc()
> > > > >                     BUG_ON(buffer_unwritten(bh)); /* !!! */
> > > > > 
> > > > > 2. The second issue is stale data exposure with page size >= blocksize
> > > > > with dioread_nolock. The conditions needed for it to happen are same as
> > > > > the previous issue ie dioread_nolock around ENOSPC condition. The issue
> > > > > is also similar where in __block_write_begin_int() when we call
> > > > > ext4_get_block_unwritten() on the buffer_head and the underlying extent
> > > > > is unwritten, we get an unwritten and mapped buffer head. Since it is
> > > > > not new, we never zero out the partial range which is not under write,
> > > > > thus writing stale data to disk. This can be easily observed with the
> > > > > following reporducer:
> > > > > 
> > > > >  fallocate -l 4k testfile
> > > > >  xfs_io -c "pwrite 2k 2k" testfile
> > > > >  # hexdump output will have stale data in from byte 0 to 2k in testfile
> > > > >  hexdump -C testfile
> > > > > 
> > > > > NOTE: To trigger this, we need dioread_nolock enabled and write
> > > > > happening via ext4_write_begin(), which is usually used when we have -o
> > > > > nodealloc. Since dioread_nolock is disabled with nodelalloc, the only
> > > > > alternate way to call ext4_write_begin() is to fill make sure dellayed
> > > > > alloc switches to nodelalloc (ext4_da_write_begin() calls
> > > > > ext4_write_begin()).  This will usually happen when FS is almost full
> > > > > like the way generic/269 was triggering it in Issue 1 above. This might
> > > > > make this issue harder to replicate hence for reliable replicate, I used
> > > > > the below patch to temporarily allow dioread_nolock with nodelalloc and
> > > > > then mount the disk with -o nodealloc,dioread_nolock. With this you can
> > > > > hit the stale data issue 100% of times:
> > > > > 
> > > > > @@ -508,8 +508,8 @@ static inline int ext4_should_dioread_nolock(struct inode *inode)
> > > > >   if (ext4_should_journal_data(inode))
> > > > >     return 0;
> > > > >   /* temporary fix to prevent generic/422 test failures */
> > > > > - if (!test_opt(inode->i_sb, DELALLOC))
> > > > > -   return 0;
> > > > > + // if (!test_opt(inode->i_sb, DELALLOC))
> > > > > + //  return 0;
> > > > >   return 1;
> > > > >  }
> > > > > 
> > > > > -------
> > > > > 
> > > > > After applying this patch to mark buffer as NEW, both the above issues are
> > > > > fixed.
> > > > > 
> > > > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > 
> > > Hi Jan, thanks for the review.
> > > 
> > > > 
> > > > Good catch! But I'm wondering whether this is really the right fix. For
> > > > example in ext4_block_truncate_page() shouldn't we rather be checking
> > > > whether the buffer isn't unwritten and if yes then bail because there's
> > > > nothing to zero out in the block? That would seem like a more logical
> > > > and robust solution of the first problem to me.
> > > 
> > > Right, I agree. I will look into it and prepare a patch for this in v2.
> > > 
> > > > 
> > > > Regarding the second issue I agree that using buffer_new flag makes the
> > > > most sense. But it would make most sense to me to put this special logic
> > > > directly into ext4_get_block_unwritten() because it is really special logic
> > > > when preparing buffered write via unwritten extent (and it relies on
> > > > __block_write_begin_int() logic to interpret buffer_new flag in the right
> > > > way). Putting in _ext4_get_block() seems confusing to me because it raises
> > > > questions like why should we set it for reads? And why not set it already
> > > > in ext4_map_blocks() which is also used by iomap?
> > > 
> > > Originally I had kept it there because it didn't seem to affect any read
> > > related paths, and marking an unwritten buffer as new for zero'ing out
> > > seemed like the right thing to do irrespective of which code path we
> > > were coming from. However, I think its okay to move it
> > > ext4_get_block_unwritten() it seems to be the only place where we need
> > > to explicitly mark it as such.
> > > 
> > > That being said, I also had an alternate solution that marked the map
> > > flag as NEW in ext4_map_blocks() -> ext4_ext4_map_blocks() ->
> > > ext4_ext_handle_unwritten_extents(). Do you think it makes more
> > > sense to handle this issue in ext4 map layer instead of relying on special
> > > handling of buffer head?
> > > 
> > > Yesterday I looked into this a bit more and it seems that all the other
> > > code paths in ext4, except ext4_da_get_block_prep(), rely on
> > > ext4_map_blocks() setting the NEW flag correctly in map->m_flags
> > > whenever the buffer might need to be zeroed out (this is true for dio
> > > write via iomap as well). Now this makes me incline towards fixing the
> > > issue in ext4_map_blocks layer, which might be better in the longer for
> > > eg when we eventually move to iomap.
> > 
> > I was also thinking about this and I'm concerned about the following:
> > __block_write_begin_int() does:
> > 
> >                 if (buffer_new(bh))
> >                         clear_buffer_new(bh);
> > 
> > before checking for buffer_mapped() flag. So if we mapped the buffer e.g.
> > in the read path and marked it as new there, then __block_write_begin_int()
> > will happily clear the new flag and because the buffer is mapped it will
> > just not bother with calling get_block() again. The buffer_new flag is not
> 
> So a question here, if we mark a buffer mapped while reading, then we
> don't really need the new flag on it right? Since it'll already have
> valid data, in which case it shouldn't matter if
> __block_write_begin_int() clears the flag.

OK, that is true so this shouldn't generally be a problem. I've now also
realized another related quirk of the ->get_block functions and that is
that on read, unwritten buffers have to be returned back from ->get_block
as !buffer_mapped so that block_read_full_page() properly zeroes the buffer
content.

> > really a buffer state flag but just a special side-band communication
> > between the ->get_block handler and __block_write_begin_int(). We have
> > similar communication happening through other bits of b_state in the legacy
> > direct IO code.
> > 
> > So this mess is specific to __block_write_begin_int() and its handling of
> > buffer heads. In iomap code we have iomap_block_needs_zeroing() used in
> > __iomap_write_begin() and unwritten extents do end up being zeroed
> > automatically regardless of the IOMAP_F_NEW flag.
> 
> So basically when to zero out is communicated to
> __block_write_begin_int() via the buffer head new flag irrespective of
> whether the extent itself is "new" or not (that is map flags has new).
> Hence, the buffer being new (needing zeroing) is really something
> get_blocks should figure out and communicate to buffer handling layer. 

Yes.
 
> Thanks for explaining this. Going through all this makes me feel the
> whole interaction between __block_write_begin_int() -> get_blocks() ->
> ext4_map_blocks() is kinda confusing/fragile and each layer has several
> implicit assumptions about how the others will behave.

Agreed. That is one of the reasons why iomap was created :). Because these
interactions became unmaintainable mess.

> Also, just bouncing some ideas here. Why is it that
> __block_write_begin_int() only considers buffer_new() when deciding to
> zero out? Shouldn't we zero out when the buffer is unwritten as well?
> That way we could avoid all the special logic of marking the buffer as
> new whenever it is unwritten, as seen in this patch and in
> ext4_da_get_block_prep().

__block_write_begin_int() (at least the core of its functionality) comes
from the times when the buffer layer didn't handle unwritten buffers at
all. Then unwritten buffers and delayed allocation was bolted on top
and the design decisions were ... suboptimal ... at some points. Well,
everybody can be clever when the problems become obvious :). Now we could
obviously rewrite buffer head handling to a saner state but since buffer
heads have also other issues, the energy is much better invested into
conversion of filesystems into iomap. That's why I'd go for a minimal patch
to fix the data corruption bug.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
