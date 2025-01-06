Return-Path: <linux-ext4+bounces-5902-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D232A029C1
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 471FD3A6157
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED3E1ADFE3;
	Mon,  6 Jan 2025 15:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jpaGQpEE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyU4Pqlr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jpaGQpEE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eyU4Pqlr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24E01791F4;
	Mon,  6 Jan 2025 15:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736177151; cv=none; b=b5gyR0GHbRFGVX7WEivBP6dR2/j3jKR6BMXfcZJ2XGHwsxkjJTnJIGG43Tkyovoe8rvN+1I2ml3KiVaOPU4tDtFu3e0TDcRap3DS92eJ9KbgTJZYJdgQvJ1mH/MAEbJkbUNLGKro722O5qlhxLzsph2f5p9wzlApqOZGRak8N3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736177151; c=relaxed/simple;
	bh=b6m3NaFcLPiQMWq5+K4t/bN4244j3BYiQx1f52Lp/D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obYJJUNUnKFKiumP9GwEJ9diC1txLpnCFEAg9Jk+jimOFm+oPM8YtBpxeH8s8xS8h5jjUnPE5BaG4D95ls2sf6M/5m0OTgQyc0MjSbNb6xHO2vGWNrHVvPJqAGr95itM6zuZGYi8rsBVIjHMHEnooRyxVFqhL+e6wWILR7CMYyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jpaGQpEE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyU4Pqlr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jpaGQpEE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eyU4Pqlr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A2A081F399;
	Mon,  6 Jan 2025 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPXOn3SlPWRFyN0bgRtrmIxPXFKXl1djyg0EKd26Jq0=;
	b=jpaGQpEEV2mLjOF8ifVqfE+29rql/g7rfTy7e5eWfT/9JwVFw442p1FGVm4YTMEtp1F12b
	IpGXE+QzhH9LyMX/8Lvwr3THW0x1CEqi36jDU/mTO10xmtKkQ9wO4VEtNwkgKDBFeuZtRU
	uJ1f9A53gVlIFhqYKNZziQRLL/jiBXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPXOn3SlPWRFyN0bgRtrmIxPXFKXl1djyg0EKd26Jq0=;
	b=eyU4PqlrqwKgN8oZyeuznwC4f2PpAaplkYL8GvF/eIMHgX5pwRJ2tnTpJgw+Bi2PgaOAxY
	MLFimhqn8usanbAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jpaGQpEE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eyU4Pqlr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736177147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPXOn3SlPWRFyN0bgRtrmIxPXFKXl1djyg0EKd26Jq0=;
	b=jpaGQpEEV2mLjOF8ifVqfE+29rql/g7rfTy7e5eWfT/9JwVFw442p1FGVm4YTMEtp1F12b
	IpGXE+QzhH9LyMX/8Lvwr3THW0x1CEqi36jDU/mTO10xmtKkQ9wO4VEtNwkgKDBFeuZtRU
	uJ1f9A53gVlIFhqYKNZziQRLL/jiBXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736177147;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sPXOn3SlPWRFyN0bgRtrmIxPXFKXl1djyg0EKd26Jq0=;
	b=eyU4PqlrqwKgN8oZyeuznwC4f2PpAaplkYL8GvF/eIMHgX5pwRJ2tnTpJgw+Bi2PgaOAxY
	MLFimhqn8usanbAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8A5D9139AB;
	Mon,  6 Jan 2025 15:25:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dYR/Ifv1e2eCSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:25:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5130A089C; Mon,  6 Jan 2025 16:25:46 +0100 (CET)
Date: Mon, 6 Jan 2025 16:25:46 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 1/7] ext4: Modify ei->i_flags before calling
 ext4_mark_iloc_dirty()
Message-ID: <7mghv2p2ee5o4cehwni7lqni3xggem7uzycpjdjvv23uuu4hov@g3sm3l4m2njj>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-2-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-2-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: A2A081F399
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 23:16:19, Julian Sun wrote:
> Modify ei->i_flags before calling ext4_mark_iloc_dirty() so that
> the modifications to ei->i_flags can be reflected in the raw_inode
> during the call to ext4_mark_iloc_dirty()->ext4_do_update_inode()
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>  fs/ext4/inline.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 3536ca7e4fcc..d479495d03aa 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -465,11 +465,10 @@ static int ext4_destroy_inline_data_nolock(handle_t *handle,
>  	ext4_clear_inode_flag(inode, EXT4_INODE_INLINE_DATA);
>  
>  	get_bh(is.iloc.bh);
> -	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);
> -
>  	EXT4_I(inode)->i_inline_off = 0;
>  	EXT4_I(inode)->i_inline_size = 0;
>  	ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
> +	error = ext4_mark_iloc_dirty(handle, inode, &is.iloc);

I don't see what difference this makes since ext4_clear_inode_state() does
not modify ei->i_flags but ei->i_state_flags which is not stored on disk...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

