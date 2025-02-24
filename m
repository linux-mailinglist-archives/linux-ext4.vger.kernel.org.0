Return-Path: <linux-ext4+bounces-6542-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A20A4257D
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 16:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC4BA4457A5
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2025 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031D517B50B;
	Mon, 24 Feb 2025 14:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbnGiZmU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cWRaYggq";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="IbnGiZmU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cWRaYggq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAC61B7F4
	for <linux-ext4@vger.kernel.org>; Mon, 24 Feb 2025 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408724; cv=none; b=ZUS+QaXkgQy10OMXpNeGinBb836hD5LsMJNlzmQ9KcJAq6Jqaoti3NDt/UI2q0gPTIDO7Fk7fbap7o9qspnlOCxJNV4SB2HkYoizXx51+HumcK2VFvwjnaRJb99PI0WGgzRBMbMWyXAyvFQwU16/U7O9x3BXg2hZNWfMQYcJA1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408724; c=relaxed/simple;
	bh=N0rAj0CwYfuQupwASK4RYBKzzj3tcT+p74zaGCG9lSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNdIY6OlEKihlz5pt4MumnMCwRij8NN+pXa5/486EqD675vIFakfxQQtWZU+/8nmD4Lo5Bki6sivNsra9rJky7ztsT4aLLMBApzg53VK8FBQb5BVU8GQmXVjLbPA7GOOp/vOxYvpSaQ+ujWeWLS6NGAQK10nGMHAw5qu2MUd0po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbnGiZmU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cWRaYggq; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=IbnGiZmU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cWRaYggq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0D5E71F45A;
	Mon, 24 Feb 2025 14:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740408721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98Ess9Xi9Tt/i1CFWqq9z57i+lTRznXPlwccb0kNr/I=;
	b=IbnGiZmUMN5hy7ayozyKKM2kBLIdW/OXDtlEWZBb8S/2l4naiNg1TdLvd971odH920ZHrq
	E3TA0V2Tol0z+3K2jmsshBDTR0CWg3IXEihsMkoHLb50dx1cK8Wc5aYUcmkb9WWXeGz9gs
	CVQc/YtCmX68giIIS26T8LzX34JeqnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740408721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98Ess9Xi9Tt/i1CFWqq9z57i+lTRznXPlwccb0kNr/I=;
	b=cWRaYggq8nRVifyQgDFZ51ttd02Up/o0+x+Yt0EySL7aCkhs5SmMqKqpOOeubGDpM0UZGp
	5+HG3x3INgwreiBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1740408721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98Ess9Xi9Tt/i1CFWqq9z57i+lTRznXPlwccb0kNr/I=;
	b=IbnGiZmUMN5hy7ayozyKKM2kBLIdW/OXDtlEWZBb8S/2l4naiNg1TdLvd971odH920ZHrq
	E3TA0V2Tol0z+3K2jmsshBDTR0CWg3IXEihsMkoHLb50dx1cK8Wc5aYUcmkb9WWXeGz9gs
	CVQc/YtCmX68giIIS26T8LzX34JeqnM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1740408721;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98Ess9Xi9Tt/i1CFWqq9z57i+lTRznXPlwccb0kNr/I=;
	b=cWRaYggq8nRVifyQgDFZ51ttd02Up/o0+x+Yt0EySL7aCkhs5SmMqKqpOOeubGDpM0UZGp
	5+HG3x3INgwreiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 02B6C13332;
	Mon, 24 Feb 2025 14:52:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fKelAJGHvGdVTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 24 Feb 2025 14:52:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AF040A0785; Mon, 24 Feb 2025 15:52:00 +0100 (CET)
Date: Mon, 24 Feb 2025 15:52:00 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, 
	Mahesh Kumar <maheshkumar657g@gmail.com>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH 1/2] ext4: only defer sb update on error if SB_ACTIVE
