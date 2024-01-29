Return-Path: <linux-ext4+bounces-994-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52A8403A7
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jan 2024 12:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1669E281EAF
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jan 2024 11:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5BC5B5C5;
	Mon, 29 Jan 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xZZzXE9F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TPfLB/H6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PoVBNPnA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7Mj6ZCOB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D135B5B0;
	Mon, 29 Jan 2024 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706527038; cv=none; b=afxnNy067UacS3it6WWg+Cbig9YEvt+Hd03wzeXE7U1A+bm1KqsMCD0Dr+ChjagvaoCYkmMxKRPYlz/WN147U39C/zqDEHNrl4yhJsfjQ3N1v7tnzIAz3q4Mt4r5sZBbq2Cz3Xa7xgmtvCtXsaHuO4PLz6mj9sWj9/PcpsLQSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706527038; c=relaxed/simple;
	bh=TLgpO6bVDu9ZlVqcFU4FafX5DCbdfjLdFbKgel+FKYU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jPJPsb3IXkb7FcHUfARyHv4ICXckI84dK1CDX0y0vx5iT+i7ujj19LQBbKsH/UtVTIUjb8C3Wl1UMFp6XwoEg8m0HLHKvYCQXEN04lYJegvWt+Y4r75XbaBXdfrZ95RpgXkdJXE8AXjH9NoQq9h+YYz5QG6e5MbpS5422chJiC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xZZzXE9F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TPfLB/H6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PoVBNPnA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7Mj6ZCOB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E4B821FCF1;
	Mon, 29 Jan 2024 11:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706527032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucSmWZC5i1uAfzHbYBObRHzIlIbwMfDip4/fjgCGR6E=;
	b=xZZzXE9FPxklhaBAQaNEXhq57XfZ/zvUUnLnHBy5k5aH48GMgnBndK4GcCt8x8JvUc0b0C
	ErCL4/QC1X1sbaeJ1linBFlqssKhuDtXid4UHjUYW1IWOaJvL4Yu/Qi4l3Q7tHEi6RNpp2
	1bAOxzOc/wuLbHtdRpfgQ98ldPCEpHk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706527032;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucSmWZC5i1uAfzHbYBObRHzIlIbwMfDip4/fjgCGR6E=;
	b=TPfLB/H6ODAApTu47ef39If6dMD1R6esFRLjFzVSvK78IISfh8/IRBIloLOGHnBHtmfJmj
	42lokxVYcC4MplAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706527031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucSmWZC5i1uAfzHbYBObRHzIlIbwMfDip4/fjgCGR6E=;
	b=PoVBNPnAFcEjNxVTjiLj0YQz0Xeis1CLqSXpsycLRHOfmtlDoZACul/XUYpx51bAkXCOon
	PTScF7ShVV/VHYyGeMDrTSBZEvglLlomoX6CGmXspZ5/8aah56c50QE3ciLXz9Svi4E/Zy
	D+pBcB33tGQ2ZPEnfatC+uBaqZaN1c4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706527031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucSmWZC5i1uAfzHbYBObRHzIlIbwMfDip4/fjgCGR6E=;
	b=7Mj6ZCOBJ1dAnAIkM332zqR6kRe4Fy/5r8V/Jl1lSHcrOLWGRQuLv3yjs0M13EjwRDlkYh
	OsxUgAxJ+Fxkq8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A1D613647;
	Mon, 29 Jan 2024 11:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XmwxFjeJt2VnCQAAD6G6ig
	(envelope-from <lhenriques@suse.de>); Mon, 29 Jan 2024 11:17:11 +0000
Received: from localhost (brahms.olymp [local])
	by brahms.olymp (OpenSMTPD) with ESMTPA id 86d7b1fb;
	Mon, 29 Jan 2024 11:17:04 +0000 (UTC)
From: Luis Henriques <lhenriques@suse.de>
To: Daniel Dawson <danielcdawson@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,  Andreas Dilger
 <adilger.kernel@dilger.ca>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [inline_data] ext4: Stale flags before sync when convert to
 non-inline
