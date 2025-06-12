Return-Path: <linux-ext4+bounces-8371-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D62AD6455
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 02:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07A13189E4BC
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Jun 2025 00:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54A32905;
	Thu, 12 Jun 2025 00:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fp3WfuMd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB6182;
	Thu, 12 Jun 2025 00:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749686827; cv=none; b=Unxkn29gpKuRlMndIaatfFbOYnA0aukWPxgQvsokLIM7FMTz3cv+Vq933iS5AlhisUPHzLgu4nkw7QSVJZ+yEIrmuPD+IKBElGPWQMSklMkNIDE3dso9cyRQMiLa1IOGBsGWV+BKjLcXZIx+mjFTmi/LMcZn3B4lXIqM7xRjIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749686827; c=relaxed/simple;
	bh=kM4wkz/dwxa0xW4cXGWEbX2WdUscnexwQFhQh8Zq1Gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7Eqtp/iucAQLefSF/tvK9rbChyqvACntgh8s0+oJPmJpLi935+9biqstb+Ft3EXqEJckfwn1YH8beB9QHkU34xywqBIOuv7BdC7EcxBqxFRz6PFfF0SRMmRl6mdMZsbkNDGIvFaQtYkLkPhr06ClKVcg3v7MM3aic68ouvQeKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fp3WfuMd; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2350b1b9129so2992225ad.0;
        Wed, 11 Jun 2025 17:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749686825; x=1750291625; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lQdNWisb6TalRPXEapWg0OiOyvj6XGGrfSAO9j4MbfQ=;
        b=Fp3WfuMdOfit25omUexpMieIQqEcLCdPUXldh8lrb2/5Ypjon/Coz48jSiBclh6MSh
         MgKdsonWW2q3lQER+P7B0QpfB1dpoLvh9zAcW810tKXItQDu5n2TvYO+WHLQ+Mpu2YQ7
         0WyT0nTl/MaeycPkeuMP13ds4eJhYyx0tx6AzlM7QJ7KTGpGj5+2AhTFgy8IqmrZWaSO
         UKm5mnst8lPTxWpc2T9gKRrD3o0BQKQC/H7YDgKriS7QmRDgJ+yhzocag6OoH3Zkl7h8
         XG6iK8/J6Bldo/F/oZRjWWptVrxflNI9aYeV8jZi4L8QHUZo0ulhFEOcDnFvQZX+lHD8
         H8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749686825; x=1750291625;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lQdNWisb6TalRPXEapWg0OiOyvj6XGGrfSAO9j4MbfQ=;
        b=N6Nq4aYbNooQadUv3ixRHxMtI7oeKT/d+aAIHewWoYbkCvyQYCPhsPiYsXlM61Pydz
         6NT6pkFx7Xc6wzQ4RGHQeWB7UJXNeU52G3YG6EDohIF8OyHVEfHIn839gDkgGcgqB/At
         dJPc1JBZOLuQpESkmlD/0w/BVE0mSrIYL+wfSQUCdJt2Du5EEQlxIO1+ntWqAj4l1uL6
         h8Wwh7RhU2z8KwEVor/GLcOn2Zm62MRTFZyfSBiHE1pIWKwtTnMvK99213HfcD+XPnAo
         4+sAYOX3kOUS6JsA/TQbkkh179QbqqOKo7ESLrOhJfyh3y3Ot/eVlfhk4ejhgHsHY/wK
         wLOA==
X-Forwarded-Encrypted: i=1; AJvYcCU8SRP4rapSwwI7j9stgT3WUEp2VVj3UbADed699bpPodz5jqCAzh82JoALr8uovhL+ZE0uoVrfHn/sUQ==@vger.kernel.org, AJvYcCXO8mS2yhbgcflzCU8BO1ObNrhPCNkLjUPZlDEA6//4nsURqXd9junmYhmu29aJRqVib+BYVD1/WMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy037T2kTeIST5CCxwUmlrWMQXQD5RenLhi4dy6mPr8d6/oMSKm
	FznlntUezlVhS5Q/0vuNpdnwYue8n0aKazy0NMFRYY3zobq+XRQ1BcFS
