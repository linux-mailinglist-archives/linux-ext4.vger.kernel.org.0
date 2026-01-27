Return-Path: <linux-ext4+bounces-13353-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8JfdAwi+eGn6sgEAu9opvQ
	(envelope-from <linux-ext4+bounces-13353-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 14:30:48 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6451694EBC
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 14:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49C58304C7D4
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Jan 2026 13:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2D2357A2D;
	Tue, 27 Jan 2026 13:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MnaTvR7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q43V5TEc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MnaTvR7p";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="q43V5TEc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DDE357733
	for <linux-ext4@vger.kernel.org>; Tue, 27 Jan 2026 13:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769520505; cv=none; b=dwf+zyKxqBN6JruuRpZLvU7CfMkG2E32SuByJ2QgccO0ZSkXPEO22cEWonK3nC+HVjfzVe8ybO85c/4pImZQsGZS8bPibzMqiwOEciXzDm1poEtDSwJ7n9pKme4+RneYFN/FV5qF8M8oNHxU26C+GGQ82sHlBKMm6m1QdwU5Miw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769520505; c=relaxed/simple;
	bh=KvJCeaBKrUyoXs6+Jiei3R+9ViZMDENWqroC+vZYsHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bY8UcMUqMsTkxqrQMrYQgXU0tnNxleBlJghlp0/+2do/ag3cTTji6UfzJVlW7ml9JEWE/5MTnka4/KgU2iaultFq6Am3vjre8U+TC7IgvNy1uvFxK21cy5o71KUlWIMDAouxmkwY3SMzaK4qTmk/hcFSnXmy2CQ69ho0XoWpmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MnaTvR7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q43V5TEc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MnaTvR7p; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=q43V5TEc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C6EA5BCF7;
	Tue, 27 Jan 2026 13:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769520502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0uonVfIBvj1V/Pw+/HE1uFbgGY4vu6yIeBLB+z1occ=;
	b=MnaTvR7p0LwigHby8leCxZsgXU/R3eF7Dg7pKee2EPtPo3zD8dqmJbfCjzXjh95bsOEi13
	BsSAK6O+Qn+1Pwp1oEjY7b3KICAMVTB/NhKFSP7vfJIhUpzfNsabXMZJ2Qp+bbT5qZzFfm
	+HDyOEbaMYlc5Bc3JUzWSvQK3lIasfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769520502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0uonVfIBvj1V/Pw+/HE1uFbgGY4vu6yIeBLB+z1occ=;
	b=q43V5TEcwdL+kve9Vy0b+0op4rq4nrInjacegYa2Pk1fKl2Mpev+egrXy1j8S5G4NcXcuc
	NhS7TbDABLpy3HCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1769520502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0uonVfIBvj1V/Pw+/HE1uFbgGY4vu6yIeBLB+z1occ=;
	b=MnaTvR7p0LwigHby8leCxZsgXU/R3eF7Dg7pKee2EPtPo3zD8dqmJbfCjzXjh95bsOEi13
	BsSAK6O+Qn+1Pwp1oEjY7b3KICAMVTB/NhKFSP7vfJIhUpzfNsabXMZJ2Qp+bbT5qZzFfm
	+HDyOEbaMYlc5Bc3JUzWSvQK3lIasfU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1769520502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n0uonVfIBvj1V/Pw+/HE1uFbgGY4vu6yIeBLB+z1occ=;
	b=q43V5TEcwdL+kve9Vy0b+0op4rq4nrInjacegYa2Pk1fKl2Mpev+egrXy1j8S5G4NcXcuc
	NhS7TbDABLpy3HCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA5ED3EA61;
	Tue, 27 Jan 2026 13:28:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OyYxOXW9eGkqCwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 27 Jan 2026 13:28:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2359A0A4A; Tue, 27 Jan 2026 14:28:21 +0100 (CET)
Date: Tue, 27 Jan 2026 14:28:21 +0100
From: Jan Kara <jack@suse.cz>
To: jiucheng.xu@amlogic.com
Cc: Theodore Ts'o <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, jianxin.pan@amlogic.com, tuan.zhang@amlogic.com
Subject: Re: [PATCH] ext4: EXT4_I(sbi->s_buddy_cache)->i_state_flags is not
 initialized
Message-ID: <4p2tihxb3pjmuyetcxb2zuoojhiss35g3zxpkocsma27mavxax@vewd3jr4f3gu>
References: <20260127-origin-dev-v1-1-cafda25e307f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-origin-dev-v1-1-cafda25e307f@amlogic.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
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
	TAGGED_FROM(0.00)[bounces-13353-lists,linux-ext4=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,amlogic.com:email,suse.cz:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jack@suse.cz,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6451694EBC
X-Rspamd-Action: no action

On Tue 27-01-26 17:34:10, Jiucheng Xu via B4 Relay wrote:
> From: Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> The i_state_flags originates from an inode that was previously
> destroyed and then allocated to s_buddy_cache; it requires
> reinitialization.
> 
> The relevant log during umount is shown below:
> 
> EXT4-fs (mmcblk0p28): unmounting filesystem xxx-xxx
> EXT4-fs (mmcblk0p28): Inode 1 (39878178): inode tracked as orphan!
> 39878178: 1411f3c7 e0182705 78cc454d ac11f000  .....'..ME.x....
> da10433b: 1a2e0146 792e03d0 9c2a04d1 0c788ad3  F......y..*...x.
> a91573cf: 44270388 4f4202ea 721a12ea 340cbce0  ..'D..BO...r...4
> 89cb2f37: 0d13f000 4f270414 1a0b01f0 4f880fe0  ......'O.......O
> 810e3bc2: 3f0c02f0 482b0009 02e048d0 83f43f2a  ...?..+H.H..*?..
> 3f37c9f7: 02880aaf 00000000 00000000 00000000  ................
> 
> Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>

Thanks for the patch but this should be fixed since commit 4091c8206cfd
("ext4: clear i_state_flags when alloc inode"). Can you confirm you cannot
reproduce the issue with the latest upstream kernel?

								Honza

> ---
>  fs/ext4/mballoc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index dbc82b65f810fed89da7fa7149d3a05de6f107d6..20b07b2bea31ea81ffbd0b4ace3a7b218c8f4dd5 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -3521,6 +3521,9 @@ static int ext4_mb_init_backend(struct super_block *sb)
>  	sbi->s_buddy_cache->i_ino = EXT4_BAD_INO;
>  	EXT4_I(sbi->s_buddy_cache)->i_disksize = 0;
>  	ext4_set_inode_mapping_order(sbi->s_buddy_cache);
> +#if (BITS_PER_LONG < 64)
> +	ext4_clear_state_flags(EXT4_I(sbi->s_buddy_cache));
> +#endif
>  
>  	for (i = 0; i < ngroups; i++) {
>  		cond_resched();
> 
> ---
> base-commit: 4f5e8e6f012349a107531b02eed5b5ace6181449
> change-id: 20260126-origin-dev-9f84135b9555
> 
> Best regards,
> -- 
> Jiucheng Xu <jiucheng.xu@amlogic.com>
> 
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

