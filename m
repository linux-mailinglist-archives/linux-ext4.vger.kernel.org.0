Return-Path: <linux-ext4+bounces-6657-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F34FA4DA53
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 11:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AF4816379C
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 10:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B951FE479;
	Tue,  4 Mar 2025 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/0XQg+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PvNeFq+3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c/0XQg+a";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PvNeFq+3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB3D42052
	for <linux-ext4@vger.kernel.org>; Tue,  4 Mar 2025 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083914; cv=none; b=WrsPe9tRV8fZ2f1GDIA8/zcfRfdMNfgZbhjL5Zoe3nn282Q72WYBU2fzJI3JT3hxywN+ZMopsHXskpBpX8v7dNSx6YRkkxp9mCu0lgIoBpsAkh5lqkL3SRYJSAXSw8b7dj0hDTFqvvxlmC4lvTEVKAIYEO8Bk7yW08NvMOyR7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083914; c=relaxed/simple;
	bh=NOqUHW3seFZh2YWGuldOAPfbkkldfc4a6Bb5Se6eYWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQ5eSUecY8sfKuyxTSbPQnqfAtQHUjjW5FPxjcEEvW5fW/y6f1mGY3P1yG/ao/n6DSkfBUI2vyQ2AmmdLUbi58lxlKUNYJAwzsjwW2y5mcK2S8mpF+KnNOSn2rFl/FdD9A/kt9efEf+YGllJeeaUI1jrlB5LVnJHgxMDvCjGx5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/0XQg+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PvNeFq+3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c/0XQg+a; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PvNeFq+3; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DF6CA1F794;
	Tue,  4 Mar 2025 10:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741083910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mt5Xdk0hLLgIZnGakwHfLJtpB/VOQ+i2AED5LN1h2g=;
	b=c/0XQg+arthzpOTJopGrMcbvVvHGZ4DiXAO3V9mcG92B3VmbBXWjN+YtBSD2I7gl4HQxae
	3n3v2/l6C7T80ChGDpsToYCcQ0P1StIEe4axRy7YubfopDRTsqaHle22ShP39DjvHP6Wsj
	/ZjXXuCvDTb9g80JfwG8wKVFbumioWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741083910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mt5Xdk0hLLgIZnGakwHfLJtpB/VOQ+i2AED5LN1h2g=;
	b=PvNeFq+3+8oYM/B+1r50dG37p+gzafWHg5ukj+SynQu6LiGgJbZIuTOPe5KxZip5gK8K9x
	0kLFKChKdPTarcDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741083910; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mt5Xdk0hLLgIZnGakwHfLJtpB/VOQ+i2AED5LN1h2g=;
	b=c/0XQg+arthzpOTJopGrMcbvVvHGZ4DiXAO3V9mcG92B3VmbBXWjN+YtBSD2I7gl4HQxae
	3n3v2/l6C7T80ChGDpsToYCcQ0P1StIEe4axRy7YubfopDRTsqaHle22ShP39DjvHP6Wsj
	/ZjXXuCvDTb9g80JfwG8wKVFbumioWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741083910;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4Mt5Xdk0hLLgIZnGakwHfLJtpB/VOQ+i2AED5LN1h2g=;
	b=PvNeFq+3+8oYM/B+1r50dG37p+gzafWHg5ukj+SynQu6LiGgJbZIuTOPe5KxZip5gK8K9x
	0kLFKChKdPTarcDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F051393C;
	Tue,  4 Mar 2025 10:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 36+5MwbVxmezYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Mar 2025 10:25:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96FBAA0921; Tue,  4 Mar 2025 11:25:02 +0100 (CET)
Date: Tue, 4 Mar 2025 11:25:02 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, 
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org, 
	Mahesh Kumar <maheshkumar657g@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <mpm3x7uonxoc73lgva72vaiydc76cmr5niapm45ipk6ts5voab@e7zundhoui6i>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
 <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl>
 <Z8BKdo5IAHJRdMkp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8BKdo5IAHJRdMkp@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 27-02-25 16:50:22, Ojaswin Mujoo wrote:
