Return-Path: <linux-ext4+bounces-14332-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNv6IAjSpWm1GwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14332-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 19:08:08 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C3A1DE3EE
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 19:08:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41D2A304DE86
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 18:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F83319859;
	Mon,  2 Mar 2026 18:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KcSiaUYn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="crEZt7cG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hAEydOyf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="al43Z80d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0926031716B
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474875; cv=none; b=Yv4AxBe2RK4qQZD5G314cyA1KUxw6mjnsy5przUg59FoN8+nFUkP56dPeCGOiACeqLwnC0PhX+hb7BiSEJRkR+Mgm9fSUL3VBmFlhCSD4E+k7M9qEZVXakpeGIgce0Z5cQeFqJBl+O8D3RZQVBCn+bnPEkEQ2LmNHwunQ87d7gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474875; c=relaxed/simple;
	bh=8XxBqnGbLam0hiS6nFhyiRK3eAOvRZbsgBq1ZsNS/74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfffezzHYeow1NC8wkuOoG2ROxVQCfSkhuLK7SbreE9Ercrj3BwvcKXd8s0Wh9AU1g3ZTBwkDgc/LFmMGbMlOMNi+PMVFz/e+UBEHKeWkepSnObaeffi8ggZct6qNkDhNSqedshJMYtxtsv2tZLbGW7T4MU+2FyCueoRyUMk5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KcSiaUYn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=crEZt7cG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hAEydOyf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=al43Z80d; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 37AA65BD6E;
	Mon,  2 Mar 2026 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772474872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar60jh7owQdwTwSBbtMA2WL2lSQ5CEiK3Uv3xs0bMzw=;
	b=KcSiaUYnbZ26vM/1u7YGFnbULm5WqF2+ZlPyv3xpFYLgrZuQP/KbMrvhwgCYWwPLhqrmxs
	1ravWVZN/lPZ8C3H6tR5Y6Lr1j3w52uWKhC9LdawUMb70HlNvwBCeF0eQ0bbXh0+F6acgk
	ccwnKh6h9NlITLBvt9k6IT1uWfS0ZU4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772474872;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar60jh7owQdwTwSBbtMA2WL2lSQ5CEiK3Uv3xs0bMzw=;
	b=crEZt7cG2djFcKuXcjCutJjMZfwCc8aPk4AuNmnjaHvupbPcDNY/aFZLVGrVtgU/bIgpFq
	V/vvogeT9HJRZlDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hAEydOyf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=al43Z80d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772474871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar60jh7owQdwTwSBbtMA2WL2lSQ5CEiK3Uv3xs0bMzw=;
	b=hAEydOyfftEg6hLhBfObXFHiYiX+hLq6N5Xajz5/B6W6u+CYTdFw+5aBfvF/iFKG4A7sNj
	p5CCeICe+PQQcwUZkNl0P+qdgWCMw68yAgQggRl5ge6YKDNH9dk6mnOzovGkHlMXESDgK9
	QxZxJCH/qbht2DCeXygD/bW7wh8pC3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772474871;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ar60jh7owQdwTwSBbtMA2WL2lSQ5CEiK3Uv3xs0bMzw=;
	b=al43Z80dpkipslK1BsyXbutnV3AZuoDrWsZJjsudBDScqhRUoyLGfOAqy4F9uXhBccqPzg
	iCwEdlBlE49MObCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CCF33EA69;
	Mon,  2 Mar 2026 18:07:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XsXmCvfRpWmXHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 18:07:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E2E20A0A4E; Mon,  2 Mar 2026 19:07:50 +0100 (CET)
Date: Mon, 2 Mar 2026 19:07:50 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>, 
	Mark Fasheh <mark@fasheh.com>, linux-ext4@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v3 1/4] jbd2: add jinode dirty range accessors
Message-ID: <bdeuybwsg2ylevzdvsflzp2glvbkwkczckyy5ez7nzqcj4jybc@msxsa4tznf5p>
References: <20260224092434.202122-1-me@linux.beauty>
 <20260224092434.202122-2-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224092434.202122-2-me@linux.beauty>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: D9C3A1DE3EE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-14332-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:email,linux.beauty:email,suse.cz:dkim,suse.cz:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue 24-02-26 17:24:30, Li Chen wrote:
> Provide a helper to fetch jinode dirty ranges in bytes. This lets
> filesystem callbacks avoid depending on the internal representation,
> preparing for a later conversion to page units.
> 
> Suggested-by: Andreas Dilger <adilger@dilger.ca>
> Signed-off-by: Li Chen <me@linux.beauty>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes since v2:
> - New patch: add jbd2_jinode_get_dirty_range() helper.
> 
>  include/linux/jbd2.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index a53a00d36228c..64392baf5f4b4 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -445,6 +445,20 @@ struct jbd2_inode {
>  	loff_t i_dirty_end;
>  };
>  
> +static inline bool jbd2_jinode_get_dirty_range(const struct jbd2_inode *jinode,
> +					       loff_t *start, loff_t *end)
> +{
> +	loff_t start_byte = jinode->i_dirty_start;
> +	loff_t end_byte = jinode->i_dirty_end;
> +
> +	if (!end_byte)
> +		return false;
> +
> +	*start = start_byte;
> +	*end = end_byte;
> +	return true;
> +}
> +
>  struct jbd2_revoke_table_s;
>  
>  /**
> -- 
> 2.52.0
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

