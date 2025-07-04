Return-Path: <linux-ext4+bounces-8821-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E98D2AF99AD
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 19:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94ED35678FA
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Jul 2025 17:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2782D8379;
	Fri,  4 Jul 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="qKY65Tke"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F379204F9B
	for <linux-ext4@vger.kernel.org>; Fri,  4 Jul 2025 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751650175; cv=none; b=lBeBHGtn57ycAAVcu/BAPyU0jndRKg2NMsz+J4ZZNd+UUV+auXsV7H5Fwan+SiDe2tqcuXL6VLIfHRDPyHMe4U/kABJ6tQYN3HWROH96HRzCukx/FG8eztgaLw74yd0MzBmf6MqRY9HQMFT6N/vZOKbQyXim+8GQs4axwA2V7qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751650175; c=relaxed/simple;
	bh=iDbM20iQNedl8N2hzi1Pep7gBZiDuMA5oe8q7lPmVJk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OhodB9yPMIHjlcSSkGjWjUW2i/f26pg10f4rmWQN5j1++2zWgoZ6Pun+ZxShaLHyJKLDpFiUwJux18SVEoQiHih9h/40W/KYes5cLioE8WKmv2tHh4OdMql3WHu6YL9WMyQNXjJSV+pQyjY+DY1GvRmB20WJMiglZQ4t/KHg7Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=qKY65Tke; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e731a56e111so990434276.1
        for <linux-ext4@vger.kernel.org>; Fri, 04 Jul 2025 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1751650171; x=1752254971; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NKZOXif4dY8WW9PJKNKuGFpmuROoWR4AN0EGiAV7vcE=;
        b=qKY65Tke4HoGO3XCKHNaT9zzKkoNLIJV7K9Ab34K9ZY4HcSnXQ6LpH03X5oR0nKz66
         U87ye6WBxhZgaOc8oWef9WLLyIvmGZb+UTyPT40hiHBam/+vZRdB+ZJF0x9HU5gbbDaX
         mFEyhedoLpZo8bkDs9Bz2Kir2Gu3pnkuyX4DjIwMA7SUYJ1C5I9eDP0QZico19gCu558
         y9WcDhz2SXUSbBbVB3KBSTOel0AtfUmQPfqGzsR86Fb40D8EQKNIxOaOqdyn4/+10T4p
         0k8W5HZE1f/uZ441oY9CtduPBvn2uZ4xVlNQRF86gExdEm72KlJyfJGW5JmTi+NHY79Y
         aXKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751650171; x=1752254971;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NKZOXif4dY8WW9PJKNKuGFpmuROoWR4AN0EGiAV7vcE=;
        b=ENU629jbmZ7YPT3pzej035+2YQpsnKyfUrmaVYs5BOxvRKeqWAI2MRpvEZGMLQQmmF
         q+Gjx0amY7OUnTNGmDAvetNzVvJud2JN66LsGHCGdvXOg9W702If2ol96tmrysQGS6eD
         bs89ldnsJ+UlyzZgioV7lLT67T45DGlt1c2Q84RRePvogdZz4CVfWy6js/F7UupcsjYk
         TGoP0xdU+q5rw3bFBzJlpQ5DMDkEw4F7Lr5Cex6t9fylEoOpQngqehkM0P16l30tw1cc
         68T1rOj/Cem4O6EdbYHtX/sWI3kb9hMla07Dlio4WFf3LqW6qgjIYINelCCV+9cTj2Q+
         kjjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbGBV7+XIWhFLkuzoVTRpQzGvuLeGe07EaYWJ9ge5BN9nXSc/I2HMKvGNBDZbV+VS2fri4AXQQl8bB@vger.kernel.org
X-Gm-Message-State: AOJu0YypS71e/xXbiS7w4xrLGfgIqQUsqC+gKo6uEYXZIploFHx2el41
	ThAcUihg3+NEd2paYd+ax8+z8rkPrClrTByEVn3hKIXHwxgtdr4CLjeQxGYwylInGUk=
X-Gm-Gg: ASbGncuW3iX0xH5hVb+OhFOnS4oCFNvpOC71yXYPXQHUC6wchikEK6sD56fCitFsDIb
	W+8eXPCpACquGbfMnLHfumkzb6sQnvqAd9TkpYYXWwTUgy21QDzko5Cp083Mx9zI2YI6HhrPRpd
	P9Hd75f1lvKgIfoayHJaxMaTesHffUNNuANCcleChO6ZGh/5j3eVTol2nMlfeUcLXZCqDKp3mUZ
	KJDKI+hwZO+MLi/CPe/NcY+s+i9FONMQiUOhBnDFaefOx62M2mMfxkkSl4RIQtZzVXUSPRp72TV
	JWjc6V6F/wXMGTZLQ7+ECIdlEQ7H30XrZDGIPe+VsgW8cBHcHKlfgBf9CxPKqFyhkkl+mYG0uAG
	vPRae9PgI82kZQPnLWUS9aYt3xPeLmJM=
