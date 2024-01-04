Return-Path: <linux-ext4+bounces-702-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 615018244E9
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E23351F22D29
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 15:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFF7241F7;
	Thu,  4 Jan 2024 15:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBfe4em3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cA3HhRsJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dBfe4em3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cA3HhRsJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC527241E7;
	Thu,  4 Jan 2024 15:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C3B5721DF7;
	Thu,  4 Jan 2024 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704382038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWbky96QGRcwFV5isIsGPDHire/PDOSyRwF8lmzP/DQ=;
	b=dBfe4em31QIE5R7CSUtW3D0QZPa8MOlx8fDV5S1iGAK42rZ7Po3nISOaPHW2uhDdjsYVQ8
	nYDd7zBm9HDobZ7st+MAJjfeZAVPWrEG5+bNK1fKYlXa/i77jLSiX438uwLXBmi9pD8L5s
	7dYHuYQWNVtkubvVWS10Y4WNmKVOGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704382038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWbky96QGRcwFV5isIsGPDHire/PDOSyRwF8lmzP/DQ=;
	b=cA3HhRsJSPma1JUPEOMAuGboHdH1B7m1qswm1PWd3HD8NBj1W0PB3+GwCmIU+OpIJUKQod
	yW3sm33pkT5nn+AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704382038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWbky96QGRcwFV5isIsGPDHire/PDOSyRwF8lmzP/DQ=;
	b=dBfe4em31QIE5R7CSUtW3D0QZPa8MOlx8fDV5S1iGAK42rZ7Po3nISOaPHW2uhDdjsYVQ8
	nYDd7zBm9HDobZ7st+MAJjfeZAVPWrEG5+bNK1fKYlXa/i77jLSiX438uwLXBmi9pD8L5s
	7dYHuYQWNVtkubvVWS10Y4WNmKVOGsw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704382038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KWbky96QGRcwFV5isIsGPDHire/PDOSyRwF8lmzP/DQ=;
	b=cA3HhRsJSPma1JUPEOMAuGboHdH1B7m1qswm1PWd3HD8NBj1W0PB3+GwCmIU+OpIJUKQod
	yW3sm33pkT5nn+AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB59313722;
	Thu,  4 Jan 2024 15:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XyKKVbOlmXXTgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 15:27:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 020E9A07EF; Thu,  4 Jan 2024 16:27:17 +0100 (CET)
Date: Thu, 4 Jan 2024 16:27:17 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	glandvador@yahoo.com, bugzilla@eyal.emu.id.au
Subject: Re: [PATCH 1/1] ext4: fallback to complex scan if aligned scan
 doesn't work
Message-ID: <20240104152717.rj7mmmij77q3mbiu@quack3>
References: <cover.1702455010.git.ojaswin@linux.ibm.com>
 <ee033f6dfa0a7f2934437008a909c3788233950f.1702455010.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee033f6dfa0a7f2934437008a909c3788233950f.1702455010.git.ojaswin@linux.ibm.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,yahoo.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,suse.cz,yahoo.com,eyal.emu.id.au];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.10

On Fri 15-12-23 16:49:50, Ojaswin Mujoo wrote:
> Currently in case the goal length is a multiple of stripe size we use
> ext4_mb_scan_aligned() to find the stripe size aligned physical blocks.
> In case we are not able to find any, we again go back to calling
> ext4_mb_choose_next_group() to search for a different suitable block
> group. However, since the linear search always begins from the start,
> most of the times we end up with the same BG and the cycle continues.
> 
> With large fliesystems, the CPU can be stuck in this loop for hours
> which can slow down the whole system. Hence, until we figure out a
> better way to continue the search (rather than starting from beginning)
> in ext4_mb_choose_next_group(), lets just fallback to
> ext4_mb_complex_scan_group() in case aligned scan fails, as it is much
> more likely to find the needed blocks.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

If I understand the difference right, the problem is that while
ext4_mb_choose_next_group() guarantees large enough free space extent for
the CR_GOAL_LEN_FAST or CR_BEST_AVAIL_LEN passes, it does not guaranteed
large enough *aligned* free space extent. Thus for non-aligned allocations
we can fail only due to a race with another allocating process but with
aligned allocations we can consistently fail in ext4_mb_scan_aligned() and
thus livelock in the allocation loop.

If my understanding is correct, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza



> ---
>  fs/ext4/mballoc.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d72b5e3c92ec..63f12ec02485 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2895,14 +2895,19 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
>  			ac->ac_groups_scanned++;
>  			if (cr == CR_POWER2_ALIGNED)
>  				ext4_mb_simple_scan_group(ac, &e4b);
> -			else if ((cr == CR_GOAL_LEN_FAST ||
> -				 cr == CR_BEST_AVAIL_LEN) &&
> -				 sbi->s_stripe &&
> -				 !(ac->ac_g_ex.fe_len %
> -				 EXT4_B2C(sbi, sbi->s_stripe)))
> -				ext4_mb_scan_aligned(ac, &e4b);
> -			else
> -				ext4_mb_complex_scan_group(ac, &e4b);
> +			else {
> +				bool is_stripe_aligned = sbi->s_stripe &&
> +					!(ac->ac_g_ex.fe_len %
> +					  EXT4_B2C(sbi, sbi->s_stripe));
> +
> +				if ((cr == CR_GOAL_LEN_FAST ||
> +				     cr == CR_BEST_AVAIL_LEN) &&
> +				    is_stripe_aligned)
> +					ext4_mb_scan_aligned(ac, &e4b);
> +
> +				if (ac->ac_status == AC_STATUS_CONTINUE)
> +					ext4_mb_complex_scan_group(ac, &e4b);
> +			}
>  
>  			ext4_unlock_group(sb, group);
>  			ext4_mb_unload_buddy(&e4b);
> -- 
> 2.39.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

