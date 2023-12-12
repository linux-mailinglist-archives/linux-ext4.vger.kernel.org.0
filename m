Return-Path: <linux-ext4+bounces-402-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B73A780EEEA
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B0EB20DA7
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D91773191;
	Tue, 12 Dec 2023 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UI5ail1E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gOAqI4sC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KyfPVBKo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ao9gqyoL"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE344FE
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:36:49 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DAD0A1FB50;
	Tue, 12 Dec 2023 14:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFOWlaTDd7Tb5rt5l+uicUR3k5CeZRqfh+u/fRDbsck=;
	b=UI5ail1EpE5HAsNPaTmbBv2iVLe11+hEYmY7hkMwVuBw4cW0TdMkilk7skhzVlTD4Un+LT
	5eDI8V0D5IKyLE/nXwvtALB/SE4b2mRMds+ZkvFAr7zzrGq/417wb9KQaD/wN2b+Dlc1KX
	sUPccKWumjCKcVxQD8CsndD6pEXi1eI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFOWlaTDd7Tb5rt5l+uicUR3k5CeZRqfh+u/fRDbsck=;
	b=gOAqI4sC65H/wi0KSQ+wCL/H9EvQdEe5/q3i1w02gYUnCHggHwXHFOHi0W3lcIvyrignjc
	iBsUJpgBV+xKkTBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFOWlaTDd7Tb5rt5l+uicUR3k5CeZRqfh+u/fRDbsck=;
	b=KyfPVBKo0OsORRweZ87jGLONPs5NwnWkYPvXkhF0+UONoCuhaO7tTpRKYPkSyo5YNVh5ZT
	CBinpAFOCLfvZuzdv02QecqxiirPoRj4CPVG+jFfRn04Yz0DXdOHJo4Xbyu6dVHA99HNrA
	0BnpL1MoX1rk2JIke+0rB2wImBUNn3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fFOWlaTDd7Tb5rt5l+uicUR3k5CeZRqfh+u/fRDbsck=;
	b=Ao9gqyoLcKghkDlhKwvxOuv8f5gjE+4JoMGYMcBY0XA174hRD6XxgTrRMwB/FKbgJXBU87
	6IyBWRm4SMF5cWDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CB969132DC;
	Tue, 12 Dec 2023 14:36:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id kpSwMf9veGUEVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:36:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BA65A06E5; Tue, 12 Dec 2023 15:36:47 +0100 (CET)
Date: Tue, 12 Dec 2023 15:36:47 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 1/5] jbd2: Add errseq to detect client fs's bdev
 writeback error
Message-ID: <20231212143647.pygpilneuonrdedq@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
 <20231103145250.2995746-2-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-2-chengzhihao1@huawei.com>
X-Spam-Level: ***********
X-Spam-Score: 11.36
X-Spam-Level: 
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: DAD0A1FB50
X-Spam-Flag: NO
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=KyfPVBKo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ao9gqyoL;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Spamd-Result: default: False [-2.81 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.00)[suse.cz];
	 R_SPF_SOFTFAIL(0.00)[~all];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -2.81

On Fri 03-11-23 22:52:46, Zhihao Cheng wrote:
> Add errseq in journal, so that JBD2 can detect whether metadata is
> successfully fallen on fs bdev. This patch adds detection in recovery
               ^^^^^^^^^ written to

> process to replace original solution(using local variable wb_err).
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Otherwise the patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 30dec2bd2ecc..a655d9a88f79 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1535,6 +1535,7 @@ static journal_t *journal_init_common(struct block_device *bdev,
>  	journal->j_fs_dev = fs_dev;
>  	journal->j_blk_offset = start;
>  	journal->j_total_len = len;
> +	jbd2_init_fs_dev_write_error(journal);
>  
>  	err = journal_load_superblock(journal);
>  	if (err)
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 01f744cb97a4..1f7664984d6e 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -289,8 +289,6 @@ int jbd2_journal_recover(journal_t *journal)
>  	journal_superblock_t *	sb;
>  
>  	struct recovery_info	info;
> -	errseq_t		wb_err;
> -	struct address_space	*mapping;
>  
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
> @@ -308,9 +306,6 @@ int jbd2_journal_recover(journal_t *journal)
>  		return 0;
>  	}
>  
> -	wb_err = 0;
> -	mapping = journal->j_fs_dev->bd_inode->i_mapping;
> -	errseq_check_and_advance(&mapping->wb_err, &wb_err);
>  	err = do_one_pass(journal, &info, PASS_SCAN);
>  	if (!err)
>  		err = do_one_pass(journal, &info, PASS_REVOKE);
> @@ -334,7 +329,7 @@ int jbd2_journal_recover(journal_t *journal)
>  	err2 = sync_blockdev(journal->j_fs_dev);
>  	if (!err)
>  		err = err2;
> -	err2 = errseq_check_and_advance(&mapping->wb_err, &wb_err);
> +	err2 = jbd2_check_fs_dev_write_error(journal);
>  	if (!err)
>  		err = err2;
>  	/* Make sure all replayed data is on permanent storage */
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 52772c826c86..15798f88ade4 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -998,6 +998,13 @@ struct journal_s
>  	 */
>  	struct block_device	*j_fs_dev;
>  
> +	/**
> +	 * @j_fs_dev_wb_err:
> +	 *
> +	 * Records the errseq of the client fs's backing block device.
> +	 */
> +	errseq_t		j_fs_dev_wb_err;
> +
>  	/**
>  	 * @j_total_len: Total maximum capacity of the journal region on disk.
>  	 */
> @@ -1695,6 +1702,25 @@ static inline void jbd2_journal_abort_handle(handle_t *handle)
>  	handle->h_aborted = 1;
>  }
>  
> +static inline void jbd2_init_fs_dev_write_error(journal_t *journal)
> +{
> +	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +
> +	/*
> +	 * Save the original wb_err value of client fs's bdev mapping which
> +	 * could be used to detect the client fs's metadata async write error.
> +	 */
> +	errseq_check_and_advance(&mapping->wb_err, &journal->j_fs_dev_wb_err);
> +}
> +
> +static inline int jbd2_check_fs_dev_write_error(journal_t *journal)
> +{
> +	struct address_space *mapping = journal->j_fs_dev->bd_inode->i_mapping;
> +
> +	return errseq_check(&mapping->wb_err,
> +			    READ_ONCE(journal->j_fs_dev_wb_err));
> +}
> +
>  #endif /* __KERNEL__   */
>  
>  /* Comparison functions for transaction IDs: perform comparisons using
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

