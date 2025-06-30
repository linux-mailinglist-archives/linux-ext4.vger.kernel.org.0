Return-Path: <linux-ext4+bounces-8695-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DC9AED207
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 02:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DF1892F9A
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Jun 2025 00:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C368642A80;
	Mon, 30 Jun 2025 00:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/CPutkz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292C82F3E;
	Mon, 30 Jun 2025 00:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751244831; cv=none; b=ZkQCUuseiR/184RGsshTJc8QZqncsE0oy08HhsyCjav5Kiayg2makvOvYBQJzIEYDAVU9q8wVzWqXlriaC4vD7AufFL/UXcF3J68fKjxsjb5nFUtsG2OhwVHSgVDdDv9TprSmhAzDckbYBlravNq43LHEY0ku3g/rOIFLRW2qTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751244831; c=relaxed/simple;
	bh=FKthKZ5AGBI1LPO2Rof+WridS24SjCZIkPO3nQZVzBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrUACadZEvMwBIyJJnWPaxS9MmUFOoms1f3cAxktXF5GmtAKN+7VKVk9heqDNpg4wYsYmozpvAeryuG6iWazg1GVln6FulM62dPzF9rvZExAMwGhjByDG8S0tl5O4SUkUux7riz8Ea9F0H+rygm6Ecu1OMclxf+FhX7Bs8ZnyrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/CPutkz; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2363e973db1so36721155ad.0;
        Sun, 29 Jun 2025 17:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751244829; x=1751849629; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKthKZ5AGBI1LPO2Rof+WridS24SjCZIkPO3nQZVzBE=;
        b=X/CPutkzZO+3DYbnD0re3eWQ7KFEww1oThoIUJbyN3StUvbvl44cN+dUJzDiROom6x
         dibYdqIMlwU49oCx3IZnqVUKs7dTMuhJ5yFko6U41gnI2u0tHkCJM4l7wTpN9EZrZpk6
         jq2HqmZt1ObhTkyR1/NwnFSXRKBEVLQkGGQ0a4H8xPbrbpiO2BZc9MRRFbk64nAEgt9x
         Y+4xLImDTSHNER/3vzEiWBjeJ9S7KWgGuCcKtEpRFDkqd5fwQkwkWhGhN2ei8yE3majI
         pyxqjFqBB94cu/pI/YVZj/s6Y6sldYFzqjwcK+FFHQBr1zKo2g5+9NM0LYTeZBrNAywB
         ji2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751244829; x=1751849629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKthKZ5AGBI1LPO2Rof+WridS24SjCZIkPO3nQZVzBE=;
        b=qT9B8xpS2oB63ZGhgHhJGKb21MYIzEbAu3vtbyuj2o6tXP9HFGChglPKYmxYWwjpbx
         QPTGIsWNlQl667Y1YcPFA8qo1KTilJgZgWSbTce/0f+esco4/+moyRt5nztfA89g89zi
         hp0UnO6EOjO/LIu0gteJZw/aIk+J78VniTvQJHWwjsc/gUiVHFG8t71CbulmHBmuw8EI
         IS6CuVkuTMvtbC01iT99GdvKyQNLbCCTUGVP2IZsWRwLS7Pks/LlIH62aiT7HgLLQeLh
         b0o7bJB+WDSqhivjrVk9Hy9V+gFZdbQSR85q6143neFiTn7EC85LdKUfkrtxmzkYw3mt
         +tKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4HMmmjRy0SopXP4hFtHlfnzoSIutVBznRbwrf2iIIMBMSWTb9g136wzibI87pNiomk3DGe5f54hMEMw==@vger.kernel.org, AJvYcCX02GU7goo3iTXGePAzegJrxYnBkNKrBw/XKNTGeEButpG/farcwqQeYTUSkLeeo/+oLUmfNr7GZaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfId+hfws0zuHK6u8UX3wNzioHSSvUiPrNlviAkmXWEMt6+vqR
	I6Ja8x43yJiV2BGH+rDgTeWhfBjX3Lc5hnQsAREYEcPZh05TB/MUqgOA
X-Gm-Gg: ASbGncsg4lL+W3T+xjkzg41vBXHC0ukrN8s5+GlgauSMrV5JNn7N4grU2zu4qJAuF/S
	XlNmyckUU8L8q4tZps2SZfQhg0bRmbYXQjVdS1iMPaVNfvF8mtjWbG4xdnKH9FDiStsSWLyx5Iu
	0/TOXpuUrGgHWCYSR1FN0/Mf7LzIbp/x3got6cH4EKyQPDCuT4+QFqHcDQDGpg36EwedDZ1UaSf
	zN+h1kigONyDaSeRdn5nCWIEdNqx0vHnd3R2zDPWXSgNNowByoo3PtdfW4JbKaOzUsrYWVDOAei
	ygv6RFb1K9LSPAPZyrblOUF2Kf7V3Oif4ylp2Nz4tTJQmWjKvZltIzWHLH/OCQ==
X-Google-Smtp-Source: AGHT+IEQbWodGX0rf2OvvWXvNIJP82dLnAuWdeDKxG9HiLhYS/lYFZEU21+vks6d+QYinYUbznlLGg==
X-Received: by 2002:a17:903:f8d:b0:221:1497:7b08 with SMTP id d9443c01a7336-2390a54c778mr261738635ad.23.1751244829186;
        Sun, 29 Jun 2025 17:53:49 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e1a8asm69663575ad.47.2025.06.29.17.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 17:53:47 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E4817420A813; Mon, 30 Jun 2025 07:53:43 +0700 (WIB)
Date: Mon, 30 Jun 2025 07:53:43 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 0/5] ext4 docs toctree reorganization
Message-ID: <aGHgF0Aa8NlTw6Eh@archie.me>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="c9RWCR0bh8lBIBaX"
Content-Disposition: inline
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>


--c9RWCR0bh8lBIBaX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 20, 2025 at 05:56:39PM +0700, Bagas Sanjaya wrote:
> Hi Jon, hi Ted,
>=20
> While discussing on my previous ext4 docs reorganization attempt
> by merging contents [1], Jon suggested that considering current docs
> file structure, a proper toctree would be ideal [2]. So, here's
> the patchset that does exactly that.
>=20
> Actual conversion to toctree structure is in [1/5], while the rest
> is cleanups to make the resulting toctree nicer.
>=20

review ping

--=20
An old man doll... just what I always wanted! - Clara

--c9RWCR0bh8lBIBaX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaGHgEwAKCRD2uYlJVVFO
o+u2AQD1g2L9ChBvGW4LNkYeldjFp7I7eZw2ZLpoGkN24tpp8wD+P3409BFqlD9K
fWnBHJJv/Du+6seEQQhFtqrf+auW4Q8=
=KWON
-----END PGP SIGNATURE-----

--c9RWCR0bh8lBIBaX--

