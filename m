Return-Path: <linux-ext4+bounces-2912-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E2B912313
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 13:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B4284DFE
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jun 2024 11:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB95172BB4;
	Fri, 21 Jun 2024 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR6ZCGHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcpkxfG9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hR6ZCGHG";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VcpkxfG9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B1617107C;
	Fri, 21 Jun 2024 11:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718968394; cv=none; b=YAHJPcyts04yO8tAeFyUfHrYS/5M1hxTL+zaQ3k1GFx32GmQZGqfdHQPPAM4wxswzxl2yaqBy1wAs9vI483U4VnFkoBV9Mk/dlsMzZGhPJYEi8Mby4MhsFUMu6Dh4f6PLBsnPABDNV6lZWgp3Kl1brn5Dg6sDVKLRsKaYx60u+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718968394; c=relaxed/simple;
	bh=pyE6rpI0+UknO/WUfC/fDntx9R2sRzT4vDGkJMqYsNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XEN5qkUxPSzKIuDFX0l8HfD8B0tN6EJOiWZi5za1tllDsQ6YKVYWj27K/kdVlzGrMQhAEf40HIce40qf0jcqip9AjeWkeJkWrC/ycRf/eu/rFJ2Cdi45ZaXDJpwbu3SZS8vwi9b1A40/nf69K754jqZjjqJ04PPSHJjB7u1pt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR6ZCGHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcpkxfG9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hR6ZCGHG; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VcpkxfG9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 521DB1FB6C;
	Fri, 21 Jun 2024 11:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718968390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc/C+EFdu9Q33AJSPSavgIomLUKLutbToyiR7oDqwo=;
	b=hR6ZCGHGbDBJ6+dzVp+qCwSBdCG3Ou9WIrNxirxxIU3EJUzX5qE1uDeixrRkXlccRBNz7s
	pJ5rAtIfC3eLZ7lRCkd8NeTO9TqkEWEoJshuF57f9EoQunQu0GW2nSu/fzLMVwryTf0H4t
	VJf8FrM4zjNFmzdUua+6PQUbYGjZajo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718968390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc/C+EFdu9Q33AJSPSavgIomLUKLutbToyiR7oDqwo=;
	b=VcpkxfG92MFA/VQOE6mEueNESkeXndNka2csU/ZgHffruro5LI06X9Tt2wtKogl0X+KsKl
	Gd7+fGXZbNevmVAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hR6ZCGHG;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VcpkxfG9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718968390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc/C+EFdu9Q33AJSPSavgIomLUKLutbToyiR7oDqwo=;
	b=hR6ZCGHGbDBJ6+dzVp+qCwSBdCG3Ou9WIrNxirxxIU3EJUzX5qE1uDeixrRkXlccRBNz7s
	pJ5rAtIfC3eLZ7lRCkd8NeTO9TqkEWEoJshuF57f9EoQunQu0GW2nSu/fzLMVwryTf0H4t
	VJf8FrM4zjNFmzdUua+6PQUbYGjZajo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718968390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dZc/C+EFdu9Q33AJSPSavgIomLUKLutbToyiR7oDqwo=;
	b=VcpkxfG92MFA/VQOE6mEueNESkeXndNka2csU/ZgHffruro5LI06X9Tt2wtKogl0X+KsKl
	Gd7+fGXZbNevmVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B6A813AAA;
	Fri, 21 Jun 2024 11:13:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xU6uDkZgdWZqYwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 21 Jun 2024 11:13:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B8ED2A087E; Fri, 21 Jun 2024 13:13:09 +0200 (CEST)
Date: Fri, 21 Jun 2024 13:13:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] fs: ext4: add missing MODULE_DESCRIPTION()
Message-ID: <20240621111309.l4f7mxu6zqjwx7ws@quack3>
References: <20240527-md-fs-ext4-v1-1-07aad5936bb1@quicinc.com>
 <bbff5b14-75ae-4dc3-9aac-17afd4e92693@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbff5b14-75ae-4dc3-9aac-17afd4e92693@quicinc.com>
X-Rspamd-Queue-Id: 521DB1FB6C
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu 20-06-24 09:06:42, Jeff Johnson wrote:
> On 5/27/24 11:02, Jeff Johnson wrote:
> > Fix the 'make W=1' warning:
> > WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o
> > 
> > Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Ted was on a long vacation recently but I expect him to pick up this patch
for the next merge window. Anyway feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

