Return-Path: <linux-ext4+bounces-8376-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34352AD65DD
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 04:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDF8178913
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 02:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3201DAC95;
	Thu, 12 Jun 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBtW6R2Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AD28F1;
	Thu, 12 Jun 2025 02:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749696533; cv=none; b=SatiBa71BU26S+WA0/jXOkZzcAV5CbCm+dDtNzwgsKOJgCu9CEiwr2GOKDFOZZOjsRa5upJPRH+I/U/VF2xeT1qcZWKW9LXSBcTFtlplcVku2X146YCQFBFFo3OrYQggUhY0fKxclzlJUm0x4Tu62zr47QBj93K5L2ryFAbUNbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749696533; c=relaxed/simple;
	bh=uOnIiEnqoE5mn6tpYF1c7GMhpFzVKgaFnmNewUSAzWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7lPkaYefP4W8UgmTbOrcg7zkM749gAqb9oARAGmjwuaWt3rmc/JwtKZ0vhaGi40lNw1f3LEkP9oY5wrcRSqlL8+eG6+HLXjH35TMCnZMjzLsE9jLeApm0e+AnHvWDsBPB3zFo4p/Gplcj47gZEl0wg/+CMJyoW916zIPBdi21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBtW6R2Q; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7486ca9d396so391850b3a.1;
        Wed, 11 Jun 2025 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749696531; x=1750301331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ahiOgmSZ189HLN8mvTYFQfG9zC9TWM2CIiM/X5I190M=;
        b=hBtW6R2QRxfBPt+LLGGgK7sUF9Edswg7zSUiVxR9fxaeepSDt1MCwmBTlRC1lCMUzT
         AIq5fLNZuUXES4cNXYtRn06c2CsFtgz9tD+Wjko0n/dauUfJN70OKIvV/gbylGEgakgw
         nybrWltl52BJQgPzs/objccg+darBT/tPxoPR3GRi64saI2T+I1G40qBZRbWju0MQFdQ
         Kjc3gV4ZIXezqvEG4MHmA38ZJ1MaJPku13szMGbpgshT9Bf/IZK6PatUzybE4bR7Wb32
         oEXvQMKVIFyVfylkvezw1F54lQx5fKh8FqczJ3B4H7381Oc8m0yIYficL56LXzp/++WJ
         IQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749696531; x=1750301331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ahiOgmSZ189HLN8mvTYFQfG9zC9TWM2CIiM/X5I190M=;
        b=mzSxPodVTIcm+wlhtKU3GaENsu0qeTD3ldHdtJ53DBSsJV6KPGPFNvFfilKrQbzCWI
         ouUsKHIA+tLRKOYlgGhQn5S/ETiWhPjSKo2sYN65+UPGvNt1tjmPepcynCyo+dLcNxKw
         FPTxPOVOQxs69cx58B1O6XOO7K3dAVN2a/m6skhDMRz+ypgvntyC3/fIHKlapPxBL2js
         2x8ZGxPZ7lKwwz+D8kov8W4PKNsRBmGSOqjj6wG4d9ruMZKH3Pmz5oESRPxyhRD56po7
         oCaRsHfbIXwp9QCNd5e7YFeqP0A7ZfTDF17kHprvty6CDUosciXPDvuh+1Cxc4BJKUyq
         GFlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbJw6UofpJ2N6b/vFA9ot6FGqsRfTHeyXhQu+m3P2/L48xs6uP4vryOGAO+iLVDKtCrjzk5FUuc7s+Rg==@vger.kernel.org, AJvYcCV/vaJV3DfMwEpL0r1D1ENDalKIfVCisiorp0/p0aAFdklIIOmWy5jkCVKj293JaVv9WvgP0tmdCp4=@vger.kernel.org, AJvYcCWGrshnJKs5rnm0Gc1pfJyN8pFd7fkez4WKoHlKCSs0IXPpzmrxb8HAoEI0JiY/x8xka98KqlIS93HZvus4@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6udsMFzEP57ZEaR6z2jeVs+2iZNItZczN9QLs6v1SAaUtBr78
	hDeUzFjaYoM/VOROGpYKjZ8UR4eICkdCltCm8qz54qmWTcHk/Fb6lZz7
