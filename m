Return-Path: <linux-ext4+bounces-906-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 206E683AF51
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 18:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9584F285FF3
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 17:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6789D7E784;
	Wed, 24 Jan 2024 17:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ec8UD5Hw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CB52rHIm";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ec8UD5Hw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CB52rHIm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206197E58B;
	Wed, 24 Jan 2024 17:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116403; cv=none; b=FDcfhDlXz5vcAdcDmnqM8RZY+LcJXxFZHYQBiDc7++2cEePnwbf9nK6RT/UXTMnfbV4mtoHKDy2ghLU9vYVWyfE8dlV9+7fRmyyGCOzL5LzbTMm2cClqLYlgCkC5LM2Y4ORLH2LcC1qOoYEYImUg4IA6ZjMGEZhVz0syPA26nkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116403; c=relaxed/simple;
	bh=TyPYUkJyBfhdoXcBp7fX8Dv0v6n6zc8eG9tu1EguJdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qIX1fX0wFVirwD+AJyTJpHljbILtQEQ0CaI/eoDtMgecD/BowYD0yx4juZe8U6inV292RAANEKw6V+Fz34DubMJPdo4yU6NdwCp5C9mCM0YbLgf7w/EX1DSQzNRfqSnWEPjFbZDh3JOCMnJ9wovh/sbB3SGMyXI6//IjPo2VPK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ec8UD5Hw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CB52rHIm; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ec8UD5Hw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CB52rHIm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2287921FC1;
	Wed, 24 Jan 2024 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706116400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QaqKCnd27EgswOXHEhXMSs8o2BKLLDke5WWj9l+tZY=;
	b=ec8UD5Hwx52eHjEJP20nWpWgDOO2ofQJoSdXu1Lgh9kyWkFThT8XvAD5xKMeXb1F+HVUnB
	4t8ADZgTHR0B2Opf3tmRjEhM4ePEafCvz7soPJByq/aM/Pp9w+aUoXBZQwiGFBXfdOT/7Z
	ZOh3NZntB1TDdP/dq05v6GpePRJjM+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706116400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QaqKCnd27EgswOXHEhXMSs8o2BKLLDke5WWj9l+tZY=;
	b=CB52rHImXyOrWEGZAsI8DR8LCTuun41np5RHXrU2Aym4qMDV1tgHSIbA/Zdggej6qn3NMR
	Ktnxq+Qn8OR13mDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706116400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QaqKCnd27EgswOXHEhXMSs8o2BKLLDke5WWj9l+tZY=;
	b=ec8UD5Hwx52eHjEJP20nWpWgDOO2ofQJoSdXu1Lgh9kyWkFThT8XvAD5xKMeXb1F+HVUnB
	4t8ADZgTHR0B2Opf3tmRjEhM4ePEafCvz7soPJByq/aM/Pp9w+aUoXBZQwiGFBXfdOT/7Z
	ZOh3NZntB1TDdP/dq05v6GpePRJjM+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706116400;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5QaqKCnd27EgswOXHEhXMSs8o2BKLLDke5WWj9l+tZY=;
	b=CB52rHImXyOrWEGZAsI8DR8LCTuun41np5RHXrU2Aym4qMDV1tgHSIbA/Zdggej6qn3NMR
	Ktnxq+Qn8OR13mDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B06CC13786;
	Wed, 24 Jan 2024 17:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GyarJy9FsWU3MgAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Wed, 24 Jan 2024 17:13:19 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id cfede600;
	Wed, 24 Jan 2024 17:13:18 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Daniel Dawson <danielcdawson@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
In-Reply-To: <358aaf68-0618-41e6-9adf-04e211eb690e@gmail.com> (Daniel Dawson's
	message of "Mon, 22 Jan 2024 21:56:28 -0800")
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
	<358aaf68-0618-41e6-9adf-04e211eb690e@gmail.com>
Date: Wed, 24 Jan 2024 17:13:18 +0000
Message-ID: <87jznyr6xd.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ec8UD5Hw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CB52rHIm
X-Spamd-Result: default: False [-3.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2287921FC1
X-Spam-Level: 
X-Spam-Score: -3.31
X-Spam-Flag: NO

Daniel Dawson <danielcdawson@gmail.com> writes:

> On 11/28/23 10:15 PM, Daniel Dawson wrote:
>> When a file is converted from inline to non-inline, it has stale flags u=
ntil
>> sync.
>
>> Why is this a problem? Because some code will fail under such a conditio=
n, for
>> example, lseek(..., SEEK_HOLE) will result in ENOENT.
>
>
> Just tested. Still happening on 6.8-rc1.

FWIW, I've been looking into a similar issue related with inline-data and
delayed allocation.  It may however be quite different because it seems to
add small block sizes into the mix:

  https://bugzilla.kernel.org/show_bug.cgi?id=3D200681

Unfortunately, I'm still trying to find my way around all this code and I
can't say I fully understand the whole flow using the reproducer provided
in that bugzilla.

Bellow, I'm inlining a patch that started as debug patch that I've used to
try to understand what was going on.  It seems to workaround that bug, but
I know it's not a real fix -- I don't yet understand what's going on.

Regarding your specific usecase, I can reproduce it and, unfortunately, I
don't thing Ted's suggestion will fix it as I don't even see
ext4_iomap_begin_report() being executed at all.  Anyway, just my 2
cents... let's see if I can come up with something.

Cheers,
--=20
Lu=C3=ADs

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index d5bd1e3a5d36..d0c3d6fd48de 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -528,7 +528,19 @@ int ext4_readpage_inline(struct inode *inode, struct f=
olio *folio)
 	if (!folio->index)
 		ret =3D ext4_read_inline_folio(inode, folio);
 	else if (!folio_test_uptodate(folio)) {
-		folio_zero_segment(folio, 0, folio_size(folio));
+		struct buffer_head *bh, *head;
+		size_t start =3D 0;
+
+		head =3D folio_buffers(folio);
+		if (head) {
+			bh =3D head;
+			do {
+				if (!buffer_uptodate(bh))
+					break;
+				start +=3D inode->i_sb->s_blocksize;
+			} while ((bh =3D bh->b_this_page) !=3D head);
+		}
+		folio_zero_segment(folio, start, folio_size(folio));
 		folio_mark_uptodate(folio);
 	}

