Return-Path: <linux-ext4+bounces-13465-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAfJNbvUgGmFBwMAu9opvQ
	(envelope-from <linux-ext4+bounces-13465-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:45:47 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE45CF1C9
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Feb 2026 17:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D66E303980A
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Feb 2026 16:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3718A37E2E5;
	Mon,  2 Feb 2026 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+EKVc0S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qoN0Xq5n";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v6qU8fZ4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6z6fR6kH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D562284B2F
	for <linux-ext4@vger.kernel.org>; Mon,  2 Feb 2026 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770050453; cv=none; b=j6ozrm5SCtjfbEdOf4dup1rNbhapuwoSciF5M4Afi+SNiUUiRge5zrfeOrG6rsIV0sXToNmm9/6+fKlzy03N+CrhERJBHnLdCOK1ZDkqVXpgZJAZKh1I37h+SgXcJOrMKfNihS76k9MLSWqYAK+v8U0IwuVGVXN3IAbQUrJjjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770050453; c=relaxed/simple;
	bh=lTX92TThL4MFg30cQtqZgfgaH4ejkk/IeuTTpfkXfKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBXaxo45hcRzIqOjLC3+4EgTKNZTwnv7tUOok3l2yrGQda/ZMUsJvDlA2eh66zyKWQ58mB+9P/aSSbK7eIHZ9LNtQE4OWVmPAuZYiAaJb5vPxl0N7BZUTG/+XnBWY1gaWjGHIjmWhjAAAGDlhtQnAX8eGpTEPIwTiZOr5EsqMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+EKVc0S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qoN0Xq5n; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v6qU8fZ4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6z6fR6kH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7D7C3352F7;
	Mon,  2 Feb 2026 16:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770050450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ranz7Fd4J2/TisVAM4IpZpx4ifuhxfHe2LEBmbY8wMg=;
	b=G+EKVc0SX5WH5BXwC8gkr3nAEMEi4NUl26L5XbSRD7CIsZW6U9mbYFWxLhvDSuj96uQtJj
	kjoW93NElC+VXHQysLCQpw51rH8yJ8QY03i6/UU6arpoCW9s360CSg1rdxzmnphWTjUeIT
	GDKdJ90kRbiVifpPdgtsszVIUD3qbwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770050450;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ranz7Fd4J2/TisVAM4IpZpx4ifuhxfHe2LEBmbY8wMg=;
	b=qoN0Xq5nird1Urb/g/+/Z2QvUu6o7IcjRsxrsvhcaYWm+xVIpPmB2HPKbyx4UbW6iLp/XJ
	1gF6MDluivXKpwAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=v6qU8fZ4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=6z6fR6kH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1770050449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ranz7Fd4J2/TisVAM4IpZpx4ifuhxfHe2LEBmbY8wMg=;
	b=v6qU8fZ4SwVrOsFkxm5U2wN3rZu55/7dz1Y6AnC4oTIToH0WZFikOziailfoq7SDHCgxNd
	n7/QB9ZWuxYdS544DLIcZZEEe6AHKiW6Gwb7MZ9w2vyZ3Fger09muhEjQFOLlhAh+FmmFH
	2Ko2pkU9B6fXOuD6Raz0Xw5ZiSNY05g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1770050449;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ranz7Fd4J2/TisVAM4IpZpx4ifuhxfHe2LEBmbY8wMg=;
	b=6z6fR6kHBjoFr8O9tzcfCbpP6sDfJU2t7Y2x0zii13sw1u3fkt74VVMubu+N0OWPx+14wN
	SIzaVCfAXxnmA6Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 699843EA62;
	Mon,  2 Feb 2026 16:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QZzGGZHTgGmqHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Feb 2026 16:40:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28474A08F8; Mon,  2 Feb 2026 17:40:45 +0100 (CET)
Date: Mon, 2 Feb 2026 17:40:45 +0100
From: Jan Kara <jack@suse.cz>
To: Li Chen <me@linux.beauty>
Cc: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>, 
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] jbd2: use READ_ONCE for lockless jinode reads
Message-ID: <cgms3ngtmgbhm6dftle6xqbezuhrjheeuiptnejf55uy2pwjil@w2vgwvm7y6hv>
References: <20260130031232.60780-1-me@linux.beauty>
 <20260130031232.60780-2-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130031232.60780-2-me@linux.beauty>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.beauty:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	DMARC_NA(0.00)[suse.cz];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13465-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2DE45CF1C9
X-Rspamd-Action: no action

On Fri 30-01-26 11:12:30, Li Chen wrote:
> jbd2_inode fields are updated under journal->j_list_lock, but some
> paths read them without holding the lock (e.g. fast commit
> helpers and the ordered truncate fast path).
> 
> Use READ_ONCE() for these lockless reads to correct the
> concurrency assumptions.
> 
> Suggested-by: Jan Kara <jack@suse.com>
> Signed-off-by: Li Chen <me@linux.beauty>

Just one nit below. With that fixed feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -191,12 +197,30 @@ EXPORT_SYMBOL(jbd2_submit_inode_data);
>  
>  int jbd2_wait_inode_data(journal_t *journal, struct jbd2_inode *jinode)
>  {
> -	if (!jinode || !(jinode->i_flags & JI_WAIT_DATA) ||
> -		!jinode->i_vfs_inode || !jinode->i_vfs_inode->i_mapping)
> +	struct address_space *mapping;
> +	struct inode *inode;
> +	unsigned long flags;
> +	loff_t start, end;
> +
> +	if (!jinode)
> +		return 0;
> +
> +	flags = READ_ONCE(jinode->i_flags);
> +	if (!(flags & JI_WAIT_DATA))
> +		return 0;
> +
> +	inode = READ_ONCE(jinode->i_vfs_inode);

i_vfs_inode never changes so READ_ONCE is pointless here.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

