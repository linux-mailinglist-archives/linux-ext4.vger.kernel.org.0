Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A949E7A880B
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Sep 2023 17:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjITPUO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Sep 2023 11:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235375AbjITPUO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Sep 2023 11:20:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A834FAF
        for <linux-ext4@vger.kernel.org>; Wed, 20 Sep 2023 08:20:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4EF90201DD;
        Wed, 20 Sep 2023 15:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695223206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7AzN1mLqwYDcL1y/3tm5qbuWrejAXkpwHmS1ksZcCC4=;
        b=q3XRGLlDn1eUBVekkErC1qijau4u/yE17vkMW+PuAN0DWGjZ775ggtf9Qmio7o3zzNGXf9
        BIjPhsdCiAxPoKRpAYuLpqaAktqnda0fxpQVylEBGaEveDifsoFiMDc8pqqo95qkIyzwNQ
        kKUz5XK8dAZT+6NwyMftz+aBUO4S3Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695223206;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7AzN1mLqwYDcL1y/3tm5qbuWrejAXkpwHmS1ksZcCC4=;
        b=j0EDtOYluXofL0TyM8mIbSpMsXmjvBSQ8Z0XrD6yu+GE5lP3ZzslmLOxaAxJ3zmKzMbx28
        L9Ug986HdRX5oKBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 41829132C7;
        Wed, 20 Sep 2023 15:20:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8jP4D6YNC2WeQQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 20 Sep 2023 15:20:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D0E10A077D; Wed, 20 Sep 2023 17:20:05 +0200 (CEST)
Date:   Wed, 20 Sep 2023 17:20:05 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Christoph Hellwig <hch@lst.de>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [bug report] ext4 misses final i_size meta sync under O_DIRECT |
 O_SYNC semantics after iomap DIO conversion
Message-ID: <20230920152005.7iowrlukd5zbvp43@quack3>
References: <20230919120532.5dg7mgdnwd5lezgz@quack3>
 <871qet6pn8.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qet6pn8.fsf@doe.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 20-09-23 17:08:19, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > Hello!
> >
> > On Tue 19-09-23 14:00:04, Gao Xiang wrote:
> >> Our consumer reports a behavior change between pre-iomap and iomap
> >> direct io conversion:
> >> 
> >> If the system crashes after an appending write to a file open with
> >> O_DIRECT | O_SYNC flag set, file i_size won't be updated even if
> >> O_SYNC was marked before.
> >> 
> >> It can be reproduced by a test program in the attachment with
> >> gcc -o repro repro.c && ./repro testfile && echo c > /proc/sysrq-trigger
> >> 
> >> After some analysis, we found that before iomap direct I/O conversion,
> >> the timing was roughly (taking Linux 3.10 codebase as an example):
> >> 
> >> 	..
> >> 	- ext4_file_dio_write
> >> 	  - __generic_file_aio_write
> >> 	      ..
> >> 	    - ext4_direct_IO  # generic_file_direct_write
> >> 	      - ext4_ext_direct_IO
> >> 	        - ext4_ind_direct_IO  # final_size > inode->i_size
> >> 	          - ..
> >> 	          - ret = blockdev_direct_IO()
> >> 	          - i_size_write(inode, end) # orphan && ret > 0 &&
> >> 	                                   # end > inode->i_size
> >> 	          - ext4_mark_inode_dirty()
> >> 	          - ...
> >> 	  - generic_write_sync  # handling O_SYNC
> >> 
> >> So the dirty inode meta will be committed into journal immediately
> >> if O_SYNC is set.  However, After commit 569342dc2485 ("ext4: move
> >> inode extension/truncate code out from ->iomap_end() callback"),
> >> the new behavior seems as below:
> >> 
> >> 	..
> >> 	- ext4_dio_write_iter
> >> 	  - ext4_dio_write_checks  # extend = 1
> >> 	  - iomap_dio_rw
> >> 	      - __iomap_dio_rw
> >> 	      - iomap_dio_complete
> >> 	        - generic_write_sync
> >> 	  - ext4_handle_inode_extension  # extend = 1
> 
> Yes, since ext4_handle_inode_extension() will handle inode i_disksize
> update and mark the inode dirty, generic_write_sync() call should happen
> after that.
> 
> That also means then we don't have any generic FS testcase which can
> validate this behaviour. 

Yeah.

> >> So that i_size will be recorded only after generic_write_sync() is
> >> called.  So O_SYNC won't flush the update i_size to the disk.
> >
> > Indeed, that looks like a bug. Thanks for report!
> >
> >> On the other side, after a quick look of XFS side, it will record
> >> i_size changes in xfs_dio_write_end_io() so it seems that it doesn't
> >> have this problem.
> >
> > Yes, I'm a bit hazy on the details but I think we've decided to call
> > ext4_handle_inode_extension() directly from ext4_dio_write_iter() because
> > from ext4_dio_write_end_io() it was difficult to test in a race-free way
> > whether extending i_size (and i_disksize) is needed or not (we don't
> > necessarily hold i_rwsem there).
> 
> We do hold i_rwsem in exclusive write mode for file extend case.
> (ext4_dio_write_checks()).

Yes, the case I'm a bit concerned about is that for AIO overwrites we don't
hold i_rwsem at all in iomap_dio_complete() but we will still be performing
checks for file extension so we have to be careful they cannot have false
positives (or some other races) in the unlocked case.

> IIUC, ext4_handle_inode_extension() takes "written" and "count" as it's
> argument. This means that "count" bytes were mapped, but only "written"
> bytes were written. This information is used in
> ext4_handle_inode_extension() case for truncating blocks beyond EOF. 
> 
> I also found this discussion here [1].
> 
> [1]:
> https://lore.kernel.org/linux-ext4/20191008151238.GK5078@quack2.suse.cz/

Yeah, thanks for finding this.

> From this thread it looks like we decided to move
> ext4_handle_inode_extension() case out of ->end_io callback after v4
> series (in v5) to handle above case. Right?

Yes, the lack of original IO length in the ->end_io callback was the final
problem that made us move the ext4_handle_inode_extension() call out of
->end_io callback.

> > I'll think how we could fix the problem you've reported.
> >
> 
> 1. I was thinking why do we need to truncate those blocks which are beyond
> EOF for DIO case? Wasn't there an argument, that for short DIO writes,
> we can use the remaining blocks allocated to be written by buffered-io,
> right? Do we risk exposing anything in doing so?
> We do fallback to buffered-io for short writes in ext4_dio_write_iter().

Yes, but as I mentioned in the thread you've referenced if we crash at
unfortunate moment, we will have inodes with blocks beyond EOF which is
not nice as we are "leaking" blocks.

> 2. Either ways let's say we still would like to call truncate. Then can we
> move ext4_truncate() logic out of ext4_handle_inode_extension() and call
> ext4_handle_inode_extension() from within ->end_io callback. 
> ext4_truncate() can be then done in the main routine directly i.e. in
> ext4_dio_write_iter() where we do have both "count" and "written" information.

The truncate itself is not a big deal, as you say that can happen later.
The real question for which we need both "count" and "written" is whether
we can remove the inode from the orphan list in ->end_io callback or not.
For the common case of successful write, we want to do the removal from the
orphan list in the same transaction as the i_disksize update for
performance reasons. So that's why we have to do the decision about
truncation at the place where we update i_disksize.

But I think it shouldn't be a big deal to actually propagate the original
IO size to iomap_dio_end() and ->end_io callback. Let's try that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
