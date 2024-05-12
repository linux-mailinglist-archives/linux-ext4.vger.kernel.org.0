Return-Path: <linux-ext4+bounces-2483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FA08C4242
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 15:43:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0B81C21243
	for <lists+linux-ext4@lfdr.de>; Mon, 13 May 2024 13:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087811534F5;
	Mon, 13 May 2024 13:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyLaJgzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7doSbCKU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyLaJgzv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7doSbCKU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9499B153511;
	Mon, 13 May 2024 13:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715607699; cv=none; b=GkBipb6ocl73plMkfjmiPRZlVP9l64XhNRE4yobc592+AGMZtDNFj300aGTmPvGFypQ5qhiYyNIUNGsQ4hm+l3iE0WVea1riyWYWEuIn9DQoGjqwhn3RM7uYcerz2t5YniOgcITPzyyRTeeduSmIKMZRRRaBH7HksOlSTctzwZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715607699; c=relaxed/simple;
	bh=TFWqmx7gsUmd8y6epgKE4Gj5LRHwSK2LTOnmU/I8vzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHBnfZiL95SH7OmGk7aS2/8+abfPNhFsMMEDm54q8YmCQD0yBHmM6l2gy7oEBQvOw/VEIIXqsNDt1WDSYYUS/PTk94pQfBM7+f9ukOsYxHN8tl4rdJXEVhLn6kwxl5HI/BvCT3NjaLJmPCtjB4nZe7/r6X+FNRThnuR/Zfs9v2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyLaJgzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7doSbCKU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyLaJgzv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7doSbCKU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C39045C0D0;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZwCBjFjZwH1ZyV1/ey+Bv4vJwyjA11mMqemQxTFYrU=;
	b=jyLaJgzvHrzkcKr2chrR5491gEoIPfXDE/1hA6ZFbCNJXFSM+lup3Mt7x/pimneYTr3SmW
	rCk4VjUAt+LLmDioCXfSlUSCHhAxN7LRPd/QwPIwQ2q19LpwRQL+8CNx84JG4IwGYxolfv
	To1omKa+ce+vCs6fGfX84DfeJIpkvlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZwCBjFjZwH1ZyV1/ey+Bv4vJwyjA11mMqemQxTFYrU=;
	b=7doSbCKU4NsYVpvHWOcSOpC2Jo70cqh9tZU7EsU0eZW1PTVIc9bmQhuwNvQvazGjAUGX7T
	lcypZWzUFbe2PECQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jyLaJgzv;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7doSbCKU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1715607695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZwCBjFjZwH1ZyV1/ey+Bv4vJwyjA11mMqemQxTFYrU=;
	b=jyLaJgzvHrzkcKr2chrR5491gEoIPfXDE/1hA6ZFbCNJXFSM+lup3Mt7x/pimneYTr3SmW
	rCk4VjUAt+LLmDioCXfSlUSCHhAxN7LRPd/QwPIwQ2q19LpwRQL+8CNx84JG4IwGYxolfv
	To1omKa+ce+vCs6fGfX84DfeJIpkvlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1715607695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cZwCBjFjZwH1ZyV1/ey+Bv4vJwyjA11mMqemQxTFYrU=;
	b=7doSbCKU4NsYVpvHWOcSOpC2Jo70cqh9tZU7EsU0eZW1PTVIc9bmQhuwNvQvazGjAUGX7T
	lcypZWzUFbe2PECQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 875C313A5C;
	Mon, 13 May 2024 13:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oScGIY8YQmZCDwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 May 2024 13:41:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B16A8A08D9; Sun, 12 May 2024 12:14:14 +0200 (CEST)
Date: Sun, 12 May 2024 12:14:14 +0200
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Zhang Yi <yi.zhang@huaweicloud.com>, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, jack@suse.com
Subject: Re: [PATCH 2/9] jbd2: remove unused return info from
 jbd2_journal_write_metadata_buffer
