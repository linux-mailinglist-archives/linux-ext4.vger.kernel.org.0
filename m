Return-Path: <linux-ext4+bounces-832-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E19582FED4
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 03:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2011F21C63
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Jan 2024 02:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088D17E9;
	Wed, 17 Jan 2024 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="nGkknhTh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18A881C05
	for <linux-ext4@vger.kernel.org>; Wed, 17 Jan 2024 02:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705458670; cv=none; b=JRJYRgd27042DtxjJbhCxa+Uk4lTBadnpvFxRSg1W59nQdbBdRrDCGjolKqSxld33DDiGJSoRnwb1sLlC3wcukAXiz1wKcuqFsQ3hGYw4eLadGUVi5kFu/aMTEdynIPZCFDrF4ibI0QGgKcIK00b7UGagnGgVSpbK9Gb8JlvnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705458670; c=relaxed/simple;
	bh=RZ+/hp8wxfGouZs1mW+AxUmCKjIkVcr2VGvjFlEmqyc=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 Message-Id:Content-Type:Mime-Version:Subject:Date:In-Reply-To:Cc:
	 To:References:X-Mailer; b=AUlXaOzckRhr3vQIq7pbnIrE6z00gaL9f4TFqQBCUMtUadNpsPFQ/t2m/FahJ8CHGZwqHSts7y32+LyfW0L7Gbv+Mu57LLaTxDtUAzz55TpoZl/y/hy1cr34FRiy/IpUDjP+mq/qeLfGBEkm3tvG0Re4W/+acwFdfOC5Z4gRkoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=nGkknhTh; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-598699c0f1eso4694770eaf.2
        for <linux-ext4@vger.kernel.org>; Tue, 16 Jan 2024 18:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1705458667; x=1706063467; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qOsZtK3oVYN2VorMLkNQ/SgGxv0pIUS90T6LHVIxPYQ=;
        b=nGkknhTh/iFPN6oO7Qx0GXQR2DIVK5TJ6mHpX610wKhu4UOdZVte9k6etCIx97LWAE
         FpHKpoSi/bxqBbLQniFulf+af4QCjJ2danvI0IEDWrdkiIP0w2qkGRIbvK1vpZhlVVJU
         AcGUyePGNvcJ8sIJKCS6DpAL9vQaCq6VbF82DmFrl2RmH4v+r+//eliF4GaOzcvv4x65
         OOwyuyI4x2peWZK/2M/HRHRL0YNgHvtivp1j5WkOgUaJvfQ+zqaBHIhMRJ9mAwUGaxwD
         sQOTGktnsS2o8l2YruMbtgVn5C8W6/E/qBaMct96oLq9gcy2pYdRfHY44W4RlRTnXuZd
         tVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705458667; x=1706063467;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qOsZtK3oVYN2VorMLkNQ/SgGxv0pIUS90T6LHVIxPYQ=;
        b=tQnsSu0gOBFGiJGov50ygk6JMQrvwPw4p/5+8qFTP5eHA9te+WXgfq5vfNfozjcjtz
         nKJgp7yyS33hhdBiUWCGtlte/fxDnCZyB3p4LZkmNCxfk98pKKmwMNm2RJ6dE27l85H1
         qtB5i6osNfSggzjaURaHYNsI2ocB93Sex12R5y+4yi1PjhqbHISqB3CYtRi15jnxgW9h
         Zp8ni5p6AXmvaLG/AvJF9DeyRG77JH+e7/GlvvHsKvqHXort5bdqeGbwXA+hA/mDJMGI
         /IqJPjaXg06seIKfdtrZWY6qGEq4fysGNPM8iBiM2w8EiIOxY6WvcfSK0OLVuDF5xvOG
         uG8g==
X-Gm-Message-State: AOJu0YyALfzQoZJQiJUNFmvrDLTj1YIR8SZ/2rvWLd2d1ISKCZRL220i
	dCPGHPZpWTMsJVXH01K2+QQD9ryuaTpbYjtzJ6O7Sej+Cuw=
