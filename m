Return-Path: <linux-ext4+bounces-14000-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHBDIl08nmkrUQQAu9opvQ
	(envelope-from <linux-ext4+bounces-14000-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 01:03:41 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E257F18E3F1
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 01:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D99A3072A3F
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Feb 2026 00:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDFC1F09B3;
	Wed, 25 Feb 2026 00:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="aGrr+Dda"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6061BD9C9
	for <linux-ext4@vger.kernel.org>; Wed, 25 Feb 2026 00:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977672; cv=none; b=peNlH17bF16et1LMOUL3HKctG7YY5pfIN+K4OnxlncONltXCZjLoO7Bdy6H2VedI1DgsQGlBDkWn1SNjGnwicrhwPs9xjzkR6hMsQ0FdCNzMP7Qj0hgVDfME91iWcGZfjaPgDhVQw23E4WV2cYWXVcLdKE1CuyJ9J92x5Jqm2tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977672; c=relaxed/simple;
	bh=R1Kzs3+QTLFJeOfnd1Mb+Cjo4gUl0iOMe1LG46BmkwA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=KrP+IkcsHvLcrkV7ejCiAlb57VReXsnRQ2yDrw+Jsso88ezFWbN5eIBTQ8JQCIJRpLSrZiso/smSa4DVWBhpmmZtO2kgDDIbgVunAFuaCLZrNVRjeloA+OkPxFTFXaWT5VcV5I9gfFku1feKaMTqzXw6l5t3wEDV5AAvc/k60zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=aGrr+Dda; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c6e2355739dso2122307a12.2
        for <linux-ext4@vger.kernel.org>; Tue, 24 Feb 2026 16:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1771977669; x=1772582469; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OuMdVIWKWOipJqhwb12lnYw6kOR9sgyk4LpFdlxB2K0=;
        b=aGrr+DdalX04GaGIYLXjTvK5Ca4gpV+LmgU/fTS3VHn4vch/GBPkfUbNXAcOFqgMIl
         cQIE2Xbi76YYb6FUDLpVLcv8+g2rlO4V1eXLeELuG6x45bXvRONtOuugxs2G4JuAQifR
         oRBrnLAhk9zPyS0hDGwZceUUW9DXVnYVgXoVW4uRZYY2ebnWVrDGE3E1wlgYPXFC2Sll
         JLXLzFmgryAKSsmlGKVvAECeCnY/or8yNUxi/hH/V65JSkQgbl/5JP692YdygL/AnCsI
         Cv1yqP/7PZKABxcKT/JmhAtRRubl4X3+MhMFCnfcBZaNgWmA9g64bQSOHzZx2kFZjFqb
         ssjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977669; x=1772582469;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OuMdVIWKWOipJqhwb12lnYw6kOR9sgyk4LpFdlxB2K0=;
        b=R9OGtxuOrQcMAF5hJ415wtcdxYlUwEJsDUcqZLqSVLQLTSaIYIUildfUl/UxGnSQZl
         ZIc2BfCmzaFnzOYgQMBVxHw87KPdtHNg6yNSDzexaCPePdiklZHLVmJJUDPI8xEKG0Gh
         M3vnaQi952y7QWh2m+g3RJxVnOsKENbrxutyU/sL55Ie91FmRhpqXox9p0NXFr3c7mLs
         Vhmo5499PtCQVm75GuPUtGAIr5pVg9UuaW/pIwzNuy+tQgfhzH///3CblcPYKsMxYFlE
         YqgqJHsC0ofAWMmIA8+Xq2m4ZJllAz5aSXWLQ9C+Aa8h8ji8J+u+ThY6kyEfec3NLIiG
         0oOg==
X-Gm-Message-State: AOJu0YySTqPM7hcq24Q4xg0kLSsTAKx/qANx3Sa53MIxealJUrm1R88e
	TcUeZpVQx1Tvz23+sy6fm49BTarTJI1/fSlKrS36BDUDak+IIbNcxpBQ8Dd0zJ4wwZY=
X-Gm-Gg: ATEYQzw8v+9AQW1tw34wojXLJu+MatyTracoBI4zPHd/DlPThztwaA5N1XOOWKHA1l4
	kRQNEoWnIqdwZ45QX61HCtAIz9gbxQTJ1vpKzVBG2jUOiO7SsPod9KOAdW2hrLC8EhZx8KMOdi/
	QPs1HjrpqZPxSDoycCTaib4Z1LnKsaD4ryRq4W7Ckimfxqkdn/bMkm/wEpS+tQseK3dJjQz4FOE
	B2I25Gh3jfPkMFWheJFCOnRFcOIJXxp1o+wwQPiGosRGN4xKVMhaZR94p7OePheSPsGoI2K3Jxa
	WPI55yMdVy+KWQm+nSwRNX1g13qaeYOT3jZsrauA4YosjrgqwBg1uT5brCyAzzx6EK5xOT4019a
	VMpGe/GZnnQzaC31HWamhjqsSMijo87bpbgRfBmCBj+1tVSpZBXQySs4q3lzO3Rt3H8lxiVsu1Y
	qdqxcQg4xw4AUoVcaa7qF6dRW0lN2EEbJMMqdC+ejx46yQYh10tF/TqmM2U8J6e7OiVkMN5Z9Sm
	av4dA==
X-Received: by 2002:a05:6a20:54a1:b0:366:14b2:30f with SMTP id adf61e73a8af0-39545fb0ea4mr10971474637.66.1771977668849;
        Tue, 24 Feb 2026 16:01:08 -0800 (PST)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd68998bsm13382380b3a.16.2026.02.24.16.01.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Feb 2026 16:01:08 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.100.1.1.5\))
