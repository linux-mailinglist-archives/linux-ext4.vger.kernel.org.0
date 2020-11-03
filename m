Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2972A3AF3
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 04:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgKCDPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Nov 2020 22:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbgKCDPm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Nov 2020 22:15:42 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62935C061A47
        for <linux-ext4@vger.kernel.org>; Mon,  2 Nov 2020 19:15:41 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id h6so12565828pgk.4
        for <linux-ext4@vger.kernel.org>; Mon, 02 Nov 2020 19:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Sdm5irojzWs/k+w4rHjxvOqM5R4vsO0T7lutHcUTNJ0=;
        b=dqKD9QQ7Zb3vONwYdA+3d9p9M9gteeB1oPx9l76sX30/T2xr1dhYKBCo0n57c5792w
         b61tgmYFMjXlekDHlSBjMZu4hzDdfUXzf0V8qAzkgrYp4LKu6aE6B40Vm0HwfN3hW95N
         tDZoBFaiuZS3PE/bKbFqHxJVmPQ0NeglFHPr56KmHkuzNnbNhfExOIfyVnBZ/KMk/QeJ
         KFk+9nQsV2yBv1GlU5LeLJ2B016iwVsVdzEXmHSMRdM+DOzoMFmud16R4fg8HXuASLU7
         Jt2wg5IgBBWrKFeXSSLdaZTldjNdNumgp5cEnWGNcV6ZSXGBgCcIn0bUWhq6wQKPURFe
         VgJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Sdm5irojzWs/k+w4rHjxvOqM5R4vsO0T7lutHcUTNJ0=;
        b=k/VrhL9/d38dmr87jxFsj8eHGZsoOaatIeWUmuHl7q4mxCzWKauX4ZWhM5xla6+l/M
         k8InyWS01m+avwUx7CH3LY/FeYA/Jdo3HFBpscYPhjKi6zEiDEcL0QFTRFyvW8UoS+n5
         04KrHZfebA0VCHBX5VA+YHHYJv0nGAmmhR3OfCgmVYVkZBQoXpRDtz+ipFhXGWlrAels
         zNnVNoDvlf1ydXm9D8BSxXthpS/zMZJ7+ItpKOcK8HJ87hHEuoDgAn05kJVWekxD4g02
         2A3r/BhaFOrUhha7dQUC++heB3AqwbqtirWAtEekwxz/HStd/eH1zNYGjZXtSMjL6xrx
         hr7A==
X-Gm-Message-State: AOAM5323nWgtEbMwGAwb3ir6aR7e4dNPWQP5y7YSll3ii+RnbjbjjhkF
        5/iLTy/73QMRoHTWuOueaRmt2Q==
X-Google-Smtp-Source: ABdhPJyELB6sSwUok+H2YSs/FJzqJTnmUXLsr533qyqmqLyPNlF9zz8l9DolGnBcSbJAn9u0Ilf+2A==
X-Received: by 2002:a63:140b:: with SMTP id u11mr14369656pgl.248.1604373340811;
        Mon, 02 Nov 2020 19:15:40 -0800 (PST)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k17sm922142pji.50.2020.11.02.19.15.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Nov 2020 19:15:40 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <8B6EE337-4C54-42C3-BB2C-5D191143FAC7@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_CA2CDAAD-51D4-4466-BDA9-6C6EE1AA654A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: unlock xattr_sem properly in
 ext4_inline_data_truncate()
Date:   Mon, 2 Nov 2020 20:15:36 -0700
In-Reply-To: <1604370542-124630-1-git-send-email-joseph.qi@linux.alibaba.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tao Ma <boyu.mt@taobao.com>
To:     Joseph Qi <joseph.qi@linux.alibaba.com>
References: <1604370542-124630-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_CA2CDAAD-51D4-4466-BDA9-6C6EE1AA654A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Nov 2, 2020, at 7:29 PM, Joseph Qi <joseph.qi@linux.alibaba.com> =
wrote:
>=20
> It takes xattr_sem to check inline data again but without unlock it
> in case not have. So unlock it before return.
>=20
> Fixes: aef1c8513c1f ("ext4: let ext4_truncate handle inline data =
correctly")
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Tao Ma <boyu.mt@taobao.com>
> Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/inline.c | 1 +
> 1 file changed, 1 insertion(+)
>=20
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index caa5147..b41512d 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1880,6 +1880,7 @@ int ext4_inline_data_truncate(struct inode =
*inode, int *has_inline)
>=20
> 	ext4_write_lock_xattr(inode, &no_expand);
> 	if (!ext4_has_inline_data(inode)) {
> +		ext4_write_unlock_xattr(inode, &no_expand);
> 		*has_inline =3D 0;
> 		ext4_journal_stop(handle);
> 		return 0;
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_CA2CDAAD-51D4-4466-BDA9-6C6EE1AA654A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+gy1kACgkQcqXauRfM
H+Du3RAAgkAdP8Gtj/41YaMujmuds3D29TAWjOd9D3+lspZaxG4JXjqyGYBiG1Fm
hvkuySDgSrhBx31at2cHtL3t3RBXekiKNqXDe2ncBjd7i4HV8nMVnW0dqDhu5m8J
V2HYI+jiuL2cjTVDp8wuGGNtS0iIIouCn1NeQywHJREOh5sq5/pwBwQ5CLUJ25Ob
IzYTzB1/xhlYnEaKKj+EPad/JLlzPq6hEkPfcpsg0QiP9BHpy89CEC+qObhvRT2u
S7rVoh1W2gO9VAsWVjsm52DOfbl299xtg6ZmihX0jr0zGUSOdkmjRoOG2O0yqPs4
cZpTH0+NETldm484tvwqc0EhrdFPlWIp5iqq3xaIPW95VnAscUgJAl35tPtI6jAj
fBgSmChwibWVldE/Ve99GEdQ6G60rmbHqoBusj3Ak/+U353MFYnvu7snJjluEerE
Tg6NBFC5ZGQWObqG3hTqaarhQR82y5c0f8+hndA4jKsqlLvkzN0rWN95RUMljr5F
fHNPzqIC+UPXty83iGghDxHXNPww6TTNsLi3C5y3+zcIC8kk5OeIMjZrRE+Vau2C
l9b4QjptS8KsyDWad2JSmnIzU+g5fQzYM+BJmKEabXTahYml8eJNwM7MT06r0FYV
uFANH8Gca8GZmssWmBNn/a4mQrCic4/tNx1kf1tucOXJC4ShbAY=
=j5d0
-----END PGP SIGNATURE-----

--Apple-Mail=_CA2CDAAD-51D4-4466-BDA9-6C6EE1AA654A--
