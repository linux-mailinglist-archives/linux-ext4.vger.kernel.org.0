Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9989B29797D
	for <lists+linux-ext4@lfdr.de>; Sat, 24 Oct 2020 01:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758458AbgJWXJU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 23 Oct 2020 19:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758457AbgJWXJU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 23 Oct 2020 19:09:20 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2452C0613CE
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:09:19 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id m3so39327pjf.4
        for <linux-ext4@vger.kernel.org>; Fri, 23 Oct 2020 16:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=vxnd4YK4s9Y4mCO4jqSbDSGaH0qz2S1flpBlGTFLq/c=;
        b=wllkX3lTtRP1Lm3Q/vM0Q4E3Iaio4oV8YVTgTcJ2wJLQFuqtfyTSYfvXj2ROYZV7MI
         olCB7sQmu3V8adgzndf5/Dlm3lLULBxjqNv4E+IeS1mYNRjce049IxNHydT26RLU+raF
         O7TSt+M98k6uYGUb41TsE8CgHgOQ9r5sYiyuKJMAxqVD9ELYipHJpceM++cdOA0ri3vk
         +DNMAZYSbNGwnDElRWOOEfDpKSWXwFXH9B+tARxdv55dGlDTpP5z7U4VGK5odSL0ywci
         66YSBxCMjuVEgZuE5NX5BJ2/9I6YfEv8zyMUtfCu60EEv0qpVBe1TtmrPAAbzaKiVR22
         5hTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=vxnd4YK4s9Y4mCO4jqSbDSGaH0qz2S1flpBlGTFLq/c=;
        b=a9zn6OeQEYc5CD8ka0yx/gvO7djkwyWpnlYangcdYR3XfK1kXcBku62uOZ1BaKTk98
         cuPXNsDoOqYf66kdxvNvtElKDv8XSn5uiu+SPDTKfkZlzF2maUd3y0npACP7aOHsp4GE
         0gN6PpZQLtNpq/4+rDKe2KzZ5tucrM5IDmPjLviv7o+FpEzwjVdu56dDL4097B12fIbG
         4JbdHAtpjmkA4uj4VJ6xrAYg7PCBJWHS4FAAPoGnlrTJCq0AFQVwo4Youd0yJlSlZqCx
         65ZlftcMsbhuFvb1MXvearJo1SYqrebPJX8Zeyq/uByCSP03H1XThlTzQ0MOnlzOPlYd
         mUUg==
X-Gm-Message-State: AOAM532JMAx9wJ1WakUtnbb/8tpe0aHsLEwC+Y8X1ae67Nh/WA4ZWtrd
        vHrmN2MKA8uCp16eGpLbYYNlTQ==
X-Google-Smtp-Source: ABdhPJxVtp74moBBe9LOrOYhft4dANAVa5AcBNcrI0PtnaXoz1ANjYANWYO5PZV+Dfeg1B2DER03kQ==
X-Received: by 2002:a17:90a:9a1:: with SMTP id 30mr5472595pjo.85.1603494559315;
        Fri, 23 Oct 2020 16:09:19 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id 186sm3267572pfv.154.2020.10.23.16.09.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 16:09:18 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C06038FE-7970-45A3-8363-F83DEADDC146@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_07079EF2-ADD7-4B70-8B45-92CC3AE07058";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 5/8] ext4: update ext4_data_block_valid related comments
Date:   Fri, 23 Oct 2020 17:09:16 -0600
In-Reply-To: <1603271728-7198-5-git-send-email-brookxu@tencent.com>
Cc:     Ted Tso <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     Chunguang Xu <brookxu.cn@gmail.com>
References: <1603271728-7198-1-git-send-email-brookxu@tencent.com>
 <1603271728-7198-5-git-send-email-brookxu@tencent.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_07079EF2-ADD7-4B70-8B45-92CC3AE07058
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Oct 21, 2020, at 3:15 AM, Chunguang Xu <brookxu.cn@gmail.com> wrote:
>=20
> From: Chunguang Xu <brookxu@tencent.com>
>=20
> Since ext4_data_block_valid() has been renamed to =
ext4_inode_block_valid(),
> the related comments need to be updated.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/block_validity.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 37025e3..07e9dc3 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -206,7 +206,7 @@ static void ext4_destroy_system_zone(struct =
rcu_head *rcu)
>  *
>  * The update of system_blks pointer in this function is protected by
>  * sb->s_umount semaphore. However we have to be careful as we can be
> - * racing with ext4_data_block_valid() calls reading system_blks =
rbtree
> + * racing with ext4_inode_block_valid() calls reading system_blks =
rbtree
>  * protected only by RCU. That's why we first build the rbtree and =
then
>  * swap it in place.
>  */
> @@ -262,7 +262,7 @@ int ext4_setup_system_zone(struct super_block *sb)
>=20
> 	/*
> 	 * System blks rbtree complete, announce it once to prevent =
racing
> -	 * with ext4_data_block_valid() accessing the rbtree at the same
> +	 * with ext4_inode_block_valid() accessing the rbtree at the =
same
> 	 * time.
> 	 */
> 	rcu_assign_pointer(sbi->s_system_blks, system_blks);
> @@ -282,7 +282,7 @@ int ext4_setup_system_zone(struct super_block *sb)
>  *
>  * The update of system_blks pointer in this function is protected by
>  * sb->s_umount semaphore. However we have to be careful as we can be
> - * racing with ext4_data_block_valid() calls reading system_blks =
rbtree
> + * racing with ext4_inode_block_valid() calls reading system_blks =
rbtree
>  * protected only by RCU. So we first clear the system_blks pointer =
and
>  * then free the rbtree only after RCU grace period expires.
>  */
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_07079EF2-ADD7-4B70-8B45-92CC3AE07058
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl+TYp0ACgkQcqXauRfM
H+Dhbw/9FwxHj7EeD7IDpHMYmW3vUamvblQA5m9fuIRG7idjurZb/3xLH1J/lJIp
dCvAm6B6YWLh0uWpCTmCi4Ttan4+wZeQqj9cLRGlvpQy1ZTKyGXLo3lezmOWPahq
B+UlkJ6j9uOrz0fBGp0/zLyGqB6QEl+oiVVV78qwpezkaG41g0ZgQt6mvls1RGLo
rBNS4T9hZrGVWeLDSiqIRkn6ypqNHdvFv5zZ+/dB7/P7JzrQZ1pbS/X5WQ0eDtFn
rVpstn5FgH6qIjMSe8Xui3KtGxgcaOyaTYYAnoEVFcjqMLcx+uiJ2MWt2J5E5mLY
H4doueUiwzjB9iwkBlVkhj9Ne/6QsblvoqFdtjUOCiw8vFvnSwtsYAMjybn/hJbO
Ll0kP1eKwafNuCB5Tvg3s2WGP+eWt9FDRbfYxlp5adALEBNk/pZjlekho8xsO7FA
HQMNuhn9wWPZ1PgywjoZspXC49xvPdBl8Ij4EfVuickIsbMOGc2eW4VkvKhv0+nK
nG8r+jiOyJoe0h/6dv5pBxJkoBfuYZm2/OQPNYnpRYFe6EkRSvNU3ACc481KoyLk
YXv6Ci2Xzyp6XfABRfVTurBL71gHxOFt1CxF5Q9PzPuc7Iw7ViMbGh0R4X0IrTq+
INzShGNENUVPtlEp52SpwUdzBeMRjEz7PMZHpcc8/Thbai+InFA=
=YJ6r
-----END PGP SIGNATURE-----

--Apple-Mail=_07079EF2-ADD7-4B70-8B45-92CC3AE07058--
