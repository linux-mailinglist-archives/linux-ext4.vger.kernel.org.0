Return-Path: <linux-ext4+bounces-8557-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8783CAE11C3
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 05:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803184A3885
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 03:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1B81C862C;
	Fri, 20 Jun 2025 03:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTuyqtTN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5D1B4132;
	Fri, 20 Jun 2025 03:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750389893; cv=none; b=eJaqjt2pr2eeCGQ4XkiJsSJz9Tt1+vT2N4Og1C5xHNff5wtGP8Df5lBJlDOy/lYPX8KspqomoQZQYnx4wYSg72238bqnW17JMJRDW7T/mZAs6hdbDiiMDMMLZcYonHPONLP9A0zsmvj51QEbvoGEaGZV/NEwmvFJRIEnjIM6mvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750389893; c=relaxed/simple;
	bh=UfJg4yAjOiMV+y31IsOK24NxXe4OLpOYc7tVNgaUOJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VbmBwJddnxAtEyv1r27XFgBSYMyHB6MDJz2DAQxebtuuDwoNIWQ2sgfHR/1E+8fTj9EXFPL+u6jrIQXhmB86GnoqTOieS1HHX+eQOkj84TACMEdkzXeCMD4WYMLwHhU1UlCCLAqNvftQgJxemRYzvDJd4fH+o9Xybo58cLUOypQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTuyqtTN; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b31d8dd18cbso1426136a12.3;
        Thu, 19 Jun 2025 20:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750389891; x=1750994691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FaBuppIXlBQzOfFRhw26Sdi46V73lR3ulh4+iDiaoY8=;
        b=YTuyqtTNpIDQ9EJGpYiYX6+EAcprzfFJzT1gysuxnYfek2sL7mZLJ0RzHP8oEVbS3h
         pDjUsYsT3nwB+Bahkfb2aJsN28q585Rzscjx5t4XBqpEtba1WVyVRMVocbrKv35Z8DtF
         PcMwdAx/E+I3Ps4pOGII6IKgT9lxSLKxcSN2FR3sPvp0r60CKF//8r/OA5zbWqCdo5N7
         AP/AJ9EdCCxna6TshZdAIbmvqXHBDMtKU9asHBqzLi3go4LjXD1oE9MJEABDDoDO4Lm5
         qzanpBHE5DR5vEGjCp0DQCNqMw7S4bXwY4Rs+rbCd2eJnJPtq0pFsgvPd7AfRXqcgma1
         9gUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750389891; x=1750994691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FaBuppIXlBQzOfFRhw26Sdi46V73lR3ulh4+iDiaoY8=;
        b=IN+5+KOKB8PvphzHq0s8ID0gNsnw2R2kiDLgGDaKnHV5ioHCr6E/JLctPDrUQ36KpB
         3+luE+MaAHv4tOvf9wXTi/OJ+K3tE8QIP+Z0YhMVcNWz4CtbZ7T9meiB/u795y4mT6sJ
         VL3PErXO9Aacz968jCpZccgybE84Eem5euWDrWJx/YNtzGl9sQXR9IQg1FgWhUzMo2U+
         lMwi84LqOJ5PM/QFKaVWJYC5JktYnBKBmhUF0NhEZu4FuPb18tRNdN/4/KQOt8wsjz2z
         AES6Fv47GusDKkyqRC3mGgs3m0NFlwSxHV1H4ymv8qOoIVIe29+f6IakSHQDWI3sTKza
         1n7g==
