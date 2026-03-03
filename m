Return-Path: <linux-ext4+bounces-14574-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DOyFOspp2nSfAAAu9opvQ
	(envelope-from <linux-ext4+bounces-14574-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:35:23 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED4CD1F55E0
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 19:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC87430330AB
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 18:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3F3DFC6B;
	Tue,  3 Mar 2026 18:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="lALIJaVB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E493988E2
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772562899; cv=none; b=jIo1Qiddu6bB3aqJBKZSa2HaAtPUPBwLv7EumPxarCqYLAdkVqfjEjwM/GpE/WKpE0zqEaTKD9cmwW7wSNA92h77txTSWjZ93noC2R31/bYq0SZA9omqxdStcmO6UXRkNivNruoXsUczl6upVMoZLM0eOg7agBrL4uP4qXcyjpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772562899; c=relaxed/simple;
	bh=C7Zs75rtN1GyQEiv1BAqzSGHIFZP/gls2uVThbOIDos=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nSdNpYFQEfYxZrdslWCmogxHjmAPHfS1RjylSbL10E7L7xcufyhiY9oZzuNyQ1CDjQf+5Hn7ViXXaBRqo+HHdPn/a4T7J2wwRhD+Bw3lcaX9sRG/NL/ARHhFMsKLA7IEqS2E66OmJXwZKu9aGnY1jIDAlWenAK9VL30QJ/RrKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=lALIJaVB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2aae4816912so40427775ad.2
        for <linux-ext4@vger.kernel.org>; Tue, 03 Mar 2026 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1772562897; x=1773167697; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcF9eF+63Jv9fwLT7rsfJstgHeCVszPeLaLouOkj9hY=;
        b=lALIJaVBv/nv7BvxnVM2LFjeVqjxk+3dNR+49qOQi6d/D+XDEfMftmIZ/saBzQUJZ2
         ZWFm75IzGkkJ497ZHi4WxhVzGlEf07OOkPJ4zn3DYR0KtvvQhNh940pXYjHFT1gvEaYO
         /mj1b0NODgl5UGZ5KrngLm/sfwM2EZAI8q1c6DBfbzTCy4urPKZyOmkCK+BQFLHGDCPv
         nQtB1YTvobMi8r4e0UN7yCaXvxzxPlEKKBxciZEcX8NBmmn8sEtGSA6Cb3qoLTR7QPv3
         NtO7pZdcVHtsqb0ve5rTNBymx14cHR9ppwVwIwKNagkc7O3tFmcz2KXRMSGe+XfucIjJ
         p1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772562897; x=1773167697;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QcF9eF+63Jv9fwLT7rsfJstgHeCVszPeLaLouOkj9hY=;
        b=hiQkE2Vm1qzfAJ+VzgauToXTnbU3QvaZ/9bMcrM5WYZ/cu6PI2L7HF4whfA07LoSmp
         p3JDCY/HrMMUJZBhXH4ka/RJGo5y9m1svcjkPrJkxCmMmcan/ZXvJcBskx6jWyqR0NdJ
         v4XhmrI6AfdDlVepdeKyCxDuv9hbz/392l1jHrcp8CKnmCii9umMK2P+fxAImjh1LSsD
         YFrfcTwxXqFjunCEdof0DgVzTZ0XfvpAGRmFQHbm3+A/uER5/CIJJERUv08cVoOToeh/
         QRuxLL3rDxkbq4C2K6Iyx60BuWz7rTqrE2s6pvs90IP6DGnj9incpvuHGMRBEurepOY2
         /NSA==
X-Forwarded-Encrypted: i=1; AJvYcCXadthgsZcDYT2dDAHXSgbmddPFXeTlUKzeTHtrhRMc9QTRh7OPr/YtqZRuTwvK2v9mja5MnAOAS/v3@vger.kernel.org
X-Gm-Message-State: AOJu0YxU/Ex0D+o+h5Rrz3P0/X/ouUAp3zGgoJXA/7WQ9S37/j04tASo
	W/2hAT3gLYCUeUoSqlnOn9EgKK1/Ps2v8UaujG8D6HMq9JlZJL+7BgjLiz8k4L3BJ2o=
X-Gm-Gg: ATEYQzxt59LLaFjgZWjUU1tMPRfUR4Z5lAAI8iS/E6e4rkoeaq3MDwD4ZFMpZM2WW6i
	CteObvcCWsUANrTytkc1/vLjvBbG0J5FJT0Dwu9qkPrD6vu6QjC1dmEFzE0NoWY5P8uRZs8TJVs
	O9qzV0VCxONNg/c191cE+yo8frnDHttRE2wTzMs8zjpif08+IWxBdm4b0PA59NzeiswUlpBhe6h
	5XShSX+8P2CT/xFsKywE+k3qwHr+rS6mFtmRQ5yqq6BrducXJYluyVujLKzIegxJ4zwMRgcniK8
	zZ3f609e9HA1gZQGKySUxSsbJEUXnchRGtaN8DnyX3HUvAVq5otzDZRHrLGC/2sw/UvM/BoyvY3
	+yaBR8JJHGp2/980HdAJVnMpmCr+vM3QF2b5LeffhGfi9Aj3lqPuTlmeIVKp2+v7+2APbxb4ldt
	+TuYMuw0vlmhbYWJhZ50b+D7XLlUO13rf9zsOIJzX1TkkEQbxeLwHEnJnM3tNifLWmKaHsyCwK2
	45GIA==
X-Received: by 2002:a17:903:2f90:b0:2ae:51bb:9809 with SMTP id d9443c01a7336-2ae51bb9f24mr81966625ad.36.1772562897338;
        Tue, 03 Mar 2026 10:34:57 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6fe4f3sm169031185ad.91.2026.03.03.10.34.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2026 10:34:56 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v4 2/2] jbd2: gracefully abort on transaction state
 corruptions
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260303180157.53061-3-nikic.milos@gmail.com>
Date: Tue, 3 Mar 2026 11:34:44 -0700
Cc: jack@suse.cz,
 tytso@mit.edu,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5DD73D47-1349-4B73-BFAF-4E1645D7B6E0@dilger.ca>
