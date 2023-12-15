Return-Path: <linux-ext4+bounces-458-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F58146FC
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 212DCB2206E
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E60724B51;
	Fri, 15 Dec 2023 11:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ptBjiITD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/NHZ4qxo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jh+aIxpm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2BojIiIZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E888025108;
	Fri, 15 Dec 2023 11:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDDB71FDCA;
	Fri, 15 Dec 2023 11:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702639959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch9KDenXdp/5Ki9hzmzpgc/jFeodkIRAf7QtZ5Pf31M=;
	b=ptBjiITDTLVs0/sWwrt5pnYuHuKgoAMTvjCpZZ0JLWFkBftq1FRqGq2Amf1Xa3ePWbca8z
	1YZmHW3/vA97/yYuBQpHhgQaz2FJ0aw6lYKQkY0aJncW6JZs0HuCIRQBIvYC8exlUTCCQF
	GHdiq9nFqp8bga5+dEn/GYFPREZlims=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702639959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch9KDenXdp/5Ki9hzmzpgc/jFeodkIRAf7QtZ5Pf31M=;
	b=/NHZ4qxobLLZnSt3y5uTyd6njcGHH/Uab19Sx1ziX8Dm6xdM48zJ4HXLrIDp4VajtOioKo
	EVBxs9ab4xzRZLAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702639958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch9KDenXdp/5Ki9hzmzpgc/jFeodkIRAf7QtZ5Pf31M=;
	b=jh+aIxpmQ791zdzGBzYPKHrgoPXVgdUb0BmAHcpRe/8VoF+uezfhst9R9hhNVrs9ey5onS
	YORZNBet+6HyNQlANnoU+1utqmtsiEatgzV2uKpjZTjBpUC9PLiIy0+odbmd5R+dNoILlE
	IPXHcaC2Y/H+Kwyf6NImtQnTYs3g2JA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702639958;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch9KDenXdp/5Ki9hzmzpgc/jFeodkIRAf7QtZ5Pf31M=;
	b=2BojIiIZs0Q4BE2T0Eznm7hpxs5q4sJhh/dbSavNzxMoe0hxx81hLU1RaxX8qCLsBvA5pS
	FT2s7z0vZmtl6ZAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DB5EF13912;
	Fri, 15 Dec 2023 11:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ezSFNVY5fGXLNwAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 11:32:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 526CFA07E0; Fri, 15 Dec 2023 12:32:34 +0100 (CET)
Date: Fri, 15 Dec 2023 12:32:34 +0100
From: Jan Kara <jack@suse.cz>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
Message-ID: <20231215113234.pevkthg57m4kyjwq@quack3>
References: <20231214064635.4128391-1-yebin10@huawei.com>
 <20231214085834.svce3mvfnctikwyq@quack3>
 <657AFDE6.1090606@huawei.com>
 <20231215111108.5xgxhhm4nskq6syh@quack3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111108.5xgxhhm4nskq6syh@quack3>
X-Spam-Level: 
X-Spam-Score: -3.79
X-Spam-Flag: NO
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.60 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -2.60

Remembered one more thing to note:

On Fri 15-12-23 12:11:08, Jan Kara wrote:
> On Thu 14-12-23 21:06:46, yebin (H) wrote:
> > On 2023/12/14 16:58, Jan Kara wrote:
> > > On Thu 14-12-23 14:46:35, Ye Bin wrote:
> > > > There will not issue discard cmd when do segment fstrim for ext4 fs, however,
> > > > if full fstrim for the same fs will issue discard cmd.
> > > > Above issue may happens as follows:
> > > > Precondition:
> > > > 1. Fstrim range [0, 15] and [16, 31];
> > > > 2. Discard granularity is 16;
> > > >              Range1          Range2
> > > >        1111000000000000 0000111010101011
> > > > There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
> > > > As ext4_try_to_trim_range() only search free space among range which user
> > > > specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
> > > > To solve above issue, we need to find the longest free space to discard.
> > > > 
> > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > OK, I agree that there is this behavioral difference. However is that a
> > > practical problem? I mean I would not expect the range to be particularly
> > > small, rather something like 1GB and then these boundary conditions don't
> > > really matter. This is also sensible so that we can properly track whether
> > > the whole block group was trimmed or not. Finally I'd also argue that
> > > trimming outside of specified range might be unexpected for the user. So a
> > > *fix* for this in my opinion lays in userspace which needs to select
> > > sensible ranges to use for trimming.
> > > 
> > > 								Honza
> > Thanks for your reply.
>
> > Our product fstrim entire file system, found to take a long time, thus
> > affecting other processes.  So they want to segment the file system
> > fstrim based on the IO of the system. But they found that fragmented
> > fstrims didn't work the same as fstrim  for the entire file system.

So I agree that trimming the whole fs at once may take too long. But also
note that if you make ranges smaller than block group size (128MB with 4k
block size), then we will never record that the group has been fully
trimmed and thus we will always trim all free extents in a group even
though there was no allocation there since the last trim. So in this sense
trims split to small ranges will not be equivalent to a large trim even
after your change.

> > Users do not know the distribution of free blocks in the file system,
> > and they do not know the reasonable range. The user's simple perception
> > is that the effect of segmented fstrim and full fstrim should be
> > consistent.

Personally I don't see a good reason to make trim range smaller than 1GB,
it just adds overhead, but I understand it may be a bit surprising.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

