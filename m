Return-Path: <linux-ext4+bounces-4870-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB469B855D
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 22:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D43E2821E7
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Oct 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962631BBBE0;
	Thu, 31 Oct 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="auHzFIlM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="f7NGle3m";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rYFfcTwf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jrgbgeoi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3823C1BD9C0;
	Thu, 31 Oct 2024 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410346; cv=none; b=ffMI+zprqwFClsRRX4NkGSM1i1I1mQjrZBdEQO8UIrX9unvI6p1AZUhy8EkklGMrRVeafPEiRhMphetjhB08ob/Q5XRJ6V/PFVmWIokhLid5ItNG7TTnqrov3N5NSLMwu3abFGZVJKWvhGqBb2djwhqQ2P0IOzMxjFCnheJiLUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410346; c=relaxed/simple;
	bh=/egSEF3cW1GYdapaEMg5jUMLNz+guIauKH2if5vL+Vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dWqdhZBWTGOpEWtPNvM3hFYA+eFaA8hswcR/quRy4sLwr/g6l49PZW3nbeKZoucUUsLJCEqZyNN48hb6FQigrTYs+cOwh12gGWv8D9QLT0RsFNM+KImo3jj1LH7UcviEcchiRdIIUARQmGmgMZHhQ6Uw1jyIX04vqWC/3BdiuNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=auHzFIlM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=f7NGle3m; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rYFfcTwf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jrgbgeoi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1E8141FCDC;
	Thu, 31 Oct 2024 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730410338; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEC/tdJvVo+qlKYuuOLLuuqD8W12rkbi1vX4sZpGjZA=;
	b=auHzFIlMstXqqPIfZhA2yvR5gn2qhwFVte72+pXYlbkS0MRm1iiUZPwCQFmWCjuGt539WP
	ukVGHlxSqXek2yiEohvQEheN3fn3jtW8ft01rTCo2oy37mHZuOSZmxEZEG9Q4SaiHlqHig
	Er/q+Lx1K0ERksXyCo/QC0DZZqm/vRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730410338;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEC/tdJvVo+qlKYuuOLLuuqD8W12rkbi1vX4sZpGjZA=;
	b=f7NGle3mj6zsoJE8/jPKwTXLADyzY6ggZdNVTRwamFqnNyI/xAvzvNXIJ349ryfVivzebp
	6OF+MC+F16xmRxCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rYFfcTwf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jrgbgeoi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1730410337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEC/tdJvVo+qlKYuuOLLuuqD8W12rkbi1vX4sZpGjZA=;
	b=rYFfcTwfAWoxgcZGBf4PrabW4YYi/cCVP6PseTTYOMq+TYIDlvq3Dnk81grulQVMZv3FAw
	A3M9+WokGRqY6kSoUZgd0B1akDtNyb1ZCrhaPGfLszvfIw8AF6rUJgQkYmUy0vJ/KU5RqH
	g4TaCa4tqwZPr+b5EBh7BI9RktB9Fuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1730410337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FEC/tdJvVo+qlKYuuOLLuuqD8W12rkbi1vX4sZpGjZA=;
	b=JrgbgeoiVtyaA3mqqV6JACcS277SraFEzmdyfPRhF4q/qXSLfoHDIQPUllfgg09mx9FHjB
	0GsjD4+S/BNXsiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13965136A5;
	Thu, 31 Oct 2024 21:32:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JGfDBGH3I2fzCAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 31 Oct 2024 21:32:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C529BA086F; Thu, 31 Oct 2024 22:32:08 +0100 (CET)
Date: Thu, 31 Oct 2024 22:32:08 +0100
From: Jan Kara <jack@suse.cz>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Jan Kara <jack@suse.cz>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] jbd2: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
Message-ID: <20241031213208.gzr5jv2kg5eobjuo@quack3>
References: <ZxvyavDjXDaV9cNg@kspp>
 <20241031123313.dfcuttwzzs5f5i7a@quack3>
 <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe0e9c86-fa44-425e-a955-aa9e401b6334@embeddedor.com>
X-Rspamd-Queue-Id: 1E8141FCDC
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Thu 31-10-24 09:54:36, Gustavo A. R. Silva wrote:
> On 31/10/24 06:33, Jan Kara wrote:
> > On Fri 25-10-24 13:32:58, Gustavo A. R. Silva wrote:
> > > -Wflex-array-member-not-at-end was introduced in GCC-14, and we
> > > are getting ready to enable it, globally.
> > > 
> > > Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> > > a flexible structure (`struct shash_desc`) where the size of the
> > > flexible-array member (`__ctx`) is known at compile-time, and
> > > refactor the rest of the code, accordingly.
> > > 
> > > So, with this, fix 77 of the following warnings:
> > > 
> > > include/linux/jbd2.h:1800:35: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> > > 
> > > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > > ---
> > >   include/linux/jbd2.h | 13 +++++--------
> > >   1 file changed, 5 insertions(+), 8 deletions(-)
> > > 
> > > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > > index 8aef9bb6ad57..ce4560e62d3b 100644
> > > --- a/include/linux/jbd2.h
> > > +++ b/include/linux/jbd2.h
> > > @@ -1796,22 +1796,19 @@ static inline unsigned long jbd2_log_space_left(journal_t *journal)
> > >   static inline u32 jbd2_chksum(journal_t *journal, u32 crc,
> > >   			      const void *address, unsigned int length)
> > >   {
> > > -	struct {
> > > -		struct shash_desc shash;
> > > -		char ctx[JBD_MAX_CHECKSUM_SIZE];
> > > -	} desc;
> > > +	DEFINE_RAW_FLEX(struct shash_desc, desc, __ctx, 1);
> > 
> > Am I missing some magic here or the 1 above should be
> > JBD_MAX_CHECKSUM_SIZE?
> 
> This seems to be 32-bit code, and the element type of the flex-array
> member `__ctx` is `void *`. Therefore, we have:

Why do you think the code is 32-bit? It is used regardless of the
architecture...

> `sizeof(ctx) == 4` when `char ctx[JBD_MAX_CHECKSUM_SIZE];`
> 
> To maintain the same size, we tell `DEFINE_RAW_FLEX()` to allocate `1`
> element for the flex array, as in 32-bit `sizeof(void *) == 4`.

So I agree we end up allocating enough space on stack but it is pretty
subtle and if JBD_MAX_CHECKSUM_SIZE definition changes, we have a problem.
I think we need something like (JBD_MAX_CHECKSUM_SIZE + sizeof(*desc->__ctx)
- 1) / sizeof(*desc->__ctx))?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

