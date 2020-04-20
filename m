Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6231B1A50
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Apr 2020 01:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgDTXv6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Apr 2020 19:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgDTXv6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Apr 2020 19:51:58 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DDFC061A0F
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 16:51:57 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id t9so606451pjw.0
        for <linux-ext4@vger.kernel.org>; Mon, 20 Apr 2020 16:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=kPK7FroCaPWeTbgHL3ANvERWsJ3ML8gxxkK6YSEQlD4=;
        b=IZFCGXzFDWUSuXh6CehF1rwZ+PMBagcwTYXw0B4lm/tqcif035HOxIky9bhx04uX75
         jKoLBR4HxVz1w67DjhC4OZ5cea3x4NvY/JBmJfD1gxCxm+Y8eiLgzIKSitXco8D3Asu4
         ue1LBMHxbHY55IHmh4ehhD0ih+66E84RETlerJsLVxmV8GGGaIl8Z3+CP37lKy5ob5L1
         rBypXp7MGllHsPklmOYpVhNRwl0wKegJVq9sftI4l16+/CCOkdY7uEpQT8kGYnEueJOV
         x8Zrh8vjzCbGCMdAQ/hhCQxAqzjhm3iAzMHqReBEgkVQmTZ+DzwpoLBpJR73cGR6uioA
         OrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=kPK7FroCaPWeTbgHL3ANvERWsJ3ML8gxxkK6YSEQlD4=;
        b=YqMmemkp+Bthwb+sMW197dA6Vj5nUgS6h5+1c1RaICt+1CKo7qGTZd3TxV7/fhcaYu
         wAJ0uTVRBVHsNxEFS2u5RheXdBK1eoWcbM5GuXGyjf6jsm7q2ryU9IOrgGs2sVjpbAes
         CLgFDjQVqsqNbssTttglWA3VPNQ0uWmhLtIM/mEoG8V33MZYeUdac+YAUmVwrYEJHQg8
         hiFKC6R+m55g7KwhmEZOQiHUgM3LnmvGZJgiH0Gd97+rhwPRl8JfheHEfEMVTMuLvKk4
         1KG8+s/QcbJm7Ta6VPj3yolSxfgW+T4Ahp1WyAx3qWuM71sGdOOCh/KMu0Lz+r7fQGZv
         5y6g==
X-Gm-Message-State: AGi0Pub4a9Kuj/nAezCRUt8eNCs6aGZYp8jZTS8AXSQf4bEqqi7b0MY/
        O6MF+vUn2M+scShtlZaa0/4uTQ==
X-Google-Smtp-Source: APiQypIQgZLRzCqT3IWv6EoKM+KrOr3Kiyb/dBQMsaKQcrw2hHLp64SwIeng70//CydmyJ+1g9lNlA==
X-Received: by 2002:a17:90a:c786:: with SMTP id gn6mr2161323pjb.147.1587426717303;
        Mon, 20 Apr 2020 16:51:57 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id 13sm620570pfv.95.2020.04.20.16.51.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 16:51:56 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <FA73C1DA-B07F-43D5-A9A8-FBC0BAE400CA@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_64F94122-2784-458A-A3F2-F89454A55F98";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] fcntl: Add 32bit filesystem mode
Date:   Mon, 20 Apr 2020 17:51:52 -0600
In-Reply-To: <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
Cc:     Florian Weimer <fw@deneb.enyo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Andy Lutomirski <luto@kernel.org>
To:     Peter Maydell <peter.maydell@linaro.org>
References: <20200331133536.3328-1-linus.walleij@linaro.org>
 <CAFEAcA9Gep1HN+7WJHencp9g2uUBLhagxdgjHf-16AOdP5oOjg@mail.gmail.com>
 <87v9luwgc6.fsf@mid.deneb.enyo.de>
 <CAFEAcA-No3Z95+UQJZWTxDesd-z_Y5XnyHs6NMpzDo3RVOHQ4w@mail.gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_64F94122-2784-458A-A3F2-F89454A55F98
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> =46rom 73471e01733dd1d998ff3cd41edebb4c78793193 Mon Sep 17 00:00:00 =
2001
> From: Peter Maydell <peter.maydell@linaro.org>
> Date: Mon, 20 Apr 2020 11:54:22 +0100
> Subject: [RFC] linux-user: Use new F_SET_FILE_32BIT_FS fcntl for =
32-bit guests
>=20
> If the guest is 32 bit then there is a potential problem if the
> host gives us back a 64-bit sized value that we can't fit into
> the ABI the guest requires. This is a theoretical issue for many
> syscalls, but a real issue for directory reads where the host
> is using ext3 or ext4. There the 'offset' values retured via
> the getdents syscall are hashes, and on a 64-bit system they
> will always fill the full 64 bits.
>=20
> Use the F_SET_FILE_32BIT_FS fcntl to tell the kernel to stick
> to 32-bit sized hashes for fds used by the guest.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Another question I had here is whether the filesystem needs to provide
32-bit values for other syscalls, such as stat() and statfs()?  For
ext4, stat() is not going to return a 64-bit inode number, but other
filesystems might (e.g. Lustre has a mode to do this).  Similarly,
should statfs() scale up f_bsize until it can return a 32-bit f_blocks
value?  We also had to do this ages ago for Lustre when 32-bit clients
couldn't handle > 16TB filesystems, but that is a single disk today.

