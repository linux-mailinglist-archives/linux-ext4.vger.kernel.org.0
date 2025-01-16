Return-Path: <linux-ext4+bounces-6134-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A770FA14153
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 18:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59FC188BFFE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Jan 2025 17:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6DB22CBDC;
	Thu, 16 Jan 2025 17:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="teEMtB/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANaVAkjI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="teEMtB/j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ANaVAkjI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2CD86323
	for <linux-ext4@vger.kernel.org>; Thu, 16 Jan 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737050366; cv=none; b=HdKU+9hTi0NHCe/n+KxfpHi6Vcd+o4lkRTrKOsnkkTgZ89R7VwsabuPqlLL40+qoF2bDP8oILWyufYMrZFyqWfwLg8v2ebTFh66AuGSmNSsXfWlhBVLsaBhEaXVl4aUAgt0/St0Tz4SDHzajq1usVznV2DdP9dhu8SKby0tpfno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737050366; c=relaxed/simple;
	bh=s4LhgCfmm8xfr7TP5cx5zs2UP4wNfYSYgTs2vtebmIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jucfi77zumyOr5ZZKUXhvkQskvhBs1XNxdWp7A5pFA/Rr6vojWDoePLwIpNqxhBxuFEqyscSxdFk1E33O9N3O7cVqurrAHScgrNbEu7h55IXwB+LjYmZMQYeYZZupwSrcvChnrfXL2rkWqvJu/kShjGQWMVgs7p5U1dlrtvqb0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=teEMtB/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANaVAkjI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=teEMtB/j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ANaVAkjI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8B01F37C;
	Thu, 16 Jan 2025 17:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBqu74IlDAmi47UeDbj9nbQ7ntvSIMJ6LozHHAbeXIc=;
	b=teEMtB/j3qsPbLiNEiun4kVxosKjoUi/bkGHmqfKUyv8LTiSeU2GY3z24SRJaZ7z35DlFA
	NViZCuhRH8yQGyFP2Ori+LW0yDhtfBWWWoSFekj5ULw4lL5nXjqhqJwAm4GVeIn/70Ziab
	2sn+eK7PEVm1y0h2ZyU9NCrt3DaDUMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBqu74IlDAmi47UeDbj9nbQ7ntvSIMJ6LozHHAbeXIc=;
	b=ANaVAkjIJ+yxNXKheDgo8i01UMhRVkK6+AhKyuGovBHKnTxYMzY8mmbFQYOM6Wgg0OAvAD
	oIJK8L00rkFsjPCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="teEMtB/j";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ANaVAkjI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1737050362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBqu74IlDAmi47UeDbj9nbQ7ntvSIMJ6LozHHAbeXIc=;
	b=teEMtB/j3qsPbLiNEiun4kVxosKjoUi/bkGHmqfKUyv8LTiSeU2GY3z24SRJaZ7z35DlFA
	NViZCuhRH8yQGyFP2Ori+LW0yDhtfBWWWoSFekj5ULw4lL5nXjqhqJwAm4GVeIn/70Ziab
	2sn+eK7PEVm1y0h2ZyU9NCrt3DaDUMA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1737050362;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pBqu74IlDAmi47UeDbj9nbQ7ntvSIMJ6LozHHAbeXIc=;
	b=ANaVAkjIJ+yxNXKheDgo8i01UMhRVkK6+AhKyuGovBHKnTxYMzY8mmbFQYOM6Wgg0OAvAD
	oIJK8L00rkFsjPCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EB0B13332;
	Thu, 16 Jan 2025 17:59:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7W0xB/pIiWdDcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 16 Jan 2025 17:59:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B959FA08E0; Thu, 16 Jan 2025 18:59:13 +0100 (CET)
Date: Thu, 16 Jan 2025 18:59:13 +0100
From: Jan Kara <jack@suse.cz>
To: Alexey Zhuravlev <azhuravlev@ddn.com>
Cc: Li Dongyang <dongyangli@ddn.com>, linux-ext4@vger.kernel.org, 
	Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] jbd2: use rhashtable for revoke records during replay
Message-ID: <bf2vn7ggijrmjixtspmp6u3fgjzzlgjfnyra32hnggulpuncbb@4lqbgrk3rgup>
References: <20241104090550.256635-1-dongyangli@ddn.com>
 <20250113183107.7bfef7b6@x390.bzzz77.ru>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113183107.7bfef7b6@x390.bzzz77.ru>
X-Rspamd-Queue-Id: 2F8B01F37C
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Mon 13-01-25 18:31:07, Alexey Zhuravlev wrote:
> Hi,
> 
> I benchmarked rhashtable based patch vs Jan's patch:
> 
> records		vanilla	rhashtable	JK patch
> 2.5M records	102s	29s		25s
> 5.0M records	317s	28s		30s
> 6.0M records	--	35s		44s
> 
> the tests were done using 4.18 kernel (I guess this doesn't matter much
> in this context), using an SSD.  time to mount after a crash (simulated
> with read-only device mapper) was measured.  unfortunately I wasn't able
> to reproduce with more records as my test node has just 32GB RAM,

Thanks for performing the tests! So I guess the dynamic sizing of revoke
table before replay is indeed good enough. Let me do a proper patch
submission.

								Honza

> 
> 
> thanks, Alex
> 
> 
> On Mon, 4 Nov 2024 20:05:50 +1100
> Li Dongyang <dongyangli@ddn.com> wrote:
> 
> > Resizable hashtable should improve journal replay time when
> > we have million of revoke records.
> > Notice that rhashtable is used during replay only,
> > as removal with list_del() is less expensive and it's still used
> > during regular processing.
> > 
> > before:
> > 1048576 records - 95 seconds
> > 2097152 records - 580 seconds
> > 
> > after:
> > 1048576 records - 2 seconds
> > 2097152 records - 3 seconds
> > 4194304 records - 7 seconds
> > 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

