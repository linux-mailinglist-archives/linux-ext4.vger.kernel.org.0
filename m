Return-Path: <linux-ext4+bounces-6776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD6DA5E25D
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 18:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5263817BC86
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 17:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303EE1D79A3;
	Wed, 12 Mar 2025 17:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rcIAqyhs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JYNXaGrn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g7a5EjLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8rZnqX5O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04BE259C
	for <linux-ext4@vger.kernel.org>; Wed, 12 Mar 2025 17:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741799757; cv=none; b=HqBsJTe2EYEAHMQFBLBshYlbU5I00kMDNlGoE5Tx1+ytzz35tJA05qoi7bQlOVQHgivK01x44FKSY/BarLxJmWSI87/wWPNa4BM6vGhhmY7g4g8IHAkBlvvuYhj9sNXx0r2v9xCcpSFllePPFZSdnJzTroXfVzmor2u1Pt+sbLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741799757; c=relaxed/simple;
	bh=ZbWt1HSfI/1sp/IxdkCHbtrv15RyTiaOOLpYqRZ1S4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwyQlqNc05T5C5fCkn+v9IwaqLqn1y3GBpAOPA2wN0FoDFeD7HrdMUBwxru/WDtXVeNZ6XGGmq2bSt8+ZZ9Vm0DgcfjnXghLHod/H1rgmE+ICAFKMUTvb0EpXg8b7NIh12uWb5uuH7y4Qs1tIeWYmU0SDll3iWQ73HNEtvT39pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rcIAqyhs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=JYNXaGrn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g7a5EjLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8rZnqX5O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD9061F388;
	Wed, 12 Mar 2025 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741799754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRKu5YTcDTCg8AtmFssPU8caprER3muD9VjLo3ODo9M=;
	b=rcIAqyhstc44zO1ZzQyqatWK5J19ppt7MUzmQ8MIF1u5RcG90fJXW+sT6FsoC0tz8hWc43
	TTI2oHuYkbNJaO9MzjQusie6V3Z1KqpfbuHEX0YZdjbXHHgNXjGqWqyNwy0U7O7KR/hDXK
	gWRkm8+AfMRoJJBD4VO4XywHNXxoSN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741799754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRKu5YTcDTCg8AtmFssPU8caprER3muD9VjLo3ODo9M=;
	b=JYNXaGrnTWZTvTOtH3oSVrYCGaZgwwRfsCMW8Vpqdjv7V+oD5xMpgVWkiEkou/hn1MBWrs
	Mgpgm5CCmg5+9hBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741799752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRKu5YTcDTCg8AtmFssPU8caprER3muD9VjLo3ODo9M=;
	b=g7a5EjLo/595zLmd7rBa8gfKrLgFtxkhuYapeWZ54Iq4VaIXPHwDE2xlVD5oIjU88YBxXX
	FsC9Y3+acCqSzbB0JEbrp/Od7fnqDzis8fNelNKQVO5lEOkA5appciVwDd9AiGcVqvjnyz
	9KQzC6ECi9P+57+DtSuOh+sD9bb9wSc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741799752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uRKu5YTcDTCg8AtmFssPU8caprER3muD9VjLo3ODo9M=;
	b=8rZnqX5O2vJGiY/YoaWIdSn69lQ5l9tHLpJ9Kcaqtm0YV2jS4DT3Hy3FxQ8sHNt2XRFOhG
	TJGWp+LG9/axgCCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD10E132CB;
	Wed, 12 Mar 2025 17:15:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SycLMkjB0WcxLwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 17:15:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8C288A0908; Wed, 12 Mar 2025 18:15:44 +0100 (CET)
Date: Wed, 12 Mar 2025 18:15:44 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>, 
	linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Baokun Li <libaokun1@huawei.com>, 
	linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <5ygal3ht47dcpftsxxksmk4lid47al2g4xzlbennmtteeqqsed@uswr3gimu3wc>
References: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
 <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87ecz7hcw0.fsf@gmail.com>
 <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87cyergyb1.fsf@gmail.com>
 <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <871pv5cx6v.fsf@gmail.com>
 <bct36ajzi6sardnmc6yz4ot4fbpr654b4k2xz54mrtyje7wofq@qpwzbtctwqnf>
 <Z9GZdSiDL0J80720@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9GZdSiDL0J80720@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org,mit.edu,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Wed 12-03-25 19:56:36, Ojaswin Mujoo wrote:
> On Wed, Mar 12, 2025 at 11:51:03AM +0100, Jan Kara wrote:
> > On Mon 10-03-25 10:13:36, Ritesh Harjani wrote:
> > > Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > > On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
> > > >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > >> > On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
> > > >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > >> >> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> > > >> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > > >> >> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
> > > >> >> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> > > >> >> >> > stress tests, it was observed that in case of some error handling paths, it is
> > > >> >> >> > possible for update_super_work to start a transaction after the journal is
> > > >> >> >> > destroyed eg:
> > > >> >> >> >
> > > >> >> >> > (umount)
> > > >> >> >> > ext4_kill_sb
> > > >> >> >> >   kill_block_super
> > > >> >> >> >     generic_shutdown_super
> > > >> >> >> >       sync_filesystem /* commits all txns */
> > > >> >> >> >       evict_inodes
> > > >> >> >> >         /* might start a new txn */
> > > >> >> >> >       ext4_put_super
> > > >> >> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > > >> >> >> >         jbd2_journal_destroy
> > > >> >> >> >           journal_kill_thread
> > > >> >> >> >             journal->j_flags |= JBD2_UNMOUNT;
> > > >> >> >> >           jbd2_journal_commit_transaction
> > > >> >> >> >             jbd2_journal_get_descriptor_buffer
> > > >> >> >> >               jbd2_journal_bmap
> > > >> >> >> >                 ext4_journal_bmap
> > > >> >> >> >                   ext4_map_blocks
> > > >> >> >> >                     ...
> > > >> >> >> >                     ext4_inode_error
> > > >> >> >> >                       ext4_handle_error
> > > >> >> >> >                         schedule_work(&sbi->s_sb_upd_work)
> > > >> >> >> >
> > > >> >> >> >                                                /* work queue kicks in */
> > > >> >> >> >                                                update_super_work
> > > >> >> >> >                                                  jbd2_journal_start
> > > >> >> >> >                                                    start_this_handle
> > > >> >> >> >                                                      BUG_ON(journal->j_flags &
> > > >> >> >> >                                                             JBD2_UNMOUNT)
> > > >> >> >> >
> > > >> >> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> > > >> >> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
> > > >> >> >> > set. Otherwise, just fallback to an un-journaled commit.
> > > >> >> >> >
> > > >> >> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
> > > >> >> >> > during ext4_put_super() (except a running transaction that will get commited
> > > >> >> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> > > >> >> >> > outside the journal as it won't race with a journaled update (refer
> > > >> >> >> > 2d01ddc86606).
> > > >> >> >> >
> > > >> >> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> > > >> >> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
> > > >> >> >> >
> > > >> >> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > > >> >> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > > >> >> >> > Suggested-by: Jan Kara <jack@suse.cz>
> > > >> >> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > > >> >> >> > ---
> > > >> >> >> >  fs/ext4/ext4.h      | 2 ++
> > > >> >> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
> > > >> >> >> >  fs/ext4/super.c     | 4 +++-
> > > >> >> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
> > > >> >> >> >
> > > >> >> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> > > >> >> >> > index 2b7d781bfcad..d48e93bd5690 100644
> > > >> >> >> > --- a/fs/ext4/ext4.h
> > > >> >> >> > +++ b/fs/ext4/ext4.h
> > > >> >> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> > > >> >> >> >  	 */
> > > >> >> >> >  	struct work_struct s_sb_upd_work;
> > > >> >> >> >  
> > > >> >> >> > +	bool s_journal_destorying;
> > > >> >> >> > +
> > > >> >> >> >  	/* Atomic write unit values in bytes */
> > > >> >> >> >  	unsigned int s_awu_min;
> > > >> >> >> >  	unsigned int s_awu_max;
> > > >> >> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> > > >> >> >> > index 9b3c9df02a39..6bd3ca84410d 100644
> > > >> >> >> > --- a/fs/ext4/ext4_jbd2.h
> > > >> >> >> > +++ b/fs/ext4/ext4_jbd2.h
> > > >> >> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> > > >> >> >> >  {
> > > >> >> >> >  	int err = 0;
> > > >> >> >> >  
> > > >> >> >> > +	/*
> > > >> >> >> > +	 * At this point all pending FS updates should be done except a possible
> > > >> >> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> > > >> >> >> > +	 * is now safe for any new errors to directly commit superblock rather
> > > >> >> >> > +	 * than going via journal.
> > > >> >> >> > +	 */
> > > >> >> >> > +	sbi->s_journal_destorying = true;
> > > >> >> >> 
> > > >> >> >> This is not correct right. I think what we decided to set this flag
> > > >> >> >> before we flush the workqueue. So that we don't schedule any new
> > > >> >> >> work after this flag has been set. At least that is what I understood.
> > > >> >> >> 
> > > >> >> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
> > > >> >> >> 
> > > >> >> >> -ritesh
> > > >> >> >
> > > >> >> > Hey Ritesh,
> > > >> >> >
> > > >> >> > Yes that is not correct, I missed that in my patch however we realised
> > > >> >> > that adding it before flush_work() also has issues [1]. More
> > > >> >> > specifically:
> > > >> >> 
> > > >> >> Ohk. right. 
> > > >> >> 
> > > >> >> >
> > > >> >> >                      **kjournald2**
> > > >> >> >                      jbd2_journal_commit_transaction()
> > > >> >> >                      ...
> > > >> >> >                      ext4_handle_error()
> > > >> >> >                         /* s_journal_destorying is not set */
> > > >> >> >                         if (journal && !s_journal_destorying)
> > > >> >> 
> > > >> >> Then maybe we should not schedule another work to update the superblock
> > > >> >> via journalling, it the error itself occurred while were trying to
> > > >> >> commit the journal txn? 
> > > >> >> 
> > > >> >> 
> > > >> >> -ritesh
> > > >> >
> > > >> > Hmm, ideally yes that should not happen, but how can we achieve that?
> > > >> > For example with the trace we saw:
> > > >> >
> > > >> >    **kjournald2**
> > > >> >    jbd2_journal_commit_transaction()
> > > >> >      jbd2_journal_get_descriptor_buffer
> > > >> >        jbd2_journal_bmap
> > > >> >          ext4_journal_bmap
> > > >> >            ext4_map_blocks
> > > >> >              ...
> > > >> >              ext4_inode_error
> > > >> >                ext4_handle_error
> > > >> >                  schedule_work(&sbi->s_sb_upd_work)
> > > >> >
> > > >> > How do we tell ext4_handle_error that it is in the context of a
> > > >> > committing txn.
> > 
> > So I was thinking about this. It is not a problem to determine we are
> > running in kjournald context - it is enough to check
> > 
> > 	current == EXT4_SB(sb)->s_journal->j_task
> 
> Oh, right :) 
> 
> > 
> > But I'm not sure checking this in ext4_handle_error() and doing direct sb
> > update instead of scheduling a journalled one is always correct. For
> > example kjournald does also writeback of ordered data and if that hits an
> > error, we do not necessarily abort the journal (well, currently we do as
> > far as I'm checking but it seems a bit fragile to rely on this).
> 
> Okay so IIUC your concern is there might be some codepaths, now or in
> the future, where kjournald might call the FS layer, hit an error and
> still decide to not abort. In which case we would still want to update
> the sb via journal.

Yeah. The reason why I'm a bit concerned about it is mostly the case of
kjournald also handling ordered data and situations like
!(journal->j_flags & JBD2_ABORT_ON_SYNCDATA_ERR) where people want to
continue although ordered data had issues. Or situations where something in
j_commit_callback or another jbd2 hook ends up calling ext4_error()...

> > static void ext4_journal_destroy(struct super_block *sb)
> > {
> > 	/*
> > 	 * At this point only two things can be operating on the journal.
> > 	 * JBD2 thread performing transaction commit and s_sb_upd_work
> > 	 * issuing sb update through the journal. Once we set
> > 	 * EXT4_FLAGS_JOURNAL_DESTROY, new ext4_handle_error() calls will not
> > 	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
> > 	 * ext4_handle_error() calls from the running transaction commit are
> > 	 * finished. Hence no new s_sb_upd_work can be queued after we
> > 	 * flush it here.
> > 	 */
> > 	set_bit(EXT4_FLAGS_JOURNAL_DESTROY, &EXT4_SB(sb)->s_ext4_flags);
> 
> Offtopic, how are s_ext4_flags different from s_mount_flags, since in a
> draft patchset for this, I am using:
> 
> 	ext4_set_mount_flag(sbi->s_sb, EXT4_JBD2_DESTORYING);
> 
> so just curious.

I don't think there's a difference and I think we can unify them. For now
pick whatever you like :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