Message-ID: <20240512101414.mmslrwpypqyretvg@quack3>
References: <20240506141801.1165315-1-shikemeng@huaweicloud.com>
 <20240506141801.1165315-3-shikemeng@huaweicloud.com>
 <97dbc0cd-5676-9e92-931c-5873f2e207cd@huaweicloud.com>
 <ba9e9257-b309-17aa-9c1d-b4730bc2a91e@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9e9257-b309-17aa-9c1d-b4730bc2a91e@huaweicloud.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	DATE_IN_PAST(1.00)[27];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C39045C0D0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Wed 08-05-24 09:42:30, Kemeng Shi wrote:
> 
> 
> on 5/7/2024 7:51 PM, Zhang Yi wrote:
> > On 2024/5/6 22:17, Kemeng Shi wrote:
> >> The done_copy_out info from jbd2_journal_write_metadata_buffer is not
> >> used. Simply remove it.
> >>
> >> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> >> ---
> >>  fs/jbd2/journal.c | 3 +--
> >>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>
> >> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> >> index 207b24e12ce9..068031f35aea 100644
> >> --- a/fs/jbd2/journal.c
> >> +++ b/fs/jbd2/journal.c
> >> @@ -320,7 +320,6 @@ static void journal_kill_thread(journal_t *journal)
> >>   *
> >>   * On success:
> >>   * Bit 0 set == escape performed on the data
> >> - * Bit 1 set == buffer copy-out performed (kfree the data after IO)
> >>   */
> >>  
> >>  int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
> >> @@ -455,7 +454,7 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
> >>  	set_buffer_shadow(bh_in);
> >>  	spin_unlock(&jh_in->b_state_lock);
> >>  
> >> -	return do_escape | (done_copy_out << 1);
> >> +	return do_escape;
> >>  }
> >>  
> > 
> > I checked the history, it seems that this bit has not been used since
> > the very beginning when the jbd code was merged in, I suppose we could
> > drop it. Since there is only one flag that is still in use, why not just
> > drop the flag and pass out do_escape through an output parameter, or
> > directly pass tag_flag, after that we could also drop the weird
> > "if (flags & 1)" check in jbd2_journal_commit_transaction()?
> Thanks for looking into this. I agree that the "flags & 1" is wired, I
> wonder if we could further remove "flags & 1" with following change:
> 
> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
> index 5e122586e06e..67077308b56b 100644
> --- a/fs/jbd2/commit.c
> +++ b/fs/jbd2/commit.c
> @@ -353,7 +353,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>         struct buffer_head *descriptor;
>         struct buffer_head **wbuf = journal->j_wbuf;
>         int bufs;
> -       int flags;
> +       int escape;
>         int err;
>         unsigned long long blocknr;
>         ktime_t start_time;
> @@ -661,10 +661,10 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>                  */
>                 set_bit(BH_JWrite, &jh2bh(jh)->b_state);
>                 JBUFFER_TRACE(jh, "ph3: write metadata");
> -               flags = jbd2_journal_write_metadata_buffer(commit_transaction,
> +               escape = jbd2_journal_write_metadata_buffer(commit_transaction,
>                                                 jh, &wbuf[bufs], blocknr);
> -               if (flags < 0) {
> -                       jbd2_journal_abort(journal, flags);
> +               if (escape < 0) {
> +                       jbd2_journal_abort(journal, escape);
>                         continue;
>                 }
>                 jbd2_file_log_bh(&io_bufs, wbuf[bufs]);
> @@ -673,7 +673,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>                     buffer */
> 
>                 tag_flag = 0;
> -               if (flags & 1)
> +               if (escape)
>                         tag_flag |= JBD2_FLAG_ESCAPE;
>                 if (!first_tag)
>                         tag_flag |= JBD2_FLAG_SAME_UUID;
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 08c59197c5bd..c8a1eca5caab 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -309,10 +309,8 @@ static void journal_kill_thread(journal_t *journal)
>   *
>   * Return value:
>   *  <0: Error
> - * >=0: Finished OK
> - *
> - * On success:
> - * Bit 0 set == escape performed on the data
> + *  =0: Finished OK without escape
> + *  =1: Finished OK with escape
>   */
> 
> Look forward to your reply.

Yep, looks like a fine solution to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

