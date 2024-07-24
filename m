Return-Path: <linux-ext4+bounces-3414-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1296693AFB5
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 12:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F951C21FD7
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432B8155C98;
	Wed, 24 Jul 2024 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2Mh4BBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ovl9IOcd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="B2Mh4BBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ovl9IOcd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F35F14A618;
	Wed, 24 Jul 2024 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721816112; cv=none; b=btBMfkUEvOsuRY6XiiRqze6wR5XFTtv4XS3cmYgpRAYv17UjiRr0oLFnHZYqcaFFqg4PtjDc5mto+DJIORg9ZgZTzWac/IpbI9TMkaLfCKT2sIh9WqZN45LgbuWfwoqDNXAimK9WXeAVC88bKT7ST96knE1j5ReM0hibxAoFMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721816112; c=relaxed/simple;
	bh=gMGnZ6vAi1TBGIlDPlcFjeJxO6InTr9Zb7RaHcMoWeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcHJ0gORv9F7TR+drINaso2n3QAmFFgZ/o8A9k6bsqvmGjyHSmkjiIn5rxrOUnM503WN6NvxZQtrliKws2qo6MNHCKqfKE+DB27+2+6VFIctSgNGcA/TLB3vde9DQYXipXO3k9j2NUnMmnPCNFlSfoVOszNwynTgtV9B3xoYcjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2Mh4BBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ovl9IOcd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=B2Mh4BBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ovl9IOcd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 243AC1FBF8;
	Wed, 24 Jul 2024 10:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721816109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=barI9SfZtaPAnTW7KMHJGM2nNuO7dzVRbMEjHFzGg3M=;
	b=B2Mh4BBjpy9afesBdwG7r/u2SKY7CQ3szUTOu1XutRHvr6e+eL3EgRWzJ6IL+iBa3n1o0/
	0DWkycSepzMAgKEZZuhoDrLx567XsVc4nUJxiDlO6euJXvUeg6lk+sNYlRwgYC41FuGSxi
	h4e/vWmeGBOdwSae+cG654PVUZPGn1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721816109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=barI9SfZtaPAnTW7KMHJGM2nNuO7dzVRbMEjHFzGg3M=;
	b=Ovl9IOcdBByQFAQ7jDT0Op0rE5A1S9lcZ9iSS466yqztcwS5wzoOSYrtRnY7BSuIszYgYY
	uuI6x/lTTn8VLFCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=B2Mh4BBj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Ovl9IOcd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721816109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=barI9SfZtaPAnTW7KMHJGM2nNuO7dzVRbMEjHFzGg3M=;
	b=B2Mh4BBjpy9afesBdwG7r/u2SKY7CQ3szUTOu1XutRHvr6e+eL3EgRWzJ6IL+iBa3n1o0/
	0DWkycSepzMAgKEZZuhoDrLx567XsVc4nUJxiDlO6euJXvUeg6lk+sNYlRwgYC41FuGSxi
	h4e/vWmeGBOdwSae+cG654PVUZPGn1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721816109;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=barI9SfZtaPAnTW7KMHJGM2nNuO7dzVRbMEjHFzGg3M=;
	b=Ovl9IOcdBByQFAQ7jDT0Op0rE5A1S9lcZ9iSS466yqztcwS5wzoOSYrtRnY7BSuIszYgYY
	uuI6x/lTTn8VLFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1524313411;
	Wed, 24 Jul 2024 10:15:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sTaaBC3UoGZFYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 10:15:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A7697A0990; Wed, 24 Jul 2024 12:15:04 +0200 (CEST)
Date: Wed, 24 Jul 2024 12:15:04 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: fix incorrect tid assumption in
 ext4_fc_mark_ineligible()
Message-ID: <20240724101504.e2t4pvgw6td7rrmm@quack3>
References: <20240723154402.21125-1-luis.henriques@linux.dev>
 <20240723154402.21125-5-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723154402.21125-5-luis.henriques@linux.dev>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.81 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.81
X-Rspamd-Queue-Id: 243AC1FBF8

On Tue 23-07-24 16:44:02, Luis Henriques (SUSE) wrote:
> Function jbd2_journal_shrink_checkpoint_list() assumes that '0' is not a
> valid value for transaction IDs, which is incorrect.
> 
> Furthermore, the sbi->s_fc_ineligible_tid handling also makes the same
> assumption by being initialised to '0'.  Fortunately, the sb flag
> EXT4_MF_FC_INELIGIBLE can be used to check whether sbi->s_fc_ineligible_tid
> has been previously set instead of comparing it with '0'.
> 
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Just one style nit below, otherwise looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

BTW, the ineligibility handling looks flaky to me, in particular the cases
where we call ext4_fc_mark_ineligible() with NULL handle seem racy to me as
fastcommit can happen *before* we mark the filesystem as ineligible.  But
that's not really related to your changes, they just made me look at that
code in detail and I couldn't resist complaining :)

> ---
>  fs/ext4/fast_commit.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3926a05eceee..3e0793cfea38 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -339,22 +339,29 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>  {
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	tid_t tid;
> +	bool has_transaction = true;
> +	bool is_ineligible;
>  
>  	if (ext4_fc_disabled(sb))
>  		return;
>  
> -	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
>  	if (handle && !IS_ERR(handle))
>  		tid = handle->h_transaction->t_tid;
>  	else {
>  		read_lock(&sbi->s_journal->j_state_lock);
> -		tid = sbi->s_journal->j_running_transaction ?
> -				sbi->s_journal->j_running_transaction->t_tid : 0;
> +		if (sbi->s_journal->j_running_transaction)
> +			tid = sbi->s_journal->j_running_transaction->t_tid;
> +		else
> +			has_transaction = false;
>  		read_unlock(&sbi->s_journal->j_state_lock);
>  	}
>  	spin_lock(&sbi->s_fc_lock);
> -	if (tid_gt(tid, sbi->s_fc_ineligible_tid))
> +	is_ineligible = ext4_test_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
> +	if (has_transaction &&
> +	    ((!is_ineligible) ||
	     ^^ these extra braces look strange

> +	     (is_ineligible && tid_gt(tid, sbi->s_fc_ineligible_tid))))
>  		sbi->s_fc_ineligible_tid = tid;
> +	ext4_set_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

