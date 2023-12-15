Return-Path: <linux-ext4+bounces-454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A88CE814674
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D59D1F23AC4
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785C824B43;
	Fri, 15 Dec 2023 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFupcyHf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZEVb9TX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFupcyHf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tZEVb9TX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A10C200A8;
	Fri, 15 Dec 2023 11:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4B9AC1F828;
	Fri, 15 Dec 2023 11:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702638669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJVS2oCZA7iGNy5SHu2/UMxwIykwJv7+WJowuK1WpM=;
	b=yFupcyHf1GJcpb1iyxM2kBW9xOod2Tlii46OKeZjEjSAI7EimBUES/yF/bGZ3YvQFb9Qqt
	3JBJJRpVBZ/Azo3Qf1OdULZweBESj4h/8mIKZF/qiAhTSM5AzXdZvkcfzBPz7VKQ6HXPS9
	1bcYAci7s2HQaZMmWSHjnrCwAuQRGTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702638669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJVS2oCZA7iGNy5SHu2/UMxwIykwJv7+WJowuK1WpM=;
	b=tZEVb9TXLkP4hcgH0jffcqelwgxUIOvVGyJtY13YCg1stkpUi6yv2d6Tj6lnMhCnYwGP28
	Mn+WKBJNPNN00uDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702638669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJVS2oCZA7iGNy5SHu2/UMxwIykwJv7+WJowuK1WpM=;
	b=yFupcyHf1GJcpb1iyxM2kBW9xOod2Tlii46OKeZjEjSAI7EimBUES/yF/bGZ3YvQFb9Qqt
	3JBJJRpVBZ/Azo3Qf1OdULZweBESj4h/8mIKZF/qiAhTSM5AzXdZvkcfzBPz7VKQ6HXPS9
	1bcYAci7s2HQaZMmWSHjnrCwAuQRGTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702638669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RoJVS2oCZA7iGNy5SHu2/UMxwIykwJv7+WJowuK1WpM=;
	b=tZEVb9TXLkP4hcgH0jffcqelwgxUIOvVGyJtY13YCg1stkpUi6yv2d6Tj6lnMhCnYwGP28
	Mn+WKBJNPNN00uDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F6A613912;
	Fri, 15 Dec 2023 11:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id l/NyD000fGVeMQAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 15 Dec 2023 11:11:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDA62A07E0; Fri, 15 Dec 2023 12:11:08 +0100 (CET)
Date: Fri, 15 Dec 2023 12:11:08 +0100
From: Jan Kara <jack@suse.cz>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Jan Kara <jack@suse.cz>, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix inconsistent between segment fstrim and full
 fstrim
Message-ID: <20231215111108.5xgxhhm4nskq6syh@quack3>
References: <20231214064635.4128391-1-yebin10@huawei.com>
 <20231214085834.svce3mvfnctikwyq@quack3>
 <657AFDE6.1090606@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <657AFDE6.1090606@huawei.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4B9AC1F828
X-Spam-Level: 
X-Spam-Score: -4.31
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=yFupcyHf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tZEVb9TX

On Thu 14-12-23 21:06:46, yebin (H) wrote:
> 
> 
> On 2023/12/14 16:58, Jan Kara wrote:
> > On Thu 14-12-23 14:46:35, Ye Bin wrote:
> > > There will not issue discard cmd when do segment fstrim for ext4 fs, however,
> > > if full fstrim for the same fs will issue discard cmd.
> > > Above issue may happens as follows:
> > > Precondition:
> > > 1. Fstrim range [0, 15] and [16, 31];
> > > 2. Discard granularity is 16;
> > >              Range1          Range2
> > >        1111000000000000 0000111010101011
> > > There's no free space length large or equal than 16 in 'Range1' or 'Range2'.
> > > As ext4_try_to_trim_range() only search free space among range which user
> > > specified. However, there's maximum free space length 16 in 'Range1'+ 'Range2'.
> > > To solve above issue, we need to find the longest free space to discard.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > OK, I agree that there is this behavioral difference. However is that a
> > practical problem? I mean I would not expect the range to be particularly
> > small, rather something like 1GB and then these boundary conditions don't
> > really matter. This is also sensible so that we can properly track whether
> > the whole block group was trimmed or not. Finally I'd also argue that
> > trimming outside of specified range might be unexpected for the user. So a
> > *fix* for this in my opinion lays in userspace which needs to select
> > sensible ranges to use for trimming.
> > 
> > 								Honza
> Thanks for your reply.
> Our product fstrim entire file system, found to take a long time, thus
> affecting other processes.
> So they want to segment the file system fstrim based on the IO of the
> system. But they found
> that fragmented fstrims didn't work the same as fstrim  for the entire file
> system.
> Users do not know the distribution of free blocks in the file system, and
> they do not know the
> reasonable range. The user's simple perception is that the effect of
> segmented fstrim and full
> fstrim should be consistent.
> I researched the implementation of fstrim on the XFS file system, and for
> the scenario described
> in my patch, the results of both operations are consistent.

OK, we've discussed this on yesterday's ext4 call and we've came to a
conclusion that we don't care that much and consistency among filesystems
is good so I'll go back and review your patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

