Return-Path: <linux-ext4+bounces-14467-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBgMOdozpmlJMQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14467-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:05:30 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BA31E7792
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 02:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA31230255E5
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6452222C5;
	Tue,  3 Mar 2026 01:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="OCA+ociv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430A73909AE
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 01:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772499924; cv=none; b=PZ+xJHZ/dOo9AG+XXCj31dGr27+lh4gzovA3WWlELLc65mTC4pHJYMPT+bL64Y6jwXZZyUd2KhxctSSb4A3Hf4uGBqtIA9UIN3cfplPlLg8W2th26xAOYLmah4gF9Q2CzpH3UQlUv6UG+3DUqf/Sf2+bSLEpZaYYF2b53g/TCBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772499924; c=relaxed/simple;
	bh=LNNVIkNFBWtwEP4iHXWMpZCTtQG/MxASHpDBycUWkTs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Bz/x8v0Pae3ERDOdlx6Iug899xuhpMS73KieSRjBG/UzlHoFu8db1Imkhwci4jTIGTYyS/lmtRkTChuGWty5IAY5f+sdgTB+4eySoqR1Q8Eb5HiDV5+HQ4w8JLmCRgfeGlcI6AdbGQtmfGuEh+Gu8Ptgcyq6qFZzmasntX++unE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=OCA+ociv; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-824a829f9bbso2339855b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 02 Mar 2026 17:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772499921; x=1773104721; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEECmBkCFf380ySY0l2Du8HTROikW88C0Mw2oBNlHbE=;
        b=OCA+ocivJ0rlwEVz7iweT0ruB/Q++MpVCfigk6JmJaWOtHMn8X0JMjuOWlhVKBPkh7
         iUDRtbVXktmI899E4LTMB+pO4FhqSFszh3l1ERg+66yHmJQyBdMM4COeL+t5DKkSVch2
         viXX5jNUVvu3Zh4tbuv9/aBO1oAEN3gfsqNSz8WWAFPnYOlvKDyKBQsLd3lARGGj1JgE
         k8r9Q5fCy4UdoNfheXcb2Pa6wwbFz6/678l51ct+Cuyx2msoYLxt9zc7cQpb8YlKVLgu
         WB+Ia+4qQhLohhcdVN69w4X31wSqbz+NT5ZC88ruLcqq6kgiNt2vjvyLEjfqNPxYIWA+
         QK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772499921; x=1773104721;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEECmBkCFf380ySY0l2Du8HTROikW88C0Mw2oBNlHbE=;
        b=Fp7kN04oAbufgcV3hjbkQtwQiqFmUoDxDcMiJe6Z2y0wUJAM7GnN5diOoMnH+ldyEo
         SYdaIvpX9FixuXvAgAcNRN4UYGPg7Zit5Ve6QchEVTalLEASYAz784ZXcygcO2Hlj6Uz
         RhuDZTSIipHBIQ51KgK6+yxxgMVe2XduEP+7HfczzscAIKeTSwgccg3xjm7/WHbCKmvo
         TB8DhXDXpb05SH+7p06xhuHxTVh3TrDd3DXlghDbKPPlBisDI4YRZ4LUMSkWyz5BDRp2
         8UICXKznKn3hMb3Ocp+WpSFSHtNC8/BJ4kjAd/9EAMmaNKvVEteppaTl9jr3p1ee9jkz
         qqBA==
X-Forwarded-Encrypted: i=1; AJvYcCWOlXgqL8GHY7vroBwMftrWeDSxpV0sWR78rjPCAWR65hY4pjuSuGq8Wd0wHN/F6cPXgqIh+N+FXAmv@vger.kernel.org
X-Gm-Message-State: AOJu0YzOdgWifxtR6ZxC1lihDd5bZkQ60SIQoDE3xG141fHhHd0wrjzy
	MDJfak27ODC7jNbL7BRUPaXVD2OYPJ7vcEXetGcHbHkdO228qY6H1oSWTVPfnq0Sp6k=
