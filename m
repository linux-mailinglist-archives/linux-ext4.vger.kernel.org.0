Return-Path: <linux-ext4+bounces-9813-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB9BB4369C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 11:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC12A163BA8
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Sep 2025 09:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1A92DBF48;
	Thu,  4 Sep 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tBi1WHIH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/bQFlyvW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tBi1WHIH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/bQFlyvW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F61286D57
	for <linux-ext4@vger.kernel.org>; Thu,  4 Sep 2025 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756976774; cv=none; b=WumBvNvyzEU7I1ymYh4bvUnLDAjaxG1DDbq0TEhUN4YJrIAUtaUgwc5NP8tlNS72YNdC7aRjs35D1KoJJges0nlWZoOYEX2c2eaWFTzoFRdGpxvypk5Y2Joi2q/nlxOK/ao6qTJ1AqX8kWo1OB8D798259kweOPeJOBKK3F3dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756976774; c=relaxed/simple;
	bh=nsaCSXt2yQa6IDIJA5Ig7dOP9O6X9m7Pm/iBimiNqgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rddqLyh2Gy4X8dLYsdb5bdLc9UQ7d+dfyqcM4JVJsiCKIKGe4OfyX16tPoUJtVGKLw44VU9hNThMIywQzv+s+69NTVsy2f/9BXeOi3AH5Dgwqd2+bJURV7oBj5Qu+u1ibkVDD9KeJlRfGYcbZHIIKeIQ7cTidcvvmKPgDB8hI54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tBi1WHIH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/bQFlyvW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tBi1WHIH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/bQFlyvW; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9D89933F64;
	Thu,  4 Sep 2025 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756976770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir2vIwHR2GJOd21YxMNJWDyUVQ3YT/MogUridkZD58U=;
	b=tBi1WHIHKqnCyutqsVqBfv7qIwbkwBp6qMqOOZtXgBv2T4snTpvzPZQOufnRzRYiI9GcRd
	A64Vks3FLZA8bp3ao6ODdNu1O7CZCvvKk22RqxbiWFo/VJnbUXm8AISWXgPSQfixpFkH2E
	wvEvmRE9hfha9xLyyI2GRFsVLQhvcbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756976770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir2vIwHR2GJOd21YxMNJWDyUVQ3YT/MogUridkZD58U=;
	b=/bQFlyvW/enUh225xu9ZNqRm0RS1JhgmLg5W3R7fGHSvUrznv3eWiea2qtdAkTQzIvUaeI
	K44VnDlcq2YFFjAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tBi1WHIH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/bQFlyvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1756976770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir2vIwHR2GJOd21YxMNJWDyUVQ3YT/MogUridkZD58U=;
	b=tBi1WHIHKqnCyutqsVqBfv7qIwbkwBp6qMqOOZtXgBv2T4snTpvzPZQOufnRzRYiI9GcRd
	A64Vks3FLZA8bp3ao6ODdNu1O7CZCvvKk22RqxbiWFo/VJnbUXm8AISWXgPSQfixpFkH2E
	wvEvmRE9hfha9xLyyI2GRFsVLQhvcbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1756976770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ir2vIwHR2GJOd21YxMNJWDyUVQ3YT/MogUridkZD58U=;
	b=/bQFlyvW/enUh225xu9ZNqRm0RS1JhgmLg5W3R7fGHSvUrznv3eWiea2qtdAkTQzIvUaeI
	K44VnDlcq2YFFjAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9326A13675;
	Thu,  4 Sep 2025 09:06:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xFDnI4JWuWi9FAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Sep 2025 09:06:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 443A3A0A2D; Thu,  4 Sep 2025 11:06:10 +0200 (CEST)
Date: Thu, 4 Sep 2025 11:06:10 +0200
From: Jan Kara <jack@suse.cz>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Sun Yongjian <sunyongjian1@huawei.com>, 
	linux-ext4@vger.kernel.org, yangerkun@huawei.com, yi.zhang@huawei.com, libaokun1@huawei.com, 
	tytso@mit.edu
Subject: Re: [PATCH -next] ext4: add an update to i_disksize in
 ext4_block_page_mkwrite