X-Gm-Gg: ASbGncub3GN2P8UfU7MIg1x+fHh2TCNewgM9eMv7NZaoXStFwKKNOBfKkEbjrp+YSTz
	PCV2ytLydDH9TbpM6pPDhbY8W4pT0lcp6C+HmPHt8d9crL6hWg21aqJMIblH590ggPGrwAxGwT1
	k5PtYbVsAK4sRbAPhCuQ5eKmsNlgdAPChEnyADF6zJfoqyipo7qr/YfvxmwQ1uUrXTjfIiMhOJf
	puntMZxx+zNRH0myy4jQZTyBoFsAOkR3ZrAuiO92b2XGdl3BYvpsYmPY/e73/6Mp5q4kCNrOAa0
	Zdt0H5knePsuFEgOAGapqjq5KD0N3deruabFSGS1KmFt5JSL9G/w9n4HU1qt+Q==
X-Google-Smtp-Source: AGHT+IEPXTV4XHn9uDXHGaK/gbEBhU8EdhLwd5PI+auaZzZZJ3JyAqtwA3diSRBeECjUiD83gObbpw==
X-Received: by 2002:a05:6a21:8dc8:b0:21f:5c9d:499a with SMTP id adf61e73a8af0-21f865baf0emr8969453637.4.1749696531007;
        Wed, 11 Jun 2025 19:48:51 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d2ad2sm321652b3a.107.2025.06.11.19.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 19:48:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 51567424180B; Thu, 12 Jun 2025 09:48:47 +0700 (WIB)
Date: Thu, 12 Jun 2025 09:48:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
Message-ID: <aEpAD2jcemzvoJlQ@archie.me>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs>
 <87ikl21a5u.fsf@trenco.lwn.net>
 <aEoaJEhw5qHkd2_w@archie.me>
 <20250612010942.GJ6179@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3EZ4Rlku9TfdJSmj"
Content-Disposition: inline
In-Reply-To: <20250612010942.GJ6179@frogsfrogsfrogs>


--3EZ4Rlku9TfdJSmj
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 06:09:42PM -0700, Darrick J. Wong wrote:
> On Thu, Jun 12, 2025 at 07:07:00AM +0700, Bagas Sanjaya wrote:
> > On Wed, Jun 11, 2025 at 11:05:17AM -0600, Jonathan Corbet wrote:
> > > Sphinx wants to snarf up every .rst file it sees, regardless of wheth=
er
> > > it is explicitly made part of the document tree.  So it will pick up
> > > atomic_writes.rst separately from the include.
>=20
> Does that mean that overview.rst doesn't need to include the other files
> at all?

I think overview.rst can be turned into toctree index.

>=20
> > > This could be "fixed" by removing the .rst extension from the included
> > > file.  But, since there is no use of the atomic_writes label to begin
> > > with, it's better to just take it out.  The other fix, removing a cro=
ss
> > > reference, is not entirely ideal, but there is little text between the
> > > label and the reference.
> >=20
> > So removing the labels looks good to you, right?
>=20
> I don't care that much either way, but if sphinx is going to include
> every rst file implicitly then maybe we just get rid of the explicit
> includes?

OK then.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--3EZ4Rlku9TfdJSmj
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaEpACgAKCRD2uYlJVVFO
o7eOAQCdeMUtvQb2DPxQBBJkiVZfYB8zlwVecHaK5nJE1VUS1gEAtQ27FccaLbs2
anyE3yTXXMGeHhBy5V+RkXLr2Dp8YQ8=
=zJ3y
-----END PGP SIGNATURE-----

--3EZ4Rlku9TfdJSmj--