Message-ID: <jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl>
References: <cover.1740212945.git.ojaswin@linux.ibm.com>
 <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da8af2e5170f0d94031b812d7d50c6ec1967db1b.1740212945.git.ojaswin@linux.ibm.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Sat 22-02-25 14:10:22, Ojaswin Mujoo wrote:
> Presently we always BUG_ON if trying to start a transaction on a journal
> marked with JBD2_UNMOUNT, since this should never happen. However while
> running stress tests it was observed that in case of some error handling
> paths, it is possible for update_super_work to start a transaction after
> the journal is destroyed eg:
> 
> (umount)
> ext4_kill_sb
>   kill_block_super
>     generic_shutdown_super
>       sync_filesystem /* commits all txns */
>       evict_inodes
>         /* might start a new txn */
>       ext4_put_super
> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>         jbd2_journal_destroy
>           journal_kill_thread
>             journal->j_flags |= JBD2_UNMOUNT;
>           jbd2_journal_commit_transaction
>             jbd2_journal_get_descriptor_buffer
>               jbd2_journal_bmap
>                 ext4_journal_bmap
>                   ext4_map_blocks
>                     ...
>                     ext4_inode_error
>                       ext4_handle_error
>                         schedule_work(&sbi->s_sb_upd_work)
> 
>                                                /* work queue kicks in */
>                                                update_super_work
>                                                  jbd2_journal_start
>                                                    start_this_handle
>                                                      BUG_ON(journal->j_flags &
>                                                             JBD2_UNMOUNT)
> 
> Hence, make sure we only defer the update of ext4 sb if the sb is still
> active.  Otherwise, just fallback to an un-journaled commit.
> 
> The important thing to note here is that we must only defer sb update if
> we have not yet flushed the s_sb_update_work queue in umount path else
> this race can be hit (point 1 below). Since we don't have a direct way
> to check for that we use SB_ACTIVE instead. The SB_ACTIVE check is a bit
> subtle so adding some notes below for future reference:
> 
> 1. Ideally we would want to have a something like (flags & JBD2_UNMOUNT
> == 0) however this is not correct since we could end up scheduling work
> after it has been flushed:
> 
>  ext4_put_super
>   flush_work(&sbi->s_sb_upd_work)
> 
>                            **kjournald2**
>                            jbd2_journal_commit_transaction
>                            ...
>                            ext4_inode_error
>                              /* JBD2_UNMOUNT not set */
>                              schedule_work(s_sb_upd_work)
> 
>    jbd2_journal_destroy
>     journal->j_flags |= JBD2_UNMOUNT;
> 
>                                       **workqueue**
>                                       update_super_work
>                                        jbd2_journal_start
>                                         start_this_handle
>                                           BUG_ON(JBD2_UNMOUNT)
> 
> Something like the above doesn't happen with SB_ACTIVE check because we
> are sure that the workqueue would be flushed at a later point if we are
> in the umount path.
> 
> 2. We don't need a similar check in ext4_grp_locked_error since it is
> only called from mballoc and AFAICT it would be always valid to schedule
> work here.
> 
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Suggested-by: Ritesh Harjani <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Good catch! But I think the solution will have to be slightly different.
Basing the check on SB_ACTIVE has the problem that you can have racing
updates of the sb in the still running transaction and in your direct
update leading to inconsistencies after a crash (that was the reason why
we've created the s_sb_upd_work in the first place).

I would solve this by implementing something like
ext4_update_sb_destroy_journal() which will set a flag in sbi, flush the
workqueue, and then destroy the journal. And ext4_handle_error() will check
for the sbi flag.

								Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index a963ffda692a..b7341e9acf62 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -706,7 +706,7 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
>  		 * constraints, it may not be safe to do it right here so we
>  		 * defer superblock flushing to a workqueue.
>  		 */
> -		if (continue_fs && journal)
> +		if (continue_fs && journal && (sb->s_flags & SB_ACTIVE))
>  			schedule_work(&EXT4_SB(sb)->s_sb_upd_work);
>  		else
>  			ext4_commit_super(sb);
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

