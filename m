Return-Path: <linux-ext4+bounces-403-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C90180EEEE
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D39B20D7D
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1047319D;
	Tue, 12 Dec 2023 14:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGR0IF8i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JOtwSDxK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DGR0IF8i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="JOtwSDxK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD988F
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:37:06 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 357B522510;
	Tue, 12 Dec 2023 14:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hes3ab+Yfl1hrxn5mHuhwlgxv3Y6Ev94ah8KQzxFE=;
	b=DGR0IF8iEz9MFYrGebtJoPC7eLvS2sOlTU6C2eGytXFDWKgjm4vl3XGwygyjJce7W7Y9m2
	GCcWQ88gQ7wT9Pt3EjFGgyb78nDfz0ym5V1obZrs0lHReLkWv995dLdbpzX+Z0lEvTwA+s
	j2kC537WBAAQ/GES2+hsZhtZ7MJZveM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hes3ab+Yfl1hrxn5mHuhwlgxv3Y6Ev94ah8KQzxFE=;
	b=JOtwSDxKt137R8urCu0MH47qZjZUGcDwoi+XjCEJhncI32mdjkXOwbXsOTFMSUw5IujEWD
	XU+lJn/mmo6/VLCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hes3ab+Yfl1hrxn5mHuhwlgxv3Y6Ev94ah8KQzxFE=;
	b=DGR0IF8iEz9MFYrGebtJoPC7eLvS2sOlTU6C2eGytXFDWKgjm4vl3XGwygyjJce7W7Y9m2
	GCcWQ88gQ7wT9Pt3EjFGgyb78nDfz0ym5V1obZrs0lHReLkWv995dLdbpzX+Z0lEvTwA+s
	j2kC537WBAAQ/GES2+hsZhtZ7MJZveM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b1hes3ab+Yfl1hrxn5mHuhwlgxv3Y6Ev94ah8KQzxFE=;
	b=JOtwSDxKt137R8urCu0MH47qZjZUGcDwoi+XjCEJhncI32mdjkXOwbXsOTFMSUw5IujEWD
	XU+lJn/mmo6/VLCA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 28590132DC;
	Tue, 12 Dec 2023 14:37:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SjrYCRFweGUdVwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:37:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C785AA06E5; Tue, 12 Dec 2023 15:37:04 +0100 (CET)
Date: Tue, 12 Dec 2023 15:37:04 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 2/5] jbd2: Replace journal state flag by checking errseq
Message-ID: <20231212143704.5sf3nrluy2klx7d4@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
 <20231103145250.2995746-3-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-3-chengzhihao1@huawei.com>
X-Spam-Score: 14.37
X-Spamd-Bar: +++++
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DGR0IF8i;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JOtwSDxK;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [5.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.76)[-0.756];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.15)[-0.739];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 5.09
X-Rspamd-Queue-Id: 357B522510
X-Spam-Flag: NO

On Fri 03-11-23 22:52:47, Zhihao Cheng wrote:
> Now JBD2 detects metadata writeback error of fs dev according to errseq.
> Replace journal state flag by checking errseq.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index a655d9a88f79..b60d19505f8a 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1850,7 +1850,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
>  
>  	if (is_journal_aborted(journal))
>  		return -EIO;
> -	if (test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags)) {
> +	if (jbd2_check_fs_dev_write_error(journal)) {
>  		jbd2_journal_abort(journal, -EIO);
>  		return -EIO;
>  	}
> @@ -2148,12 +2148,12 @@ int jbd2_journal_destroy(journal_t *journal)
>  
>  	/*
>  	 * OK, all checkpoint transactions have been checked, now check the
> -	 * write out io error flag and abort the journal if some buffer failed
> -	 * to write back to the original location, otherwise the filesystem
> -	 * may become inconsistent.
> +	 * writeback errseq of fs dev and abort the journal if some buffer
> +	 * failed to write back to the original location, otherwise the
> +	 * filesystem may become inconsistent.
>  	 */
>  	if (!is_journal_aborted(journal) &&
> -	    test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags))
> +	    jbd2_check_fs_dev_write_error(journal))
>  		jbd2_journal_abort(journal, -EIO);
>  
>  	if (journal->j_sb_buffer) {
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

