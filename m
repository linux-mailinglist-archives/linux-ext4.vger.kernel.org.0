Return-Path: <linux-ext4+bounces-14302-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAHCDJGMpWmoDgYAu9opvQ
	(envelope-from <linux-ext4+bounces-14302-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 14:11:45 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6631D988C
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 14:11:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3575D302A2E2
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 13:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05753DA7DF;
	Mon,  2 Mar 2026 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrIHlZHp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="05jyNH2v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RrIHlZHp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="05jyNH2v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728363D7D7C
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456896; cv=none; b=MQooPLAb3HKGZ1tJaeqzQYtX5yaFHTSL6G6NgZwMqdcrjs9dBy3y1jygxTaymoC6UZtGpYP7haxnHsCmxidV1UDG4CHrLnmwJGZMSVrtW+zidh39xsTRN/aGZEEgTlr64Qsfw0NsGhL+f3jbZ/2ewAo2ruM4axLjJXZkVSqTyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456896; c=relaxed/simple;
	bh=KK4fdU6gtMvF3KOGjBDUD+17xa9sIYleDZXVCWCujHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/rW5SlYIExj+y37fLQOtTHL8FHUloHbjDUXhycCOcOKr20xGcCssfGnESKnrHaofG5reG+bWlFFDM3cc+995K7XDLPBzUcKuzf4hOkQjHhLuy0kufYjPHiuq1t5M1BuHX9KOMEHCL9Y8SqqRrKinGw1xMK9XqXDHeRyomGlodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrIHlZHp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=05jyNH2v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RrIHlZHp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=05jyNH2v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9057A3E7CE;
	Mon,  2 Mar 2026 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772456892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XKQb2yxDM/WT1kATY3lBcKTWJzFDcHoA6g2LKhLh0k=;
	b=RrIHlZHpsZG6lT4U61HNz9UboVBP0c+93gQSuMMPwgIxSVeDz30kxcVHEgb9mJton/Oa/Q
	Q28lo9wAFJlnsvWsKaq7K6NGyFL6VxNOgd0rOa/we1a+V2NzUwY2ZHzd/1h+GFM7IE511B
	sgGjxAUia6PiLre3YXRNGrl0sYSDuP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772456892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XKQb2yxDM/WT1kATY3lBcKTWJzFDcHoA6g2LKhLh0k=;
	b=05jyNH2vh0mExFBNYssS94uxf6/5dyJzkeaTwNR5kRJMEZYqs3UP5xAgPZVUGQ0GM1iWS1
	xxG2znOEaQjuvCCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RrIHlZHp;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=05jyNH2v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772456892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XKQb2yxDM/WT1kATY3lBcKTWJzFDcHoA6g2LKhLh0k=;
	b=RrIHlZHpsZG6lT4U61HNz9UboVBP0c+93gQSuMMPwgIxSVeDz30kxcVHEgb9mJton/Oa/Q
	Q28lo9wAFJlnsvWsKaq7K6NGyFL6VxNOgd0rOa/we1a+V2NzUwY2ZHzd/1h+GFM7IE511B
	sgGjxAUia6PiLre3YXRNGrl0sYSDuP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772456892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7XKQb2yxDM/WT1kATY3lBcKTWJzFDcHoA6g2LKhLh0k=;
	b=05jyNH2vh0mExFBNYssS94uxf6/5dyJzkeaTwNR5kRJMEZYqs3UP5xAgPZVUGQ0GM1iWS1
	xxG2znOEaQjuvCCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B8B43EA69;
	Mon,  2 Mar 2026 13:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NVw9GryLpWlPYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 13:08:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2B1C6A0A0B; Mon,  2 Mar 2026 14:07:57 +0100 (CET)
Date: Mon, 2 Mar 2026 14:07:57 +0100
From: Jan Kara <jack@suse.cz>
To: Milos Nikic <nikic.milos@gmail.com>
Cc: jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: gracefully abort instead of panicking on unlocked
 buffer
Message-ID: <u4zbebo5va2oxs3ggr5caspz5mklufrfx2rjjg4sw3vhm5d3pw@a5vd7a2ufarh>
References: <20260302003135.93802-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302003135.93802-1-nikic.milos@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-14302-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8B6631D988C
X-Rspamd-Action: no action

On Sun 01-03-26 16:31:35, Milos Nikic wrote:
> In jbd2_journal_get_create_access(), if the caller passes an unlocked
> buffer, the code currently triggers a fatal J_ASSERT.
> 
> While an unlocked buffer here is a clear API violation and a bug in the
> caller, crashing the entire system is an overly severe response. It brings
> down the whole machine for a localized filesystem inconsistency.
> 
> Replace the J_ASSERT with a WARN_ON_ONCE to capture the offending caller's
> stack trace, and return an error (-EINVAL). This allows the journal to
> gracefully abort the transaction, protecting data integrity without
> causing a kernel panic.
> 
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>

In principle I'm fine with this however we have lots of similar asserts in
the code. So how is this one special? Did you somehow trigger it?

								Honza

> ---
>  fs/jbd2/transaction.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index dca4b5d8aaaa..04d17a5f2a82 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1302,7 +1302,12 @@ int jbd2_journal_get_create_access(handle_t *handle, struct buffer_head *bh)
>  		goto out;
>  	}
>  
> -	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
> +	if (WARN_ON_ONCE(!buffer_locked(jh2bh(jh)))) {
> +		err = -EINVAL;
> +		spin_unlock(&jh->b_state_lock);
> +		jbd2_journal_abort(journal, err);
> +		goto out;
> +	}
>  
>  	if (jh->b_transaction == NULL) {
>  		/*
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

