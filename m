Return-Path: <linux-ext4+bounces-6801-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91741A60E4F
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 11:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9C3E3BA03D
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Mar 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F731F4179;
	Fri, 14 Mar 2025 10:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdPqOAwQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NIvflLW5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qdPqOAwQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NIvflLW5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F59C1F30BB
	for <linux-ext4@vger.kernel.org>; Fri, 14 Mar 2025 10:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947044; cv=none; b=pnjuyRScINr8wik/xVmzDm0zT36Mam7RlisO2QEG7yqmnkHQuFd8o/HMg4iCQPstS27QpwJ73Kho1FArjQPasd+IY7d6ApSYeVf/9RVGsoGMbyd90eRX+NmxCThI5wFny0OcGLYLMEiUjj9/V361ngxJY8/k/WMk2Aj8u4BXjpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947044; c=relaxed/simple;
	bh=I3pbZZ4w9ZR2irPL08h5Ft22D/Mr3/CcODRL6Wqc5yE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErheMtiCLsTPJ+9teaYa80c10KJQf9dt+JIokdIEyGL1OKhEMYmQyWk/HwTAIC1ksNOz8mGxmEI4evJFyaZ5qtTO7cLROaPXPQyyfjt+db2ulEnYJtO5DcvjLStSLGGVS7yT1ImzjoSJD95vxfcSA8zoBziXwKfJgXlD3JDBsLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdPqOAwQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NIvflLW5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qdPqOAwQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NIvflLW5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 730141F388;
	Fri, 14 Mar 2025 10:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741947040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3mbbcvBa0h0mjxgwS50dXCX1D4h9U4ox31ttijU7E=;
	b=qdPqOAwQBkQ1X14p53rR5t2sWgpBe4PR0X5YdCdVO/pfddkhnPnfjAgTi+hd0ixrUYW9Wx
	Btsa++w/38ZBJXbb1puyXKskQnMuNNRK4niPeSsEJ6z+KH7Gn7+l+qjPlpUEeX0fb0q1pk
	2o2U0J0WfFbCQdPmwhIXVBDa7LwgPuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741947040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3mbbcvBa0h0mjxgwS50dXCX1D4h9U4ox31ttijU7E=;
	b=NIvflLW5p04SXT4mnuIQx5QDtaSolMEAT5C9hLsrSqzQtBdK9AfWTyV4ga1xd9Gi4x/r1S
	v3vqyq3T2zO7ShDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qdPqOAwQ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=NIvflLW5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741947040; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3mbbcvBa0h0mjxgwS50dXCX1D4h9U4ox31ttijU7E=;
	b=qdPqOAwQBkQ1X14p53rR5t2sWgpBe4PR0X5YdCdVO/pfddkhnPnfjAgTi+hd0ixrUYW9Wx
	Btsa++w/38ZBJXbb1puyXKskQnMuNNRK4niPeSsEJ6z+KH7Gn7+l+qjPlpUEeX0fb0q1pk
	2o2U0J0WfFbCQdPmwhIXVBDa7LwgPuc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741947040;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pF3mbbcvBa0h0mjxgwS50dXCX1D4h9U4ox31ttijU7E=;
	b=NIvflLW5p04SXT4mnuIQx5QDtaSolMEAT5C9hLsrSqzQtBdK9AfWTyV4ga1xd9Gi4x/r1S
	v3vqyq3T2zO7ShDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ED2013A31;
	Fri, 14 Mar 2025 10:10:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONIeF6AA1GciYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 14 Mar 2025 10:10:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24242A0908; Fri, 14 Mar 2025 11:10:40 +0100 (CET)
Date: Fri, 14 Mar 2025 11:10:40 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, 
	Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org, 
	Mahesh Kumar <maheshkumar657g@gmail.com>
Subject: Re: [PATCH v3 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
Message-ID: <2ptbzrdbw2ttnd2ik5y4qq5py7ho7kusescdhtfzwg4ft7ldgs@qnkbcdoxvpfs>
References: <cover.1741938027.git.ojaswin@linux.ibm.com>
 <b8e529f340a9c25c270a77733c79ffc590a9935c.1741938027.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e529f340a9c25c270a77733c79ffc590a9935c.1741938027.git.ojaswin@linux.ibm.com>
X-Rspamd-Queue-Id: 730141F388
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
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,huawei.com,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51
X-Spam-Flag: NO

On Fri 14-03-25 13:14:10, Ojaswin Mujoo wrote:
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
> Hence, introduce a new mount flag to indicate journal is destroying and only do
> a journaled (and deferred) update of sb if this flag is not set. Otherwise, just
> fallback to an un-journaled commit.
> 
> Further, in the journal destroy path, we have the following sequence:
> 
>   1. Set mount flag indicating journal is destroying
>   2. force a commit and wait for it
>   3. flush pending sb updates
> 
> This sequence is important as it ensures that, after this point, there is no sb
> update that might be journaled so it is safe to update the sb outside the
> journal. (To avoid race discussed in 2d01ddc86606)
> 
> Also, we don't need a similar check in ext4_grp_locked_error since it is only
> called from mballoc and AFAICT it would be always valid to schedule work here.
> 
> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Mostly looks good. Couple of small comments below:

> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1179,6 +1179,7 @@ struct ext4_inode_info {
>  #define	EXT4_ERROR_FS			0x0002	/* Errors detected */
>  #define	EXT4_ORPHAN_FS			0x0004	/* Orphans being recovered */
>  #define EXT4_FC_REPLAY			0x0020	/* Fast commit replay ongoing */
> +#define EXT4_JOURNAL_DESTORY		0x0040	/* Journal is in process of destroying */

This should be defined as part of the following enum:

/*
 * run-time mount flags
 */
enum {
        EXT4_MF_MNTDIR_SAMPLED,
        EXT4_MF_FC_INELIGIBLE   /* Fast commit ineligible */
};

Also you have a typo in the flag name. I guess it should be
EXT4_MF_JOURNAL_DESTROY.

> @@ -4957,8 +4961,6 @@ static int ext4_load_and_init_journal(struct super_block *sb,
>  	return 0;
>  
>  out:
> -	/* flush s_sb_upd_work before destroying the journal. */
> -	flush_work(&sbi->s_sb_upd_work);
>  	ext4_journal_destroy(sbi, sbi->s_journal);
>  	return -EINVAL;
>  }
> @@ -5648,8 +5650,6 @@ failed_mount8: __maybe_unused
>  	sbi->s_ea_block_cache = NULL;
>  
>  	if (sbi->s_journal) {
> -		/* flush s_sb_upd_work before journal destroy. */
> -		flush_work(&sbi->s_sb_upd_work);
>  		ext4_journal_destroy(sbi, sbi->s_journal);
>  	}
>  failed_mount3a:

These are good. I would also move the flush_work() in ext4_put_super()
into else branch of:

	if (sbi->s_journal)

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