References: <20260303180157.53061-1-nikic.milos@gmail.com>
 <20260303180157.53061-3-nikic.milos@gmail.com>
To: Milos Nikic <nikic.milos@gmail.com>
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Queue-Id: ED4CD1F55E0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14574-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger.ca:mid,dilger.ca:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,dilger-ca.20230601.gappssmtp.com:dkim]
X-Rspamd-Action: no action

On Mar 3, 2026, at 11:01, Milos Nikic <nikic.milos@gmail.com> wrote:
>=20
> Auditing the jbd2 codebase reveals several legacy J_ASSERT calls
> that enforce internal state machine invariants (e.g., verifying
> jh->b_transaction or jh->b_next_transaction pointers).
>=20
> When these invariants are broken, the journal is in a corrupted
> state. However, triggering a fatal panic brings down the entire
> system for a localized filesystem error.
>=20
> This patch targets a specific class of these asserts: those
> residing inside functions that natively return integer error codes,
> booleans, or error pointers. It replaces the hard J_ASSERTs with
> WARN_ON_ONCE to capture the offending stack trace, safely drops
> any held locks, gracefully aborts the journal, and returns -EINVAL.
>=20
> This prevents a catastrophic kernel panic while ensuring the
> corrupted journal state is safely contained and upstream callers
> (like ext4 or ocfs2) can gracefully handle the aborted handle.
>=20
> Functions modified in fs/jbd2/transaction.c:
> - jbd2__journal_start()
> - do_get_write_access()
> - jbd2_journal_dirty_metadata()
> - jbd2_journal_forget()
> - jbd2_journal_try_to_free_buffers()
> - jbd2_journal_file_inode()
>=20
> Signed-off-by: Milos Nikic <nikic.milos@gmail.com>

Looks good, with one minor suggestion.  Either way you could add:

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> @@ -1531,13 +1558,15 @@ int jbd2_journal_dirty_metadata(handle_t =
*handle, struct buffer_head *bh)
>  			spin_lock(&jh->b_state_lock);
>  			if (jh->b_transaction =3D=3D transaction &&
>  			    jh->b_jlist !=3D BJ_Metadata)
> -				pr_err("JBD2: assertion failure: =
h_type=3D%u "
> - 				       "h_line_no=3D%u block_no=3D%llu =
jlist=3D%u\n",
> +				pr_err("JBD2: assertion failure: =
h_type=3D%u h_line_no=3D%u block_no=3D%llu jlist=3D%u\n",
>  				       handle->h_type, =
handle->h_line_no,
>  				       (unsigned long long) =
bh->b_blocknr,
>  				       jh->b_jlist);
> -			J_ASSERT_JH(jh, jh->b_transaction !=3D =
transaction ||
> -				    jh->b_jlist =3D=3D BJ_Metadata);
> +			if (WARN_ON_ONCE(jh->b_transaction =3D=3D =
transaction &&
> +					 jh->b_jlist !=3D BJ_Metadata)) =
{
> +				ret =3D -EINVAL;
> +				goto out_unlock_bh;
> +			}
>  			spin_unlock(&jh->b_state_lock);
>  		}

It doesn't make sense to check these conditions twice.  That was needed =
with
the J_ASSERT_JH() calls, but it is now possible to put the pr_err() =
calls
inside "if (WARN_ON_ONCE(...))" as it is done in other parts of the =
patch.

Cheers, Andreas




