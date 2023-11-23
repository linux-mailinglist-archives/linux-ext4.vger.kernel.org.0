Return-Path: <linux-ext4+bounces-103-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89ACB7F5A7C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 09:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46792281834
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A51B295;
	Thu, 23 Nov 2023 08:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="F8BRUFig";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3nONaTMx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD06D49
	for <linux-ext4@vger.kernel.org>; Thu, 23 Nov 2023 00:49:56 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD99A1F388;
	Thu, 23 Nov 2023 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1700729394; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yo9knWJxValzq/0VWfJy9cex96z7opEcw8Pj1Mo8Mt0=;
	b=F8BRUFig9haKyiP0FutFuzUV+AtiurR83E4pEstwfB9Y2qqjyru3yNhI9HZXrcaDSo+k95
	YD/Awp2KXPIj+jW32/Mi5xp9gzxVZxeddMpZ2an64YLDU6KJ444XnFTQJi5qqyw28h6cHb
	o/9rjP0acb8J3GnYPn1ISCdREwCJt2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1700729394;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yo9knWJxValzq/0VWfJy9cex96z7opEcw8Pj1Mo8Mt0=;
	b=3nONaTMx0ON8WyB1ppiwdG6e7cjh8lT7nzmYbfFQZXh3oe38+8kxm7zJodvC/TQBLd7O4V
	ny9fD/DdkePcbJCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A53F4133B6;
	Thu, 23 Nov 2023 08:49:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id A9FRKDISX2UhCgAAMHmgww
	(envelope-from <jack@suse.cz>); Thu, 23 Nov 2023 08:49:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3AF07A07D9; Thu, 23 Nov 2023 09:49:54 +0100 (CET)
Date: Thu, 23 Nov 2023 09:49:54 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org,
	syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix warning in ext4_dio_write_end_io()
Message-ID: <20231123084954.oegpgspqm37nnz2a@quack3>
References: <20231122181440.12043-1-jack@suse.cz>
 <87zfz5q76w.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfz5q76w.fsf@doe.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: 5.38
X-Spamd-Result: default: False [5.38 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[47479b71cdfc78f56d30];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_SPAM_LONG(3.50)[1.000];
	 NEURAL_SPAM_SHORT(2.98)[0.993];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_COUNT_TWO(0.00)[2];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Thu 23-11-23 12:37:03, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > The syzbot has reported that it can hit the warning in
> > ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
> > reproducer creates a race between DIO IO completion and truncate
> > expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
> > inode state where i_disksize is already updated but i_size is not
> > updated yet. Since we are careful when setting up DIO write and consider
> > it extending (and thus performing the IO synchronously with i_rwsem held
> > exclusively) whenever it goes past either of i_size or i_disksize, we
> > can use the same test during IO completion without risking entering
> > ext4_handle_inode_extension() without i_rwsem held. This way we make it
> > obvious both i_size and i_disksize are large enough when we report DIO
> > completion without relying on unreliable WARN_ON.
> 
> Does it make sense to add this in ext4_handle_inode_extension()?
> 	WARN_ON_ONCE(!inode_is_locked(inode));
> Ohk, we already have "lockdep_assert_held_write(&inode->i_rwsem)" so
> hopefully it can catch via lockdep.

Exactly.
 
> So, IIUC, the WARN happened when we were doing a non-extending
> AIO-DIO write which was racing with truncate trying to expand the file
> size. Because only then the DIO completion will not have i_rwsem held
> which can race with truncate. Truncate since it is expanding the file
> size, will not use inode_dio_wait() (since no block allocations).
> 
> Is this understanding correct?

Yes, correct.

								Honza

> 
> >
> > Reported-by: syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
> > Fixes: 91562895f803 ("ext4: properly sync file size update after O_SYNC direct IO")
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/file.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 0166bb9ca160..ba497aabdd1e 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -386,10 +386,11 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> >  	 * blocks. But the code in ext4_iomap_alloc() is careful to use
> >  	 * zeroed/unwritten extents if this is possible; thus we won't leave
> >  	 * uninitialized blocks in a file even if we didn't succeed in writing
> > -	 * as much as we intended.
> > +	 * as much as we intended. Also we can race with truncate or write
> > +	 * expanding the file so we have to be a bit careful here.
> >  	 */
> > -	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
> > -	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
> > +	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize) &&
> > +	    pos + size <= i_size_read(inode))
> >  		return size;
> >  	return ext4_handle_inode_extension(inode, pos, size);
> >  }
> > -- 
> > 2.35.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

