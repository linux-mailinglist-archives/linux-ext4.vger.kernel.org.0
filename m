Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52FA531883C
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 11:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBKKeD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 05:34:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbhBKKbY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Feb 2021 05:31:24 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C2DC061756
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 02:30:44 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id fa16so3141089pjb.1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Feb 2021 02:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=7QTh6rGtqzYkmEmInCb7uJ+5gRGWOs9jxcfadCIgSJQ=;
        b=lJjPXzjGPLQw+/Z4qPRQTbdNG/JhC7037bOfKYYFt1wl1O5/qEAZMflgxIuLlvqBGC
         lxCOfItI9gSN1GtlI2Ywkji5brsW2aYBW/AblAVja9AaL6N3V3eZf73SaXnWAfY96ahC
         hWKASe3N4Wmp+d3wuNr53YUvVIvPETYIGVljvuOSdihv3WcMHQAQNy/LrnaC3kRrF05f
         PyvR2TnBQWvDnWoZN4LiE2Zl1o2lWbtnFCEuRlRbfJyG11q0afsUCtB7WmNKu3YTcSsM
         RTEkEh1E8P5563Dj85zZBtNFSXocuxehqmicsL7RP3bUzS+GJvzu4IqxQjVPPhjwjQAd
         ZG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=7QTh6rGtqzYkmEmInCb7uJ+5gRGWOs9jxcfadCIgSJQ=;
        b=ECZrjPzvZesdGbifX3PrIWsJyoZ9fzN6isxLSTy8OZ2dZTCvak9bWX3oN6CwBHi2KV
         mmTzBgICCSRWjgCAzz6h4DA2uqJhWNXHk4+7/o9cQFq+yIrDSJO/b6OYKzgzSxu88MeC
         a9OWfLdWTb1yadRtnLdjIjDOatxws42ebIyS7JmFWZhcHdr7xAA9ePCDiw0gXZvjH6Ip
         YodP88NDw/5qyUaKkpWPjZaMsuD0GK29Vpx2O8mtnIjPHtoRKkxE19GvcC1hOzNU+nsP
         B1rnMHcrLOrKG3zLD7qi4ujVPwG0/XU+bZIpSi8wbcRMBr9i9g0QOulNKv0fFmSg5jNj
         ex/g==
X-Gm-Message-State: AOAM530Jk1DBfe4oT7dtrA0QQMhEXhCyKLdnQRd8QWuyCDqWFNUO5Zrz
        5DjlO9DIsrVgTjZ/gnbY5sGjDg==
X-Google-Smtp-Source: ABdhPJwbsyH4IiW/5IAw6olsKktx+Nf1afkwlbgGtjgCq5Ta8Hg1xH3qvRKgdz4EBFDLWgPWrmpWxg==
X-Received: by 2002:a17:90a:e003:: with SMTP id u3mr3338637pjy.30.1613039443462;
        Thu, 11 Feb 2021 02:30:43 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id i10sm4952434pgt.85.2021.02.11.02.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Feb 2021 02:30:42 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F90B563C-B06A-49F3-B276-A7A28D9E6332@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_30940554-E254-46D2-9585-29350C9D21E5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Thu, 11 Feb 2021 03:30:31 -0700
