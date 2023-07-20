Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E3275BAC7
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jul 2023 00:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjGTWuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jul 2023 18:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjGTWuO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jul 2023 18:50:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA221171A
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:50:12 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e64e97e2so886533b3a.1
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jul 2023 15:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1689893412; x=1690498212;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WBVt3w/668AupDqo5ClntZ5vcMaL+3V7ugbI4JmvNNo=;
        b=jZDx1JSO+S8jHs6vaQrNaW7aq9JzIwqCFdkOZKtCKdJ6JW8hVki80WXO9gIrt39Riu
         qgBsi9Z593kssmxKgOTeu7GDy8nlluemliZktonleISxUnhwnGMn6p3kKDwcPJPe4Jr6
         vDJCwbgLPzO2v6J1ZTd3ZduIbMI6HcnfWqMRvCgzbIq9h2rJYAdrx54630GWU+utibTc
         t/R7N1GJkDbBFu8Dat82UAB7opct2R3Gst9WhaH6IDRwUxpMF8pH1fkUrp0YhLpm+sHq
         M46KkSL/k7XIwbahtmzhJ30zxXXcTixWtbHqXIbWh+Vo9hkNOF3K4ErjxjEDpW1Ku/cI
         5ClQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689893412; x=1690498212;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WBVt3w/668AupDqo5ClntZ5vcMaL+3V7ugbI4JmvNNo=;
        b=PniEqrokfrF7IYIDLR21mtol7mMljkebb0YvEt/aeWPPwQ8p+aqrJcE5Q1nzzh9xKB
         kBE/T72AjWC+TeQ4RGEAKJ0Jg4c5IYs3oM4+nRghvWN+JBp+qyFqwXNActXUkbwRQxv0
         dlDuZ3vblhTux+VCQBcl5ivsud8Jn8NELbx4GzRDBVi5lZmwAuG25FkI1uu1wFT9allG
         q6ZLxaPBwkYO34SqEOP90Kk0JWqyxgD0Tt+dJxmJVcE29MHRVupO70Dx6NG38T/ihebq
         q5uHc6gCG6Gdxll+xBG2CeQzBLw/IRTef/W1o5c3n+SXfda3MQcx0mBjwf7nVh3IjfAr
         7JGg==
X-Gm-Message-State: ABy/qLY+K0Clyn6f+GME5OikgY5mBcK5xkVjQtho92sjdtI0JaJdIFp5
        6/C5aCfobORqXSohbRDPFizF/g==
X-Google-Smtp-Source: APBJJlGUAs1VDAhjzEEwTyfV2dle53MlIqhiyKWDAZuIXofVvEh7AM9jOjwV2O+7+rhLJO+nqSCr0Q==
X-Received: by 2002:a05:6a20:12c1:b0:137:2101:6578 with SMTP id v1-20020a056a2012c100b0013721016578mr266987pzg.41.1689893412347;
        Thu, 20 Jul 2023 15:50:12 -0700 (PDT)
Received: from cabot.hitronhub.home (S0106bc4dfb596de3.ek.shawcable.net. [174.0.67.248])
        by smtp.gmail.com with ESMTPSA id iz5-20020a170902ef8500b001b8959fb293sm1940565plb.125.2023.07.20.15.50.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jul 2023 15:50:11 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <20FD8461-AEE4-4414-8637-4D1230AB5A20@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_9DDBBDCE-FB71-4347-A7F9-63974E931C7A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] ext4: Replace value of xattrs in place
Date:   Thu, 20 Jul 2023 16:51:41 -0600
In-Reply-To: <20230510001409.14522-1-sunjunchao2870@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     JunChao Sun <sunjunchao2870@gmail.com>
References: <20230510001409.14522-1-sunjunchao2870@gmail.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_9DDBBDCE-FB71-4347-A7F9-63974E931C7A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On May 9, 2023, at 6:14 PM, JunChao Sun <sunjunchao2870@gmail.com> =
wrote:
>=20
> When replacing the value of an xattr found in an ea_inode, currently
> ext4 will evict the ea_inode that stores the old value, recreate an
> ea_inode, and then write the new value into the new ea_inode.
> This can be optimized by writing the new value into the old
> ea_inode directly.

