Return-Path: <linux-ext4+bounces-233-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C627FEC56
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 10:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DA61B21059
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Nov 2023 09:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7363AC25;
	Thu, 30 Nov 2023 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xYilHNIl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZzZEPaD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BE910E6
	for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 01:55:28 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 821DD1FC83;
	Thu, 30 Nov 2023 09:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1701338126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxB3p2NrSYa0lIa6Sjt30IBr5ON93xntzTViXDOTZUc=;
	b=xYilHNIlCX4bXNH0+ZyE5Y7SRlApSuAL9T/G22+xEFX/804rv8uzT/lnYcmaU31ULKF506
	AUzkWAqLnLf1GprLzjFgr/ppiESRWtjN3mDR5/EtyfCliSqDoH8ZTHk8AIsE9mgRXb8tvf
	6M7AbdLcNj6QYytL95SEdhzFxlrsOcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1701338126;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TxB3p2NrSYa0lIa6Sjt30IBr5ON93xntzTViXDOTZUc=;
	b=1ZzZEPaDYyiwASnw4Q/Ot1HOX7qUfBcf5L33CV+nPFTz62KPNWKocMV7RF0pjupEQ3pp15
	FGi2FDgtmQoqVRBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7537B13A5C;
	Thu, 30 Nov 2023 09:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id hEyaHA5caGWwLAAAn2gu4w
	(envelope-from <jack@suse.cz>); Thu, 30 Nov 2023 09:55:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 208EAA07E3; Thu, 30 Nov 2023 10:55:22 +0100 (CET)
Date: Thu, 30 Nov 2023 10:55:22 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org,
	syzbot+47479b71cdfc78f56d30@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: Fix warning in ext4_dio_write_end_io()
Message-ID: <20231130095522.zlgumj6zuqyygdzu@quack3>
References: <20231123084954.oegpgspqm37nnz2a@quack3>
 <87ttpcrebz.fsf@doe.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ttpcrebz.fsf@doe.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TAGGED_RCPT(0.00)[47479b71cdfc78f56d30];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]

On Thu 23-11-23 15:17:28, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Thu 23-11-23 12:37:03, Ritesh Harjani wrote:
> >> Jan Kara <jack@suse.cz> writes:
> >> 
> >> > The syzbot has reported that it can hit the warning in
> >> > ext4_dio_write_end_io() because i_size < i_disksize. Indeed the
> >> > reproducer creates a race between DIO IO completion and truncate
> >> > expanding the file and thus ext4_dio_write_end_io() sees an inconsistent
> >> > inode state where i_disksize is already updated but i_size is not
> >> > updated yet. Since we are careful when setting up DIO write and consider
> >> > it extending (and thus performing the IO synchronously with i_rwsem held
> >> > exclusively) whenever it goes past either of i_size or i_disksize, we
> >> > can use the same test during IO completion without risking entering
> >> > ext4_handle_inode_extension() without i_rwsem held. This way we make it
> >> > obvious both i_size and i_disksize are large enough when we report DIO
> >> > completion without relying on unreliable WARN_ON.
> >> 
> >> Does it make sense to add this in ext4_handle_inode_extension()?
> >> 	WARN_ON_ONCE(!inode_is_locked(inode));
> >> Ohk, we already have "lockdep_assert_held_write(&inode->i_rwsem)" so
> >> hopefully it can catch via lockdep.
> >
> > Exactly.
> >  
> >> So, IIUC, the WARN happened when we were doing a non-extending
> >> AIO-DIO write which was racing with truncate trying to expand the file
> >> size. Because only then the DIO completion will not have i_rwsem held
> >> which can race with truncate. Truncate since it is expanding the file
> >> size, will not use inode_dio_wait() (since no block allocations).
> >> 
> >> Is this understanding correct?
> >
> > Yes, correct.
> 
> Thanks Jan,
> 
> Also ext4_inode_extension_cleanup() function can take care of deleting
> the inode from the orphan list in case if there is a race with truncate 
> which extended made both i_disksize and inode->i_size and the DIO
> completion couldn't call ext4_handle_inode_extension(), right?
> 
> In that case, does it make sense to update a comment here too? 
> 
> @@ -350,7 +350,10 @@ static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
>         }
>         /*
>          * If i_disksize got extended due to writeback of delalloc blocks while
> -        * the DIO was running we could fail to cleanup the orphan list in
> +        * the DIO was running, or
> +        * If i_disksize and inode->i_size both got extened during truncate
> +        * which raced with DIO completion,
> +        * In both such cases, we could fail to cleanup the orphan list in
>          * ext4_handle_inode_extension(). Do it now.
>          */
>         if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {

Good point. Expanded comment in this way. I'll send v2 shortly.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

