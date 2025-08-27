Return-Path: <linux-ext4+bounces-9712-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC1B386AE
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 17:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332111BA2CA7
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6296281375;
	Wed, 27 Aug 2025 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PuwPX139";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1fKBmqgK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oe0HrLFx";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EJ9pqY3a"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8AF478F59
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756308532; cv=none; b=Zx8kURcq7Ree0Fz+dk9uoraQuc1fOSat1r2rOYofs3M73lpGdaKStV+aJ5g65JuFDb7Y2beW8Ln+ubBKP1IRmboi/q1ZhvkPTvAif6XAN0P4ae1DCx7tujukBqFPOu9lrTmooyL8Q8aIH0IaMyZIXtSaz2KxHl0C2pwibTnH5RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756308532; c=relaxed/simple;
	bh=1G5EI8YpDsHaWd4PLBIsjJ2l3KU/hJFuiNpPGDgDIQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Miul33EPPLAmaFJwhHlHx5w5GdE2rNw6lil8uelnPfRB2qEtNvTEQLe2XvlxQq+FOSiFZ6KJJ5L//Y2FZVuY20zUq59UBkR+2z+UYFM81rJB0A+jG21JkucIFcGsKeuW+kM4FHXheOnIlJDqolqUECDTymg9bFOVryDhbJqrOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PuwPX139; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1fKBmqgK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oe0HrLFx; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EJ9pqY3a; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E82CE227D6;
	Wed, 27 Aug 2025 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756308529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcYptHgMuv59YjYUW+650OeLF+jMQhfSnoLIi0Ho9dA=;
	b=PuwPX139DfdLmb3n7cZzRekYrz9jRrbwKvrP5GK34zRJzht5lcNRXp5yPSx3XUnYy9ltj2
	R+3TSOX0HhhC9scaAPOMbBzdw7lxs4dnggeI7zl3XeuyVV1+i3nsSzV31iwoFdYgBg5CNC
	xU3b+rjzjii7qbaBgfjLB7hcP3h3v4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756308529;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcYptHgMuv59YjYUW+650OeLF+jMQhfSnoLIi0Ho9dA=;
	b=1fKBmqgKLbXQUGVcfSGhNqC4nX5Kmf32uP9Jy6uBgYHaqI0aFDochAO+wTfePr4MnMQ8Aw
	s10hgxJzajvu7dCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oe0HrLFx;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EJ9pqY3a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756308527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcYptHgMuv59YjYUW+650OeLF+jMQhfSnoLIi0Ho9dA=;
	b=oe0HrLFxGv71pW/ATHSQjd4O1EhDGZ+IsId/vkKO6jaZUuj3OvPlM5vKyKS8LxweDmG5vc
	V5eQD1st93RMmJ9mBKVR/0AdEQKpN7XUN2AteEyL38YB6B08QkVK4IhIKkWTbH9zXl2AZV
	z9BdaKVacD1juU40tFUi9A67+cO4S2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756308527;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tcYptHgMuv59YjYUW+650OeLF+jMQhfSnoLIi0Ho9dA=;
	b=EJ9pqY3atMbszuaY+KrOmHQzqRiRCa212UiMwN+XYREiIPIaDyzhpkvNBuf/WCmxEpP9DK
	KtuFFFxGOodj1xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCF7613867;
	Wed, 27 Aug 2025 15:28:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hAHsNS8kr2jhDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 Aug 2025 15:28:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58332A0999; Wed, 27 Aug 2025 17:28:47 +0200 (CEST)
Date: Wed, 27 Aug 2025 17:28:47 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz, 
	harshadshirwadkar@gmail.com, ritesh.list@gmail.com
Subject: Re: [PATCH] ext4: Increase IO priority of fastcommit.
Message-ID: <yacgtmlni4jlrdybwpzw7nzpvu3sg4n2hzu3fxvxa4gskduvb6@tu5nfo5e4hra>
References: <20250827121812.1477634-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827121812.1477634-1-sunjunchao@bytedance.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E82CE227D6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,suse.cz,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -2.51

On Wed 27-08-25 20:18:12, Julian Sun wrote:
> The following code paths may result in high latency or even task hangs:
>    1. fastcommit io is throttled by wbt.
>    2. jbd2_fc_wait_bufs() might wait for a long time while
> JBD2_FAST_COMMIT_ONGOING is set in journal->flags, and then
> jbd2_journal_commit_transaction() waits for the
> JBD2_FAST_COMMIT_ONGOING bit for a long time while holding the write
> lock of j_state_lock.
>    3. start_this_handle() waits for read lock of j_state_lock which
> results in high latency or task hang.
> 
> Given the fact that ext4_fc_commit() already modifies the current
> process' IO priority to match that of the jbd2 thread, it should be
> reasonable to match jbd2's IO submission flags as well.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 42bee1d4f9f9..fa66b08de999 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -663,7 +663,7 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
>  
>  static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
>  {
> -	blk_opf_t write_flags = REQ_SYNC;
> +	blk_opf_t write_flags = JBD2_JOURNAL_REQ_FLAGS;
>  	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
>  
>  	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
> -- 
> 2.20.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