In-Reply-To: <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        artem.blagodarenko@gmail.com, Shuichi Ihara <sihara@ddn.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-5-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_30940554-E254-46D2-9585-29350C9D21E5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 9, 2021, at 1:28 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> Instead of traversing through groups linearly, scan groups in specific
> orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> largest free order >=3D the order of the request. So, with this patch,
> we maintain lists for each possible order and insert each group into a
> list based on the largest free order in its buddy bitmap. During cr 0
> allocation, we traverse these lists in the increasing order of largest
> free orders. This allows us to find a group with the best available cr
> 0 match in constant time. If nothing can be found, we fallback to cr 1
> immediately.
>=20
> At CR1, the story is slightly different. We want to traverse in the
> order of increasing average fragment size. For CR1, we maintain a rb
> tree of groupinfos which is sorted by average fragment size. Instead
> of traversing linearly, at CR1, we traverse in the order of increasing
> average fragment size, starting at the most optimal group. This brings
> down cr 1 search complexity to log(num groups).
>=20
> For cr >=3D 2, we just perform the linear search as before. Also, in
> case of lock contention, we intermittently fallback to linear search
> even in CR 0 and CR 1 cases. This allows us to proceed during the
> allocation path even in case of high contention.
>=20
> There is an opportunity to do optimization at CR2 too. That's because
> at CR2 we only consider groups where bb_free counter (number of free
> blocks) is greater than the request extent size. That's left as future
> work.
>=20
> All the changes introduced in this patch are protected under a new
> mount option "mb_optimize_scan".
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> ---
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index b7f25120547d..63562f5f42f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
>=20
> +/*
> + * Choose next group by traversing largest_free_order lists. Return 0 =
if next
> + * group was selected optimally. Return 1 if next group was not =
selected
> + * optimally. Updates *new_cr if cr level needs an update.
> + */
> +static int ext4_mb_choose_next_group_cr0(struct =
ext4_allocation_context *ac,
> +		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	for (i =3D ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> +		if (list_empty(&sbi->s_mb_largest_free_orders[i]))
> +			continue;
> +		read_lock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		if (list_empty(&sbi->s_mb_largest_free_orders[i])) {
> +			=
read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +			continue;
> +		}
> +		grp =3D NULL;
> +		list_for_each_entry(iter, =
&sbi->s_mb_largest_free_orders[i],
> +				    bb_largest_free_order_node) {
> +			/*
> +			 * Perform this check without a lock, once we =
lock
> +			 * the group, we'll perform this check again.
> +			 */

This comment is no longer correct.

> +			if (likely(ext4_mb_good_group(ac, =
iter->bb_group, 0))) {
> +				grp =3D iter;
> +				break;
> +			}
> +		}
> +		read_unlock(&sbi->s_mb_largest_free_orders_locks[i]);
> +		if (grp)
> +			break;
> +	}
> +}

> +/*
> + * ext4_mb_choose_next_group: choose next group for allocation.
> + *
> + * @ac        Allocation Context
> + * @new_cr    This is an output parameter. If the there is no good =
group available
> + *            at current CR level, this field is updated to indicate =
the new cr
> + *            level that should be used.
> + * @group     This is an input / output parameter. As an input it =
indicates the last
> + *            group used for allocation. As output, this field =
indicates the
> + *            next group that should be used.
> + * @ngroups   Total number of groups
> + */
> +static void ext4_mb_choose_next_group(struct ext4_allocation_context =
*ac,
> +		int *new_cr, ext4_group_t *group, ext4_group_t ngroups)
> +{
> +	int ret;
> +
> +	*new_cr =3D ac->ac_criteria;
> +
> +	if (!test_opt2(ac->ac_sb, MB_OPTIMIZE_SCAN) ||
> +	    *new_cr >=3D 2 ||
> +	    !ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> +		goto inc_and_return;

I still think it would be beneficial to check if the next group is good
before going to the list/tree.  That will reduce lock contention, and
will also avoid needless seeking between groups if possible.

> +	if (*new_cr =3D=3D 0) {
> +		ret =3D ext4_mb_choose_next_group_cr0(ac, new_cr, group, =
ngroups);
> +		if (ret)
> +			goto inc_and_return;
> +	}
> +	if (*new_cr =3D=3D 1) {
> +		ret =3D ext4_mb_choose_next_group_cr1(ac, new_cr, group, =
ngroups);
> +		if (ret)
> +			goto inc_and_return;
> +	}
> +	return;
> +
> +inc_and_return:
> +	/*
> +	 * Artificially restricted ngroups for non-extent
> +	 * files makes group > ngroups possible on first loop.
> +	 */
> +	*group =3D *group + 1;
> +	if (*group >=3D ngroups)
> +		*group =3D 0;
> +}
> +
> /*
>  * Cache the order of the largest free extent we have available in =
this block
>  * group.
> @@ -751,18 +1001,32 @@ static void ext4_mb_mark_free_simple(struct =
super_block *sb,
> static void
> mb_set_largest_free_order(struct super_block *sb, struct =
ext4_group_info *grp)
> {
> +	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
> 	int i;
> -	int bits;
>=20
> +	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +		list_del_init(&grp->bb_largest_free_order_node);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +	}
> 	grp->bb_largest_free_order =3D -1; /* uninit */
>=20
> -	bits =3D MB_NUM_ORDERS(sb) - 1;
> -	for (i =3D bits; i >=3D 0; i--) {
> +	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
> 		if (grp->bb_counters[i] > 0) {
> 			grp->bb_largest_free_order =3D i;
> 			break;
> 		}
> 	}
> +	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
> +		write_lock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +		list_add_tail(&grp->bb_largest_free_order_node,
> +		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
> +		write_unlock(&sbi->s_mb_largest_free_orders_locks[
> +					      =
grp->bb_largest_free_order]);
> +	}
> }