X-Gm-Gg: ASbGncst5t86nhF0oGG38o7RDE89hsYFKpdXlQwiEmTQ4QwdZqWoK32oHylqtcqxwND
	Cex6SGLAmRgwIgagEUESdDtlCb+AWZ0j84CKkJTs+ly0op5kbCS5Jp8hbcI6UwUGNooFG2fEvls
	qjB8dXQGiqGfWqXMp+6GxeSFacenNc6Z490plf1Ia2qVbPJHudsZHfJtCe7UQKi6MDz6xMkT8eI
	xEWbiDOemyyCyjJjaDzkn+RsEhtStvJOCpfrI8gNlYp8KSdhmT66l76xVN/exef+WLL+bfqoPaA
	p03PIjYCKEBJx9fXZuvXmuj7vng0IcpUR3zOeA4vUdQpNUpq5Xpw6ke7FsTdwg==
X-Google-Smtp-Source: AGHT+IEsN7Bu671DA14zZxy9bgMmEbIOhi5XXbISeqwcmmbAcTTvu3o69KPy92HniR4rrPpub1UMIg==
X-Received: by 2002:a17:903:32ca:b0:234:c2e7:a0e4 with SMTP id d9443c01a7336-2364c8b81ccmr18935955ad.3.1749686825121;
        Wed, 11 Jun 2025 17:07:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2364e6d9bb8sm1582135ad.113.2025.06.11.17.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 17:07:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id A96B1424180B; Thu, 12 Jun 2025 07:07:00 +0700 (WIB)
Date: Thu, 12 Jun 2025 07:07:00 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>, "Darrick J. Wong" <djwong@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH] Documentation: ext4: atomic_writes: Remove
 cross-reference labels
Message-ID: <aEoaJEhw5qHkd2_w@archie.me>
References: <20250610091200.54075-2-bagasdotme@gmail.com>
 <20250611164800.GC6134@frogsfrogsfrogs>
 <87ikl21a5u.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZHoNJR7Yp/fs3t3e"
Content-Disposition: inline
In-Reply-To: <87ikl21a5u.fsf@trenco.lwn.net>


--ZHoNJR7Yp/fs3t3e
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 11:05:17AM -0600, Jonathan Corbet wrote:
> "Darrick J. Wong" <djwong@kernel.org> writes:
>=20
> > On Tue, Jun 10, 2025 at 04:11:59PM +0700, Bagas Sanjaya wrote:
> >> Sphinx reports htmldocs warnings on ext4 atomic block writes docs:
> >>=20
> >> Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate=
 label atomic_writes, other instance in Documentation/filesystems/ext4/atom=
ic_writes.rst
> >> Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplica=
te label atomic_write_bdev_support, other instance in Documentation/filesys=
tems/ext4/atomic_writes.rst
> >>=20
> >> These warnings reference duplicated cross-reference labels to themselv=
es in
> >> the same doc, which are because atomic_writes.rst is transcluded in
> >> overview.rst via include:: directive, thus the culprit docs get proces=
sed
> >> twice.
> >
> > <confused> How is that possible?  atomic_writes.rst is only "include::"d
> > once in overview.rst.  Is the file implicitly included through some
> > other means?
>=20
> Sphinx wants to snarf up every .rst file it sees, regardless of whether
> it is explicitly made part of the document tree.  So it will pick up
> atomic_writes.rst separately from the include.
>=20
> This could be "fixed" by removing the .rst extension from the included
> file.  But, since there is no use of the atomic_writes label to begin
> with, it's better to just take it out.  The other fix, removing a cross
> reference, is not entirely ideal, but there is little text between the
> label and the reference.

So removing the labels looks good to you, right?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--ZHoNJR7Yp/fs3t3e
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaEoaHwAKCRD2uYlJVVFO
ozRNAP4rqmYsSw/PYLeoGBzEqB5LnXGG8bFlzEhWr2Xjst8QGgD+IDODlnZyKYVW
nWWTqzLnYN2LmlAyRXI2BiDN7EYWUQ0=
=wyqL
-----END PGP SIGNATURE-----

--ZHoNJR7Yp/fs3t3e--

