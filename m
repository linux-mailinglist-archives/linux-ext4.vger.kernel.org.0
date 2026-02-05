Return-Path: <linux-ext4+bounces-13545-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOWJJHmVhGk43gMAu9opvQ
	(envelope-from <linux-ext4+bounces-13545-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 14:04:57 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4EF2F3D
	for <lists+linux-ext4@lfdr.de>; Thu, 05 Feb 2026 14:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2AB301B93D
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Feb 2026 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B053D413F;
	Thu,  5 Feb 2026 12:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="gaG797Sm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0DA3B95F9
	for <linux-ext4@vger.kernel.org>; Thu,  5 Feb 2026 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770296378; cv=pass; b=fMHjd6K4nRljZlzIAggSnGOl+KOKt5V5wwyM72YpDp8aCOKGQBnUAjbPxeWSM3XK48aiE4F8sHH2X/f3Wn8/3voWEYbyfDe713miZo45mO6FXjeQiUFjXITyPMsudefiA3Sfhaa99OLZZmeEvnHrYxRBP1o0gvRyprZL2FEo6dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770296378; c=relaxed/simple;
	bh=b6ybiLUWQC0U95KN4n2npwQwXvLR6ygB0oFnX8K6/rg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LavKfHgpQRP8l5u64tr0+6f0YgPgZjlySg8deovrXwA+1Y1/hlpxKt9uj3tqp+MTv456bY6eednNxaEDwJ3YfQ/SEs+mXVf1DOCkDpFPeRYtA+XvCBacaOLYDz7webqjl2652Aq+gvn6Ysg5CF9fkqQIKUcj5p4dek0OBT4wAdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=gaG797Sm; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C43593F520
	for <linux-ext4@vger.kernel.org>; Thu,  5 Feb 2026 12:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1770296369;
	bh=qqKrekzgv2kE0rks6W5HOVCMvB1GxK8/1lFD25PHZRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=gaG797Smp11FNaqTEnm/KNmfJ+gqelsumX8O2BZS9TQnJFmiukCsemsIStROqSmv3
	 25FRasENr/qeeUsoOKNfVB8jSHTCzYQmVH14KeTU2OhK9V7InsqA4xWKylNlEGQcUj
	 pdbkEQkU9XyyvAtfUMoNXO6DhUdnS0bKhxtlRl6dLbe5ROzKgh6nfLn/Cp0PpyznlN
	 zPDNLEInABMw5B/o9bWdb1KygdAHdGG8huXLVZHdGP6wOthRH2ejjbRa0tBJy0eQJH
	 fs0aXejbDWX+T68qhUuKM49yzuVwDrFIkPZqCSHjAVbejqZajvTsP4i3sRmT8A3Jn5
	 UR7naE/El41ZV8b6ZSwG/l9THQnZfFC+kPuXr2RrOyYDp2+6maEyPBOoDTYrFXL0Ay
	 HVM69Oje4+TMAcP7Kn90uw5vp9JzJB3IAlM5GKBOXFvZXciaTqgSw+R37w8EolD/3a
	 MRqXjzVyaQnnkIVNYLENZx06PJOiT4wC1Ruv5zXHK9pMmxz9OiSfaW/eOt4qbnEvmX
	 6yZcrnwOrvZlN+xt6Lz14PF9yKdbNSdW3cSmY1YHjrcAm2MDxhBHGBt55drGFMtcwR
	 9lFseUu57Q+RmXlkX901b396bp8jcKc3IkWBIFj1QrETGBH9kIQcl9RE9B0r7Uaj2N
	 QOHptEVst5eJRB/mkj7+JnYs=
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f1665f706so3119886b6e.3
        for <linux-ext4@vger.kernel.org>; Thu, 05 Feb 2026 04:59:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770296368; cv=none;
        d=google.com; s=arc-20240605;
        b=GhCFiQa/zETIwTWIibUddF15qWkckU3NUoE4d3hFgk8PrNzCRHBRJ5d4V2ibAZIAGM
         Xw76gHUvItR34Gol9IblQ/Jq45kGLJJTzlWDu7TH3ccu7p5ah3/fLT0q908aZNh87kz+
         TEP4BOVZWGqrZWFWQaiuKxMineEl/YB5qpNEXrrpH+/sMz4Qnp+uL8Wc+4eNRHmE9eyJ
         DIyiYOIVG1NRj6mM2DH0rJgQmxhrXaBOzEsEaw7jmeDYXdlNEzn3HP3uEyJmBGFSnuFk
         KAjHpk5QDKFJkA9+Z5C9ieLPTG3fwseQqrQrY6hV54xEZe6zfYoE4ikWtdPt4R0JiCaf
         JSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=qqKrekzgv2kE0rks6W5HOVCMvB1GxK8/1lFD25PHZRg=;
        fh=yvx/tm7EMdooEqTr9zh8mhbUelW3Bgtdvs5Jh01wKnw=;
        b=HAV87ksWE4i9Vd+uQkiOj+4GgpCqvjK2SKqXjYJi+teIfaZyWw8ftpWUgSfcqBNxpQ
         jkD9CYnJC7OP6k5kjTneUCiTqjeO2X61270Pzv9gUeM9sCJB44TAXgNMW9Bgevj+cbr8
         YhqACAvW0WaOr0bo1qcdSwhWKdpwQwJVLuP+FnvAwO0XZvoGXp4tOjHI1R7pATN9+5yo
         r2gx1/a9LwX/i5dNhyrMD/ZRaamnEgBHCI+lQrd8kXFUIXreE8a3ZurF1o3nXOePDakD
         m71CAXgkcdZ8dA/XwD6ec5pyD4dRMKlz1+AOlgX6WVaYyL7SIePBUlSQU1Yjxmz1M/5c
         i6Hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770296368; x=1770901168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qqKrekzgv2kE0rks6W5HOVCMvB1GxK8/1lFD25PHZRg=;
        b=fyjoulMurNIPlRMEugaQiVddLs9mwWzz7LlQuvM06jQl+3ryXIdfMcP0P492pNh/Tb
         k/NumBONR5a++268+PN6Jg4Mx2A8rT1SvTV6ZSMek6UMajAhO6aC4lEF5BuGQMFHSL0w
         9adxAYq4e707ISrAiwagXGPhuQESISJak6ajHTgD6HYZwyc4J45zNyBUDy2xT6e5PSuQ
         nVMYtrg/A0+VKphjMhd9LtGTrHX/PoIiOtFsXPc5RXVinDi9pvWru2rh8z0NgnQiGm11
         W+yKNeFvTTFzhNeTsYz4E1OU2DGA8eMB2s9kX0+DkrJYTMQWvpmdCQoPOndCt9/Grg4e
         sDMA==
X-Forwarded-Encrypted: i=1; AJvYcCWhI2dT9i9z7GToiDDXjn+gI4aCJ6uSORgTDHsRnlaN1XHKpqlFUvHnXSQAn7qm7TkMPcA+RU4ncHyh@vger.kernel.org
X-Gm-Message-State: AOJu0YwwPjcmibwfl/R21SboVSlETnX+GeJY9/7n3xYggsKa4FSEAjvD
	0rsUCCciGcvSk6KXvy4mIzHje6vEJU/XLS+Vm0SirL/VGfMWMPcHqZWep23w3ZLeBXG0U886zuu
	Rj5S/MXseV8kiTC76tDZXQUwsl2M1+XWF71LenOCjXOjkpjYBzmmnG6zzz2Hn0xwmnoRyH+DACy
	WAPZwMjUUp1C2N0+74edUCNRUEHzKhG1ciMSZcy6HXBx7O8L2gV2qdIA==
X-Gm-Gg: AZuq6aKqvH7BdOSiY1S7zkZ/YFj/ttSMMR/DC4JwdrS0FcR2h3GHD+ikePetgGuO5Or
	2szycnMCP5X0+EgsexcEIscBib1120YkazQnS1OrqjJuJkSKQRCH/sBHOyF2H9Sq1TKxpZsxTRx
	IW7VadpPcY9GkNb163W2rpIBt2SrxZhFmoMH8VwhUhekbuZa22IOwTbD7CsOraecCGBi0=
X-Received: by 2002:a05:6808:15a0:b0:450:794a:6cee with SMTP id 5614622812f47-462d5907893mr3661109b6e.21.1770296368645;
        Thu, 05 Feb 2026 04:59:28 -0800 (PST)
X-Received: by 2002:a05:6808:15a0:b0:450:794a:6cee with SMTP id
 5614622812f47-462d5907893mr3661099b6e.21.1770296368340; Thu, 05 Feb 2026
 04:59:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128074515.2028982-1-gerald.yang@canonical.com>
 <4u2l4huoj7zsfy2u37lgdzlmwwdntgqaer7wta7ud3kat7ox2n@oxhbcqryre3r>
 <CAMsNC+s1R-AUzhe80vjxYCSRu0X9Ybp33sSMHGHKpBL6=dG2_w@mail.gmail.com>
 <bycdopvwzfaskilhk3nsljuk3gkztvoa3is466a6utuj2lozmj@pxf44ulcnqup>
 <CAMsNC+ve3dRwT1xGWB0pvBJXqBpeksf7PgbEeihcnfs=AmwVRQ@mail.gmail.com>
 <gluj62pw5pu7ag2juf5ejwsr3ghvckag7wh4zunwyk57slcrmg@42of57gybigz> <tmtgzmvkfag4r6lbt4i2ej5ad3bfudezcm35l27ybit25r7l4d@5o2i4cuymh5j>
In-Reply-To: <tmtgzmvkfag4r6lbt4i2ej5ad3bfudezcm35l27ybit25r7l4d@5o2i4cuymh5j>
From: Gerald Yang <gerald.yang@canonical.com>
Date: Thu, 5 Feb 2026 20:59:13 +0800
X-Gm-Features: AZwV_QhwvKyPhKC_AULj0yACRazOcdsNLyJoWYEw-m1ch3bTmpOh67ChjUEbJo4
Message-ID: <CAMsNC+svSX9AiZbs1dd4qigZqBuOjuCHOjpyXzgaO0sNLUHDYA@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix call trace when remounting to read only in
 data=journal mode
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	gerald.yang.tw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13545-lists,linux-ext4=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerald.yang@canonical.com,linux-ext4@vger.kernel.org];
	DKIM_TRACE(0.00)[canonical.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email,canonical.com:dkim,mail.gmail.com:mid,suse.cz:email]