Sorry for the long delay in reviewing this patch.

The performance gains are nice, and reducing overhead is always good.

One question about this patch is whether it is safe to overwrite the
xattr in place if the system crashes during the overwrite?  That was
one of the reasons why the xattr update was implemented by writing to
a new xattr inode, and then atomically swapping xattr inode numbers.

However, if the xattr overwrite is done via journaled data writes then
it would be safe to "overwrite" the xattr data "in place", because
data will first be committed to the journal and then checkpointed into
the inode itself, so it should never be inconsistent/corrupted.

Did you also test cases where the xattr size is growing or shrinking
during the overwrite in place?  That should allocate or free blocks
in the xattr inode so that they are not wasted.

Cheers, Andreas

> The logic for replacing value of xattrs without this patch
> is as follows:
> ext4_xattr_set_entry()
>    ->ext4_xattr_inode_iget(&old_ea_inode)
>    ->ext4_xattr_inode_lookup_create(&new_ea_inode)
>    ->ext4_xattr_inode_dec_ref(old_ea_inode)
>    ->iput(old_ea_inode)
>        ->ext4_destroy_inode()
>        ->ext4_evict_inode()
>        ->ext4_free_inode()
>    ->iput(new_ea_inode)
>=20
> The logic with this patch is:
> ext4_xattr_set_entry()
>    ->ext4_xattr_inode_iget(&old_ea_inode)
>    ->ext4_xattr_inode_write(old_ea_inode, new_value)
>    ->iput(old_ea_inode)
>=20
> This patch reduces the time it takes to replace xattrs in the ext4.
> Without this patch, replacing the value of an xattr two million times =
takes
> about 45 seconds on Intel(R) Xeon(R) CPU E5-2620 v3 platform.
> With this patch, the same operation takes only 6 seconds.
>=20
>  [root@client01 sjc]# ./mount.sh
>  /dev/sdb1 contains a ext4 file system
>      last mounted on /mnt/ext4 on Mon May  8 17:05:38 2023
>  [root@client01 sjc]# touch /mnt/ext4/file1
>  [root@client01 sjc]# gcc test.c
>  [root@client01 sjc]# time ./a.out
>=20
>  real    0m45.248s
>  user    0m0.513s
>  sys 0m39.231s
>=20
>  [root@client01 sjc]# ./mount.sh
>  /dev/sdb1 contains a ext4 file system
>      last mounted on /mnt/ext4 on Mon May  8 17:08:20 2023
>  [root@client01 sjc]# touch /mnt/ext4/file1
>  [root@client01 sjc]# time ./a.out
>=20
>  real    0m5.977s
>  user    0m0.316s
>  sys 0m5.659s
>=20
> The test.c and mount.sh are in [1].
> This patch passed the tests with xfstests using 'check -g quick'.
>=20
> [1] https://gist.github.com/sjc2870/c923d7fa627d10ab65d6c305afb02cdb
>=20
> Signed-off-by: JunChao Sun <sunjunchao2870@gmail.com>
> ---
>=20
> Changes in v2:
>  - Fix a problem when ref of an ea_inode not equal to 1
>  - Link to v1: =
https://lore.kernel.org/linux-ext4/20230509011042.11781-1-sunjunchao2870@g=
mail.com/
>=20
> fs/ext4/xattr.c | 36 ++++++++++++++++++++++++++++++++++++
> 1 file changed, 36 insertions(+)
>=20
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index d57408cbe903..8f03958bfcc6 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1713,6 +1713,42 @@ static int ext4_xattr_set_entry(struct =
ext4_xattr_info *i,
> 		}
> 	}
>=20
> +	if (!s->not_found && i->value && here->e_value_inum && =
i->in_inode) {
> +		/* Replace xattr value in ea_inode in place */
> +		int size_diff =3D i->value_len - =
le32_to_cpu(here->e_value_size);
> +
> +		ret =3D ext4_xattr_inode_iget(inode,
> +						=
le32_to_cpu(here->e_value_inum),
> +						=
le32_to_cpu(here->e_hash),
> +						&old_ea_inode);
> +		if (ret) {
> +			old_ea_inode =3D NULL;
> +			goto out;
> +		}
> +		if (ext4_xattr_inode_get_ref(old_ea_inode) =3D=3D 1) {
> +			if (size_diff > 0)
> +				ret =3D =
ext4_xattr_inode_alloc_quota(inode, size_diff);
> +			else if (size_diff < 0)
> +				ext4_xattr_inode_free_quota(inode, NULL, =
-size_diff);
> +			if (ret)
> +				goto out;
> +
> +			ret =3D ext4_xattr_inode_write(handle, =
old_ea_inode, i->value, i->value_len);
> +			if (ret) {
> +				if (size_diff > 0)
> +					=
ext4_xattr_inode_free_quota(inode, NULL, size_diff);
> +				else if (size_diff < 0)
> +					ret =3D =
ext4_xattr_inode_alloc_quota(inode, -size_diff);
> +				goto out;
> +			}
> +			here->e_value_size =3D =
cpu_to_le32(i->value_len);
> +			new_ea_inode =3D old_ea_inode;
> +			old_ea_inode =3D NULL;
> +			goto update_hash;
> +		} else
> +			iput(old_ea_inode);
> +	}
> +
> 	/*
> 	 * Getting access to old and new ea inodes is subject to =
failures.
> 	 * Finish that work before doing any modifications to the xattr =
data.
> --
> 1.8.3.1
>=20


Cheers, Andreas






--Apple-Mail=_9DDBBDCE-FB71-4347-A7F9-63974E931C7A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmS5un0ACgkQcqXauRfM
H+ClGg//dLfLGp+/vFSh6OQJa1/ZlpuLhCtBbl5hOjKS6JFyPdZm3Uh8WpscTQJX
vtQ8ZlmNqE7OQehmYigKuuDwVaiVbKOyIOws9PH7Paavt/k1GaXDmTSRQSEVCx1V
8gRDBxAvVOF6x+8QWtV0J/8SwneDtA9umcritCvN1r3Ej05TO3TNCWyvkSCPlg9o
cl4kdpvnKGLHHZ9jmATemUXdGIL0MCipHiTulG/+lz2ox6DoBQFnha44ienumywB
xhUxAUzsWvmF7Nc3O8Euycj8c6NcFUIO5ehJLt+Y6Fr6JYv+MWf7Mmm0yDMl0OcT
9Ro8olrt4lZkpyed0jod4//nYwQw80MfHD/oM3XEGxrQBOxWnXdmU2GUNlDrIexp
woktvAhWCp3mzSQh1cbSGMn7cq9SMBNlMSHsuPLNjPrBuu7633M5TmYVfWKAYJuE
yv3AAjt1P1ta+iubYrev3GC/tPmntcRW9Zsd/7rdkQTI3BCbmMLZuP/8MDDL+JVt
NVQPLsTnx4pa6YwPTRYDNcS4WpRYB4/9g5uesAH7NhGBz+qLiRb4xL2D6tUOedDf
dpj+vLCwZ5CVkGqStBYNn8Yr0dNEGUY1Q2YRFUuAL68NSAN3bq0yeB6P1W1e+VtT
flSEZQFu1YzfHE8CP8NM4wJcrEwFdS4ML6K2feSXzk7wmCd3zCU=
=Z2MX
-----END PGP SIGNATURE-----

--Apple-Mail=_9DDBBDCE-FB71-4347-A7F9-63974E931C7A--
