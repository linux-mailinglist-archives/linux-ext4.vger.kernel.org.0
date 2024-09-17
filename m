Return-Path: <linux-ext4+bounces-4195-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BF697B02B
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 14:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8E41B22D81
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAF016D9BF;
	Tue, 17 Sep 2024 12:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqdJ6zgz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="52RkqkDz";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DqdJ6zgz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="52RkqkDz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F6A2BAEB;
	Tue, 17 Sep 2024 12:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726576565; cv=none; b=AdyRnBcYWja898fRjLRa49JIz9ABdAlE1aLbdsZDYcWuy+ApwyC8zQ/ejHE5IAyqZ6PAbiOmbXK6/L5WSAJcbKCBkmV78aDaDAef3VG1Szp9Yke4YHRbtLuTnAWQatAPZV2ieri9etS7itaBixHIZGxfqbN6rwr1RqcNcRZ4ZCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726576565; c=relaxed/simple;
	bh=xZEdMZsIYhBlrL7+PAFPW+dXzMkzNkdmM+dkkt+2NO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+0TksnrG+fvavt1PBtKgXPnvlb60jA27l/bKIqQ+B+/QRHYqA2RZqOfhEqMAtTmS4XooGgfelfg0Emcmeq04s1JF0Xtlf+rV3XlFUEw3xgjgqEOoFt+6rA1dbf7TeAxEdP1j9iUtDH7EVR4zal/bEiu6TEJ2lKBAxJd9doX86c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqdJ6zgz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=52RkqkDz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DqdJ6zgz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=52RkqkDz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2FE042005A;
	Tue, 17 Sep 2024 12:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lB4qgIiJTwsTorinJVnENANKo2juI/k0mXnfHkVXw=;
	b=DqdJ6zgzBEiNvtQIj+SCX7w1StZs6Dp2UVcQ40vyykU42N4bNOsrb7prO0r6HyzCnNUvMf
	6uIrkWvEaywqXv5GuKq9X3RIR1eHEc2cM4fciNsWp17W5a/WNEqamM72qu/fJvg8WPYBa/
	S6m/OSd6zEHSXkbFmOOvnMQIUReqb7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lB4qgIiJTwsTorinJVnENANKo2juI/k0mXnfHkVXw=;
	b=52RkqkDzb8DyK5X6OBPUVuSmWgOO4vNZFDVNhiKsj3QPdmyjtf9FjO9EkJV7efLceTEy0i
	D4rLa/TqxS//2RCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DqdJ6zgz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=52RkqkDz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1726576561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lB4qgIiJTwsTorinJVnENANKo2juI/k0mXnfHkVXw=;
	b=DqdJ6zgzBEiNvtQIj+SCX7w1StZs6Dp2UVcQ40vyykU42N4bNOsrb7prO0r6HyzCnNUvMf
	6uIrkWvEaywqXv5GuKq9X3RIR1eHEc2cM4fciNsWp17W5a/WNEqamM72qu/fJvg8WPYBa/
	S6m/OSd6zEHSXkbFmOOvnMQIUReqb7c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1726576561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=k0lB4qgIiJTwsTorinJVnENANKo2juI/k0mXnfHkVXw=;
	b=52RkqkDzb8DyK5X6OBPUVuSmWgOO4vNZFDVNhiKsj3QPdmyjtf9FjO9EkJV7efLceTEy0i
	D4rLa/TqxS//2RCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1917613AB6;
	Tue, 17 Sep 2024 12:36:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3uYXBrF36WZcHwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Sep 2024 12:36:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 17BB9A086F; Tue, 17 Sep 2024 14:35:45 +0200 (CEST)
Date: Tue, 17 Sep 2024 14:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: Fanqi Yu <fanqi.yu@columbia.edu>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Prevent successful remount as r/w after filesystem
 abort
Message-ID: <20240917123545.hmyj2ho4whpn2u67@quack3>
References: <20240915210802.3835698-1-fanqi.yu@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915210802.3835698-1-fanqi.yu@columbia.edu>
X-Rspamd-Queue-Id: 2FE042005A
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sun 15-09-24 17:08:04, Fanqi Yu wrote:
> While the order of writing to the shutdown and read-only flags has been
> enforced by a write memory barrier, the read side in remount does not
> have a pairing read barrier.
> 
> In the event of a fs forced shutdown remounting as read-only,
> remounting it again as read-write can succeed when the flag reads are
> reordered such that sb_rdonly() returns true and
> ext4_forced_shutdown() returns false.
> 
> Commit 4418e14112e3 ("ext4: Fix fsync error handling after filesystem
> abort") has added the other barriers related to these two flags but
> seems to have missed this one.
> 
> Signed-off-by: Fanqi Yu <fanqi.yu@columbia.edu>

Thanks for the patch but there's a changed queued in ext4 tree [1] which
removes setting of SB_RDONLY flag in emergency remount because it has other
problems as well. And after this change the memory ordering problem you
speak about is not an issue anymore.

								Honza

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git/commit/?h=dev&id=d3476f3dad4ad68ae5f6b008ea6591d1520da5d8

> ---
>  fs/ext4/super.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 044135796f2b..c5d3f8969dec 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6542,6 +6542,13 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  	flush_work(&sbi->s_sb_upd_work);
>  
>  	if ((bool)(fc->sb_flags & SB_RDONLY) != sb_rdonly(sb)) {
> +
> +		/*
> +		 * Make sure we read the updated s_ext4_flags.
> +		 * Pairs with smp_wmb() in ext4_handle_error().
> +		 */
> +		smp_rmb();
> +
>  		if (ext4_forced_shutdown(sb)) {
>  			err = -EROFS;
>  			goto restore_opts;
> -- 
> 2.34.1
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

