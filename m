Return-Path: <linux-ext4+bounces-1812-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D14894733
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 00:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDFAB218CE
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 22:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5896256B7B;
	Mon,  1 Apr 2024 22:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="UUMN76Bq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F156473
	for <linux-ext4@vger.kernel.org>; Mon,  1 Apr 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712009933; cv=none; b=muCIN4cGgoCitRWdtEJsgtiPjtDHHBRPCUBmhgr4/rHXuQproEL8tB3YhRbv0uQ8PYG+iwJWOnsuYjBHUz+LxyNCFSn/G4SsFeUzzE+9pSSNzEnY9pFf21fyEhTRpynEd0+pCAiKMtGpRwWR5KfwmQPhsvTcHJPxLNOP2zqw3DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712009933; c=relaxed/simple;
	bh=fNwKQw6xra4LSLrZ5cZAMLRgSSIz1uE5rdy+1OtO2R8=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=ik+gZCdI+sDz+TFRwRJ10M74KftNkpgykqkyS7t5Tagxn9gZGYoIOEbBx4PvYowo/wUkQbGhTrrpXRlMcHdC1w/bxD9Jc9ySKDzlnsQzOeA8dzG9M483x9DV3KDTLFSXRidfanj3ldlhBNHtod7qePmQYfWSxmVV8bxtXAq6dho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=UUMN76Bq; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5e42b4bbfa4so2704910a12.1
        for <linux-ext4@vger.kernel.org>; Mon, 01 Apr 2024 15:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712009930; x=1712614730; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=uV6vYadPnpN9VpvV2Q/17RnlW5lvpgBgkdGbq3aaNZ4=;
        b=UUMN76BqmRl+/MwNAqgpI3F0ZqMf2n53iQx8n6FUhE28kSrXcLC4mmbE5NxJ7wEjkm
         OWD0ObmDTdmhK/hnuWSwuHfx6+EMPNTZfpE/rOnQzymUifLU7+jNrDj3/xhbegIxOjfW
         PTr0AChmXBRfgF1dCtiiQYiODSgRpkyK8Hu10MgAhooh7wpy8UlnfllNN1wJA3D5ee3T
         lQisJm4cizZV81dNE8/Tl676wy9SCsprTWectlYbbVkkkEKDSNzx6ClRvntcwUSSpOSv
         7DieMc5ZnrXUz859B/vIpj9u8EGSzQbXPaF4fbQl0nyLaMuK62SkZi1vYbkgvzgTRi1Y
         vTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712009930; x=1712614730;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uV6vYadPnpN9VpvV2Q/17RnlW5lvpgBgkdGbq3aaNZ4=;
        b=TGv7N3zhD7XC1roprpvYFEoAv9TEBHv7DKCInQk5bCxFpOkSEfMKXAl//I21RCnxjp
         dnM5qutxghgIs18ojWMuehKcce7Vu0Chp9D1eKP1LMyLGV2mdp//R7dMmDrIvHPxt+eM
         MPM8STWiEqtUOjQKeM5iuIpMj+dhyTQqCveuqcWWyD5jTS8M8aXjQLsiUYkuBdvEDvfh
         sFFE13nx8BpYiO/1juFmkzeDUkgoJ701JABTWzCTOv0ljaj/sPb2GHGRtL++zhNsM3/s
         AUNq02X73nxWQOBtG5FYPThXpWmLhGDSOhVSQMguTg2SYB3GN55ShCFbYpJoEzpAWvLV
         NmZw==
X-Gm-Message-State: AOJu0YwV40OvSpMIrClc4N5htSQrIoI98+WB32Zl69TCze98Y5lIR4jq
	d0/rpJixaxg4LazmCWxcAKYE1It5kpShdlUlEauNUsI4lxeOJ2zXeg6DnZFUfFdIsuomRKCHxXS
	g
X-Google-Smtp-Source: AGHT+IHvs/+EH9MprhkPlZhua0Hf9V/qQPHuujMY5oRCw4Y5/x9yjLi8iwKy561O4YqXTbcpTUzvpA==
X-Received: by 2002:a05:6a20:e605:b0:1a3:dd15:dacb with SMTP id my5-20020a056a20e60500b001a3dd15dacbmr11943512pzb.52.1712009930369;
        Mon, 01 Apr 2024 15:18:50 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id y7-20020aa793c7000000b006e6fd17069fsm8353704pff.37.2024.04.01.15.18.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Apr 2024 15:18:49 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <83B84172-84F5-4B56-B73D-E8B921ACEA92@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_5E9E02FF-8D9D-4CC6-8515-EE109DAB9943";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] tests: make m_assume_storage_prezeroed more robust
