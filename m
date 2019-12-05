Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B781114770
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2019 20:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729535AbfLETFe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Dec 2019 14:05:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42702 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfLETFe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Dec 2019 14:05:34 -0500
Received: by mail-pg1-f193.google.com with SMTP id i5so2014666pgj.9
        for <linux-ext4@vger.kernel.org>; Thu, 05 Dec 2019 11:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=eCvR6kEsPmAsleM3DbRxn5rO7GhWHxXhrh0FqnZEtGw=;
        b=nfmHxKR4doICYkJsz1hL+2yRu5K35U9PuARctHt2n3TeKddDYnJHEAoL1I8l6vKsjL
         3f9RXV1bickYILrwkz1TPttwQKPmcFugjD/zUomVuAqTwDrtFW1Bq9YTV+gbWP79rvrB
         oMawfiShJilNZ45GoLpVG2X8dbVtgo/4osOpmlqDW9MW5QjKrEEjnZ72YfHBt2EU3GhS
         o+Yh4o7snkxtNojg1167q3cPdYBDgE2UqrvVfmLlqVEW+Fr/GB93wwyT+DZiSqn3diet
         ARTncaXVmE20HVR+wueW7ySFpbZ9JbPKYCZWHVj1y9JG2YWO/rSmLkpLO4PXP7U1/oiw
         VMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=eCvR6kEsPmAsleM3DbRxn5rO7GhWHxXhrh0FqnZEtGw=;
        b=oRKuilmp7Sshd6/rh0FhfxOdH9SbSAo/Mxl98HleZtnexWxoyLjU+FRPy3lmqSG5cu
         NnWqhp20TJp7TNX6YJ8D9dBCFsGwcnw4YRDYa258C5h/zLgqWLo0P6IqDIN/AvFFzKTV
         KHJCmc7Jb9WHcuD1PhhzoJcatFjtY9eIvOnbvzeMKKNplTB3rF1hzPYSE/H/uDyAB8lH
         WA8Oit+2dZLhRfhp/ByFI4oYrUuMuvyAeqSjumSOuYXKlHraKMRTaN/8uTEc07i81rwi
         JUBta2Kp5xqx1cMQ/aBCQxIIDND1Fd3DC0jLpm+nPnCsRScRlTzrqkiOC5qpfKxyilul
         QgOA==
X-Gm-Message-State: APjAAAV/Lkhezq2waPSh/PMm6trRT3Nb+N2EHiMJEOob40uurG6gdPPY
        e97gga9mDkLoSK/d/nz/CCB/Tw==
X-Google-Smtp-Source: APXvYqyHnnMht/+3NCFIHok32EOg1xLVVyl4ACQNf8Dns/29DvZhJ5CSib74zNoDbBjn8S8n0Jxjzw==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr10831226pgk.357.1575572733204;
        Thu, 05 Dec 2019 11:05:33 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 3sm10394403pfi.13.2019.12.05.11.05.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Dec 2019 11:05:32 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8504AF0E-39F8-4C56-86EE-9945E15C1A16@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C56576EA-77D2-441C-A1DD-C6A164C6516D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH -v2 2/2] ext4: simulate various I/O and checksum errors
 when reading metadata
Date:   Thu, 5 Dec 2019 12:05:30 -0700
In-Reply-To: <20191204032335.7683-2-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20191204032335.7683-1-tytso@mit.edu>
 <20191204032335.7683-2-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_C56576EA-77D2-441C-A1DD-C6A164C6516D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 3, 2019, at 8:23 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> This allows us to test various error handling code paths
>=20
> Previous-Version-Link: =
https://lore.kernel.org/r/20191121183036.29385-2-tytso@mit.edu
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>=20
> +/*
> + * Simulate_fail flags
> + */
> +#define EXT4_SIM_BBITMAP_EIO	0x00000001
> +#define EXT4_SIM_BBITMAP_CRC	0x00000002
> +#define EXT4_SIM_IBITMAP_EIO	0x00000004
> +#define EXT4_SIM_IBITMAP_CRC	0x00000008
> +#define EXT4_SIM_INODE_EIO	0x00000010
> +#define EXT4_SIM_INODE_CRC	0x00000020
> +#define EXT4_SIM_DIRBLOCK_EIO	0x00000040
> +#define EXT4_SIM_DIRBLOCK_CRC	0x00000080

Do we really need to have the ability to inject several different =
failures
at the same time?  This will only allow 32 or 64 different failure =
hooks.

IMHO it would be much more flexible to have these as an enum of =
independent
values.  That does somewhat limit the ability to inject multiple =
failures,
but allows for many more different/specific fault injection points to be
added in the future.  We have hundreds of different fault points in =
Lustre
to simulate hard-to-hit race conditions and trigger specific error =
paths.

If this patch has already been landed, it would still be possible to =
change
ext4_simulate_fail() to check "if (likely(old !=3D flag))" rather than =
just
the bit.  That allows making this into an enum that just happens to have =
an
non-consecutive sequence of values assigned rather than a bitmask.


Cheers, Andreas






--Apple-Mail=_C56576EA-77D2-441C-A1DD-C6A164C6516D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl3pVPoACgkQcqXauRfM
H+BZNRAAvCYxq2w08YIGY7XptRrC406S95dU4tR8LDUcg9FopeOsdEqMNTY+TyCC
ajtIjqMMXhwFl2c8gqZ6jukB1jEGsA6T6ChWtM/mRwBkUDeQas9gGwrpbU54A6oE
goSS99ZNSvUijNSdqdvjDn0u3PI33V1JkkyIG46yYhYmdpCw2HVzWpacR2vaH0F0
RRnsXS1rt2WH+mtsaURllq2Vxe/ou9g3wbFeBKe+zk0xHjBc7wc77P2L+rdFOEZH
HX7k4QvMGlB+JF4IuLoofK3k5vdJd6nIK/2WqRD42OawitoooPOtblf95eEQAC+v
7TwKFow/Lz0o5efnz5zg0AMjNlHVAF/a0s1s13ybuIWtDqq8WjmBUnEKI2BUSNJu
K441m8kiRa6ta92bkMWla+7wcqBs+G7/8Ak1MTlp+cF8eE3c/2/rGWYZbWy0V+s3
Xjvh5YXWT9cPZ28Ln/ZtV81gnAtHiBnpng9C4EQdP7UHP8b+iXVRyu0+P/Uv+GUq
SvnsjZsPWWyaSJF9rZjwhcr2r3nKDbZWkCaWTbnPbogTGjD24BtNd3PzreZ0blPU
IOPngIA8plO3XbwA5v+GjmotaB2Hh9UxrNqb9acbdGjmqb3ZmWsCA4a1/oLkJxog
GgJPQybNPgBBJP3Kq1a6JmEdOugpGPXXDVpglGllsQmhGmO/+Yk=
=deV0
-----END PGP SIGNATURE-----

--Apple-Mail=_C56576EA-77D2-441C-A1DD-C6A164C6516D--
