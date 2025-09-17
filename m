Return-Path: <linux-ext4+bounces-10229-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 827E3B7D6AD
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D32E1C0316F
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 06:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10AF62627F9;
	Wed, 17 Sep 2025 06:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="R/lPyAmP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA5710F1
	for <linux-ext4@vger.kernel.org>; Wed, 17 Sep 2025 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758090393; cv=none; b=ekwcOiePhiLAEGkB8YJz7pv/e9D0G/PpCXa8qxbTSI/Ao5s08TqPjVAQjzpKgCFWe9nGzo9Nm3/1nl9qDGeXZ/STKWS/od7a3t0+gHr2S4eHvwVHY2Z5Iy5Wl9pYQ3LUxhLi4oCzAPD2pZb39UOp+ZMZ8o8+1I8LCvnbU4QYM6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758090393; c=relaxed/simple;
	bh=E6KKy6zfbcKrhrUHA3d/rAIMDp0BRFaZgyROrwmxNQo=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=Gj/C2w7d10qAexsLQXtIo2fVxmPKzynfdJyg96TjTwTUbWO8VOZmxxoedm11uDwdBIKGosxzo0LYpBhhCeVYav1Xqm8eXFnUtrrweO4cmR5NUYOEKJqS7viJwb6SonZmWsFy5rv75lSZK8BtZN2+WrchWCZ1sVNnVd8HwugVf0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=R/lPyAmP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54d23714adso466337a12.0
        for <linux-ext4@vger.kernel.org>; Tue, 16 Sep 2025 23:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1758090390; x=1758695190; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1bI5LBj8RG4IS4WwS2xJKStu1xxVLfsr9SnWt61k7+c=;
        b=R/lPyAmPmbu2KlmCNWiAe8Fi3ajEHxWxB2opD3SItLxbS5X0tHy72E4F7Lfr4Y1iyE
         AfO+ro71F+/9dRTf+b2szFIlhO3IyyjAx+0qJxyh1uvau3ZyJc6XxGpyCP804qdydlyx
         gKpt5BtXf+z10Vx+VdSGl0N0U5iEof7gaBefUR/uLJIhyVaeUKuMGlQbBrqgm50Pg3QB
         3jpwn3D4mIDbU7o37hoR9H9HkQJfC6HEHhokiovQw53uitB2Fda3HJCBf++BBoQgZBuN
         Bs+fINtYWhb7qGa/pmEW3K53eCcBQjwe70QCGYjd7tfjNnxA0Y+7qqDMV/kk1iwnDmBE
         PfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758090390; x=1758695190;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bI5LBj8RG4IS4WwS2xJKStu1xxVLfsr9SnWt61k7+c=;
        b=tVtgL2WaKMtWvXjYOGZ57Dxo8FzCr0rBBrZ0gZc2pTTRPw8FD4T4Q5hBedvV7EXk6L
         X0TgW7OJA1DcNBzmChjLEVQfse7cWd9DGObYpoA3irqr8oh3OEP/91vvvN78OY5Bvn+n
         xlCQRlMh21D7on5uViCvOcucGrCi9hICc69Jq5l4Ze3duJQDAxcLZvMhab7XeKLFT/BV
         dPmzeUuc4OGjZDPRYvjqdRUzueJExBBtrmm5uca9I6lCyxV919/hejkh2S6ga/S13gft
         jtZug2WqTzKSJ6yGUsmL56mYxMDxhjRbXcE7cK6VJTrQlH/NEZzmBAwia+heS56xrQO8
         be8g==
X-Gm-Message-State: AOJu0YwCAaQxfrWyHHN3APjDhV0A5Vx2qF37i/nP+cj4Lz5sbwrY1LRs
	eDIsC3UkG9xzlA+wbDfD2WxpAG5R4DYq/anoFPDy4BwirQ7fOGyEnQFLqUdp/mbt67fjA3bNVzL
	8nBQZ
X-Gm-Gg: ASbGncvC9lg/gBYKs6WK3lQHRP+naRAltQ0zkA/ADpq6W94/OzSmdlcUaBXfYl/yU1y
	MyAyM48Ebm4JUExwAY2YeptWGVBopfL2xw1oJyRmltfLqFtJc5llakpKJc/AAseMXwl+wez5T/J
	i2dPDKFvasIfWIDbEYYwCpNLeryoLsNTZFPTyxJ0tQEOdfdv+4QSk74OBe1WCabVnDxMwM4JHLi
	DenI8LUMC4t5v5sXQ+slpv5Ef40Moa91C74myGGI3dWulTdOmqJQAjHTItxVWhmyFtowtUNjt3X
	mhZ0dTq0T7JgzDrafP5xI8SAYb7JaPVtpyBKsIIuK8zfYPToH7RxRp7neeaJUrda5Tm7PCb/A5p
	WsJ/Ff2GEhz/SX8++s7sl05k3uYfCLnxBNOF8p7uKqBam3+tK6QX3dSuGwglkRfg3ER5aPP4A
X-Google-Smtp-Source: AGHT+IEY+w5DySha4s3psQbrH3TccRfSFkithtPv+PG+alEfKPEN5Lfgv9VRZQOjI1JcaI9L6UX+bg==
X-Received: by 2002:a17:903:1a6f:b0:269:4752:e21f with SMTP id d9443c01a7336-2694752e600mr4005545ad.22.1758090389787;
        Tue, 16 Sep 2025 23:26:29 -0700 (PDT)
Received: from smtpclient.apple (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25e66bf4017sm140982375ad.66.2025.09.16.23.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Sep 2025 23:26:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andreas Dilger <adilger@dilger.ca>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] E2fsprogs: tune2fs: use an ioctl to update mounted fs
Date: Wed, 17 Sep 2025 00:26:18 -0600
Message-Id: <C2130E9A-7467-4AC6-A0FE-0C4F4093DE20@dilger.ca>
References: <20250917032814.395887-1-tytso@mit.edu>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>
In-Reply-To: <20250917032814.395887-1-tytso@mit.edu>
To: Theodore Ts'o <tytso@mit.edu>
X-Mailer: iPhone Mail (22G100)

On Sep 16, 2025, at 21:28, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> =EF=BB=BFTeach tune2fs to try use the new EXT4_IOC_SET_TUNE_SB_PARAM ioctl=

> interface to update mounted file systems.  This will allow us to
> disallow read/write access to the block device while the file system
> is mounted, once we are sure the updated e2fsprogs is in use.
>=20
> Theodore Ts'o (3):
>  tune2fs: reorganize command-line flag handling
>  tune2fs: rework parse_extended_opts() so it only parses the option
>    string
>  tune2fs: try to use the SET_TUNE_SB_PARAM ioctl on mounted file
>    systems

Have you considered to use a mount option (eg. mount.ext4) or a flag stored i=
n the sb
to indicate that a new e2fsprogs is installed in userspace?

That would take the guesswork out of when to enable blocking direct superblo=
ck writes,
and allow this feature to be enabled sooner.=20

Cheers, Andreas=20

>=20
> misc/tune2fs.c | 763 ++++++++++++++++++++++++++++++++-----------------
> 1 file changed, 496 insertions(+), 267 deletions(-)
>=20
> --
> 2.51.0
>=20
>=20

