Return-Path: <linux-ext4+bounces-1846-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F53896BC9
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 12:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A3A0292D90
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 10:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A7113A259;
	Wed,  3 Apr 2024 10:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="z2+aO1up";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wnvQ48cR"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECDB1384B0;
	Wed,  3 Apr 2024 10:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139087; cv=none; b=kxPswvkWnqap0gRoQDSNN5gZNeTJyLIHjHv+17yY0UbMrJCcOOaeNvx+AnlQ4u0KU3pE1wVGo2Au/3VUmfLe2MFU2hhQMRZYj7hNXn8alIRhvtdy+HtreuY3SDsmDXmdvDhBunkXVy31mMYPbvm034ytlKA3ZDwkixj7K0RKKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139087; c=relaxed/simple;
	bh=5sRrnYDlue/R5LusQUCeZ/NavfccssSP+9n69xB5wWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qrpdjCD2QAOdZeosU+NXWhpnZ+JGiD+4Cm2PDSwLhP6T0wBjgDwwsylSZQWFucD4woXUbs3fjMZy1ZczQsdevNHdjdR6nar9aaJ+Wqz9Ni/QMeFWdi3g9hE7crmhnRnTGDwbdGmq0C1bFy9thPY0IYBbQVQAqplf5/p+Ib0WsNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=z2+aO1up; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wnvQ48cR; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C5B7351E8;
	Wed,  3 Apr 2024 10:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712139082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZ1VVg9ohX4ltkkDD2gbJ9aeiuQeuh/sj7CBEgj02E=;
	b=z2+aO1upxP0Dtv/e0dL6o2l/3/HPyczzG4WtExN2l+nxV4ZfIcZP20g3GYzIop8ngtxKd+
	Gk/nP6Nhw2ctnnBwGuBI1352c1O55tuqunf9MRuTEiwoYNGgg7diKvRpNUHnZFNMkEbUrC
	xnTeA3vJBLpk21yGudhndrUXti5l7lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712139082;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CkZ1VVg9ohX4ltkkDD2gbJ9aeiuQeuh/sj7CBEgj02E=;
	b=wnvQ48cRBCiLzfckmj/+hToHbmtprvv2CnNCO0GuyvGUFvojM4l2VjFMl0Ayc5JvIHpfHh
	3RM3xsHxjAJ3FRBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 90AD51331E;
	Wed,  3 Apr 2024 10:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id BahFI0orDWYGCQAAn2gu4w
	(envelope-from <jack@suse.cz>); Wed, 03 Apr 2024 10:11:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3F94CA0814; Wed,  3 Apr 2024 12:11:22 +0200 (CEST)
Date: Wed, 3 Apr 2024 12:11:22 +0200
From: Jan Kara <jack@suse.cz>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Jan Kara <jack@suse.cz>, Ye Bin <yebin10@huawei.com>,
	adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid mount failed when commit block is partial
 submitted
Message-ID: <20240403101122.rmffivvvf4a33qis@quack3>
References: <20240402090951.527619-1-yebin10@huawei.com>
 <20240402134240.5he4mxei3nvzolb3@quack3>
 <20240403033742.GE1189142@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403033742.GE1189142@mit.edu>
X-Spam-Score: -1.61
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.61 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:98:from];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
X-Rspamd-Queue-Id: 9C5B7351E8

On Tue 02-04-24 23:37:42, Theodore Ts'o wrote:
> On Tue, Apr 02, 2024 at 03:42:40PM +0200, Jan Kara wrote:
> > On Tue 02-04-24 17:09:51, Ye Bin wrote:
> > > We encountered a problem that the file system could not be mounted in
> > > the power-off scenario. The analysis of the file system mirror shows that
> > > only part of the data is written to the last commit block.
> > > To solve above issue, if commit block checksum is incorrect, check the next
> > > block if has valid magic and transaction ID. If next block hasn't valid
> > > magic or transaction ID then just drop the last transaction ignore checksum
> > > error. Theoretically, the transaction ID maybe occur loopback, which may cause
> > > the mounting failure.
> > > 
> > > Signed-off-by: Ye Bin <yebin10@huawei.com>
> > 
> > So this is curious. The commit block data is fully within one sector and
> > the expectation of the journaling is that either full sector or nothing is
> > written. So what kind of storage were you using that it breaks these
> > expectations?
> 
> I suppose if the physical sector size is 512 bytes, and the file
> system block is 4k, I suppose it's possible that on a crash, that part
> of the 4k commit block could be written.

I was thinking about that as well but the commit block looks like:

truct commit_header {
        __be32          h_magic;
        __be32          h_blocktype;
        __be32          h_sequence;
        unsigned char   h_chksum_type;
        unsigned char   h_chksum_size;
        unsigned char   h_padding[2];
        __be32          h_chksum[JBD2_CHECKSUM_BYTES];
        __be64          h_commit_sec;
        __be32          h_commit_nsec;
};

where JBD2_CHECKSUM_BYTES is 8. So all the data in the commit block
including the checksum is in the first 60 bytes. Hence I would be really
surprised if some storage can tear that...

Hence either Ye Bin is running on some really exotic storage or the storage
/ CPU in fact flipped bits somewhere so that the checksum didn't match or
the commit block was in fact not written now but it was a leftover from
previous journal use and h_sequence happened to match. Very unlikely but
depending on how exactly they do their powerfail testing I can imagine it
would be possible with enough tries...

> In *practice* though, this
> is super rare.  That's because on many modern HDD's, the physical
> sector size is 4k (because the ECC overhead is much lower), even if
> the logical sector size is 512 byte (for Windows 98 compatibility).
> And even on HDD's where the physical sector size is really 512 bytes,
> the way the sectors are laid out in a serpentine fashion, it is
> *highly* likely that 4k write won't get torn.
> 
> And while this is *possible*, it's also possible that some kind of I/O
> transfer error --- such as some bit flips which breaks the checksum on
> the commit block, but also trashes the tid of the subsequent block,
> such that your patch gets tricked into thinking that this is the
> partial last commit, when in fact it's not the last commit, thus
> causing the journal replay abort early.  If that's case, it's much
> safer to force fsck to be run to detect any inconsistency that might
> result.

Yeah, I agree in these cases of a corrupted journal it seems dangerous to
just try to continue without fsck based on some heuristics.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