Subject: Re: [PATCH v3] ext4: simplify mballoc preallocation size rounding for
 small files
From: Andreas Dilger <adilger@dilger.ca>
In-Reply-To: <20260224125136.62551-1-cuiweixie@gmail.com>
Date: Tue, 24 Feb 2026 17:00:56 -0700
Cc: linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B328ADF-EB80-4D69-8B2C-BA1DE290445B@dilger.ca>
References: <20260224125136.62551-1-cuiweixie@gmail.com>
To: cuiweixie@gmail.com
X-Mailer: Apple Mail (2.3864.100.1.1.5)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dilger-ca.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dilger-ca.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-14000-lists,linux-ext4=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dilger.ca];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adilger@dilger.ca,linux-ext4@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dilger-ca.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dilger.ca:mid,dilger.ca:email]
X-Rspamd-Queue-Id: E257F18E3F1
X-Rspamd-Action: no action

On Feb 24, 2026, at 05:51, cuiweixie@gmail.com wrote:
>=20
> From: Weixie Cui <cuiweixie@gmail.com>
>=20
> The if-else ladder in ext4_mb_normalize_request() manually rounds up
> the preallocation size to the next power of two for files up to 1MB,
> enumerating each step from 16KB to 1MB individually. Replace this with
> a single roundup_pow_of_two() call clamped to a 16KB minimum, which
> is functionally equivalent but much more concise.
>=20
> Also replace raw byte constants with SZ_1M and SZ_16K from
> <linux/sizes.h> for clarity, and remove the stale "XXX: should this
> table be tunable?" comment that has been there since the original
> mballoc code.
>=20
> No functional change.
>=20
> Signed-off-by: Weixie Cui <cuiweixie@gmail.com>

One minor code style nit below, but otherwise,

Reviewed-by: Andreas Dilger <adilger@dilger.ca =
<mailto:adilger@dilger.ca>>

> ---
> fs/ext4/mballoc.c | 25 ++++++++++---------------
> 1 file changed, 10 insertions(+), 15 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 20e9fdaf4301..a5c51daaba78 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4561,22 +4561,17 @@ ext4_mb_normalize_request(struct =
ext4_allocation_context *ac,
>  		(req <=3D (size) || max <=3D (chunk_size))
>=20
>  	/* first, try to predict filesize */
> -	/* XXX: should this table be tunable? */
>  	start_off =3D 0;
> -	if (size <=3D 16 * 1024) {
> -		size =3D 16 * 1024;
> -	} else if (size <=3D 32 * 1024) {
> -		size =3D 32 * 1024;
> -	} else if (size <=3D 64 * 1024) {
> -		size =3D 64 * 1024;
> -	} else if (size <=3D 128 * 1024) {
> -		size =3D 128 * 1024;
> -	} else if (size <=3D 256 * 1024) {
> -		size =3D 256 * 1024;
> -	} else if (size <=3D 512 * 1024) {
> -		size =3D 512 * 1024;
> -	} else if (size <=3D 1024 * 1024) {
> -		size =3D 1024 * 1024;
> +	if (size <=3D SZ_1M) {
> +		/*
> +		 * For files up to 1MB, round up the preallocation size =
to
> +		 * the next power of two, with a minimum of 16KB.
> +		 */
> +		if (size <=3D (unsigned long)SZ_16K) {
> +			size =3D SZ_16K;
> +		} else {
> +			size =3D roundup_pow_of_two(size);
> +		}

No need for {} around single-line if-else blocks.

>  	} else if (NRL_CHECK_SIZE(size, 4 * 1024 * 1024, max, 2 * 1024)) =
{
>  		start_off =3D ((loff_t)ac->ac_o_ex.fe_logical >>
>  						(21 - bsbits)) << 21;
> --=20
> 2.39.5 (Apple Git-154)
>=20


