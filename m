Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDF77D0005
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Oct 2023 18:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjJSQzv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Oct 2023 12:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbjJSQzu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Oct 2023 12:55:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F02126;
        Thu, 19 Oct 2023 09:55:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D08CB1FD93;
        Thu, 19 Oct 2023 16:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697734546; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Onw+wNK6InUnlhETp0GeaBLibtNHkDq/qABZV2fpE0=;
        b=wez2v4rlvkQ6K/ggTd/wX9+iAbDJ0IX+aGpTkwR8PuFm1nZ5VL2I4hPO4mfYBSj+veEWUq
        D3KHWxedvoUXlx1xBCQ2FdhKLncAVeKFUqaJVNIN75lmcmDTXZSsx6Eq4FOUFgSgL49iYt
        TFlMsb0NreTFf1nra/AwUR8SaREk+Mg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697734546;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9Onw+wNK6InUnlhETp0GeaBLibtNHkDq/qABZV2fpE0=;
        b=Hx2s8nb+4VzfATRJknw1zBO5ftOec7VrhspM4JbUkXtKQCmz864k1NsCANAKJ49feCeL0l
        IpGESrHcbc+6IxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C30691357F;
        Thu, 19 Oct 2023 16:55:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Z0SVL5JfMWXcUAAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 19 Oct 2023 16:55:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 448B9A0550; Thu, 19 Oct 2023 18:55:46 +0200 (CEST)
Date:   Thu, 19 Oct 2023 18:55:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH 2/3] ext4: truncate complete range in pagecache before
 calling ext4_zero_partial_blocks()
Message-ID: <20231019165546.norapdphdyx7g3ob@quack3>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
 <f7aaea4a59bc1c69f87e178dae34c38d2bcfee12.1695987265.git.ojaswin@linux.ibm.com>
 <ZRb4BX8bhhyWEari@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRb4BX8bhhyWEari@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[6];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,suse.cz]
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 29-09-23 21:45:29, Ojaswin Mujoo wrote:
> On Fri, Sep 29, 2023 at 07:40:44PM +0530, Ojaswin Mujoo wrote:
> > In ext4_zero_range() and ext4_punch_hole(), the range passed could be unaligned
> > however we only zero out the pagecache range that is block aligned. These
> > functions are relying on ext4_zero_partial_blocks() ->
> > __ext4_block_zero_page_range() to take care of zeroing the unaligned edges in
> > the pageacache. However, the right thing to do is to properly zero out the whole
> > range in these functions before and not rely on a different function to do it
> > for us. Hence, modify ext4_zero_range() and ext4_punch_hole() to zero the
> > complete range.
> > 
> > This will also allow us to now exit early for unwritten buffer heads in
> > __ext4_block_zero_page_range(), in upcoming patch.
> > 
> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > ---
> >  fs/ext4/extents.c | 17 +++++++++++------
> >  fs/ext4/inode.c   |  3 +--
> >  2 files changed, 12 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index c79b4c25afc4..2dc681cab6a5 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> > @@ -4582,9 +4582,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >  
> >  	/* Zero range excluding the unaligned edges */
> >  	if (max_blocks > 0) {
> > -		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
> > -			  EXT4_EX_NOCACHE);
> > -
> >  		/*
> >  		 * Prevent page faults from reinstantiating pages we have
> >  		 * released from page cache.
> > @@ -4609,17 +4606,25 @@ static long ext4_zero_range(struct file *file, loff_t offset,
> >  		 * disk in case of crash before zeroing trans is committed.
> >  		 */
> >  		if (ext4_should_journal_data(inode)) {
> > -			ret = filemap_write_and_wait_range(mapping, start, end - 1);
> > +			ret = filemap_write_and_wait_range(mapping, start,
> > +							   end - 1);
> 
> I think this accidentally creeped in, will fix it in next rev.

Yeah, just pull it in patch 1.

> >  			if (ret) {
> >  				filemap_invalidate_unlock(mapping);
> >  				goto out_mutex;
> >  			}
> >  		}
> > +	}
> 
> So the above if (max_blocks) {...} block runs when the range spans
> multiple blocks but I think the filemap_write_and_wait_range() and
> ext4_update_disksize_before_punch() should be called when we are actually
> spanning multiple pages, since the disksize not updating issue and the 
> truncate racing with checkpoint only happen when the complete page is
> truncated. Is this understanding correct? 

Why do you think the issues apply only to multiple pages? I mean even if a
single block is dirty in memory, it may be pushing i_disksize or carrying
journalled data we need to commit.

> > +	/*
> > +	 * Now truncate the pagecache and zero out non page aligned edges of the
> > +	 * range (if any)
> > +	 */
> > +	truncate_pagecache_range(inode, offset, offset + len - 1);
> >  
> > -		/* Now release the pages and zero block aligned part of pages */
> > -		truncate_pagecache_range(inode, start, end - 1);
> > +	if (max_blocks > 0) {
> >  		inode->i_mtime = inode->i_ctime = current_time(inode);
> >  
> > +		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
> >  		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
> >  					     flags);
> >  		filemap_invalidate_unlock(mapping);
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 6c490f05e2ba..de8ea8430d30 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -3974,9 +3974,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
> >  		ret = ext4_update_disksize_before_punch(inode, offset, length);
> 
> In this function ext4_punch_hole() I see that we call
> filemap_write_and_wait_range() and then take the inode_lock() later.
> Doesn't this leave a window for the pages to get dirty again? 

There's definitely a race window but I think the call to
filemap_write_and_wait_range() is a leftover from the past when hole
punching could race in a nasty way. These days we have invalidate_lock so I
*think* we can just remove that filemap_write_and_wait_range() call. At
least I don't see a good reason for it now because the pages are going away
anyway. But it needs testing :).

> For example, in ext4_zero_range(), we checkpoint using
> filemap_write_and_wait_range() in case of data=journal under
> inode_lock() but that's not the case here. Just wondering if this 
> or any other code path might still race here? 

Well, that's a bit different story as the comment there explains. And yes,
invalidate_lock protects us from possible races there.

> >  		if (ret)
> >  			goto out_dio;
> > -		truncate_pagecache_range(inode, first_block_offset,
> > -					 last_block_offset);
> >  	}
> > +	truncate_pagecache_range(inode, offset, offset + length - 1);

But I have realized that changes done in this patch actually don't help
with changing ext4_zero_partial_blocks() because as soon as we drop
invalidate_lock, a page fault can come in and modify contents of partial
pages we need zeroed.

So thinking about this again with fresh mind, these block vs pagecache
consistency issues aren't probably worth it and current code flow is good
enough. Sorry for misleading you. We might just add a comment to
__ext4_block_zero_page_range() to explain that buffer_unwritten() buffers
can get there but they should be already zeroed-out and uptodate and we do
need to process them because of page cache zeroing. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
