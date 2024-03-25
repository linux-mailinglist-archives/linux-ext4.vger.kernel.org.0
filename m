Return-Path: <linux-ext4+bounces-1749-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C4F88AF39
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 20:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 580271C24523
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6D04C6D;
	Mon, 25 Mar 2024 19:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="277dbaH8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zHm5JTt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="277dbaH8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2zHm5JTt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2533A1C02
	for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393420; cv=none; b=YBMTh+UzuY3sAM1xaThiZOOFatRKi46LmVwqrmCr8FLy4aTcTcmLp41lwNdhllO9fVbDJAIGr3g1qcYOn/BkEnn59Ly3A5d4xxmXwrligBdKasezcgWHAveQvI0KUClHICAvz9cn+eOP/KkY/mmSYq+sSApSFzUKJ6LOzoJOSZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393420; c=relaxed/simple;
	bh=nbgXSVrSYuMqZieI5DjCMAMc8Wz90BtLPlAs3KEDy0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJB5fiGNo8/EbM2cO4LqDOnMuiF3pCwXeBDsMUgleXp8VWT3MIQG00sG3WnCOz3bF9d+vEGLRgnBZhbFtQbuTn/hYA4i65LN7GWQ92OSRqOOjTGU5797gQANw+DOwCkBP5KQukUxA33f1IQMhSPymQEYo3bxJCP0uf30U5q0YLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=277dbaH8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2zHm5JTt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=277dbaH8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2zHm5JTt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 383F85CA94;
	Mon, 25 Mar 2024 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xt3jBy0CyP/ENx8kGsp3Ah62Ww/A9lCsJjmyuQ3cq8=;
	b=277dbaH88SxviisiJH4mhbJfwN/gI9nU9jj/NFaVnHUXZSFzF/gZC/BlQYcpI08aGm2gQY
	zwvg+xdX2idwBtegKiFRQon0gu5oT7h8cHtkStwS8s3Z8MSkrOyG2rcriBbQl6rK3h5mL/
	Tv+N0CzL2pfTewGbAZBpJYSC6+7nK8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xt3jBy0CyP/ENx8kGsp3Ah62Ww/A9lCsJjmyuQ3cq8=;
	b=2zHm5JTt9xnIpc1QJDQ3+9JGjwLI+1FtjJD3w7aAwgfhCGBJztzrmq/K6cSaim2BAYzHXK
	4bQmVMGJ+yUZySAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1711393417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xt3jBy0CyP/ENx8kGsp3Ah62Ww/A9lCsJjmyuQ3cq8=;
	b=277dbaH88SxviisiJH4mhbJfwN/gI9nU9jj/NFaVnHUXZSFzF/gZC/BlQYcpI08aGm2gQY
	zwvg+xdX2idwBtegKiFRQon0gu5oT7h8cHtkStwS8s3Z8MSkrOyG2rcriBbQl6rK3h5mL/
	Tv+N0CzL2pfTewGbAZBpJYSC6+7nK8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1711393417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8Xt3jBy0CyP/ENx8kGsp3Ah62Ww/A9lCsJjmyuQ3cq8=;
	b=2zHm5JTt9xnIpc1QJDQ3+9JGjwLI+1FtjJD3w7aAwgfhCGBJztzrmq/K6cSaim2BAYzHXK
	4bQmVMGJ+yUZySAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2DF5E13A2E;
	Mon, 25 Mar 2024 19:03:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id rF8xC4nKAWYbZQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 25 Mar 2024 19:03:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BE3A5A0812; Mon, 25 Mar 2024 20:03:36 +0100 (CET)
Date: Mon, 25 Mar 2024 20:03:36 +0100
From: Jan Kara <jack@suse.cz>
To: Andreas Dilger <adilger@dilger.ca>
Cc: Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
	linux-ext4@vger.kernel.org,
	syzbot+a43d4f48b8397d0e41a9@syzkaller.appspotmail.com
Subject: Re: [PATCH 2/2] ext4: Do not create EA inode under buffer lock
Message-ID: <20240325190336.lgnoze44yrdjjb7o@quack3>
References: <20240209111418.22308-1-jack@suse.cz>
 <20240321162657.27420-2-jack@suse.cz>
 <79FE751F-CFA8-4C46-B3D7-507C6A3BCFD3@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79FE751F-CFA8-4C46-B3D7-507C6A3BCFD3@dilger.ca>
X-Spam-Score: 0.48
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=277dbaH8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=2zHm5JTt
X-Spamd-Bar: /
X-Spam-Flag: NO
X-Spamd-Result: default: False [0.48 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.01)[48.83%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 TAGGED_RCPT(0.00)[a43d4f48b8397d0e41a9];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 383F85CA94

On Fri 22-03-24 12:06:16, Andreas Dilger wrote:
> On Mar 21, 2024, at 10:26 AM, Jan Kara <jack@suse.cz> wrote:
> > 
> > ext4_xattr_set_entry() creates new EA inodes while holding buffer lock
> > on the external xattr block. This is problematic as it nests all the
> > allocation locking (which acquires locks on other buffers) under the
> > buffer lock. This can even deadlock when the filesystem is corrupted and
> > e.g. quota file is setup to contain xattr block as data block. Move the
> > allocation of EA inode out of ext4_xattr_set_entry() into the callers.
> 
> This looks like it will allocate a new inode for every setxattr called,
> even if the xattr is small and will likely fit inside the inode itself?
> This would seem to add a lot of extra overhead for the 99% of cases when
> an external inode is not needed.

This is not the case AFAICT. We call ext4_xattr_inode_lookup_create() only
in:

       if (i->value && i->in_inode) {

so that means we've already decided we need to put the xattr value in the
EA inode. Note that ext4_xattr_set_handle() for smaller xattr value first
calls ext4_xattr_block_set() with i.in_inode == 0 and if that fails due to
ENOSPC, it sets i.in_inode = 1 and tries again.

So I think everything is fine.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

