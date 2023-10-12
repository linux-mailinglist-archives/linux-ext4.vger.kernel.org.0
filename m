Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD27C68B9
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjJLI7m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 04:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234141AbjJLI7l (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 04:59:41 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CC590
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 01:59:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71A3921846;
        Thu, 12 Oct 2023 08:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697101178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyhFvv+qdLUo0ERrheeJqM4zIwaG8Gs3HwAf3WBBz00=;
        b=HOIzkyRtj0xbVUMiRO2nW/gq07Oz1PjO5chP9RTofzr+6nPu2XJc8kgjk0MRGL9wfnNUPs
        j3exQC2+jrXWAsa801L/mZrIGVWXWOp42rvDPZr8iB3hFx09Bq02ZJEKNculf3BgZIgLEN
        swecHQ1ydnu03Gx4OXkdtoqJw7oZV18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697101178;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LyhFvv+qdLUo0ERrheeJqM4zIwaG8Gs3HwAf3WBBz00=;
        b=MdGoz8F+MPVQ+H/A9n8jZs5MtBBX2QJ72Nlz+7yZzIFEeHZkxwsPv2kUONTcI4777NKVhy
        y9EAe1nRo29XwvCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D660139ED;
        Thu, 12 Oct 2023 08:59:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kXrDFnq1J2VpXgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 08:59:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id C582DA06B0; Thu, 12 Oct 2023 10:59:37 +0200 (CEST)
Date:   Thu, 12 Oct 2023 10:59:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct
 IO
Message-ID: <20231012085937.pzfsttumi6q4g3tm@quack3>
References: <20231011142155.19328-1-jack@suse.cz>
 <ZSc9J9zFChyxl1U2@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSc9J9zFChyxl1U2@dread.disaster.area>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-0.20)[71.38%];
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
         FREEMAIL_CC(0.00)[suse.cz,mit.edu,vger.kernel.org,gmail.com,linux.alibaba.com]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-10-23 11:26:15, Dave Chinner wrote:
> On Wed, Oct 11, 2023 at 04:21:55PM +0200, Jan Kara wrote:
> > Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> > sync file size update and thus if we crash at unfortunate moment, the
> > file can have smaller size although O_SYNC IO has reported successful
> > completion. The problem happens because update of on-disk inode size is
> > handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> > dio_complete() in particular) has returned and generic_file_sync() gets
> > called by dio_complete(). Fix the problem by handling on-disk inode size
> > update directly in our ->end_io completion handler.
> > 
> > References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> > Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
> >  1 file changed, 52 insertions(+), 87 deletions(-)
> .....
> > @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> >  		 */
> >  		if (inode->i_nlink)
> >  			ext4_orphan_del(NULL, inode);
> > +		return;
> >  	}
> > +	/*
> > +	 * If i_disksize got extended due to writeback of delalloc blocks while
> > +	 * the DIO was running we could fail to cleanup the orphan list in
> > +	 * ext4_handle_inode_extension(). Do it now.
> > +	 */
> > +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> 
> So this has to be called after the DIO write completes and calls
> ext4_handle_inode_extension()?

Yes, if the write was setup as extending one ('extend' is set to true in
ext4_dio_write_iter()).

> > @@ -606,9 +570,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >  			   dio_flags, NULL, 0);
> >  	if (ret == -ENOTBLK)
> >  		ret = 0;
> > -
> >  	if (extend)
> > -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> > +		ext4_inode_extension_cleanup(inode, ret);
> 
> Because this doesn't wait for AIO DIO to complete and actually
> extend the file before running the cleanup code...

As Gao wrote, ext4 sets IOMAP_DIO_FORCE_WAIT if 'extend' is set (see
ext4_dio_write_checks()) so if we get to calling
ext4_inode_extension_cleanup() we are guaranteed the IO has already
completed.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