Should that be added into F_SET_FILE_32BIT_FS also?

Cheers, Andreas

> ---
> RFC patch because it depends on the kernel patch to provide
> F_SET_FILE_32BIT_FS, which is still under discussion. All this
> patch does is call the fcntl for every fd the guest opens.
>=20
> linux-user/syscall.c | 27 +++++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 674f70e70a5..8966d4881bd 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -884,6 +884,28 @@ static inline int host_to_target_sock_type(int =
host_type)
>     return target_type;
> }
>=20
> +/*
> + * If the guest is using a 32 bit ABI then we should try to ask the =
kernel
> + * to provide 32-bit offsets in getdents syscalls, as otherwise some
> + * filesystems will return 64-bit hash values which we can't fit into
> + * the field sizes the guest ABI mandates.
> + */
> +#ifndef F_SET_FILE_32BIT_FS
> +#define F_SET_FILE_32BIT_FS (1024 + 15)
> +#endif
> +
> +static inline void request_32bit_fs(int fd)
> +{
> +#if HOST_LONG_BITS > TARGET_ABI_BITS
> +    /*
> +     * Ignore errors, which are likely due to the host kernel being =
too
> +     * old to support this fcntl. We'll try anyway, which might or =
might
> +     * not work, depending on the guest code and on the host =
filesystem.
> +     */
> +    fcntl(fd, F_SET_FILE_32BIT_FS);
> +#endif
> +}
> +
> static abi_ulong target_brk;
> static abi_ulong target_original_brk;
> static abi_ulong brk_page;
> @@ -7704,6 +7726,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>                                   target_to_host_bitmask(arg2,
> fcntl_flags_tbl),
>                                   arg3));
>         fd_trans_unregister(ret);
> +        request_32bit_fs(ret);
>         unlock_user(p, arg1, 0);
>         return ret;
> #endif
> @@ -7714,6 +7737,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>                                   target_to_host_bitmask(arg3,
> fcntl_flags_tbl),
>                                   arg4));
>         fd_trans_unregister(ret);
> +        request_32bit_fs(ret);
>         unlock_user(p, arg2, 0);
>         return ret;
> #if defined(TARGET_NR_name_to_handle_at) && =
defined(CONFIG_OPEN_BY_HANDLE)
> @@ -7725,6 +7749,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>     case TARGET_NR_open_by_handle_at:
>         ret =3D do_open_by_handle_at(arg1, arg2, arg3);
>         fd_trans_unregister(ret);
> +        request_32bit_fs(ret);
>         return ret;
> #endif
>     case TARGET_NR_close:
> @@ -7769,6 +7794,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>             return -TARGET_EFAULT;
>         ret =3D get_errno(creat(p, arg2));
>         fd_trans_unregister(ret);
> +        request_32bit_fs(ret);
>         unlock_user(p, arg1, 0);
>         return ret;
> #endif
> @@ -12393,6 +12419,7 @@ static abi_long do_syscall1(void *cpu_env, int
> num, abi_long arg1,
>         }
>         ret =3D get_errno(memfd_create(p, arg2));
>         fd_trans_unregister(ret);
> +        request_32bit_fs(ret);
>         unlock_user(p, arg1, 0);
>         return ret;
> #endif
> --
> 2.20.1


Cheers, Andreas






--Apple-Mail=_64F94122-2784-458A-A3F2-F89454A55F98
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6eNZkACgkQcqXauRfM
H+C2Rg//WIhBY2K+idPg4SqGPqUmkxjgNa5FLYv3VD4Hf9G5kUdSpkUbQG1zAZaM
+D1KAmXgMGEMJ4/T+XPB8R2zAOuHt3fdzQEu84u2OI0v/2oC9vdln89pfVe46YZP
BPSmuIYevFo9ybJw3kMzSwj7OpJHpKY0fWZ/lfkQijHlbE1GoTqToTCIfRpunlEH
P3lStjiDhhi3o8Zms2TRiJa5SfNojUanWJBzPvUXXzN7roqKdJfb4UpqYAri0ZCr
VI32nNtMGYorT2Rb4KLGvbj8kgqpF2heuiCHDFJU1/7ozj/C8a6qzJzTbWvktCql
XuyYEjela/VX1JjSxENYSwuOF/XYVQaEMSL346IkjGe4FDv3vVoNG+iMXgcsEhCx
q+M5sbWsRqL02yZ40buAFqUfP5heGyE8FzKNqXnfCOJEkyPZ7625lsmD1xLWxQOM
ZhfTLsaxhT1ETNdkydHUQcorsArywKABPk4i4MihzV9ADLYJuW84MtBRxNQs1mOu
N2YesKlObHOoJjWbw6hIH7o2x5mQ5Mw7QkYZY/bll2bcdr4fd0SEfaZV4k4DvlME
uhSgY2OvyLtMIc55aN8xpIeRdDFk8fe+wf+nFwQr+qglHSSDnd3+HyYU2BmFILo0
FiCbO/5ZhQ8cX9b5Mo4YIhN9kMZaRK1RRemDYI+lcupBw8ApGlI=
=iebv
-----END PGP SIGNATURE-----

--Apple-Mail=_64F94122-2784-458A-A3F2-F89454A55F98--