Date: Mon, 1 Apr 2024 16:20:35 -0600
In-Reply-To: <20231123030350.7418-1-adilger@dilger.ca>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
References: <20231123030350.7418-1-adilger@dilger.ca>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_5E9E02FF-8D9D-4CC6-8515-EE109DAB9943
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 22, 2023, at 8:03 PM, Andreas Dilger <adilger@dilger.ca> wrote:
>=20
> Don't assume that mke2fs is going to zero out an exact number
> of blocks when run with/without "-E assume_storage_prezeroed",
> since this depends on a number of different options that are
> not specified in the test script.

Another patch that looks like it fell between the cracks.  This
helps the m_assume_storage_prezeroed test pass consistently on
different systems.

Cheers, Andreas

> Instead, check that the number of blocks zeroed in the image is
> a small fraction (1/40th) of the number of blocks zeroed when
> "-E assume_sotrage_prezeroed" is not given, which makes it more
> robust when running in different environments.  This varies from
> 1/47 in the original test to 1/91 in my local test environment.
>=20
> Avoid "losetup --sector-size 4096", use "mke2fs -b 4096" instead.
> Clean up the loop device before checking "stat" so that all
> blocks are flushed to the backing storage before calling sync.
> Only one loop device and test file is needed for the test.
>=20
> Signed-off-by: Andreas Dilger <adilger@dilger.ca>
> ---
> tests/m_assume_storage_prezeroed/expect |  2 -
> tests/m_assume_storage_prezeroed/script | 64 ++++++++++++-------------
> 2 files changed, 30 insertions(+), 36 deletions(-)
> delete mode 100644 tests/m_assume_storage_prezeroed/expect
>=20
> diff --git a/tests/m_assume_storage_prezeroed/expect =
b/tests/m_assume_storage_prezeroed/expect
> deleted file mode 100644
> index b735e2425..000000000
> --- a/tests/m_assume_storage_prezeroed/expect
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -> 10000
> -224
> diff --git a/tests/m_assume_storage_prezeroed/script =
b/tests/m_assume_storage_prezeroed/script
> index 1a8d84635..eea881428 100644
> --- a/tests/m_assume_storage_prezeroed/script
> +++ b/tests/m_assume_storage_prezeroed/script
> @@ -10,48 +10,44 @@ if test "$(id -u)" -ne 0 ; then
> elif ! command -v losetup >/dev/null ; then
>     echo "$test_name: $test_description: skipped (no losetup)"
> else
> -    dd if=3D/dev/zero of=3D$TMPFILE.1 bs=3D1 count=3D0 =
seek=3D$FILE_SIZE >> $LOG 2>&1
> -    dd if=3D/dev/zero of=3D$TMPFILE.2 bs=3D1 count=3D0 =
seek=3D$FILE_SIZE >> $LOG 2>&1
> +    dd if=3D/dev/zero of=3D$TMPFILE bs=3D1 count=3D0 seek=3D$FILE_SIZE =
>> $LOG 2>&1
>=20
> -    LOOP1=3D$(losetup --show --sector-size 4096 -f $TMPFILE.1)
> -    if [ ! -b "$LOOP1" ]; then
> -        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> -        rm -f $TMPFILE.1 $TMPFILE.2
> -        exit 0
> -    fi
> -    LOOP2=3D$(losetup --show --sector-size 4096 -f $TMPFILE.2)
> -    if [ ! -b "$LOOP2" ]; then
> -        echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> -        rm -f $TMPFILE.1 $TMPFILE.2
> -	losetup -d $LOOP1
> -        exit 0
> +    LOOP=3D$(losetup --show -f $TMPFILE)
> +    if [ ! -b "$LOOP" ]; then
> +         echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> +         rm -f $TMPFILE
> +         exit 0
>     fi
>=20
> -    echo $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
> -    $MKE2FS -o Linux -t ext4 $LOOP1 >> $LOG 2>&1
> +    cmd=3D"$MKE2FS -o Linux -t ext4 -b 4096"
> +    echo "$cmd $LOOP" >> $LOG
> +    $cmd $LOOP >> $LOG 2>&1
> +    losetup -d $LOOP
>     sync
> -    stat $TMPFILE.1 >> $LOG 2>&1
> -    SZ=3D$(stat -c "%b" $TMPFILE.1)
> -    if test $SZ -gt 10000 ; then
> -	echo "> 10000" > $OUT
> -    else
> -	echo "$SZ" > $OUT
> +    stat $TMPFILE >> $LOG 2>&1
> +    BLOCKS_DEF=3D$(stat -c "%b" $TMPFILE)
> +
> +    > $TMPFILE
> +    dd if=3D/dev/zero of=3D$TMPFILE bs=3D1 count=3D0 seek=3D$FILE_SIZE =
>> $LOG 2>&1
> +    LOOP=3D$(losetup --show -f $TMPFILE)
> +    if [ ! -b "$LOOP" ]; then
> +         echo "$test_name: $DESCRIPTION: skipped (no loop devices)"
> +         rm -f $TMPFILE
> +         exit 0
>     fi
>=20
> -    echo $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=3D1 =
$LOOP2 >> $LOG 2>&1
> -    $MKE2FS -o Linux -t ext4 -E assume_storage_prezeroed=3D1 $LOOP2 =
>> $LOG 2>&1
> +    cmd+=3D" -E assume_storage_prezeroed=3D1"
> +    echo "$cmd $LOOP" >> $LOG
> +    $cmd $TMPFILE >> $LOG 2>&1
> +    losetup -d $LOOP
>     sync
> -    stat $TMPFILE.2 >> $LOG 2>&1
> -    stat -c "%b" $TMPFILE.2 >> $OUT
> -
> -    losetup -d $LOOP1
> -    losetup -d $LOOP2
> -    rm -f $TMPFILE.1 $TMPFILE.2
> +    stat $TMPFILE >> $LOG 2>&1
> +    BLOCKS_ASP=3D$(stat -c "%b" $TMPFILE)
>=20
> -    cmp -s $OUT $EXP
> -    status=3D$?
> +    echo "blocks_dev: $BLOCKS_DEF blocks_asp: ${BLOCKS_ASP}" >> $LOG
>=20
> -    if [ "$status" =3D 0 ] ; then
> +    # should use less than 1/20 of the blocks with =
assume_storage_prezeroed
> +    if (( $BLOCKS_DEF > $BLOCKS_ASP * 40 )) ; then
> 	echo "$test_name: $test_description: ok"
> 	touch $test_name.ok
>     else
> @@ -60,4 +56,4 @@ else
> 	diff $EXP $OUT >> $test_name.failed
>     fi
> fi
> -unset LOG OUT EXP FILE_SIZE LOOP1 LOOP2
> +unset LOG OUT EXP FILE_SIZE LOOP