X-Gm-Gg: ATEYQzyDsapKv0oWTaRO60HVSmyd/3+HICzPOhcGQtvs4qOa9PWmgvK6Rh+sQIH82Zb
	GKCpIe/c1zOSpx8euIHYfNVAk1PhW+3pPcHOZZjcU2woBJUPyNSLkH5LdAZW5fk1aTs/1qyrI2/
	ZYi3DEC/9ONlkJIM0U0Sqt3a6/MoD1lYry6F4/8oAjVp27NcVZpV9WkQyXhpbMMEy13KQ/MO4VT
	1PWNvgwrAMPykScA5YNszORjJEDAE1kkCzsR9/Eoh+WL71WiKPNO8jz1ubQraWVW4opcYXJeyYD
	Ni/x7ZJbcjRpnV2Ynu9mE6lFd3OzCmgt8EbqC1McBEO5CFxXSxKJ2Cm9TTvhhTGDM6kwzqn5cse
	vZYeove9vwTBUmwtez5G0UuCKrRQO7nHlfB89wuok+HsVXdN18LMvzagGIald4qE0YDlDMfQlGf
	kCgWdW/D/T5wVOMaD8z17sTAerr19gGo0jDJ6/G9upt/67hWZNBRTAxMxFKQ2aZFLGROieVZIzM
	VoeQ03TVOoTnUgZ
X-Received: by 2002:a05:6a00:3c8b:b0:819:5db9:6ac0 with SMTP id d2e1a72fcca58-8274d9e9b22mr15196880b3a.37.1772499921401;
        Mon, 02 Mar 2026 17:05:21 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739db3e4asm14251338b3a.28.2026.03.02.17.05.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2026 17:05:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v3 1/2] jbd2: gracefully abort instead of panicking on
 unlocked buffer
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260303005502.337108-2-nikic.milos@gmail.com>
Date: Mon, 2 Mar 2026 18:05:09 -0700
Cc: jack@suse.cz,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Zhang Yi <yi.zhang@huawei.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E5CC201C-6F63-412E-A083-77C80CEDF5AE@dilger.ca>
References: <20260303005502.337108-1-nikic.milos@gmail.com>
 <20260303005502.337108-2-nikic.milos@gmail.com>
To: Milos Nikic <nikic.milos@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: D1BA31E7792
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14467-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid,dilger.ca:email,huawei.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.cz:email]
X-Rspamd-Action: no action

On Mar 2, 2026, at 17:55, Milos Nikic <nikic.milos@gmail.com> wrote:
>=20
> In jbd2_journal_get_create_access(), if the caller passes an unlocked
> buffer, the code currently triggers a fatal J_ASSERT.
>=20
> While an unlocked buffer here is a clear API violation and a bug in =
the
> caller, crashing the entire system is an overly severe response. It =
brings
> down the whole machine for a localized filesystem inconsistency.
>=20
> Replace the J_ASSERT with a WARN_ON_ONCE to capture the offending =
caller's
> stack trace, and return an error (-EINVAL). This allows the journal to
> gracefully abort the transaction, protecting data integrity without
> causing a kernel panic.
>=20
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> fs/jbd2/transaction.c | 7 ++++++-
> 1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
> index dca4b5d8aaaa..04d17a5f2a82 100644
> --- a/fs/jbd2/transaction.c
> +++ b/fs/jbd2/transaction.c
> @@ -1302,7 +1302,12 @@ int jbd2_journal_get_create_access(handle_t =
*handle, struct buffer_head *bh)
> goto out;
> }
>=20
> -	J_ASSERT_JH(jh, buffer_locked(jh2bh(jh)));
> +	if (WARN_ON_ONCE(!buffer_locked(jh2bh(jh)))) {
> +		err =3D -EINVAL;
> +		spin_unlock(&jh->b_state_lock);
> +		jbd2_journal_abort(journal, err);
> +	goto out;
> +	}
>=20
> if (jh->b_transaction =3D=3D NULL) {
> /*
> --=20
> 2.53.0
>=20
>=20


