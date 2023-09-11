Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2BC779AF5A
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Sep 2023 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240989AbjIKVVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 11 Sep 2023 17:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242777AbjIKQSc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 11 Sep 2023 12:18:32 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8C0CC3
        for <linux-ext4@vger.kernel.org>; Mon, 11 Sep 2023 09:18:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 61BA31F8A6;
        Mon, 11 Sep 2023 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1694449106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNrkxlZqPkjWN3fP/jPtj5Tj2E65s2xVzyS/puMfyNA=;
        b=dDPHoaqAvqPpfeTuIZXwOooPDrih9mwnXaZ89n+yOWSUcjCI7U9+OBwxfO6J3rjh2wJPHX
        sWmTWBYvqr4bRbkgCYSYhJGdGCnSGNG/bkmglw1NOJgQCjo9G12XcygzdHUz+w8/vkZV6k
        2qSQvaaVitHubs0E3d6JPc80G5bhqNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1694449106;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rNrkxlZqPkjWN3fP/jPtj5Tj2E65s2xVzyS/puMfyNA=;
        b=F65CQdRl0xAIOtbgP36d4V8d6jHDN59415q/SioDE2nX0b1/a+0PvQvD57Np3XBDSjWzCu
        Uln3x77N8BPEoUCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5377C13780;
        Mon, 11 Sep 2023 16:18:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VXBVFNI9/2TqBQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 11 Sep 2023 16:18:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D2EBFA077E; Mon, 11 Sep 2023 18:18:25 +0200 (CEST)
Date:   Mon, 11 Sep 2023 18:18:25 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Zhihao Cheng <chengzhihao1@huawei.com>, tytso@mit.edu,
        jack@suse.com, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: Fix potential data lost in recovering journal
 raced with synchronizing fs bdev
Message-ID: <20230911161825.4ny4ynxyxabwqbee@quack3>
References: <20230908124317.2955345-1-chengzhihao1@huawei.com>
 <2b2718a4-7d8b-e0bc-c045-59fe7562392d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b2718a4-7d8b-e0bc-c045-59fe7562392d@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello!

On Sat 09-09-23 11:41:11, Zhang Yi wrote:
> On 2023/9/8 20:43, Zhihao Cheng wrote:
> > JBD2 makes sure journal data is fallen on fs device by sync_blockdev(),
> > however, other process could intercept the EIO information from bdev's
> > mapping, which leads journal recovering successful even EIO occurs during
> > data written back to fs device.
> > 
> > We found this problem in our product, iscsi + multipath is chosen for block
> > device of ext4. Unstable network may trigger kpartx to rescan partitions in
> > device mapper layer. Detailed process is shown as following:
> > 
> >   mount          kpartx          irq
> > jbd2_journal_recover
> >  do_one_pass
> >   memcpy(nbh->b_data, obh->b_data) // copy data to fs dev from journal
> >   mark_buffer_dirty // mark bh dirty
> >          vfs_read
> > 	  generic_file_read_iter // dio
> > 	   filemap_write_and_wait_range
> > 	    __filemap_fdatawrite_range
> > 	     do_writepages
> > 	      block_write_full_folio
> > 	       submit_bh_wbc
> > 	            >>  EIO occurs in disk  <<
> > 	                     end_buffer_async_write
> > 			      mark_buffer_write_io_error
> > 			       mapping_set_error
> > 			        set_bit(AS_EIO, &mapping->flags) // set!
> > 	    filemap_check_errors
> > 	     test_and_clear_bit(AS_EIO, &mapping->flags) // clear!
> >  err2 = sync_blockdev
> >   filemap_write_and_wait
> >    filemap_check_errors
> >     test_and_clear_bit(AS_EIO, &mapping->flags) // false
> >  err2 = 0
> > 
> > Filesystem is mounted successfully even data from journal is failed written
> > into disk, and ext4 could become corrupted.
> > 
> > Fix it by comparing 'sbi->s_bdev_wb_err' before loading journal and after
> > loading journal.
> > 
> > Fetch a reproducer in [Link].
> > 
> > Link: https://bugzilla.kernel.org/show_bug.cgi?id=217888
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > ---
> >  v1->v2: Checks wb_err from block device only in ext4.
> >  fs/ext4/super.c | 22 +++++++++++++++-------
> >  1 file changed, 15 insertions(+), 7 deletions(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 38217422f938..4dcaad2403be 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -4907,6 +4907,14 @@ static int ext4_load_and_init_journal(struct super_block *sb,
> >  	if (err)
> >  		return err;
> >  
> > +	err = errseq_check_and_advance(&sb->s_bdev->bd_inode->i_mapping->wb_err,
> > +				       &sbi->s_bdev_wb_err);
> > +	if (err) {
> > +		ext4_msg(sb, KERN_ERR, "Background error %d when loading journal",
> > +			 err);
> > +		goto out;
> > +	}
> > +
> 
> This solution cannot solve the problem, because the journal tail is
> still updated in journal_reset() even if we detect the writeback error
> and refuse to mount the ext4 filesystem here. So I suppose we have to
> check the I/O error by jbd2 module itself like v1 does.

Hum, that's a good point because next time we will try to mount the fs we
will not try to replay the journal anymore. So let's return to v1 and I'm
sorry for misguiding you Zhihao.

But when we are doing background IO error detection in jbd2 during journal
replay, I'm wondering whether we shouldn't be doing something similar in
checkpointing code - like when we are about to remove a transaction from
the journal. And as I'm checking we already do that using
JBD2_CHECKPOINT_IO_ERROR bit handling - maybe we could replace that with a
more standard errseq mechanism that is available these days as a cleanup?

And the ext4 handling in ext4_check_bdev_write_error() is useful only in
nojournal mode as otherwise jbd2 is taking care of all writeback errors
including the background ones. So maybe we can guard the
ext4_check_bdev_write_error() by a !ext4_handle_valid(handle) check to make
that obvious (and comment about that).

What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