This function would be more efficient to do the list move under a single
write lock if the order doesn't change.  The order loop would just
save the largest free order, then grab the write lock, do the =
list_del(),
set bb_largest_free_order, and list_add_tail():

mb_set_largest_free_order(struct super_block *sb, struct ext4_group_info =
*grp)
{
	struct ext4_sb_info *sbi =3D EXT4_SB(sb);
	int i, new_order =3D -1;

	for (i =3D MB_NUM_ORDERS(sb) - 1; i >=3D 0; i--) {
		if (grp->bb_counters[i] > 0) {
			new_order =3D i;
			break;
		}
	}
	if (test_opt2(sb, MB_OPTIMIZE_SCAN) && =
grp->bb_largest_free_order >=3D 0) {
		write_lock(&sbi->s_mb_largest_free_orders_locks[
					      =
grp->bb_largest_free_order]);
		list_del_init(&grp->bb_largest_free_order_node);

		if (new_order !=3D grp->bb_largest_free_order) {
			=
write_unlock(&sbi->s_mb_largest_free_orders_locks[
					      =
grp->bb_largest_free_order]);
			grp->bb_largest_free_order =3D new_order;
			write_lock(&sbi->s_mb_largest_free_orders_locks[
					      =
grp->bb_largest_free_order]);
		}
		list_add_tail(&grp->bb_largest_free_order_node,
		      =
&sbi->s_mb_largest_free_orders[grp->bb_largest_free_order]);
		write_unlock(&sbi->s_mb_largest_free_orders_locks[
					      =
grp->bb_largest_free_order]);
	}
}


Cheers, Andreas






--Apple-Mail=_30940554-E254-46D2-9585-29350C9D21E5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmAlB0cACgkQcqXauRfM
H+BMMhAAnuqwq2VJsP7erGiBBtF0drsb20eJsud60O/7OITRB8IhaiS1/tEJmKIC
D0jvlXysSoX69n+2MYqS1DGyo+vVFBqjJisCGDMZeWCdzgwL/6iSRpqLWGNMKqgx
38LzfsVJgveXO0/uVjDSaEe7EHFXsUF1KMwCTy5QipmOiX/5kHENR1soJsnpEkly
m3nZidIiiWwOanN1YdG3DuhNalPFvVSo+QForXNUf9AyyThUmhxMLm2aitsWmIB1
ILKHFJWJcj2ZRZGIzOPh5r9NHAT127JqO4u1Ql1i5UV5GfDq8ldcxg8sFMWpsE/r
vYM9HTk7czK5n1S1Mjg8sVcdmQRu2sjBjuxZ5iKMYHREqGWQ76mMwtvom6m+nBW4
M5a9O7D86Hkg9rirjU7rf4kJMbW7ibQCGiKj/MzWLFovByQgy5TO/wWqEQgTUYjN
40a3u235RWuJ5uTV5BYpEANQjfu5AL+plXkgfUnhsaIcsWDHAJQnaWyECy/gh+uv
VcmXIPbVTMQ7WQqzOqd8RBjAfRqXKDs/O7ti02yhnzuSN+mOV1NLQK3VjFOZuA/z
IztZaW/EqEEBuIxCvggZDjD40eZ5iX8xV0BEam+vSF4Btsc3dPoKfGR3g/2fcXPy
4l3+Qn38Sy1z0okPGBqcuzq+QqPXKOfCC9XgWI19Nx2vmOlLevY=
=5353
-----END PGP SIGNATURE-----

--Apple-Mail=_30940554-E254-46D2-9585-29350C9D21E5--