Cheers, Andreas






--Apple-Mail=_5E9E02FF-8D9D-4CC6-8515-EE109DAB9943
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYLMzQACgkQcqXauRfM
H+A1bBAAhaPTd0Mq3C7pV8XjwLIDjLEy08JkAtK2ofqhmTZdyWmf1seWBfpfIVes
8Pol0zeNleNWZ/1HQP6FPH0tX+Xmpvb2HtV90nc5jKHK3SLYMwpQeasKKEDBRm/I
tJ8AO11kN9LtFPWt5V34ziefOdG/AMqU0TR4Zj2OM5sDNLreqqgooF9wPJJQ3yPV
YMgGFH3R+P9EjpjAP9DiUp2kG/eSRCO3ys4e5YuvBUdiAw10dRpz/Ui2Rwc/h0uS
rcETD5cMcb9Od2vDbc0shSyZYjJNsKE10uPK0hmeiSYBUwQM/CCX88X9wHGe9Wh8
WPDKJpOSEDh7tXDpG9HgIAPZnIS6kVQ+k+rkxldz8A03BOU3n4/q05yIQJL23OjX
AXbVrlAPZrGqPXmzlOUvwOWa6ztFF96qbSnrC88Rqtzn/oJHwXhCq7gqSFrg09xS
4aomUl/0Fd3JuIpcq/KjtlYUQzHeZ0ru+v1bdKp2wlHrrc8ap5IbVM3cYspF1gxZ
LusZnj801za5upGohp6qk1imgExmpRIp+kDCNg/8/i5kA3JeqwhMVY/15NvgZFVa
+tYwiBfP63kDY0BybmrjkQeRUqwJIlQw5a0LO1tj9n+V5PWd7gpX040/ss7sTMAj
A+wn09x+XeGW+SDtjhtQQZpPb321d2rfvsrOlCv5sEsbgt50Aic=
=E/9e
-----END PGP SIGNATURE-----

--Apple-Mail=_5E9E02FF-8D9D-4CC6-8515-EE109DAB9943--