In-Reply-To: <a25e5ee6-70c2-421f-92c2-407b43a7c61e@gmail.com> (Daniel Dawson's
	message of "Sun, 28 Jan 2024 04:06:38 -0800")
References: <5189fe60-c3e3-4bc6-89d4-1033cf4337c3@gmail.com>
	<358aaf68-0618-41e6-9adf-04e211eb690e@gmail.com>
	<87jznyr6xd.fsf@suse.de>
	<a25e5ee6-70c2-421f-92c2-407b43a7c61e@gmail.com>
Date: Mon, 29 Jan 2024 11:17:04 +0000
Message-ID: <87frygqthr.fsf@suse.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[4];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-0.998];
	 FREEMAIL_TO(0.00)[gmail.com];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_LAST(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Daniel Dawson <danielcdawson@gmail.com> writes:

> I didn't see your message until now. Sorry.
>
> On 1/24/24 9:13 AM, Luis Henriques wrote:
>> Bellow, I'm inlining a patch that started as debug patch that I've used =
to
>> try to understand what was going on.  It seems to workaround that bug, b=
ut
>> I know it's not a real fix -- I don't yet understand what's going on.
>
> Thanks for this. I'm not sure if you meant to say you think it works arou=
nd the
> present issue. I just tested it, and it does not. In case you missed the =
start

I was referring to the bugzilla bug [1] I've been looking into recently.
My patch was a debug patch for that bug, but it definitely does not fix
the issue you're reporting.  Sorry for mixing up everything and confusing
everyone ;-)

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D200681

> of the thread, here is the test I gave for triggering the issue:
>
> $ rm -f test-file; dd if=3D/dev/zero of=3Dtest-file bs=3D64 count=3D3 sta=
tus=3Dnone;
> lsattr test-file
>
> Instead of writing the file all at once, it splits it into 3 writes, wher=
e the
> first is small enough to make the file inline, and then it becomes
> non-inline. Ideally, the output should be
>
> --------------e------- test-file
>
> but delayed allocation means it instead shows
>
> ------------------N--- test-file
>
> until sync. I also gave this code for testing SEEK_HOLE:
>
> https://gist.github.com/ddawson/22cfd4cac32916f6f1dcc86f90eed21a
>
>> Regarding your specific usecase, I can reproduce it and, unfortunately, I
>> don't thing Ted's suggestion will fix it as I don't even see
>> ext4_iomap_begin_report() being executed at all.
>
> To be clear, that function is called in a few specific circumstances, suc=
h as
> when lseek() is called with SEEK_HOLE or SEEK_DATA, or with FIEMAP. When I
> traced the kernel myself, I did see it being executed from the lseek() ca=
ll. The
> changes are to address the file not yet being converted from inline, wher=
e the
> contents are still written where the map would otherwise be. If you treat=
 it as
> the map, you get nonsense. Something else needs to be done.
>
> I'm not clear on whether his proposed changes would then allow an applica=
tion to
> function properly under such a condition, but it should at least *not* gi=
ve
> ENOENT.
>
> After testing what I think are the changes he proposed, I find it doesn't
> work. If I remove the "&& iomap->type =3D=3D IOMAP_HOLE", lseek() no long=
er gives an
> error, but instead returns 0, which I'm pretty sure won't work for the af=
fected
> use case. Either way, I'm not sure I interpreted his description of the c=
hanges
> correctly.

Sure, I can understand under which circumstances ext4_iomap_begin_report()
can be executed.  What I meant was that, for your very simple test case
(using 'dd' and 'lsattr'), this function will not be executed and thus the
suggested fix will still show the 'N' in the file attributes.

Anyway, thanks a lot for the extra information your providing here.  I'll
try to find some time in the next few days to keep debugging the issue and
hopefully get some more useful info (and, who knows! a patch).

Cheers,
--=20
Lu=C3=ADs

