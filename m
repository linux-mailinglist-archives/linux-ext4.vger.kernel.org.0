Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F414E28EA33
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 03:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388935AbgJOBeu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Oct 2020 21:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbgJOBeh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Oct 2020 21:34:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E2C0F26F0
        for <linux-ext4@vger.kernel.org>; Wed, 14 Oct 2020 17:56:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o3so741389pgr.11
        for <linux-ext4@vger.kernel.org>; Wed, 14 Oct 2020 17:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=jxJmliOdeiXzslwNZRF7Ur56kSu9peaxEpGKIJPybhM=;
        b=BehJ4qJLR9wt79WGu7O1BHfNrBrjiBE4fsDkhoy1RHs/LxCHS6gsguKGRTbpF9FHrO
         /QT+MrU899yiD9PiJWi2PgK4KOXZ1Gv3HF213rTNUTqI+eoG92r6wvPcV/mrme5I07lP
         WG9Vg6RI2mk8XR2f036jGigw9EGcSpo4pR78erhPt5rv4EKM8i2Cslep9uWtv2hnpv3W
         LSl6U8Got1Wxa04CbhGeFxrwwOPvtv5uRJpJ/Ag4aWQsMqih1pubwz7MBQB/j90dCxaO
         v3t9+88my/vMYdRdY+V0Wru5Bp0T/6G0OXfCURID+e96beCuOoajrBHmsOuEDorWiMNz
         Yx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=jxJmliOdeiXzslwNZRF7Ur56kSu9peaxEpGKIJPybhM=;
        b=bUR1dUqO5UEIaPPpkEnp9VLXafwquwJ4kSZ6w0IC0rWAUBhoO42WJAM07mYayKPwEB
         jxNSBY46eVc8O9fmyG9Or9ANzEX+gNJyROUEbTXVLey03BPWSl45LYDogCKJ9Lx91Iti
         BxORSl/Le6HfABgdGX6RvHKG9OMy1RHpkiz8sgECzxBRKiLwdf4bEIX86YQjKX5wHvS7
         wR/8ssXwba3qSgBpEwMUBk8J773xeAVKdIAyXbF4rZ+5E60TKQWF9tnGzkVGiIpFSO6+
         QUvBvb7uHtuoaV4oTwIl4Hhu977ZLcrTyYiu/sqrdPKdtfb7o5T8DwI2AgzUa3SNGWVy
         XwOg==
X-Gm-Message-State: AOAM532umXLQF+9NZC9VJjOo/+GjPlIFWLOjBeDL5J/8XN/ARfYs+4Kv
        vltCmk52gT1Cd6HeIIXuxm4VwrHCPCKxKwCe
X-Google-Smtp-Source: ABdhPJyKjpGeRf3aFKepZPXN/mkTXMSgdl/SvgA7fH4++JDRj8/N7qGV1C3Ywoi2FqbKqAYJWx8Akg==
X-Received: by 2002:aa7:854a:0:b029:154:f2fd:c70a with SMTP id y10-20020aa7854a0000b0290154f2fdc70amr1754776pfn.39.1602723377097;
        Wed, 14 Oct 2020 17:56:17 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id hg15sm789542pjb.39.2020.10.14.17.56.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Oct 2020 17:56:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <43B157BB-33E4-4D82-8A09-0E1BCACC55D9@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6AF3D071-5BD3-4E1B-9E87-F5519B690E5E";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mke2fs.8: Improve valid block size documentation
Date:   Wed, 14 Oct 2020 18:56:13 -0600
In-Reply-To: <20201013133848.23287-1-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20201013133848.23287-1-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6AF3D071-5BD3-4E1B-9E87-F5519B690E5E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 13, 2020, at 7:38 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> Explain which valid block sizes mke2fs supports in more detail.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>

Should this mention that the default block size is 4096 bytes for most
filesystems?

It might mention e.g. ppc64 or aarch64 can use 64KB page size, but this
is definitely an improvement already.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> misc/mke2fs.8.in | 9 +++++----
> 1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
> index e6bfc6d6fd2d..0814d216f3a4 100644
> --- a/misc/mke2fs.8.in
> +++ b/misc/mke2fs.8.in
> @@ -207,10 +207,11 @@ manual page for more details.
> .SH OPTIONS
> .TP
> .BI \-b " block-size"
> -Specify the size of blocks in bytes.  Valid block-size values are =
1024,
> -2048 and 4096 bytes per block.  If omitted,
> -block-size is heuristically determined by the filesystem size and
> -the expected usage of the filesystem (see the
> +Specify the size of blocks in bytes.  Valid block-size values are =
powers of two
> +from 1024 up to 65536 (however note that the kernel is able to mount =
only
> +filesystems with block-size smaller or equal to the system page size =
- 4k on
> +x86 systems). If omitted, block-size is heuristically determined by =
the
> +filesystem size and the expected usage of the filesystem (see the
> .B \-T
> option).  If
> .I block-size
> --
> 2.16.4
>=20


Cheers, Andreas






--Apple-Mail=_6AF3D071-5BD3-4E1B-9E87-F5519B690E5E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+Hni0ACgkQcqXauRfM
H+D1VA/8CAy7rQzl+ikN1HdfYSuvo10e6VI/eWsxWIwD3azwcuOjvRyxMJaBke2A
G8myaSG0Q+ZxBN7X0hmfI7REJZL7kEe9s81iz+3abNJzgmK7E/UU9MAo2rQGH4K4
h/8TCJk/RR7LMIh8Qcv2mIX60tJ4c2LOgT/h1Br70ZITD3GezmEn5GptU88bO07k
axRsL54P3t9Q5i3t7dOWHf5nj+Ahb4UyXMe8yvuJ5rfZxoGBOefrDLIsBDSqRN+h
Obk5F0xvAFoq0hJQ5hjPvg8zP19tuU8rLKB3kOtswVuhCHKiwCrDnS1IT5opHbqt
UikiOu0ixFEwB6SXgOWvwgyhq76UYHvVLEqfbMYITYq0LY4c/4yS6FigCqcegzVA
Nc0mbeSI7Nm0vs6+hYSqkIKYhOCpYQYLP/y5XyAQ/8vYiR3uJK0So+RxLqf6g8F5
NMmg1DDPtfrJXlR+P3Yvtv9NO9xGc/2/gp2Ks2/vI+bQ9eAtP7YB6RHPi02pXYX6
dUdz2oJK40yupBKdfqq1at0+1Q21ENFDYjXo4zICg82R1NXTtl7nLsXvzqfSrYy6
BSSBwO2zUtpwT25lgT5EYnmmWw1e6csX4u5a4KmLknjGZnAelzEVpUOFelmE1p+W
16prlTKakHLh4GoRXP4kr+EpAAwDouXn2Ggf4LJqp64dR1aWFGc=
=pTAf
-----END PGP SIGNATURE-----

--Apple-Mail=_6AF3D071-5BD3-4E1B-9E87-F5519B690E5E--
