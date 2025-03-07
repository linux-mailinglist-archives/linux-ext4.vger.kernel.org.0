Return-Path: <linux-ext4+bounces-6711-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DD9A56A53
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 15:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620063AA414
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Mar 2025 14:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8077821B91D;
	Fri,  7 Mar 2025 14:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhQHhyMi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ymmHkVD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EhQHhyMi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ymmHkVD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7E664C6
	for <linux-ext4@vger.kernel.org>; Fri,  7 Mar 2025 14:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357618; cv=none; b=WW9jYqC0AXsaSJKd6MkRhThMujL51exjghJKyN/mUs7+6rBdVb0mGlxwLYW8EXagfrM0mhMwGef5/4vBu2rL+kCNqmpmfTepRY21XfQ5whOj5CQ4Bu2euVDtlMecPY6TT5tTA68qV+HrSQgWEy0tGOGFeOqNKepO/SlM/+XupMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357618; c=relaxed/simple;
	bh=h4bpISeEZ/keczAPwR0YhUNXcrsmtOuxYAI3ufbC4jk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtKNcxp+N0mYqNG0tvuoGJaaRnqmZlh7nV7XyR8Icy1ffT2r6XOukR/zef86P8dvijfgwb4Qsa1Z7iQEbsIrNowm9PbIuhRnsgXFac8LnLuqilzOqFx9U4VtcK8N7EueJcrc7oIwJTUU1ozGiq0OZYaOM7SLHvo5pQrVw+NOLxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhQHhyMi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ymmHkVD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EhQHhyMi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ymmHkVD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5E6EE21186;
	Fri,  7 Mar 2025 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741357614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cizMMiZiPnh7KzSLZq60GxWWDgcapftsvCLiX48cH4k=;
	b=EhQHhyMigkFOhnM0vMFeU3X7s2BOok0fCo7RPa5IgAKFEn2SOoc1aZn6f+rmckCZK2pgFQ
	gE1d7iiLIcBGZ5lMB8cyWWhc4dPKZjs3LUWHV/5rfdwJQ3bvyYk1Ex196cDBFqLuHkJ3Su
	63LozrxkRJ6VZP8O/u9zsQRWIGIb+SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741357614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cizMMiZiPnh7KzSLZq60GxWWDgcapftsvCLiX48cH4k=;
	b=4ymmHkVDrK5iidRoaeLTyXI43Ev55oChP6WQaVGnmQCWfD/F1FzZn3bXCuBA7GFn1RJYpU
	Nkrnu1e7bBcKQMAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EhQHhyMi;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4ymmHkVD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741357614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cizMMiZiPnh7KzSLZq60GxWWDgcapftsvCLiX48cH4k=;
	b=EhQHhyMigkFOhnM0vMFeU3X7s2BOok0fCo7RPa5IgAKFEn2SOoc1aZn6f+rmckCZK2pgFQ
	gE1d7iiLIcBGZ5lMB8cyWWhc4dPKZjs3LUWHV/5rfdwJQ3bvyYk1Ex196cDBFqLuHkJ3Su
	63LozrxkRJ6VZP8O/u9zsQRWIGIb+SE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741357614;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cizMMiZiPnh7KzSLZq60GxWWDgcapftsvCLiX48cH4k=;
	b=4ymmHkVDrK5iidRoaeLTyXI43Ev55oChP6WQaVGnmQCWfD/F1FzZn3bXCuBA7GFn1RJYpU
	Nkrnu1e7bBcKQMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56B7513939;
	Fri,  7 Mar 2025 14:26:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u4ArFS4Cy2eGKwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 07 Mar 2025 14:26:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17D97A087F; Fri,  7 Mar 2025 15:26:54 +0100 (CET)
Date: Fri, 7 Mar 2025 15:26:54 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, 
	Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <3y7za2sfohzeifijsnlxdp7zb7vfkltjgeqcca57tw6uqzlxtt@hngy3b6up3ch>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
X-Rspamd-Queue-Id: 5E6EE21186
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,huawei.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 06-03-25 19:58:33, Ojaswin Mujoo wrote:
> Presently we always BUG_ON if trying to start a transaction on a journal marked
> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
> stress tests, it was observed that in case of some error handling paths, it is
> possible for update_super_work to start a transaction after the journal is
> destroyed eg:
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
> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
> destroying only do a journaled (and deferred) update of sb if this flag is not
> set. Otherwise, just fallback to an un-journaled commit.
> 
> We set sbi->s_journal_destroying = true only after all the FS updates are done
> during ext4_put_super() (except a running transaction that will get commited
> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
> outside the journal as it won't race with a journaled update (refer
> 2d01ddc86606).
> 
> Also, we don't need a similar check in ext4_grp_locked_error since it is only
> called from mballoc and AFAICT it would be always valid to schedule work here.
> 
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/ext4.h      | 2 ++
>  fs/ext4/ext4_jbd2.h | 8 ++++++++
>  fs/ext4/super.c     | 4 +++-
>  3 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 2b7d781bfcad..d48e93bd5690 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>  	 */
>  	struct work_struct s_sb_upd_work;
>  
> +	bool s_journal_destorying;
> +

Not that it would matter much but why not make this a flag in
sbi->s_mount_flags?

> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
> index 9b3c9df02a39..6bd3ca84410d 100644
> --- a/fs/ext4/ext4_jbd2.h
> +++ b/fs/ext4/ext4_jbd2.h
> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>  {
>  	int err = 0;
>  
> +	/*
> +	 * At this point all pending FS updates should be done except a possible
> +	 * running transaction (which will commit in jbd2_journal_destroy). It
> +	 * is now safe for any new errors to directly commit superblock rather
> +	 * than going via journal.
> +	 */
> +	sbi->s_journal_destorying = true;
> +

So as you already uncovered with Zhang Yi, this does not work. What I meant
was that we move flush_work(&sbi->s_sb_upd_work) into
ext4_journal_destroy() and set s_journal_destorying *before* calling
flush_work(). By the time ext4_journal_destroy() gets called, the
filesystem is quiescent, there cannot be new handles started (except for sb
update itself from the workqueue) and thus if we hit some error, the
journal will be aborted anyway and in that case non-journaled sb update is
safe.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

