Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCD12437D4
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 11:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgHMJlD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Aug 2020 05:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgHMJlC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Aug 2020 05:41:02 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776CFC061757
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 02:41:02 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g33so2544045pgb.4
        for <linux-ext4@vger.kernel.org>; Thu, 13 Aug 2020 02:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=thm+kfgqUs/Q5WOmuiGw/M+WBa5aZyDEDZdt/gnaRAQ=;
        b=Gl0OndnyIuxuw4PvgmRmcLLwBqschjNBOL5kDrpMJOIzdr9IDAYiJ9WoKigUm+/i0q
         PuYz3cXtjwZmrjBGSfI/A6G8EW2Zi2KgfWWJLCvsbxVb1CyI9eGZynWuORTBVpA33czH
         YwuemXcZo1X6qn6uFdbItajjwUZ8EhOfwWHUNE4PMO7U5GUMnnzNY/hlRQblSN9/HwII
         +Y+jtls96xBdeyaMZ17JqSFK7a7rnH+7rgKKSz1PNGf5T9oYxWWocojwWHCfJqMndsRw
         bdTA8IHhHYPKmPeabJoAaptSmje1SL4f4K+EcvXBk71oA7ektFHAXO5Y0oqQqPYkO20C
         JN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=thm+kfgqUs/Q5WOmuiGw/M+WBa5aZyDEDZdt/gnaRAQ=;
        b=IbR1hqez91BCmVYPaGqSAmqXZTSF4bbPYNXpa49K8Z6+2BY9XXmqdyejPl+PDDLSIM
         902H94ivGrkgLdL1+DwVM0nhn9m9FS4eQuXwhUKvefBxQ9OrAc2DyZ5eovy0UKA4SblQ
         YAEnFLfB7Bf3j+mDoIhCIHfVkYL9lZDqqBiwDc0+tTl/bhmhvpCXREfnHNWv0Q5ULiCY
         R8poBsdmy5JsJAfCWI8SoriZHfIyMjypbczABezQ5BNV/pzO6JQUIorzXW/tjIriQJi+
         xxmML3dCS+CtuyLPAa7bx2LjoOLkOVQRc9ndkya/bSnJDcxd2gkMYp7sR9PFYNAsRNVh
         fCXQ==
X-Gm-Message-State: AOAM531Xil4GGDvYtleY+qhRrDRClrNDFTeryPMhu+uQwYvfIFx0eMqs
        8XASVUnurl59abF1W3C5yGXFmg==
X-Google-Smtp-Source: ABdhPJxsYjfNM5D9clTHMqLifxuAzqNyN5+oYvDHSBwyoWWOCEkF11N5Zn2WpvpDy6H9WwDzcNXr/w==
X-Received: by 2002:a62:c582:: with SMTP id j124mr3621854pfg.21.1597311661862;
        Thu, 13 Aug 2020 02:41:01 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a4sm4716682pju.49.2020.08.13.02.40.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 02:41:00 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <AE5D98E4-6F8C-4785-93C0-919FC2DDDB24@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_86F233BD-D304-44A4-951C-A4AA36218F40";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: put grp related checks into ext4_mb_good_group()
Date:   Thu, 13 Aug 2020 03:40:57 -0600
In-Reply-To: <a53fe585-2b31-3a2e-f3eb-edc6f80ad85f@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <a53fe585-2b31-3a2e-f3eb-edc6f80ad85f@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_86F233BD-D304-44A4-951C-A4AA36218F40
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 7, 2020, at 8:01 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> We will make these judgments in ext4_mb_good_group(), maybe there
> is no need to repeat judgments here.

This patch looks like it _may_ have some performance impact on a large
filesystem that has some of the block groups that are mostly full, or
the group is already marked corrupt.

These checks are trying to avoid initializing the group's block =
allocation
bitmap(s) from disk and initializing the buddy bitmap(s) if that is not
actually needed.  See comment in ext4_mb_regular_allocator():

		/* This now checks without needing the buddy page */
		ret =3D ext4_mb_good_group_nolock(ac, group, cr);

		err =3D ext4_mb_load_buddy(sb, group, &e4b);
		if (err)
			goto out;

		ext4_lock_group(sb, group);

		/*
		 * We need to check again after locking the
		 * block group
		 */
		ret =3D ext4_mb_good_group(ac, group, cr);

If those checks are not done in ext4_mb_good_group_nolock() to return 0
to the caller, then the call to ext4_mb_init_group() and =
ext4_mb_load_buddy()
will be done, only to find in ext4_mb_good_group() that the group is no =
good.

There were also some performance-related patches in the past that show
the calls to ext4_mb_load_buddy() is expensive with real filesystems:

    commit 1c8457cadc9cefe7ec920a2f3537ff1fe20f4061
    Author:     Aditya Kali <adityakali@google.com>
    AuthorDate: Sat Jun 30 19:10:57 2012 -0400

    ext4: avoid uneeded calls to ext4_mb_load_buddy() while reading =
mb_groups

    Currently ext4_mb_load_buddy is called for every group, irrespective
    of whether the group info is already in memory, while reading
    /proc/fs/ext4/<partition>/mb_groups proc file.  For the purpose of
    mb_groups proc file, it is unnecessary to load the file group info
    from disk if it was loaded in past.  These calls to =