> On Mon, Feb 24, 2025 at 03:52:00PM +0100, Jan Kara wrote:
> > On Sat 22-02-25 14:10:22, Ojaswin Mujoo wrote:
> > > Presently we always BUG_ON if trying to start a transaction on a journal
> > > marked with JBD2_UNMOUNT, since this should never happen. However while
> > > running stress tests it was observed that in case of some error handling
> > > paths, it is possible for update_super_work to start a transaction after
> > > the journal is destroyed eg:
> > > 
> > > (umount)
> > > ext4_kill_sb
> > >   kill_block_super
> > >     generic_shutdown_super
> > >       sync_filesystem /* commits all txns */
> > >       evict_inodes
> > >         /* might start a new txn */
> > >       ext4_put_super
> > > 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
> > >         jbd2_journal_destroy
> > >           journal_kill_thread
> > >             journal->j_flags |= JBD2_UNMOUNT;
> > >           jbd2_journal_commit_transaction
> > >             jbd2_journal_get_descriptor_buffer
> > >               jbd2_journal_bmap
> > >                 ext4_journal_bmap
> > >                   ext4_map_blocks
> > >                     ...
> > >                     ext4_inode_error
> > >                       ext4_handle_error
> > >                         schedule_work(&sbi->s_sb_upd_work)
> > > 
> > >                                                /* work queue kicks in */
> > >                                                update_super_work
> > >                                                  jbd2_journal_start
> > >                                                    start_this_handle
> > >                                                      BUG_ON(journal->j_flags &
> > >                                                             JBD2_UNMOUNT)
> > > 
> > > Hence, make sure we only defer the update of ext4 sb if the sb is still
> > > active.  Otherwise, just fallback to an un-journaled commit.
> > > 
> > > The important thing to note here is that we must only defer sb update if
> > > we have not yet flushed the s_sb_update_work queue in umount path else
> > > this race can be hit (point 1 below). Since we don't have a direct way
> > > to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
> > > subtle so adding some notes below for future reference:
> > > 
> > > 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
> > > == 0) however this is not correct since we could end up scheduling work
> > > after it has been flushed:
> > > 
> > >  ext4_put_super
> > >   flush_work(&sbi->s_sb_upd_work)
> > > 
> > >                            **kjournald2**
> > >                            jbd2_journal_commit_transaction
> > >                            ...
> > >                            ext4_inode_error
> > >                              /* JBD2_UNMOUNT not set */
> > >                              schedule_work(s_sb_upd_work)
> > > 
> > >    jbd2_journal_destroy
> > >     journal->j_flags |= JBD2_UNMOUNT;
> > > 
> > >                                       **workqueue**
> > >                                       update_super_work
> > >                                        jbd2_journal_start
> > >                                         start_this_handle
> > >                                           BUG_ON(JBD2_UNMOUNT)
> > > 
> > > Something like the above doesn't happen with SB_ACTIVE check because we
> > > are sure that the workqueue would be flushed at a later point if we are
> > > in the umount path.
> > > 
> > > 2. We don't need a similar check in ext4_grp_locked_error since it is
> > > only called from mballoc and AFAICT it would be always valid to schedule
> > > work here.
> > > 
> > > Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> > > Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> > > Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
> > > Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> > 
> > Good catch! But I think the solution will have to be slightly different.
> > Basing the check on SB_ACTIVE has the problem that you can have racing
> > updates of the sb in the still running transaction and in your direct
> > update leading to inconsistencies after a crash (that was the reason why
> > we've created the s_sb_upd_work in the first place).
> > 
> > I would solve this by implementing something like
> > ext4_update_sb_destroy_journal() which will set a flag in sbi, flush the
> > workqueue, and then destroy the journal. And ext4_handle_error() will check
> > for the sbi flag.
> > 
> > 								Honza
> 
> Hey Jan,
> 
> Thanks for the review. So earlier I did go through different code paths to see
> if we will have a direct sb write clash with a journalled one it wouldn't but,
> relooking at it, seems like we might have a scenario as follows:
> 
> generic_super_shutdown
>  sync_filesytems
>   /* running txns committed. executing ext4_journal_commit_callback */
>   ext4_maybe_update_superblock
>    /* schedules work */
>    schedule_work(&sbi->s_sb_upd_work)
>                                           update_super_work
>                                           /* start a txn and add sb to it */
>  sb->s_flags &= ~SB_ACTIVE;
>  evict_inode
>    ext4_evict_inode
>     ext4_std_error
>      ext4_handle_error
>       /* direct commit of sb (Not good!) */
> 
> 
> Now with the 'setting the flag in sbi' approach, I'm not sure if that will be
> enough to handle this as well. For example, if we add a flag like
> sbi->s_journal_destroying, then:
> 
> ext4_put_super
>  sbi->s_journal_destroying = true
>  flush_workqueue()
>   /* sb is now journalled */
>  jbd2_journal_destory
>   jbd2_journal_commit_transaction
>    /* add tag for sb in descriptor and add buffer to wbufs[] */
>    /* Later from some other buffer in the txn: */
>    jbd2_journal_next_log_block
>     /* hits error in ext4_journal_bmap */
>     ext4_handle_error
>       sbi->s_journal_destroying == true
>       /* update and commit sb directly causing a checksum mismatch b/w entry in descriptor */
>    jbd2_journal_abort
>    /* after abort everything in wbufs[] is written to journal */
> 
> In the above we will have a checksum mismatch but then maybe its not really
> an issue. Maybe since we never commit the txn it is understood that the contents
> can't be trusted and it should be fine to have a mismatch b/w the decriptor tag
> and the actual super block contents? In which case the sbi flag approach should
> be fine.
> 
> Does my understanding sound correct?

Yes. Since the transaction does not get committed, its contents will be
(and must be) ignored. So although you are correct that the superblock
content in the transaction need to match the content we write directly, it
does not matter because whatever is in the uncommitted transaction must
never be written to the final position on disk.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

