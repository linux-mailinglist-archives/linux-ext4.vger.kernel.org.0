Return-Path: <linux-ext4+bounces-2840-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF136902A4A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2024 22:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88D541F24660
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jun 2024 20:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8F04DA0E;
	Mon, 10 Jun 2024 20:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="uFk8m5k4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3836A17545
	for <linux-ext4@vger.kernel.org>; Mon, 10 Jun 2024 20:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052913; cv=none; b=OtuGuHmunUV+8HXbPAWcXJtbqYHSIYYgOiThVYTcuGbsciAHj5B3iLyDgb+mglQvdYEiCpybiaFmEC/9boGY690DEng6iTO9Gst9aoCLhV4oH63EaTbnfOlcu/sK0/aF1h7/mkt7tNhHwhc72O1u6vsgP1iFtMMUmuounc29LWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052913; c=relaxed/simple;
	bh=8Y1NSG503wfVzuDj2cF/EshhHcwHy5rH7iPB81OOEMI=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ERYa2oeU6pNg5DyOarBOMjStZ3IWA3ETw0A2Yw9p0NGxbgvFikxuZ7eIfNC55OdVXKLyO8MovdVFAMm4CEuGqQYHPBv3TaXOnP/5DQ2cHQHbyXtz8gzTB4/FNuUzm+Db0eUHy5Y1P9MJntDvJJDJieK5J1eDEQY2FM6yBeOyMdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=uFk8m5k4; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f480624d10so43784385ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 10 Jun 2024 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1718052910; x=1718657710; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=EuaJxvRCyWnmSKBZm8X2IijGDFCvSRqpEMUvI0L5QVc=;
        b=uFk8m5k4r0Gx5Nk4x0bkQJ2AZxLbRs1KNpifNz39xQBntcPZ/7qaB5WuKiyl5QdY5V
         GhBhZ+SyMv16Av2SOgdm0bXkIfEHtp4XnoHuq5dS7FVDR7l49fsMHkKRHTewJYF79u4E
         xRsIb1ywi0hJP5YF8GkKiPdNt2tAdvJV5Rnkt4L09/faWe1Ru2mNvIWld0WgjihStsaD
         hkA0RncJZNyYsmwOZHCoFE82s3j1J/Fx2m9jNEyrupFLLjeLGzmttNbm18Q0DzBav+nz
         /PIhpxc8Ve/G45DQwuc3eFDYM7pF+VK/QooBiC8INuSyiatHqRdeNs1/PD5dKNnWAqUK
         1hHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718052910; x=1718657710;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EuaJxvRCyWnmSKBZm8X2IijGDFCvSRqpEMUvI0L5QVc=;
        b=o+arTLhpOZujILiSBiaq7kqpDlLDoAXoJ8qG+UtO05Ky0kmdBKNjiK5i9BMadO5PqP
         zFdgzQgKIzF82C4usNMQi9bMieiv/PUBCV+DO2yVsTTWFm+ZUHGBAFwHVOmaAbfiQZXr
         HBfl2rkk4l8ZSY3hlT3pl4CARID4gCF0JLVMDUisSEmMP4080eCGZBCwI4Aw3gGzTVF+
         LYfA1fCJEulJjuSMbhJnPhagb4lszkYYhSjF+h8IZyVlSSOcy7o3uU9icA/Sr3u1BelB
         aiCPoutI8N0tkcW5QvRrjwvJmvU3Y5pzfy317ucumT93z403cFmDP+FVYcLkCotoJ1sY
         d/lw==
X-Gm-Message-State: AOJu0YxkFsIqfFjzGg3qBG17Mma3L+Z6+PMbHe5/JLqYl/QDL0gp5cz3
	0oWEtd6VZtgah+THhSIijEZwSlBJUxirxwKfOQcKFCbmbW+BLh1z7WWv/1y1JDYW305qcXZrWk2
	RJcQ=