ext4_mb_load_buddy
    make reading the mb_groups proc file expensive.


    commit 78944086663e6c1b03f3d60bf7610128149be5fc
    Author:     Lukas Czerner <lczerner@redhat.com>
    AuthorDate: Tue May 24 18:16:27 2011 -0400

    ext4: only load buddy bitmap in ext4_trim_fs() when it is needed

    Currently we are loading buddy ext4_mb_load_buddy() for every block
    group we are going through in ext4_trim_fs() in many cases just to =
find
    out that there is not enough space to be bothered with. As Amir =
Goldstein
    suggested we can use bb_free information directly from =
ext4_group_info.

    This commit removes ext4_mb_load_buddy() from ext4_trim_fs() and =
rather
    get the ext4_group_info via ext4_get_group_info() and use the =
bb_free
    information directly from that. This avoids unnecessary call to load
    buddy in the case the group does not have enough free space to trim.

I think some options still exist for this patch:
- make a helper routine like "ext4_mb_group_unsuitable(ac, grp, cr)
  that does these common checks and use it in both ext4_mb_good_group()
  and ext4_mb_good_group_nolock() to reduce code duplication.  However,
  checks in ext4_mb_good_group() have also been changed/removed in
  another of your patches, so it may not make sense anymore?

- add an optimization in ext4_mb_good_group_nolock() to do the
  unlock/lock only in the unlikely case that GRP_NEED_INIT is true:

	if (should_lock)
		ext4_lock_group(sb, group);
	free =3D grp->bb_free;
	if (free =3D=3D 0)
		goto out;
	if (cr <=3D 2 && free < ac->ac_g_ex.fe_len)
		goto out;
	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
		goto out;

-	if (should_lock)
-		ext4_unlock_group(sb, group);

        /* We only do this if the grp has never been initialized */
        if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
+	        if (should_lock)
+			ext4_unlock_group(sb, group);
		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
		if (ret)
			return ret;
+		if (should_lock)
+			ext4_lock_group(sb, group);
        }

-	if (should_lock)
-		ext4_lock_group(sb, group);
	ret =3D ext4_mb_good_group(ac, group, cr);
out:
	if (should_lock)
		ext4_unlock_group(sb, group);
	return ret;
}

That will avoid some lock contention on the group lock in the common =
case,
which will probably avoid more overhead than .

Cheers, Andreas

> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> ---
> fs/ext4/mballoc.c | 16 ++--------------
> 1 file changed, 2 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 4304113..84871f7 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2178,21 +2178,8 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
> 	struct ext4_group_info *grp =3D ext4_get_group_info(ac->ac_sb, =
group);
> 	struct super_block *sb =3D ac->ac_sb;
> 	bool should_lock =3D ac->ac_flags & EXT4_MB_STRICT_CHECK;
> -	ext4_grpblk_t free;
> 	int ret =3D 0;
>=20
> -	if (should_lock)
> -		ext4_lock_group(sb, group);
> -	free =3D grp->bb_free;
> -	if (free =3D=3D 0)
> -		goto out;
> -	if (cr <=3D 2 && free < ac->ac_g_ex.fe_len)
> -		goto out;
> -	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
> -		goto out;
> -	if (should_lock)
> -		ext4_unlock_group(sb, group);
> -
> 	/* We only do this if the grp has never been initialized */
> 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> 		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> @@ -2202,8 +2189,9 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>=20
> 	if (should_lock)
> 		ext4_lock_group(sb, group);
> +
> 	ret =3D ext4_mb_good_group(ac, group, cr);
> -out:
> +
> 	if (should_lock)
> 		ext4_unlock_group(sb, group);
> 	return ret;
> --
> 1.8.3.1
>=20
>=20


Cheers, Andreas






--Apple-Mail=_86F233BD-D304-44A4-951C-A4AA36218F40
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl81CqoACgkQcqXauRfM
H+CUGBAAkm6GNNQKhGIeygKIczrc9rj0hNsmpr3hmo9M5f7xbL96ht2PW+XhWgo6
uqT2mjun4bWu1nAL2SBN/0WSvTq4cMQya7B8NjQtYrrlTE53lKSOScyYGkydC/1q
y+4ATnmWQ6zsTzrqT5NYsi/Sy2FIHxXuMIm6ekFw/18dKqHYSJ1oFfvyO/FR/Rqi
zHYgoUcBvDYKpG91sGe+g6nSRE7LlitP2cVj6VELzyKfOE3wonx/3SLSPeyxm1ax
21sav1tEOZGcUessWsJCa4QCJF6szNpQ7oUETi9PNVrowTlofHd5l2o7wrflg1hN
dSnRazQKeLdjldOarVNGY5l50j6ZTBeTurhSsdnVKXn27myoZsLMawG2Tm3Ipp5e
CPLBNDq6xVblsV5mpHSsAekIoLT0CZJbPwcQElrDJQFosud0ttJQdyyRV/B5jKbD
Hz/rv7VMrNxuuCaXFKlEzn2cZqLXkxUtvX0dnHgu49lZCridvvIOSTSdJlHcC6mh
DthA/ezKnFmd3eiFkXt5oGGbObXjauYyF9zB+tN0zBvFZAZf+dTBQa7+gOcWsE9L
/tdi0yZhhztFwvSUql5dfR1vxitbmuJMilB23oFHaBOacp8qw+MiJ4hghSbtiCbM
pXicOVKZuaTxMGl3PX4D9mJ7LkaYap+BZxZNDQPjd/WxQtafuhU=
=IJwU
-----END PGP SIGNATURE-----

--Apple-Mail=_86F233BD-D304-44A4-951C-A4AA36218F40--