Message-ID: <4d4dahpbk33ntrqaz26lahxpqx2zox2jwowz6thnlzdy4u2sd4@zhpgpwtga5sd>
References: <ksmu3jz7ll2kp3xwemvil56ntzljrdaamv5hmdj7dbjniqsprv@25ypuymdslac>
 <68b91720.170a0220.23bef.d913@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <68b91720.170a0220.23bef.d913@mx.google.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 9D89933F64
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -2.51

On Thu 04-09-25 09:33:56, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> > On Mon 01-09-25 15:01:45, Sun Yongjian wrote:
> >> 在 2025/7/31 22:05, sunyongjian@huaweicloud.com 写道:
> >> Gentle ping.
> >> > From: Yongjian Sun <sunyongjian1@huawei.com>
> >> > 
> >> > After running a stress test combined with fault injection,
> >> > we performed fsck -a followed by fsck -fn on the filesystem
> >> > image. During the second pass, fsck -fn reported:
> >> > 
> >> > Inode 131512, end of extent exceeds allowed value
> >> > 	(logical block 405, physical block 1180540, len 2)
> >> > 
> >> > This inode was not in the orphan list.
> >
> > Thanks for report! Interesting... Which kernel were you using?
> >
> >> > Analysis revealed the
> >> > following call chain that leads to the inconsistency:
> >> > 
> >> >                               ext4_da_write_end()
> >> >                                //does not update i_disksize
> >
> > Right, for any write beyond i_disksize to unallocated blocks we update
> > i_disksize only during page writeback.
> >
> >> >                               ext4_punch_hole()
> >> >                                //truncate folio, keep size
> >
> > So here offset + len passed to ext4_punch_hole() is important. Because
> > there's ext4_update_disksize_before_punch() call which updates i_disksize
> > to i_size if the punched hole reaches EOF. So did you punch hole in the
> > middle of the file?
> >
> >> > ext4_page_mkwrite()
> >> >   ext4_block_page_mkwrite()
> >> >    ext4_block_write_begin()
> >> >      ext4_get_block()
> >> >       //insert written extent without update i_disksize
> >
> > We should insert unwritten extent here, shouldn't we? We use
> > ext4_get_block_unwritten() when we are inside i_size. Ah, you mention below
> > you use nodioread_nolock. Nasty :)
> >
> >> > journal commit
> >> > echo 1 > /sys/block/xxx/device/delete
> >> > 
> >> > da-write path updates i_size but does not update i_disksize. Then
> >> > ext4_punch_hole truncates the da-folio yet still leaves i_disksize
> >> > unchanged. Then ext4_page_mkwrite sees ext4_nonda_switch return 1
> >> > and takes the nodioread_nolock path, the folio about to be written
> >> > has just been punched out, and it’s offset sits beyond the current
> >> > i_disksize. This may result in a written extent being inserted, but
> >> > again does not update i_disksize. If the journal gets committed and
> >> > then the block device is yanked, we might run into this.
> >> > 
> >> > To fix this, we now check in ext4_block_page_mkwrite whether
> >> > i_disksize needs to be updated to cover the newly allocated blocks.
> >> > 
> >> > Signed-off-by: Yongjian Sun <sunyongjian1@huawei.com>
> >
> > Hum, rather than complicating this niche code what if we just
> > unconditionally used ext4_get_block_unwritten() in
> > ext4_block_page_mkwrite() when delalloc gets disabled? It is far from any
> > performance critical path. What do people think? The code would actually
> > have to be something like:
> >
> > 	if (ext4_should_journal_data(inode))
> > 		get_block = ext4_get_block;
> > 	else
> > 		get_block = ext4_get_block_unwritten;
> >
> 
> The problem mainly was when e2fsck identify a written extent beyond
> i_disksize. But if it is unwritten extent, then we are still good. So
> using ext4_get_block_unwritten() by default in page fault path make
> sense.
> 
> So what about other checks like S_ISREG() and file with indirect blocks
> in ext4_should_dioread_nolock()? We still need ext4_get_block() for them right? 
> (Do we even fault on !S_ISREG() :) ?)

S_ISREG() is always true for page faults but I forgot about indirect block
based inodes, there we indeed cannot create unwritten extent. Drat, so
probably what Sun suggests is the easiest solution in the end. Going back
to his patch.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