X-Google-Smtp-Source: AGHT+IH4uIaV7V9YwdwX3BxhJ/jTpB1zJ1+twuOz6Lj+aAiA9RX9HTaYykm9X0s2oCu2Z458HyIW+w==
X-Received: by 2002:a17:903:41c7:b0:1f7:17c2:116f with SMTP id d9443c01a7336-1f717c213bcmr35633195ad.53.1718052910285;
        Mon, 10 Jun 2024 13:55:10 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd76c240sm88404435ad.89.2024.06.10.13.55.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Jun 2024 13:55:09 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <A87288AE-DEE1-4D3F-9947-FB5A82F2643B@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B925A3BA-F4C5-40A4-8E80-A544FB103A61";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: stat Size and Blocks numbers don't decrease after deletion
Date: Mon, 10 Jun 2024 14:55:01 -0600
In-Reply-To: <CAPXz4EPz+JVCBJ8AF3u9JKzQZk1JWZvf4oW9VVJxVTry8rJz6A@mail.gmail.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To: Nic Bretz <bretznic@gmail.com>
References: <CAPXz4EPz+JVCBJ8AF3u9JKzQZk1JWZvf4oW9VVJxVTry8rJz6A@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_B925A3BA-F4C5-40A4-8E80-A544FB103A61
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 7, 2024, at 10:25 AM, Nic Bretz <bretznic@gmail.com> wrote:
>=20
> When I create a new directory and new files in it, I see its size and
> blocks increase when running stat. After deleting all files, the size
> and blocks of the directory don't decrease in stat.

Correct, ext4 does not shrink directories after they have been =
populated.
There was a patch series at =
https://patchwork.ozlabs.org/project/linux-ext4/patch/20190821182740.97127=
-1-harshadshirwadkar@gmail.com/ that fell
into a crack and was never landed.  However, I think that patch would
still be interesting to revive.

> I was thinking that ext4 runs defragmentation in the background and
> eventually those two numbers will decrease. It looks like they don't.

No, ext4 does not do any kind of automatic background scanning or
filesystem changes.  You can run (offline) "e2fsck -fD" if there is
a big problem with large empty directories.

Cheers, Andreas






--Apple-Mail=_B925A3BA-F4C5-40A4-8E80-A544FB103A61
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmZnaCUACgkQcqXauRfM
H+A8wRAAipaQdPdOJGYeQ5aGTIHOtJPw75OCrryWYUR0I32A6EotpC1MKNgLw0Tx
0BQb2AC6eZ4X+jxZ68UPJzeJkw5RbrdkI9r/TN+qy1C3X7WaVRKCWD1muenjrCYx
JHUx+HWDmJJQX81LmSePottBd+YBkyNcQuFyntkspfVZpKHrXQ25h1uOCQ17IrS5
wi2V+SHTpLiIzxrZ1j2ItBLaBjGriHbxnFPYF6EyD+yAvjrJa2xrVfr0PeaXdCi/
So0CvWNHZNYEcfYFl3ilhETCM6K1tjOFR88in/wDg0/OGp3TnO2SlTVVvaL7331Z
B6bH2dDbEsd1VnsBAvZ8RuPzKOK2vQ5qxB3+VjqxytpP0EXiigaiq7v0SanKYAuk
eoZttSFcb5/Gbp3P73zPx53kQA9mhonTrej3cB1nwMSZUownwJLmbQVxrnjqo6lV
uvCKMJx6fvRPKCzbawBZfEJixXNTgumL+vqpEusnGB8Mjuhx8HgdexlNjGet0RIj
rKmyrj5CcmUpkKkPqoR0i8Xk1ori/3hyjIQbcFgfvpYupVUPyJdLpRRuwTr15Z7n
UQ+IVxNTRVy+VsSwm+VV5/iWyDKw3pJoLs1fIdAMCzdCHV8yrhPUpVceE954/pbd
jAtc0Ak5loiGGeFBkvtJ+N9+Rs5hmExgMt+lQYyWqpxpis3KnmE=
=csdF
-----END PGP SIGNATURE-----

--Apple-Mail=_B925A3BA-F4C5-40A4-8E80-A544FB103A61--

