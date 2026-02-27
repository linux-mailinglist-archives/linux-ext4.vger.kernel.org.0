Return-Path: <linux-ext4+bounces-14201-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sN4GJD19oWkUtgQAu9opvQ
	(envelope-from <linux-ext4+bounces-14201-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:17:17 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EC91B66FA
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 12:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0E8930C29EE
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Feb 2026 11:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F113ECBC0;
	Fri, 27 Feb 2026 11:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ykjuOxZZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PqJS1jdt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sZbuaGP+";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ypw/TOc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED12566F5
	for <linux-ext4@vger.kernel.org>; Fri, 27 Feb 2026 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772190996; cv=none; b=EJD+CQExn+tRqa/6aVI0cqLVpgT1vF91T7d1UAo4yKajTKQUFrMSfKlUmcSwwR7dONIDemsC2AbmlrrwXFwS/EFQ6oi2gPubvWIIMuBmT0D2cTx6OR+AXJu3d2RDK6I03pychWFNTVJ4exVWd6VVIvyPJlnx2p0rmjwaImejZYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772190996; c=relaxed/simple;
	bh=AIhJZ4h+0EPWjRrfHKk4Bx4LShnW0GvC/GbRdNSLJeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqI6HwwF2J8qCA5XM0BC1eIhNgNA3qPP/rjm/UrYHcQ+uxU2BL8zaqMhA7FFQZ/EjOmvc4OwhLq19p7MXx9O1U5Dpsywq28yedI7QTXfqw736zULYqSvkl9IcYW/kJk7J97EEDVIY3iZYDHxdwEL0JvJPwxS+Jz3xSus1batVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ykjuOxZZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PqJS1jdt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sZbuaGP+; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ypw/TOc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E6B9B5BDF8;
	Fri, 27 Feb 2026 11:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772190988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5KoO5uVvNWNdJhEE3xif5OJlr8ptQgjVaC2Lr6i6sk=;
	b=ykjuOxZZRYvkEd5GBEbWi6HKwfaMX8xCT/62inQBBduSl5gwtB92uJD5cwhqqNyQoO+n3l
	12ybF13TrXb3mTsPQ24K03t2sm4sF+PquzFFNDt9EiBrnV/buxZbYn8ga9gjWgvsAWdKyK
	PdNwGKXGdTUxG9G/RpJwnLMB2dh0MFM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772190988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5KoO5uVvNWNdJhEE3xif5OJlr8ptQgjVaC2Lr6i6sk=;
	b=PqJS1jdt8OgHTAcnMhiw2XtUi7qs+0QIuP7Oenhv9CmGFQILSG83eRPQ899Uc/DfdNH0VW
	X1teeyEOiC9WbnDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sZbuaGP+;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="9ypw/TOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1772190986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5KoO5uVvNWNdJhEE3xif5OJlr8ptQgjVaC2Lr6i6sk=;
	b=sZbuaGP+0v59rXQu/0PBwl2Q6yy1gGFcddJDWHwweGJXLUQxL60CLojVoYPMmqi4zHXaHx
	bN/6fedv5ofxUSxL8sHKt4szk2P8QnynqidjRg40TBQDQGmuArJQ6+XxdWvU4cWwYGagZR
	tgK95ClZFvEBduFpge71ggxjsiAf8gc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1772190986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w5KoO5uVvNWNdJhEE3xif5OJlr8ptQgjVaC2Lr6i6sk=;
	b=9ypw/TOcHAujPXKAnLa5g2DTPlmqUKqKK10xlPyBJOpNdrhpi9vc8dh8quRb2kokzw62ti
	ugCSuYjnV+Iy6sCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F163EA69;
	Fri, 27 Feb 2026 11:16:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BYfXMgp9oWkLHAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Feb 2026 11:16:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9598CA06D4; Fri, 27 Feb 2026 12:16:22 +0100 (CET)
Date: Fri, 27 Feb 2026 12:16:22 +0100
From: Jan Kara <jack@suse.cz>
To: Milos Nikic <nikic.milos@gmail.com>
Cc: jack@suse.com, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2: replace BUG_ON with WARN_ON_ONCE in ext2_get_blocks
Message-ID: <c7utv3udkhdtglrgelqdgcvrrihlsler2rjme36uruwkhnrizy@ojijdvi3l7rm>
References: <20260207010617.216675-1-nikic.milos@gmail.com>
 <20260227050819.14920-1-nikic.milos@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227050819.14920-1-nikic.milos@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14201-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	DMARC_NA(0.00)[suse.cz];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E9EC91B66FA
X-Rspamd-Action: no action

On Thu 26-02-26 21:08:19, Milos Nikic wrote:
> Hi Jan,
> 
> Just a friendly ping on this patch now that a few weeks have passed.
> Let me know if you need any changes!

Thanks merged now.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

