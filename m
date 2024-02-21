Return-Path: <linux-ext4+bounces-1340-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C4385E3D9
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B867B21BAB
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Feb 2024 16:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC4782D9F;
	Wed, 21 Feb 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="thqdSiY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z1ugZmnm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="thqdSiY4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z1ugZmnm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D4A8062A
	for <linux-ext4@vger.kernel.org>; Wed, 21 Feb 2024 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534691; cv=none; b=uSF4VWZnak4BqkTY9nBAnS8qHtNHuBw1caz/Zkkn2fEFskd9KK6lI33+l5njGdncy9NDv02PlyrZRU0Sj0PQK/0k01EscN1rkRfKVv3LeuRfsMVEGNRkyFnLxiIG2+Ukq4xzoeV+/Ms9rn9F4b+/AjFMZTF6kS5FfT4YEFlutWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534691; c=relaxed/simple;
	bh=AE3lHk3+mirSD2e3Xoqkhk26xryrPJ3sTT/p8JP3sCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8LKhv035WdYAudQOxEnZslT2ofX/LFsr6WfMUmdnS0pt1gPFqZU8TQDhk8NW94cYcA1Q3IJuHNrYGGUzs6k+g0l+g8E8GqJLYT3u6G2zQObFsOIRH7KT9mvImQufDFVtkueFhTu9JLDOE44TJ3StMaK96lf6+bNZt3TDZuvvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=thqdSiY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z1ugZmnm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=thqdSiY4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z1ugZmnm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 36AAB21F46;
	Wed, 21 Feb 2024 16:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708534686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5/LPWsnkhpHJRDrvjbAZmywGw2dskl6cEX0hLSY2Us=;
	b=thqdSiY4fIFl8VeUKsqUhQPsG7MZzr2RKNRtbafjo1HFChFVxxZJ64iR4jDU8p5S2hz+Gm
	uHDnEiOGDBwbr3hhbhjtOEhPlVYDvMQg/Wf9SnpB9GsQk3+8W0iCFbJtbYyBfiCAdq2U4/
	K5Pbv4qdhN8ysEqdWJXGN1MxafdktJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708534686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5/LPWsnkhpHJRDrvjbAZmywGw2dskl6cEX0hLSY2Us=;
	b=Z1ugZmnm20kSHvwMOxFPTUVdkgH6+OkjmOMFBZav/ei0KRbi3a3Khf+gwzkS2SZir6ss1O
	HD/aCF9Y6lqpXEDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708534686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5/LPWsnkhpHJRDrvjbAZmywGw2dskl6cEX0hLSY2Us=;
	b=thqdSiY4fIFl8VeUKsqUhQPsG7MZzr2RKNRtbafjo1HFChFVxxZJ64iR4jDU8p5S2hz+Gm
	uHDnEiOGDBwbr3hhbhjtOEhPlVYDvMQg/Wf9SnpB9GsQk3+8W0iCFbJtbYyBfiCAdq2U4/
	K5Pbv4qdhN8ysEqdWJXGN1MxafdktJo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708534686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g5/LPWsnkhpHJRDrvjbAZmywGw2dskl6cEX0hLSY2Us=;
	b=Z1ugZmnm20kSHvwMOxFPTUVdkgH6+OkjmOMFBZav/ei0KRbi3a3Khf+gwzkS2SZir6ss1O
	HD/aCF9Y6lqpXEDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 266FC139D1;
	Wed, 21 Feb 2024 16:58:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id vk0BCZ4r1mXPbAAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 21 Feb 2024 16:58:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BA71BA0807; Wed, 21 Feb 2024 17:58:05 +0100 (CET)
Date: Wed, 21 Feb 2024 17:58:05 +0100
From: Jan Kara <jack@suse.cz>
To: Michael Opdenacker <michael.opdenacker@bootlin.com>
Cc: Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: Why isn't ext2 deprecated over ext4?
Message-ID: <20240221165805.plnkvymjzqts2l6r@quack3>
References: <bcaf9066-bb4a-4db3-b423-c9871b6b5a2f@bootlin.com>
 <20240221110043.mj4v25a2mtmo54bw@quack3>
 <192cb320-2ded-4761-b0c9-3e273931f6f6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <192cb320-2ded-4761-b0c9-3e273931f6f6@bootlin.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=thqdSiY4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Z1ugZmnm
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 MID_RHS_NOT_FQDN(0.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 SUBJECT_ENDS_QUESTION(1.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 36AAB21F46
X-Spam-Flag: NO

Hello!

On Wed 21-02-24 17:29:48, Michael Opdenacker wrote:
> On 2/21/24 at 12:00, Jan Kara wrote:
> > On Wed 21-02-24 10:33:04, Michael Opdenacker wrote:
> > > I'm wondering why ext2 isn't marked as deprecated yet as it has 32 bit dates
> > > and dates will rollover in 2038 (in 14 years from now!).
> > > 
> > > I'm asking because ext4, when used without a journal, seems to be a worthy
> > > replacement and has 64 bit dates.
> > > 
> > > I'll be happy to send a patch to fs/ext2/Kconfig to warn users.
> > For all practical purposes I agree we expect users to use ext4 driver on a
> > filesystem without a journal instead of ext2 driver. We are still keeping
> > ext2 around mostly as a simple reference filesystem for other fs
> > developers. I agree we should improve the kconfig text to reference users
> > to ext4.
> 
> I can submit some changes to the Kconfig file along these lines, thanks!

Thanks!

> > Regarding y2038 problem - this is really the matter of on-disk format as
> > created by mke2fs, not so much of the kernel driver. And the kernel will be
> > warning about that when you mount ext2 so I don't think special handling is
> > needed for that.
> 
> So, if I understand correctly, it's mke2fs that should be creating a
> filesystem with 64 bit dates, which the ext2 kernel driver could happily
> support, right? However, I made an experiment by using "mkfs.ext2 -I 256"
> and I still got the warning:
> 
> [  689.213780] ext2 filesystem being mounted at /mnt supports timestamps
> until 2038-01-19 (0x7fffffff)
> 
> "tune2fs -l" also confirmed I had 256 byte inodes. Anything else I should
> pass to mkfs.ext2 to get 64 bit dates in ext2?

Hum, so I didn't quite think through my comment about on disk format :).
When you create filesystem with larger inodes, mke2fs will indeed create
inodes with extra timestamp fields etc. ext4 driver will recognize them
and use them, however ext2 driver happily ignores them (I thought we refuse
to mount such filesystem but we don't because of the way how large inodes
were defined in the ondisk format).

In any case the ext2 driver does not really support handling of larger
timestamps. If you want y2038 safety, you must use the ext4 driver.

> By the way, the code shows that the warning is issued 30 years ahead of
> time!
> https://elixir.bootlin.com/linux/v6.8-rc5/source/include/linux/time64.h#L43
> 
> I also could check, with "busybox ls",  that if I cross the 2038-01-19
> 03:14:07 date barrier, all the new files I create on an ext2 filesystem
> stick to that date, instead of rolling over to 1901 as I expected. That's
> better :)

Yes, but all files created in 1971 will magically appear to be created in
2038 when you cross that date :).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