X-Rspamd-Queue-Id: A8C4EF2F3D
X-Rspamd-Action: no action

Thanks Jan for fixing this issue, I can confirm the patch works for me too.


On Thu, Feb 5, 2026 at 5:25=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 03-02-26 15:50:43, Jan Kara wrote:
> > Hello,
> >
> > On Fri 30-01-26 19:38:55, Gerald Yang wrote:
> > > Thanks for sharing the findings, I'd also like to share some findings=
:
> > > I tried to figure out why the buffer is dirty after calling sync_file=
system,
> > > in mpage_prepare_extent_to_map, first I printed folio_test_dirty(foli=
o):
> > >
> > > while (index <=3D end)
> > >     ...
> > >     for (i =3D 0; i < nr_folios; i++) {
> > >         ...
> > >         (print if folio is dirty here)
> > >
> > > and actually all folios are clean:
> > > if (!folio_test_dirty(folio) ||
> > >     ...
> > >     folio_unlock(folio);
> > >     continue;       <=3D=3D=3D=3D continue here without writing anyth=
ing
> > >
> > > Because the call trace happens before going into the above while loop=
:
> > >
> > > if (ext4_should_journal_data(mpd->inode)) {
> > >     handle =3D ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
> > >
> > > it checks if the file system is read only and dumps the call trace in
> > > ext4_journal_check_start, but it doesn't check if there are any real =
writes
> > > that will happen later in the loop.
> > >
> > > To confirm this, first I added 2 more lines in the reproduce script b=
efore
> > > remounting read only:
> > > sync      <=3D=3D=3D=3D it calls ext4_sync_fs to flush all dirty data=
 same as what's
> > >                          called during remount read only
> > > echo 1 > /proc/sys/vm/drop_caches       <=3D=3D=3D=3D drop clean page=
 cache
> > > mount -o remount,ro ext4disk mnt
> > >
> > > Then I can no longer reproduce the call trace.
> >
> > OK, but ext4_do_writepages() has a check at the beginning:
> >
> >         if (!mapping->nrpages || !mapping_tagged(mapping, PAGECACHE_TAG=
_DIRTY))
> >                 goto out_writepages;
> >
> > So if there are no dirty pages, mapping_tagged(mapping, PAGECACHE_TAG_D=
IRTY)
> > should be false and so we shouldn't go further?
> >
> > It all looks like some kind of a race because I'm not always able to
> > reproduce the problem... I'll try to look more into this.
>
> OK, the race is with checkpointing code writing the buffers while flush
> worker tries to writeback the pages. I've posted a patch which fixes the
> issue for me.
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