X-Google-Smtp-Source: AGHT+IH90uXGHA1KLkxMwBoLjKzi40wo5WwD8z6pePkSFDnX+wBofTNDe+oRgHEM+GBC/SzPv5geJw==
X-Received: by 2002:a05:6902:2808:b0:e81:b6b1:153d with SMTP id 3f1490d57ef6-e89a0c1fb0emr3480402276.21.1751650171096;
        Fri, 04 Jul 2025 10:29:31 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f030:281a:9e2c:722? ([2600:1700:6476:1430:f030:281a:9e2c:722])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c48b086sm742656276.42.2025.07.04.10.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 10:29:30 -0700 (PDT)
Message-ID: <d698490f3ee35889d8922f392079846b647cd47e.camel@dubeyko.com>
Subject: Re: [PATCH 2/4] fs/buffer: parse IOCB_DONTCACHE flag in
 block_write_begin()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, axboe@kernel.dk,
 aivazian.tigran@gmail.com, 	viro@zeniv.linux.org.uk, brauner@kernel.org,
 jack@suse.cz, linkinjeon@kernel.org, 	sj1557.seo@samsung.com,
 yuezhang.mo@sony.com, glaubitz@physik.fu-berlin.de, 	shaggy@kernel.org,
 konishi.ryusuke@gmail.com, 	almaz.alexandrovich@paragon-software.com,
 me@bobcopeland.com, 	willy@infradead.org, josef@toxicpanda.com,
 kovalev@altlinux.org, dave@stgolabs.net, 	mhocko@suse.com,
 chentaotao@didiglobal.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, 
	jfs-discussion@lists.sourceforge.net, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, linux-karma-devel@lists.sourceforge.net, 
	bpf@vger.kernel.org
