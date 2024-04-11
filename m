Return-Path: <linux-ext4+bounces-2031-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 565E28A15B9
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 15:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB63B1F24484
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Apr 2024 13:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727EC14D29C;
	Thu, 11 Apr 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v+FpaYUi";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EG8vViw2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kI6MuY7m";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="U1v7pCeI"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED140C09;
	Thu, 11 Apr 2024 13:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712842645; cv=none; b=Xyy4WJgklWtVj2xzrmc+icW8+kq0myVhKLK0OeECw/osHvuGPbOkG3R7C800Z9GlvOMo6gq8kKTomuoJYdcs3bOJ5gMc91wAACxl7t4t/ByMlDzv0tdKn/FvMjIXaQ2RZGIlzhO38f5jBkUvPhJcCj7zqEVswlxjfNMRJxRX4jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712842645; c=relaxed/simple;
	bh=Gov5da9+2mwv1ZNdu7x32Xa3aWMrPpVACIDy2ibKlhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tds2kV2irGKwAL5skmVvXNKb8iAUL//4s/S2H5wKzE8vi5a/L4D0gJZS0wg4nz7Gr3JI3+o8eYfkJgw7MT4roheJIKbO0zeDbdzUDsGcJSRrQzysr52QdA2YTUtGjr5g4hRGjup4sB7ZZbn7pEnAo7CEeN1KfDHSVZFt0uj04Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v+FpaYUi; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EG8vViw2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kI6MuY7m; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=U1v7pCeI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 12B63211F2;
	Thu, 11 Apr 2024 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712842640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=230ULb+KJLSRLQGrt8PgfUIPhmHoza//HzB4A0PIuXs=;
	b=v+FpaYUiYC8Jzk7w9vRRKw028kDOYnV7yIEpU1p4Pbh7k2hf+xQL8SIbh21F5SGpy9i3NV
	6IwzAhRCtaD3UGgtTsMplcRJaqOFTTcbi1J/SLKUiExOh4mwJ4oalaT4TjhrSLMShLbWLp
	FRRp6KOb5v4CT92EjoNSYXpQ4gSKhjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712842640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=230ULb+KJLSRLQGrt8PgfUIPhmHoza//HzB4A0PIuXs=;
	b=EG8vViw2buJfKTBaFkZ2e7wc3AYmfMNYxqyzIawxGN0IU8GoKjb5XY6BRRAQg2NqzQkSwA
	MAXhkCD2L9ffoDDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kI6MuY7m;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=U1v7pCeI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712842639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=230ULb+KJLSRLQGrt8PgfUIPhmHoza//HzB4A0PIuXs=;
	b=kI6MuY7mUjHl5pIXmdKV0O+BsqHGlmEtdyUuTf1wg7t9geu7ieH+/MiUuvDsX9YIYsCBJi
	CF+ex6w1DY/ZmOqDHcYiDQohDRMMZFkqdDKP/dPha2vzW4RErbgR6TK492+MA89krNCO9w
	536TrPHUL+46hqTUJwWh6g0RkXxawJA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712842639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=230ULb+KJLSRLQGrt8PgfUIPhmHoza//HzB4A0PIuXs=;
	b=U1v7pCeIJMlqspYvhhDp256151uYSP1kO7EAqMSr26Fkn0fBOx1PquPBmNaHevw+LuEQgD
	B2Xwcwmv5FgCw1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0314139DE;
	Thu, 11 Apr 2024 13:37:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K/2bOo7nF2aRMwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 11 Apr 2024 13:37:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 95C68A082F; Thu, 11 Apr 2024 15:37:18 +0200 (CEST)
Date: Thu, 11 Apr 2024 15:37:18 +0200
From: Jan Kara <jack@suse.cz>
To: "yebin (H)" <yebin10@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240411133718.tq74yorf6odpla4r@quack3>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
 <20240403033742.GE1189142@mit.edu>
 <20240403101122.rmffivvvf4a33qis@quack3>
 <6611F8D5.3030403@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6611F8D5.3030403@huawei.com>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 12B63211F2
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]

On Sun 07-04-24 09:37:25, yebin (H) wrote:
> On 2024/4/3 18:11, Jan Kara wrote:
> > On Tue 02-04-24 23:37:42, Theodore Ts'o wrote:
> > > On Tue, Apr 02, 2024 at 03:42:40PM +0200, Jan Kara wrote:
> > > > On Tue 02-04-24 17:09:51, Ye Bin wrote:
> > > > > We encountered a problem that the file system could not be mounted in
> > > > > the power-off scenario. The analysis of the file system mirror shows that
> > > > > only part of the data is written to the last commit block.
> > > > > To solve above issue, if commit block checksum is incorrect, check the next
> > > > > block if has valid magic and transaction ID. If next block hasn't valid
> > > > > magic or transaction ID then just drop the last transaction ignore checksum
> > > > > error. Theoretically, the transaction ID maybe occur loopback, which may cause
> > > > > the mounting failure.
> > > > > 
> > > > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > > > So this is curious. The commit block data is fully within one sector and
> > > > the expectation of the journaling is that either full sector or nothing is
> > > > written. So what kind of storage were you using that it breaks these
> > > > expectations?
> > > I suppose if the physical sector size is 512 bytes, and the file
> > > system block is 4k, I suppose it's possible that on a crash, that part
> > > of the 4k commit block could be written.
> > I was thinking about that as well but the commit block looks like:
> > 
> > truct commit_header {
> >          __be32          h_magic;
> >          __be32          h_blocktype;
> >          __be32          h_sequence;
> >          unsigned char   h_chksum_type;
> >          unsigned char   h_chksum_size;
> >          unsigned char   h_padding[2];
> >          __be32          h_chksum[JBD2_CHECKSUM_BYTES];
> >          __be64          h_commit_sec;
> >          __be32          h_commit_nsec;
> > };
> > 
> > where JBD2_CHECKSUM_BYTES is 8. So all the data in the commit block
> > including the checksum is in the first 60 bytes. Hence I would be really
> > surprised if some storage can tear that...
> This issue has been encountered a few times in the context of eMMC devices.
> The vendor
> has confirmed that only 512-byte atomicity can be ensured in the firmware.
> Although the valid data is only 60 bytes, the entire commit block is used
> for calculating
> the checksum.
> jbd2_commit_block_csum_verify:
> ...
> calculated = jbd2_chksum(j, j->j_csum_seed, buf, j->j_blocksize);
> ...

Ah, indeed. This is the bit I've missed. Thanks for explanation! Still I
think trying to somehow automatically deal with wrong commit block checksum
is too dangerous because it can result in fs corruption in some (unlikely)
cases. OTOH I understand journal replay failure after a power fail isn't
great either so we need to think how to fix this...

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

