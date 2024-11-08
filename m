Return-Path: <linux-ext4+bounces-5004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41B9C1ABB
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ACF4285E61
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A76E1E7C01;
	Fri,  8 Nov 2024 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuvF8XVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYN7O/Ec";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BuvF8XVa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PYN7O/Ec"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522451E32D2
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062043; cv=none; b=FqfnV6td6P4z8XMikwX1SrHPlAmRt1XQFjmFJfbmaSMlfOZgg4e/dVS8AWejACvjG+XtQMKsa6ehEyJxC/p5rRKuysfTz2F+qaPoTQyp/PCUbG3kXS9vWj/G7MzG97qIGFwAUvLal+8ZSUFDqPBF/sOgdniqzas6XKQTKPeV0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062043; c=relaxed/simple;
	bh=H9UZDqGJrwU7sDaBHonDH64OX++58GvJiEIrsLmqxjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gic959QW9coiTYQ7r4ycwaXV7qNDMsXvVNo70ttWFlfPv+u9aEQoLf4hLju5ZCPYx1wYOLfBzDjtYgEZRBc3m+d5anS5OE0ZDa2Rasj1SVq9fGdiIdjn/VnYOvpp2GZbjUiNFozA+xFOuD0jRyv6T7A6OSs2WlHOnnA/WBmTkZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuvF8XVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYN7O/Ec; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BuvF8XVa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PYN7O/Ec; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6389621BA7;
	Fri,  8 Nov 2024 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731062039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0MArPXu4Yv3b7Rdxw1lZKhS9zlOz5kGIq7Wrstqo6k=;
	b=BuvF8XVa1Vfa5ygQ10r9RcRfDfIPoDA1IJFw76cAStqI0ADdDrWuwX6Dy/A25u+y0+JUMR
	YbiP5vNNpYD0orLBIC5BMAa6uTYrZs/C2bA92kQyen7CR7jUKHsR21739s/Gn6OGV5XoGN
	STPgHLhqRQ24hd5/7WaqxhfrR6FZuIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731062039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0MArPXu4Yv3b7Rdxw1lZKhS9zlOz5kGIq7Wrstqo6k=;
	b=PYN7O/EcR5WhOSXorQtlbUFgg47eUfxf0WF9QrmUid6dZHPkUxLATOTQjGmHmG82LONmN4
	Lznz5ZzpbhUxn+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BuvF8XVa;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="PYN7O/Ec"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731062039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0MArPXu4Yv3b7Rdxw1lZKhS9zlOz5kGIq7Wrstqo6k=;
	b=BuvF8XVa1Vfa5ygQ10r9RcRfDfIPoDA1IJFw76cAStqI0ADdDrWuwX6Dy/A25u+y0+JUMR
	YbiP5vNNpYD0orLBIC5BMAa6uTYrZs/C2bA92kQyen7CR7jUKHsR21739s/Gn6OGV5XoGN
	STPgHLhqRQ24hd5/7WaqxhfrR6FZuIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731062039;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V0MArPXu4Yv3b7Rdxw1lZKhS9zlOz5kGIq7Wrstqo6k=;
	b=PYN7O/EcR5WhOSXorQtlbUFgg47eUfxf0WF9QrmUid6dZHPkUxLATOTQjGmHmG82LONmN4
	Lznz5ZzpbhUxn+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54A071394A;
	Fri,  8 Nov 2024 10:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 42yjFBfpLWfGNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 08 Nov 2024 10:33:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E98A9A0AF4; Fri,  8 Nov 2024 11:33:58 +0100 (CET)
Date: Fri, 8 Nov 2024 11:33:58 +0100
From: Jan Kara <jack@suse.cz>
To: Li Dongyang <dongyangli@ddn.com>
Cc: linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
	Alex Zhuravlev <bzzz@whamcloud.com>
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
Message-ID: <20241108103358.ziocxsyapli2pexv@quack3>
References: <20241105034428.578701-1-dongyangli@ddn.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105034428.578701-1-dongyangli@ddn.com>
X-Rspamd-Queue-Id: 6389621BA7
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue 05-11-24 14:44:28, Li Dongyang wrote:
> Resizable hashtable should improve journal replay time when
> we have million of revoke records.
> Notice that rhashtable is used during replay only,
> as removal with list_del() is less expensive and it's still used
> during regular processing.
> 
> before:
> 1048576 records - 95 seconds
> 2097152 records - 580 seconds

These are really high numbers of revoke records. Deleting couple GB of
metadata doesn't happen so easily. Are they from a real workload or just
a stress test?
 
> after:
> 1048576 records - 2 seconds
> 2097152 records - 3 seconds
> 4194304 records - 7 seconds

The gains are very nice :).

> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Signed-off-by: Li Dongyang <dongyangli@ddn.com>

> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 667f67342c52..d9287439171c 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -294,6 +294,10 @@ int jbd2_journal_recover(journal_t *journal)
>  	memset(&info, 0, sizeof(info));
>  	sb = journal->j_superblock;
>  
> +	err = jbd2_journal_init_recovery_revoke(journal);
> +	if (err)
> +		return err;
> +
>  	/*
>  	 * The journal superblock's s_start field (the current log head)
>  	 * is always zero if, and only if, the journal was cleanly
> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
> index 4556e4689024..d6e96099e9c9 100644
> --- a/fs/jbd2/revoke.c
> +++ b/fs/jbd2/revoke.c
> @@ -90,6 +90,7 @@
>  #include <linux/bio.h>
>  #include <linux/log2.h>
>  #include <linux/hash.h>
> +#include <linux/rhashtable.h>
>  #endif
>  
>  static struct kmem_cache *jbd2_revoke_record_cache;
> @@ -101,7 +102,10 @@ static struct kmem_cache *jbd2_revoke_table_cache;
>  
>  struct jbd2_revoke_record_s
>  {
> -	struct list_head  hash;
> +	union {
> +		struct list_head  hash;
> +		struct rhash_head linkage;
> +	};
>  	tid_t		  sequence;	/* Used for recovery only */
>  	unsigned long long	  blocknr;
>  };
> @@ -680,13 +684,22 @@ static void flush_descriptor(journal_t *journal,
>   * single block.
>   */
>  
> +static const struct rhashtable_params revoke_rhashtable_params = {
> +	.key_len     = sizeof(unsigned long long),
> +	.key_offset  = offsetof(struct jbd2_revoke_record_s, blocknr),
> +	.head_offset = offsetof(struct jbd2_revoke_record_s, linkage),
> +};
> +

I'd probably view your performance results as: "JOURNAL_REVOKE_DEFAULT_HASH
is just too small for replays of a journal with huge numbers of revoked
blocks". Or did you observe that JOURNAL_REVOKE_DEFAULT_HASH is causing
performance issues also during normal operation when we track there revokes
for the current transaction?

If my interpretation is correct, then rhashtable is unnecessarily huge
hammer for this. Firstly, as the big hash is needed only during replay,
there's no concurrent access to the data structure. Secondly, we just fill
the data structure in the PASS_REVOKE scan and then use it. Thirdly, we
know the number of elements we need to store in the table in advance (well,
currently we don't but it's trivial to modify PASS_SCAN to get that
number). 

So rather than playing with rhashtable, I'd modify PASS_SCAN to sum up
number of revoke records we're going to process and then prepare a static
hash of appropriate size for replay (we can just use the standard hashing
fs/jbd2/revoke.c uses, just with differently sized hash table allocated for
replay and point journal->j_revoke to it). And once recovery completes
jbd2_journal_clear_revoke() can free the table and point journal->j_revoke
back to the original table. What do you think?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

