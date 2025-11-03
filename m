Return-Path: <linux-ext4+bounces-11413-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33ED8C2A9FB
	for <lists+linux-ext4@lfdr.de>; Mon, 03 Nov 2025 09:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3143A6E06
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Nov 2025 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33402223323;
	Mon,  3 Nov 2025 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIw5I3sk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U80RCbYC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sIw5I3sk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U80RCbYC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5D7DA66
	for <linux-ext4@vger.kernel.org>; Mon,  3 Nov 2025 08:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762159598; cv=none; b=AGA64xjzaB2sSS2w9Gw+Tp1fQ9lRnTrjy/MxK352dsQ+9W2s2JmouYuuvD7qjg15OkoU2Nm+6BD8JK5CT2iX6riSsKwEFZn7e+LEQFehJv7U5McnZv6WspysoyN35cmO4RG4gV/XpRJ6CnrtqmZP88tzYT7MuSb3PgxvSsx6uwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762159598; c=relaxed/simple;
	bh=VleiOzfdhxXGkrltlLI7VGd619PMR4vVeDp7yRBj93k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WO4eNu6ObDJ3NOWhXZDjg2dE/Sfsi1jhdaQ65+qKuY+vdI25GSo76L0lPS3UzHvGihz17ME4myURHvJqmOXM5PsHhdEsbvvjRT4e+WRw4TF1fNOcXFnYC0DdPUB1fWISZNDAdtnkqHRd9vYO1LFyD0P//vfx2xaVD1f9N/YKT0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIw5I3sk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U80RCbYC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sIw5I3sk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U80RCbYC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 609ED1F7A5;
	Mon,  3 Nov 2025 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762159595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5agJgW16EOeEZtDnEWS52BJBid49sEn0gLBvpaWf7Tw=;
	b=sIw5I3skk3JxqWJ8h2wdU8vXPeJiyFbGpa8lcdHHLXPQkeJeoVeJTaMKDo5lrmqoFNYR3l
	12qACNzhBUSCsjpO/p3f5+//+1fmj+901lRpMHPY1xONz2KfMRH8tUsCelk4vgtPiV919q
	0ymKa034IaM5W6V/INLiVDf+xqTvR8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762159595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5agJgW16EOeEZtDnEWS52BJBid49sEn0gLBvpaWf7Tw=;
	b=U80RCbYCk0mUtgVzijxgOG8i7ZxZEVbHnjfyjs3p7A3DgbrcuNWV3CrEar54//vaBRbQ7p
	hCGHuckI4WqOdVAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762159595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5agJgW16EOeEZtDnEWS52BJBid49sEn0gLBvpaWf7Tw=;
	b=sIw5I3skk3JxqWJ8h2wdU8vXPeJiyFbGpa8lcdHHLXPQkeJeoVeJTaMKDo5lrmqoFNYR3l
	12qACNzhBUSCsjpO/p3f5+//+1fmj+901lRpMHPY1xONz2KfMRH8tUsCelk4vgtPiV919q
	0ymKa034IaM5W6V/INLiVDf+xqTvR8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762159595;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5agJgW16EOeEZtDnEWS52BJBid49sEn0gLBvpaWf7Tw=;
	b=U80RCbYCk0mUtgVzijxgOG8i7ZxZEVbHnjfyjs3p7A3DgbrcuNWV3CrEar54//vaBRbQ7p
	hCGHuckI4WqOdVAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 505EE139A9;
	Mon,  3 Nov 2025 08:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gjidE+trCGkiBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 03 Nov 2025 08:46:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B690FA2A66; Mon,  3 Nov 2025 09:46:34 +0100 (CET)
Date: Mon, 3 Nov 2025 09:46:34 +0100
From: Jan Kara <jack@suse.cz>
To: Bough Chen <haibo.chen@nxp.com>
Cc: Theodore Tso <tytso@mit.edu>, "jack@suse.cz" <jack@suse.cz>, 
	"adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: ext4 issue on  linux-next(next-20251030)
Message-ID: <xrytdoegosn2qbvqdx6idvardvsbhj4blxnuschvgnl4i2bhxj@ezuawpusl6sn>
References: <20251023-qm_dts-v1-0-9830d6a45939@nxp.com>
 <20251023-qm_dts-v1-2-9830d6a45939@nxp.com>
 <DU0PR04MB9496D99F17904D1B2EFB9E5090FBA@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <20251031013335.GA10593@macsyma-3.local>
 <DU0PR04MB9496B72135BFB95A93DB577E90F8A@DU0PR04MB9496.eurprd04.prod.outlook.com>
 <AS1PR04MB950288682BF1CA58C32AE0F390C7A@AS1PR04MB9502.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS1PR04MB950288682BF1CA58C32AE0F390C7A@AS1PR04MB9502.eurprd04.prod.outlook.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Mon 03-11-25 03:57:37, Bough Chen wrote:
> Hi All,
> 
> I find something when debug, share the finding here:
> 
> I notice every time this issue happen, the log always show inode 1, so I
> think this is supper inode related. And seems related to the
> i_state_flags of struct ext4_inode_info
> 
> [  210.104663] 48812578: f6bffadf 00000000 00000000 00000000
> 
> Here the i_state_flags = 0xf6bffadf, the Inode dynamic state flags only
> touch to bit0~bit12, so this i_state_flags is abnormal.
> 
> When I add the following changes, this issue gone:
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 66f92f832b0fb..c6c2d32d5531b 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1396,6 +1396,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
> 
>         inode_set_iversion(&ei->vfs_inode, 1);
>         ei->i_flags = 0;
> +       ext4_clear_state_flags(ei);
>         spin_lock_init(&ei->i_raw_lock);
>         ei->i_prealloc_node = RB_ROOT;
>         atomic_set(&ei->i_prealloc_active, 0);

OK, that's a good catch. I was scratching my head how inode with ino 1
could get orphan bit set when the kernel should never touch it. Now I've
found out mbcache abuses EXT4_BAD_INO for its internal purposes so what we
complain about is an in-memory auxiliary inode used by mbcache. Indeed it
looks safer to initialize i_state_flags in ext4_alloc_inode() and we can
drop the initialization from __ext4_iget() and __ext4_new_inode().

> This can explain why this issue can't be reproduce 100%. And can also
> explain why only imx6/7 series meet this issue, but imx8/9 not, because
> imx6/7 is arm32 core, it use i_state_flags, but imx8/9 use arm64 core, do
> not use i_state_flags.
> 
> This issue may exist long time, but Jack's patch trigger this issue.
> 
> I also have the following concern:
> Why need to distinguish arch32 and arch64, why not use u64 to merge these
> two casees?

Because atomic bit operations are only guaranteed to work on unsigned long
type (32-bit on 32-bit architectures), not on u64 type.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

