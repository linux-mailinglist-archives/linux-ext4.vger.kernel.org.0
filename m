Return-Path: <linux-ext4+bounces-6772-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B286DA5DAE1
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 11:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C744D17321A
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Mar 2025 10:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E311D63FF;
	Wed, 12 Mar 2025 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYaA7A91";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLaF5k/8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cYaA7A91";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLaF5k/8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC68215853B
	for <linux-ext4@vger.kernel.org>; Wed, 12 Mar 2025 10:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741776672; cv=none; b=ueSTHleuBRE9aEDGppVwjklLHmMGn+6Ql/9BXMfCicnwS1SMp2ev/SGKHuw8yhNc+K7zeWojzbil8sG+F6ntkRxK9qY4QVe8eUz35YalPtlLr9GCi+ljoyykgVJjoHA8guWVrHco3VojGhbZCiHoq6qxJ5tvlDJLU8AXuGKsENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741776672; c=relaxed/simple;
	bh=E5bg+GLYVKpHYRKr5lfXct1sUfJCZ9dFFUkXW6fB0jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITrSDJyaDbe2eD3IcQ6FphSq6rtLmvra4StQ4hoX/JmQHJYSyqc9V0g/lya151fIwsdwO/HqoqPcVomQ+1B0SObZhbTz09rfvkczpFzbXnH4iQ7ZObUhMN+V6+CzwpNkhPiGcxlh9pXvh/PHtMQuFdLlVT8Jdb+k9J+IKsLAM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYaA7A91; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLaF5k/8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cYaA7A91; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLaF5k/8; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B296421134;
	Wed, 12 Mar 2025 10:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741776667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZmcVXPZ7+TXW24PsEAaSx1n69dwWK+qUZeeM3lHsqU=;
	b=cYaA7A91xWHXxdl9U7K633S4EYQnKQmiCdOKZluqgk//Bc/WePa7cKqBLwFmgPqlBVsqFP
	D8ODmChTV343NLqBj5jYpzWcpoUhWt0mNuTlia9aXgjk22Ga5BBOr/MHRJorpef7u/+aBn
	PBS/J+8g4azRjbr5JAI3pLMN3aRDl6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741776667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZmcVXPZ7+TXW24PsEAaSx1n69dwWK+qUZeeM3lHsqU=;
	b=jLaF5k/8VgjHU2tWUTL7ITjp9U8k1pbPZNZp82brEyj8XoelbF/qfnnKJAY3Xo/P9xCYIq
	C9u2ORj77/49XFCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cYaA7A91;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="jLaF5k/8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741776667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZmcVXPZ7+TXW24PsEAaSx1n69dwWK+qUZeeM3lHsqU=;
	b=cYaA7A91xWHXxdl9U7K633S4EYQnKQmiCdOKZluqgk//Bc/WePa7cKqBLwFmgPqlBVsqFP
	D8ODmChTV343NLqBj5jYpzWcpoUhWt0mNuTlia9aXgjk22Ga5BBOr/MHRJorpef7u/+aBn
	PBS/J+8g4azRjbr5JAI3pLMN3aRDl6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741776667;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZmcVXPZ7+TXW24PsEAaSx1n69dwWK+qUZeeM3lHsqU=;
	b=jLaF5k/8VgjHU2tWUTL7ITjp9U8k1pbPZNZp82brEyj8XoelbF/qfnnKJAY3Xo/P9xCYIq
	C9u2ORj77/49XFCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3901132CB;
	Wed, 12 Mar 2025 10:51:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3vbrJxtn0Wf/LgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 12 Mar 2025 10:51:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5F86DA08CF; Wed, 12 Mar 2025 11:51:03 +0100 (CET)
Date: Wed, 12 Mar 2025 11:51:03 +0100
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org, 
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, 
	linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <bct36ajzi6sardnmc6yz4ot4fbpr654b4k2xz54mrtyje7wofq@qpwzbtctwqnf>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <87ldtfhmo7.fsf@gmail.com>
 <Z8xAmyICsNlln4Y3@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87ecz7hcw0.fsf@gmail.com>
 <Z8xbLrdN3L1E50-G@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <87cyergyb1.fsf@gmail.com>
 <Z82EjcExRMc8nz2v@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <871pv5cx6v.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871pv5cx6v.fsf@gmail.com>