X-Google-Smtp-Source: AGHT+IGR1DFIo/gFXGbwbwSusuE/hn3y6znHjeZCcdemFAruzGU6LkEJAoC0dPr+/6bLp9Zx4NV1ZQ==
X-Received: by 2002:a05:6359:594:b0:176:2f2:1c5a with SMTP id ee20-20020a056359059400b0017602f21c5amr1336190rwb.30.1705458666974;
        Tue, 16 Jan 2024 18:31:06 -0800 (PST)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id s123-20020a632c81000000b005ca5619a764sm10574950pgs.11.2024.01.16.18.31.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jan 2024 18:31:06 -0800 (PST)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <4F9ECC50-EE67-44D6-816D-81F6EB840A69@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_750805AA-7EA4-401C-8400-BECA3CEEE5B4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Protecting lost+found from rmdir by directory owner?
Date: Tue, 16 Jan 2024 19:31:03 -0700
In-Reply-To: <42bc44533e997531baa79c73867a942504122886.camel@interlinx.bc.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: "Brian J. Murrell" <brian@interlinx.bc.ca>
References: <42bc44533e997531baa79c73867a942504122886.camel@interlinx.bc.ca>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_750805AA-7EA4-401C-8400-BECA3CEEE5B4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jan 16, 2024, at 6:26 AM, Brian J. Murrell <brian@interlinx.bc.ca> wrote:
> 
> Let's say I create a new ext4 filesystem for exclusive use by alice and
> when I mount it, say, on /mnt/alice I set the permissions so that alice
> can work in that directory:
> 
> # mkfs.ext4 /dev/foo
> # mount /dev/foo /mnt/alice
> # chown alice:alice /mnt/alice
> # chmod 775 /mnt/alice
> 
> But now /mnt/alice/lost+found is at the mercy of alice since she has
> write permission for /mnt/alice.
> 
> [How] can I protect /mnt/alice/lost+found from removal by alice?

You might be able to mark the directory with "chattr +a lost+found"
(append only) so that new files can be written there but not deleted
even with malice, except by the root user.  Not 100% sure that

It would be useful to have a patch that allowed that directory to be
renamed ".lost+found" so that it is not visible in normal "ls" by
users, but still available for e2fsck to store files if needed, since
it would be very unlikely to be deleted in the first place if hidden.

I'd expect that it would be a few lines patch to e2fsck to check both
names, and a new mke2fs option like "-E hidden_lost_found" and allow
it to be renamed by "mv" on existing filesystems.

Cheers, Andreas






--Apple-Mail=_750805AA-7EA4-401C-8400-BECA3CEEE5B4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmWnO+cACgkQcqXauRfM
H+CXkA/9EVh+z5XCj7fythD1k9uyGNNAl1w4f3bHZ2antLfgglzLDtEJdqZ0FwxI
uIY3XV8P+sLNC8oD+9mfndxJym/6frpQ3ulfy/I7Rl41K6cv9Qg3MUIQ9MepcN9G
58ZpsN6qlVXBS4mFZkDNO5cKOU6qn8XDsOw/NnfQjBjCLfP3sGF4IKHiAzR9Nofk
WGtpc9wpMGB3oRC2hraQpS40xsJq857Xm3skFNmHutz06rGwZys17nn1G7nPau1H
o7pP3jBy56lBLw3vTR9lwzzQ7YPwFyOyVu4AtCzVmvNmIGdgLL7B1LcqCibT9RVy
VbSEeE/f46Y6RtkPzF7TsSoggeuxuyffEyp8aOmGDw+yUk74g4azqm4PNZoFqZ24
iJxobmUMaJe+mu45Abmj1+eSJXKgMEmvgNic8ZQcxKLLqwLtb/UCzK8pkDTT81eg
g5lEF7SYULCR/3gPEV+8CaYpatls9gBiF4OJfawtzC8mKts4FbFFyjfZTbo3ACyE
DV7+4aRHoX5ftLHWAy0zyIdEu69V+QCAqq2PTv0O+NYXLpoMpEuCoHup4ybJQFsH
iTnSpnQrEVT0JN8Txp5vDxRW0twAzMiFTslX6rp+Gf4F380sEw3Da9D02LM7tbfa
fpBvdbSfBzfo20T4vZkrsVc0yV5QQ61PdUupWqNd5M7Hj7wsR+0=
=6oS8
-----END PGP SIGNATURE-----

--Apple-Mail=_750805AA-7EA4-401C-8400-BECA3CEEE5B4--