X-Forwarded-Encrypted: i=1; AJvYcCVxcS6qhy8UyCIqGuxi7O7xMV/il5N4BWp1gXTFRtY7uUcpGvwRrJbk4GM5T0fdRZR9LkO7POODQ3o=@vger.kernel.org, AJvYcCXa/P7QZm5lybk68irIYzQqE2ybtpXY6Og/jlm9q4L/tBgLvB2PQ7/i5aBgD/9JQHtDlej0AJG5xqhZqQ==@vger.kernel.org, AJvYcCXsibkX3+RMEF/ktOpmbJDALYMYQqNRcL/72RCelC6tD9CuGBdWSwgUIU3zYJvNfv8vqhMm8QARriBiS38d@vger.kernel.org
X-Gm-Message-State: AOJu0YzeosllWKtSyuO0KRVaaiE+QJba2uRzi+d4nZjmeqVj6/Sh22dv
	SPfOMbC5zGyO9qQFXjbOsN7N0YKCt7Ke4JNZ9bk6z/G2Q+kcPheTAVhmjkqYUQ==
X-Gm-Gg: ASbGncuXJYb0G67irUcd65tTVZV6jcJOlLdxgvOVj9LAAD7AJKDkCj2rHKbLNyZgkFT
	WK2Y8DilizP6y+0QgOx+++SgEOw89FvtcLkf83WHvOM68GmUxEHeKmfXkDHTEuceeJHFxS9HVvW
	oQPKEaR+csMYIhsipC2FJUNNAtp3uqyRcmQSvNIksKFgthC9txGpwuIEFU87x//vFNTpEbkPneQ
	9KPvLuntYDeOkl/Od8eNUreOVgYUSbGXoeRp9LbP6syacv9OArFNqKEtprVu+wYsst+81He7ao4
	C3X/t3Gpt8c/kA48bMO6llpgG+FDsC3Gcw5WkrFecmUgtTeqOR8RtdORnN6VfE0mn9tuYy5S
X-Google-Smtp-Source: AGHT+IG+vaalCxAVq2BC6r08xK89yfNGR2G2wwij9kS1tlP4LtkR20HLJSGApwZY+YCuk+dWsqKg2g==
X-Received: by 2002:a17:903:46cb:b0:236:6f5f:cac1 with SMTP id d9443c01a7336-237d998df09mr18762565ad.46.1750389890817;
        Thu, 19 Jun 2025 20:24:50 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8640dc6sm6621245ad.146.2025.06.19.20.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 20:24:49 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 40C7E4209E8C; Fri, 20 Jun 2025 10:24:47 +0700 (WIB)
Date: Fri, 20 Jun 2025 10:24:47 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH 0/4] Slurp (squash) ext4 subdocs
Message-ID: <aFTUf2IZ72d9BODs@archie.me>
References: <20250618111544.22602-1-bagasdotme@gmail.com>
 <87bjqjh5dr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0Ws6ZzGjYlbKevTo"
Content-Disposition: inline
In-Reply-To: <87bjqjh5dr.fsf@trenco.lwn.net>


--0Ws6ZzGjYlbKevTo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 01:56:48PM -0600, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > Let's slurp (squash) the subdocs instead. This will make the master docs
> > larger of course (although not as big as KVM API docs), but one can use
> > cross-reference labels without hitting aforementioned warning bug. Also,
> > docs directory structure is tidier with only 4 files (master docs and
> > about.rst). As a bonus, also reduce toctree depth as to not spill the
> > whole hierarchy.
>=20
> "slurp" is not exactly a technical term that will make sense to readers
> of the changelogs.
>=20
> But, more importantly... Might it be that the current file structure
> reflects the way the authors wanted to manage the docs?  It seems to me
> that just organizing the existing files into a proper toctree would be
> rather less churny and yield useful results, no?
>=20

Agreed. The toctree approach was indeed my first thought ([1]).

Thanks.

[1]: https://lore.kernel.org/linux-doc/aEpAD2jcemzvoJlQ@archie.me/

--=20
An old man doll... just what I always wanted! - Clara

--0Ws6ZzGjYlbKevTo
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCaFTUeQAKCRD2uYlJVVFO
o2lHAP9OBooD4BhMSfSNF05P4yDJYZroEygDCD5eDsGMXCpLcgEA/kmmZn8B4lnw
7Z2lZTqouXwaj6ZrNpBwKL3n7BQ9nQI=
=+/sY
-----END PGP SIGNATURE-----

--0Ws6ZzGjYlbKevTo--