X-Rspamd-Queue-Id: B296421134
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,vger.kernel.org,mit.edu,suse.cz,huawei.com,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Mon 10-03-25 10:13:36, Ritesh Harjani wrote:
> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> > On Sun, Mar 09, 2025 at 12:11:22AM +0530, Ritesh Harjani wrote:
> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> >> > On Sat, Mar 08, 2025 at 06:56:23PM +0530, Ritesh Harjani wrote:
> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> >> >> > On Sat, Mar 08, 2025 at 03:25:04PM +0530, Ritesh Harjani (IBM) wrote:
> >> >> >> Ojaswin Mujoo <ojaswin@linux.ibm.com> writes:
> >> >> >> > Presently we always BUG_ON if trying to start a transaction on a journal marked
> >> >> >> > with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> >> >> >> > stress tests, it was observed that in case of some error handling paths, it is
> >> >> >> > possible for update_super_work to start a transaction after the journal is
> >> >> >> > destroyed eg:
> >> >> >> >
> >> >> >> > (umount)
> >> >> >> > ext4_kill_sb
> >> >> >> >   kill_block_super
> >> >> >> >     generic_shutdown_super
> >> >> >> >       sync_filesystem /* commits all txns */
> >> >> >> >       evict_inodes
> >> >> >> >         /* might start a new txn */
> >> >> >> >       ext4_put_super
> >> >> >> > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> >> >> >> >         jbd2_journal_destroy
> >> >> >> >           journal_kill_thread
> >> >> >> >             journal->j_flags |= JBD2_UNMOUNT;
> >> >> >> >           jbd2_journal_commit_transaction
> >> >> >> >             jbd2_journal_get_descriptor_buffer
> >> >> >> >               jbd2_journal_bmap
> >> >> >> >                 ext4_journal_bmap
> >> >> >> >                   ext4_map_blocks
> >> >> >> >                     ...
> >> >> >> >                     ext4_inode_error
> >> >> >> >                       ext4_handle_error
> >> >> >> >                         schedule_work(&sbi->s_sb_upd_work)
> >> >> >> >
> >> >> >> >                                                /* work queue kicks in */
> >> >> >> >                                                update_super_work
> >> >> >> >                                                  jbd2_journal_start
> >> >> >> >                                                    start_this_handle
> >> >> >> >                                                      BUG_ON(journal->j_flags &
> >> >> >> >                                                             JBD2_UNMOUNT)
> >> >> >> >
> >> >> >> > Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> >> >> >> > destroying only do a journaled (and deferred) update of sb if this flag is not
> >> >> >> > set. Otherwise, just fallback to an un-journaled commit.
> >> >> >> >
> >> >> >> > We set sbi->s_journal_destroying = true only after all the FS updates are done
> >> >> >> > during ext4_put_super() (except a running transaction that will get commited
> >> >> >> > during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> >> >> >> > outside the journal as it won't race with a journaled update (refer
> >> >> >> > 2d01ddc86606).
> >> >> >> >
> >> >> >> > Also, we don't need a similar check in ext4_grp_locked_error since it is only
> >> >> >> > called from mballoc and AFAICT it would be always valid to schedule work here.
> >> >> >> >
> >> >> >> > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> >> >> >> > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> >> >> >> > Suggested-by: Jan Kara <jack@suse.cz>
> >> >> >> > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> >> >> >> > ---
> >> >> >> >  fs/ext4/ext4.h      | 2 ++
> >> >> >> >  fs/ext4/ext4_jbd2.h | 8 ++++++++
> >> >> >> >  fs/ext4/super.c     | 4 +++-
> >> >> >> >  3 files changed, 13 insertions(+), 1 deletion(-)
> >> >> >> >
> >> >> >> > diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> >> >> >> > index 2b7d781bfcad..d48e93bd5690 100644
> >> >> >> > --- a/fs/ext4/ext4.h
> >> >> >> > +++ b/fs/ext4/ext4.h
> >> >> >> > @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
> >> >> >> >  	 */
> >> >> >> >  	struct work_struct s_sb_upd_work;
> >> >> >> >  
> >> >> >> > +	bool s_journal_destorying;
> >> >> >> > +
> >> >> >> >  	/* Atomic write unit values in bytes */
> >> >> >> >  	unsigned int s_awu_min;
> >> >> >> >  	unsigned int s_awu_max;
> >> >> >> > diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> >> >> >> > index 9b3c9df02a39..6bd3ca84410d 100644
> >> >> >> > --- a/fs/ext4/ext4_jbd2.h
> >> >> >> > +++ b/fs/ext4/ext4_jbd2.h
> >> >> >> > @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
> >> >> >> >  {
> >> >> >> >  	int err = 0;
> >> >> >> >  
> >> >> >> > +	/*
> >> >> >> > +	 * At this point all pending FS updates should be done except a possible
> >> >> >> > +	 * running transaction (which will commit in jbd2_journal_destroy). It
> >> >> >> > +	 * is now safe for any new errors to directly commit superblock rather
> >> >> >> > +	 * than going via journal.
> >> >> >> > +	 */
> >> >> >> > +	sbi->s_journal_destorying = true;
> >> >> >> 
> >> >> >> This is not correct right. I think what we decided to set this flag
> >> >> >> before we flush the workqueue. So that we don't schedule any new
> >> >> >> work after this flag has been set. At least that is what I understood.
> >> >> >> 
> >> >> >> [1]: https://lore.kernel.org/all/87eczc6rlt.fsf@gmail.com/
> >> >> >> 
> >> >> >> -ritesh
> >> >> >
> >> >> > Hey Ritesh,
> >> >> >
> >> >> > Yes that is not correct, I missed that in my patch however we realised
> >> >> > that adding it before flush_work() also has issues [1]. More
> >> >> > specifically:
> >> >> 
> >> >> Ohk. right. 
> >> >> 
> >> >> >
> >> >> >                      **kjournald2**
> >> >> >                      jbd2_journal_commit_transaction()
> >> >> >                      ...
> >> >> >                      ext4_handle_error()
> >> >> >                         /* s_journal_destorying is not set */
> >> >> >                         if (journal && !s_journal_destorying)
> >> >> 
> >> >> Then maybe we should not schedule another work to update the superblock
> >> >> via journalling, it the error itself occurred while were trying to
> >> >> commit the journal txn? 
> >> >> 
> >> >> 
> >> >> -ritesh
> >> >
> >> > Hmm, ideally yes that should not happen, but how can we achieve that?
> >> > For example with the trace we saw:
> >> >
> >> >    **kjournald2**
> >> >    jbd2_journal_commit_transaction()
> >> >      jbd2_journal_get_descriptor_buffer
> >> >        jbd2_journal_bmap
> >> >          ext4_journal_bmap
> >> >            ext4_map_blocks
> >> >              ...
> >> >              ext4_inode_error
> >> >                ext4_handle_error
> >> >                  schedule_work(&sbi->s_sb_upd_work)
> >> >
> >> > How do we tell ext4_handle_error that it is in the context of a
> >> > committing txn.

So I was thinking about this. It is not a problem to determine we are
running in kjournald context - it is enough to check

	current == EXT4_SB(sb)->s_journal->j_task

But I'm not sure checking this in ext4_handle_error() and doing direct sb
update instead of scheduling a journalled one is always correct. For
example kjournald does also writeback of ordered data and if that hits an
error, we do not necessarily abort the journal (well, currently we do as
far as I'm checking but it seems a bit fragile to rely on this).

So I'd rather keep the solution for these umount issues specific to the
umount path. What if we did:

static void ext4_journal_destroy(struct super_block *sb)
{
	/*
	 * At this point only two things can be operating on the journal.
	 * JBD2 thread performing transaction commit and s_sb_upd_work
	 * issuing sb update through the journal. Once we set
	 * EXT4_FLAGS_JOURNAL_DESTROY, new ext4_handle_error() calls will not
	 * queue s_sb_upd_work and ext4_force_commit() makes sure any
	 * ext4_handle_error() calls from the running transaction commit are
	 * finished. Hence no new s_sb_upd_work can be queued after we
	 * flush it here.
	 */
	set_bit(EXT4_FLAGS_JOURNAL_DESTROY, &EXT4_SB(sb)->s_ext4_flags);
	ext4_force_commit(sb);
	flush_work(&EXT4_SB(sb)->s_sb_upd_work);
	jbd2_journal_destroy(EXT4_SB(sb)->s_journal);
}

And then add the check to ext4_handle_error():

                /*
                 * In case the fs should keep running, we need to writeout
                 * superblock through the journal. Due to lock ordering
                 * constraints, it may not be safe to do it right here so we
-		 * defer superblock flushing to a workqueue.
+		 * defer superblock flushing to a workqueue. We just need
+		 * to be careful when the journal is already shutting down.
+		 * If we get here in that case, just update the sb directly
+		 * as the last transaction won't commit anyway.
                 */
-		if (continue_fs && journal)
+		if (continue_fs && journal &&
+		    !test_bit(EXT4_FLAGS_JOURNAL_DESTROY,
+			      &EXT4_SB(sb)->s_ext4_flags))
			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
		else
			ext4_commit_super(sb);

What do people think about this? Am I missing some possible race?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

