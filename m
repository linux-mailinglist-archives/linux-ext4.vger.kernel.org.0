Return-Path: <linux-ext4+bounces-404-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 704F880EEEF
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 15:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A16AE1C20AE0
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Dec 2023 14:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0AC7319D;
	Tue, 12 Dec 2023 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NXE45uni";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="XfsHw3KI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yWBaMam/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+PNhXUQz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE158F
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 06:37:30 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 605A61FB50;
	Tue, 12 Dec 2023 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//aFDfzMMpIhSh1625uqPdbHpgHExe22Wb4CLmN0Jcg=;
	b=NXE45uni6lWdpARRhk3wF0BKK5sbZOnDNjoqx82swLE9VZqhejPJVGYYP4zG8VufJfognC
	h442D2mBLZxAR+ZO5du+SaEiygc8vobK7QbxIPDpyDjM8xFaqEujO0pFgOMyfxecE9dmqo
	nfZPfl09mWYp8k9FRtRqTLhkC9Kf4wc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//aFDfzMMpIhSh1625uqPdbHpgHExe22Wb4CLmN0Jcg=;
	b=XfsHw3KIwyNSoNteZQADUa3a941ju3P9chp8Ch+tY76mU7qfbBX5sp34YsuEtkcDyotem3
	OG9idb36rG2PE6Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702391847; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//aFDfzMMpIhSh1625uqPdbHpgHExe22Wb4CLmN0Jcg=;
	b=yWBaMam/LOBv5uUAeepeB/IPcD+aBBfgIYYcXyliAiwGoCnAgUTe1PcWqcrfKKlmLeZPnE
	bJ5Yjzb2jvZo2CPoUQDQjrFCcnSKN4eQZ1JIKHMROJsfyAsMF8ps+0qslHMIuj02OrhEHj
	lzhpGAQ4lFfkXqjmf7+wqzV96dOql0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702391847;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//aFDfzMMpIhSh1625uqPdbHpgHExe22Wb4CLmN0Jcg=;
	b=+PNhXUQzqeeVfiioaDuk38Qda+04m/I7929G65KTZ+pugnbZercnfLZkipKmyhNNbVBD+O
	e1FpAzcADaKECSCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 51AAF132DC;
	Tue, 12 Dec 2023 14:37:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id LmvxEydweGU2VwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 12 Dec 2023 14:37:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F09A4A06E5; Tue, 12 Dec 2023 15:37:26 +0100 (CET)
Date: Tue, 12 Dec 2023 15:37:26 +0100
From: Jan Kara <jack@suse.cz>
To: Zhihao Cheng <chengzhihao1@huawei.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
	yi.zhang@huawei.com
Subject: Re: [PATCH 3/5] jbd2: Remove unused 'JBD2_CHECKPOINT_IO_ERROR' and
 'j_atomic_flags'
Message-ID: <20231212143726.c34yco7rsd5zv456@quack3>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
 <20231103145250.2995746-4-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231103145250.2995746-4-chengzhihao1@huawei.com>
X-Spam-Score: 11.85
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="yWBaMam/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+PNhXUQz;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of jack@suse.cz) smtp.mailfrom=jack@suse.cz
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.63 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-0.78)[-0.784];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(1.20)[suse.cz];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.15)[-0.735];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.42)[97.37%]
X-Spam-Score: 2.63
X-Rspamd-Queue-Id: 605A61FB50
X-Spam-Flag: NO

On Fri 03-11-23 22:52:48, Zhihao Cheng wrote:
> Since 'JBD2_CHECKPOINT_IO_ERROR' and j_atomic_flags' are not useful
> anymore after fs dev's errseq is imported into jbd2, just remove them.
> 
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 11 -----------
>  include/linux/jbd2.h | 11 -----------
>  2 files changed, 22 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 118699fff2f9..1c97e64c4784 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -556,7 +556,6 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	struct transaction_chp_stats_s *stats;
>  	transaction_t *transaction;
>  	journal_t *journal;
> -	struct buffer_head *bh = jh2bh(jh);
>  
>  	JBUFFER_TRACE(jh, "entry");
>  
> @@ -569,16 +568,6 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  
>  	JBUFFER_TRACE(jh, "removing from transaction");
>  
> -	/*
> -	 * If we have failed to write the buffer out to disk, the filesystem
> -	 * may become inconsistent. We cannot abort the journal here since
> -	 * we hold j_list_lock and we have to be careful about races with
> -	 * jbd2_journal_destroy(). So mark the writeback IO error in the
> -	 * journal here and we abort the journal later from a better context.
> -	 */
> -	if (buffer_write_io_error(bh))
> -		set_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags);
> -
>  	__buffer_unlink(jh);
>  	jh->b_cp_transaction = NULL;
>  	percpu_counter_dec(&journal->j_checkpoint_jh_count);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 15798f88ade4..bdde776b90d9 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -755,11 +755,6 @@ struct journal_s
>  	 */
>  	unsigned long		j_flags;
>  
> -	/**
> -	 * @j_atomic_flags: Atomic journaling state flags.
> -	 */
> -	unsigned long		j_atomic_flags;
> -
>  	/**
>  	 * @j_errno:
>  	 *
> @@ -1403,12 +1398,6 @@ JBD2_FEATURE_INCOMPAT_FUNCS(fast_commit,	FAST_COMMIT)
>  #define JBD2_JOURNAL_FLUSH_VALID	(JBD2_JOURNAL_FLUSH_DISCARD | \
>  					JBD2_JOURNAL_FLUSH_ZEROOUT)
>  
> -/*
> - * Journal atomic flag definitions
> - */
> -#define JBD2_CHECKPOINT_IO_ERROR	0x001	/* Detect io error while writing
> -						 * buffer back to disk */
> -
>  /*
>   * Function declarations for the journaling transaction and buffer
>   * management
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

