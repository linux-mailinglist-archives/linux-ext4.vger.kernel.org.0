Return-Path: <linux-ext4+bounces-4888-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C39B8EE2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 11:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF5B283506
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 10:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBB1165F1D;
	Fri,  1 Nov 2024 10:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xva2rPu2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="09BZYjYl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xva2rPu2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="09BZYjYl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED2538FA3;
	Fri,  1 Nov 2024 10:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730456117; cv=none; b=WI9wo5u/p8UGGkJglsKAtGLlXo1VBVTRvbK0+N0dM7Fa/Q0cjki0LzSSpVGDsK7jjlFj1QyrYyL/EO/k3Z+U77gtiQHVrAQ4zJVhwhYLj6QbChdGtfNUf6BoTch+hEPQs+TSEI67C6oIqNz1izi595V2JIjgOJgQFw0bwT3r1aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730456117; c=relaxed/simple;
	bh=789k37XnM9w3YEfp3eSkssvrySctPWu8LxI1RW4Zano=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fAmzokAi7CXwyoE7nLiHBSp8z2gGscOv1qYAFtL2CAPITLAFowYht6Caw3d1AY7XAvzbzgXOGirBkpCJ0xR3IrAa3/ZxxWY9m2k39YIaLFYyc/ijpw8bEWrSgfCv/+cCivL5rwKat33gcrwUs/TkiT75g1uoJVrTo6/+FDeb2bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xva2rPu2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=09BZYjYl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xva2rPu2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=09BZYjYl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 586A81FE97;
	Fri,  1 Nov 2024 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730456113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR2Mt0wiEo2QIMD2PG/AzuDa+28IdGqUvSC2wnWG/2o=;
	b=xva2rPu2u5AFmda+PZOqm3DQ/eIPbVAgEVHGfszHV+2y9f5qqxZTMR0yGWihxlIBXZ2W2j
	YzSKQQJrf+aTpMOheq/gZntzUpQVcQ4JdEtWMaV3n2ygxejum4e1SW0nld2Ic31e8LJZAB
	/Bnu9sivEpvMfhynCuXxo5qZF+sban0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730456113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR2Mt0wiEo2QIMD2PG/AzuDa+28IdGqUvSC2wnWG/2o=;
	b=09BZYjYlgRy6d5TsRJrOM9RV3ARLMkHiZdLRBXyZSrj6ts4+rYVJdquPOa+8Hl9eQSbnQ3
	4omMNgZjS2SKFKBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xva2rPu2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=09BZYjYl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730456113; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR2Mt0wiEo2QIMD2PG/AzuDa+28IdGqUvSC2wnWG/2o=;
	b=xva2rPu2u5AFmda+PZOqm3DQ/eIPbVAgEVHGfszHV+2y9f5qqxZTMR0yGWihxlIBXZ2W2j
	YzSKQQJrf+aTpMOheq/gZntzUpQVcQ4JdEtWMaV3n2ygxejum4e1SW0nld2Ic31e8LJZAB
	/Bnu9sivEpvMfhynCuXxo5qZF+sban0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730456113;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZR2Mt0wiEo2QIMD2PG/AzuDa+28IdGqUvSC2wnWG/2o=;
	b=09BZYjYlgRy6d5TsRJrOM9RV3ARLMkHiZdLRBXyZSrj6ts4+rYVJdquPOa+8Hl9eQSbnQ3
	4omMNgZjS2SKFKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4193C13722;
	Fri,  1 Nov 2024 10:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ler6DzGqJGe4SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 01 Nov 2024 10:15:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C6B43A0AF4; Fri,  1 Nov 2024 11:15:12 +0100 (CET)
Date: Fri, 1 Nov 2024 11:15:12 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jan Kara <jack@suse.cz>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241101101512.eee2nkaqgffsoxe3@quack3>
References: <ZxvyavDjXDaV9cNg@kspp>
 <20241031123313.dfcuttwzzs5f5i7a@quack3>
 <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
 <20241031213208.gzr5jv2kg5eobjuo@quack3>
 <ca7be9f4-3f33-48ba-b61a-0a40ea1f17a6@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7be9f4-3f33-48ba-b61a-0a40ea1f17a6@embeddedor.com>
X-Rspamd-Queue-Id: 586A81FE97
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 31-10-24 17:31:34, Gustavo A. R. Silva wrote:
> On 31/10/24 15:32, Jan Kara wrote:
> > 
> > > `sizeof(ctx) == 4` when `char ctx[JBD_MAX_CHECKSUM_SIZE];`
> > > 
> > > To maintain the same size, we tell `DEFINE_RAW_FLEX()` to allocate `1`
> > > element for the flex array, as in 32-bit `sizeof(void *) == 4`.
> > 
> > So I agree we end up allocating enough space on stack but it is pretty
> > subtle and if JBD_MAX_CHECKSUM_SIZE definition changes, we have a problem.
> > I think we need something like (JBD_MAX_CHECKSUM_SIZE + sizeof(*desc->__ctx)
> > - 1) / sizeof(*desc->__ctx))?
> 
> I see. Well, in that case it'd be something more like:
> 
> -       struct {
> -               struct shash_desc shash;
> -               char ctx[JBD_MAX_CHECKSUM_SIZE];
> -       } desc;
> +       DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
> +                       (JBD_MAX_CHECKSUM_SIZE +
> +                        sizeof(*((struct shash_desc *)0)->__ctx)) /
> +                        sizeof(*((struct shash_desc *)0)->__ctx));
> 
> Notice that `desc` is created inside `DEFINE_RAW_FLEX()`
  Right. Thanks for fixing this. The cleanest option then probably is:

	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx,
		DIV_ROUND_UP(JBD_MAX_CHECKSUM_SIZE,
			     sizeof(*((struct shash_desc *)0)->__ctx)))

									Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