Date: Fri, 04 Jul 2025 10:29:27 -0700
In-Reply-To: <20250626173023.2702554-3-frank.li@vivo.com>
References: <20250626173023.2702554-1-frank.li@vivo.com>
	 <20250626173023.2702554-3-frank.li@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=mQINBGgaTLYBEADaJc/WqWTeunGetXyyGJ5Za7b23M/ozuDCWCp+yWUa2GqQKH40dxRIR
 zshgOmAue7t9RQJU9lxZ4ZHWbi1Hzz85+0omefEdAKFmxTO6+CYV0g/sapU0wPJws3sC2Pbda9/eJ
 ZcvScAX2n/PlhpTnzJKf3JkHh3nM1ACO3jzSe2/muSQJvqMLG2D71ccekr1RyUh8V+OZdrPtfkDam
 V6GOT6IvyE+d+55fzmo20nJKecvbyvdikWwZvjjCENsG9qOf3TcCJ9DDYwjyYe1To8b+mQM9nHcxp
 jUsUuH074BhISFwt99/htZdSgp4csiGeXr8f9BEotRB6+kjMBHaiJ6B7BIlDmlffyR4f3oR/5hxgy
 dvIxMocqyc03xVyM6tA4ZrshKkwDgZIFEKkx37ec22ZJczNwGywKQW2TGXUTZVbdooiG4tXbRBLxe
 ga/NTZ52ZdEkSxAUGw/l0y0InTtdDIWvfUT+WXtQcEPRBE6HHhoeFehLzWL/o7w5Hog+0hXhNjqte
 fzKpI2fWmYzoIb6ueNmE/8sP9fWXo6Av9m8B5hRvF/hVWfEysr/2LSqN+xjt9NEbg8WNRMLy/Y0MS
 p5fgf9pmGF78waFiBvgZIQNuQnHrM+0BmYOhR0JKoHjt7r5wLyNiKFc8b7xXndyCDYfniO3ljbr0j
 tXWRGxx4to6FwARAQABtCZWaWFjaGVzbGF2IER1YmV5a28gPHNsYXZhQGR1YmV5a28uY29tPokCVw
 QTAQoAQQIbAQUJA8JnAAULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBFXDC2tnzsoLQtrbBDlc2cL
 fhEB1BQJoGl5PAhkBAAoJEDlc2cLfhEB17DsP/jy/Dx19MtxWOniPqpQf2s65enkDZuMIQ94jSg7B
 F2qTKIbNR9SmsczjyjC+/J7m7WZRmcqnwFYMOyNfh12aF2WhjT7p5xEAbvfGVYwUpUrg/lcacdT0D
 Yk61GGc5ZB89OAWHLr0FJjI54bd7kn7E/JRQF4dqNsxU8qcPXQ0wLHxTHUPZu/w5Zu/cO+lQ3H0Pj
 pSEGaTAh+tBYGSvQ4YPYBcV8+qjTxzeNwkw4ARza8EjTwWKP2jWAfA/ay4VobRfqNQ2zLoo84qDtN
 Uxe0zPE2wobIXELWkbuW/6hoQFPpMlJWz+mbvVms57NAA1HO8F5c1SLFaJ6dN0AQbxrHi45/cQXla
 9hSEOJjxcEnJG/ZmcomYHFneM9K1p1K6HcGajiY2BFWkVet9vuHygkLWXVYZ0lr1paLFR52S7T+cf
 6dkxOqu1ZiRegvFoyzBUzlLh/elgp3tWUfG2VmJD3lGpB3m5ZhwQ3rFpK8A7cKzgKjwPp61Me0o9z
 HX53THoG+QG+o0nnIKK7M8+coToTSyznYoq9C3eKeM/J97x9+h9tbizaeUQvWzQOgG8myUJ5u5Dr4
 6tv9KXrOJy0iy/dcyreMYV5lwODaFfOeA4Lbnn5vRn9OjuMg1PFhCi3yMI4lA4umXFw0V2/OI5rgW
 BQELhfvW6mxkihkl6KLZX8m1zcHitCpWaWFjaGVzbGF2IER1YmV5a28gPFNsYXZhLkR1YmV5a29Aa
 WJtLmNvbT6JAlQEEwEKAD4WIQRVwwtrZ87KC0La2wQ5XNnC34RAdQUCaBpd7AIbAQUJA8JnAAULCQ
 gHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRA5XNnC34RAdYjFEACiWBEybMt1xjRbEgaZ3UP5i2bSway
 DwYDvgWW5EbRP7JcqOcZ2vkJwrK3gsqC3FKpjOPh7ecE0I4vrabH1Qobe2N8B2Y396z24mGnkTBbb
 16Uz3PC93nFN1BA0wuOjlr1/oOTy5gBY563vybhnXPfSEUcXRd28jI7z8tRyzXh2tL8ZLdv1u4vQ8
 E0O7lVJ55p9yGxbwgb5vXU4T2irqRKLxRvU80rZIXoEM7zLf5r7RaRxgwjTKdu6rYMUOfoyEQQZTD
 4Xg9YE/X8pZzcbYFs4IlscyK6cXU0pjwr2ssjearOLLDJ7ygvfOiOuCZL+6zHRunLwq2JH/RmwuLV
 mWWSbgosZD6c5+wu6DxV15y7zZaR3NFPOR5ErpCFUorKzBO1nA4dwOAbNym9OGkhRgLAyxwpea0V0
 ZlStfp0kfVaSZYo7PXd8Bbtyjali0niBjPpEVZdgtVUpBlPr97jBYZ+L5GF3hd6WJFbEYgj+5Af7C
 UjbX9DHweGQ/tdXWRnJHRzorxzjOS3003ddRnPtQDDN3Z/XzdAZwQAs0RqqXrTeeJrLppFUbAP+HZ
 TyOLVJcAAlVQROoq8PbM3ZKIaOygjj6Yw0emJi1D9OsN2UKjoe4W185vamFWX4Ba41jmCPrYJWAWH
 fAMjjkInIPg7RLGs8FiwxfcpkILP0YbVWHiNAaQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-06-26 at 11:30 -0600, Yangtao Li wrote:
> When iocb flags passes IOCB_DONTCACHE, use FGP_DONTCACHE mode to get
> folio.
>=20
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> =C2=A0fs/buffer.c | 7 +++++--
> =C2=A01 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/buffer.c b/fs/buffer.c
> index f2b7b30a76ca..0ed80b62feea 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2251,11 +2251,14 @@ int block_write_begin(struct kiocb *iocb,
> struct address_space *mapping, loff_t
> =C2=A0		unsigned len, struct folio **foliop, get_block_t
> *get_block)
> =C2=A0{
> =C2=A0	pgoff_t index =3D pos >> PAGE_SHIFT;
> +	fgf_t fgp =3D FGP_WRITEBEGIN;
> =C2=A0	struct folio *folio;
> =C2=A0	int status;
> =C2=A0
> -	folio =3D __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
> -			mapping_gfp_mask(mapping));
> +	if (iocb->ki_flags & IOCB_DONTCACHE)
> +		fgp |=3D FGP_DONTCACHE;
> +
> +	folio =3D __filemap_get_folio(mapping, index, fgp,
> mapping_gfp_mask(mapping));
> =C2=A0	if (IS_ERR(folio))
> =C2=A0		return PTR_ERR(folio);
> =C2=A0

Correct me if I am wrong. As far as I can see, the first patch depends
from  second one. It means that if somebody applies the first patch
but, somehow, don't apply the second one, then nobody will be able to
compile the kernel code. Am I correct?

Why do we need to make this modification and, then, touch other file
systems? What the justification of this? Why do we need to make this
modification at the first place?

Thanks,
Slava.

