Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F0C3294E4
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Mar 2021 23:29:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238354AbhCAW0G (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 1 Mar 2021 17:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbhCAWXj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 1 Mar 2021 17:23:39 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499C6C061756
        for <linux-ext4@vger.kernel.org>; Mon,  1 Mar 2021 14:22:59 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id l2so12557998pgb.1
        for <linux-ext4@vger.kernel.org>; Mon, 01 Mar 2021 14:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=sqf52MskJHPotrXO+uooqkH7QhK00cK2Es42sRcxBcg=;
        b=ou60UOZa1P+u/UVH6V/n/f+WLCx8X2BflIaWkImvvjrXy4hvdXuBTbDtiBtZRSsr6R
         ztzWRC9KFwKkvdd7N7nk/dUhlyqUPFK+/nQB1+KXW8oIQMjQWpGIVFtfG844OFRZ9Q1b
         hxAeIKB1bQ6TpQpAMbl7p/89fC3xfTbizJizneuqhoiHU/RPdckBwqVgvX2VJFBw0aer
         CluVF9jkHwG3yyL5Q+xgi2D7qzjt8j9l7oaSavCmyN1z54ZtGSHMpIFpK7yc9O0F1M6g
         TF9y8wvHnfFCKy4PhYoaYonO3jY4uf+wPlgBAbzv+KQ2cw+UxBQUWishJ8gd5BDoYTcX
         xvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=sqf52MskJHPotrXO+uooqkH7QhK00cK2Es42sRcxBcg=;
        b=jE8XWqq7ynzNeNOlF3lg2NYLSHn7dkCjTORzErexoJqUK+ygI2GqdvxO4Aam6XVgOb
         smhAzsvaCaJId+3OqWaI7txwTpR1U4rFkZ3FRiIQ3+gocJ4Evllvdv6px8hPGrpEvi3L
         SsiiA/lzHjkb9zL3VaPqfxCbetE3EZGOz/K7L7Umg3Jz5Gp1m7Wedxaw5u0DZ9alojd8
         UgX20tg78mcauovJM3euMa2ApzpvKjRldy0fYeWB3ngu14AmDs2IXCoOTXCQd9bvMOBA
         9to5qY/KHuGO9JbohN8eKSgIO+rZMeEfoFMENrXcsqyqf/TdB8utPevqbLbG3rw2fXeA
         WGYA==
X-Gm-Message-State: AOAM532zn2Hb+BOkNp1VB9Ouu+1p2RWdWto6hoo/J7ustfOU2CDcsii5
        GQbTQPAAfL7Kg/kxjW+q1T9U+FQAf0kx+NWP
X-Google-Smtp-Source: ABdhPJzQB5SAjV3odbRJrx2O3qz9NDTbKpG6lPJsS1BduTsSFmfHNWOs25WadDoPC2fyFT5DP2JyvQ==
X-Received: by 2002:a63:5044:: with SMTP id q4mr4741234pgl.178.1614637378504;
        Mon, 01 Mar 2021 14:22:58 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id k15sm19184767pfh.17.2021.03.01.14.22.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 14:22:58 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C9D3369F-E02F-4D49-A719-6793B70E7D22@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B9E19B55-BF83-4C77-A59F-5CA85D26A830";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 4/5] ext4: improve cr 0 / cr 1 group scanning
Date:   Mon, 1 Mar 2021 15:22:55 -0700
In-Reply-To: <20210226193612.1199321-5-harshadshirwadkar@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20210226193612.1199321-1-harshadshirwadkar@gmail.com>
 <20210226193612.1199321-5-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B9E19B55-BF83-4C77-A59F-5CA85D26A830
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 26, 2021, at 12:36 PM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
> Instead of traversing through groups linearly, scan groups in specific
> orders at cr 0 and cr 1. At cr 0, we want to find groups that have the
> largest free order >=3D the order of the request. So, with this patch,
> we maintain lists for each possible order and insert each group into a
> list based on the largest free order in its buddy bitmap. During cr 0
> allocation, we traverse these lists in the increasing order of largest
> free orders. This allows us to find a group with the best available cr
> 0 match in constant time. If nothing can be found, we fallback to cr 1
> immediately.

Thanks for the updated patch, I think it looks pretty good, with a
few suggestions.

> At CR1, the story is slightly different. We want to traverse in the
> order of increasing average fragment size. For CR1, we maintain a rb
> tree of groupinfos which is sorted by average fragment size. Instead
> of traversing linearly, at CR1, we traverse in the order of increasing
> average fragment size, starting at the most optimal group. This brings
> down cr 1 search complexity to log(num groups).

One thing that came to mind here is that *average* fragment size is
not necessarily a good heuristic for allocation.  Consider a group with
mean fragment size of 2MB, made up of equal parts 4MB and 4KB free
blocks.  If looking for many 2MB allocations this would quickly cause
the 4MB chunks to be split (pushing down the average below 2MB) even
when there are *exactly* 2MB free chunks available in that group.

Another alternative (short of having a full "free extents" tree like
XFS does) would be to keep the rbtree sorted by *maximum* fragment
size.  That would not be any more expensive (one entry per group)
and guarantee that at least one free extent closely matches the size
of the extent being allocated.  I _suspect_ that the cr1 allocations
are mostly for smaller files/tails that are not power-of-two sizes
(which would normally be handled by cr0 except in pathological test
cases), so finding an exact match is the right thing to do.

In that case, the cr0 pass would handle most of the file's data, and
cr1 would handle smaller files or the tail that are not 2^n extents.
Filling (nearly) exact fragments would be good for space efficiency,
and avoid fragmenting larger extents when that is not needed.

That said, I'm not confident enough about this to suggest that this
has to be changed before landing the patch, just an observation that
came to mind.  Having a good workload simulator (or actual application
benchmark) would be needed to assess the difference here, since a
synthetic workload (e.g. fill alternate 2MB chunks) is not reflective
of how the filesystem would be used in real life.

A few minor comments inline...

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 161412070fef..bcfd849bc61e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
>=20
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

No reason why these comments can't be wrapped at 80 columns

> @@ -2938,6 +3273,20 @@ int ext4_mb_init(struct super_block *sb)
> 		spin_lock_init(&lg->lg_prealloc_lock);
> 	}
>=20
> +	if (blk_queue_nonrot(bdev_get_queue(sb->s_bdev)))
> +		sbi->s_mb_linear_limit =3D 0;
> +	else
> +		sbi->s_mb_linear_limit =3D MB_DEFAULT_LINEAR_LIMIT;
> +#ifndef CONFIG_EXT4_DEBUG
> +	/*
> +	 * Disable mb_optimize scan if we don't have enough groups. If
> +	 * CONFIG_EXT4_DEBUG is set, we don't disable this =
MB_OPTIMIZE_SCAN even
> +	 * for small file systems. This allows us to test correctness on =
small
> +	 * file systems.
> +	 */
> +	if (ext4_get_groups_count(sb) < =
MB_DEFAULT_LINEAR_SCAN_THRESHOLD)
> +		clear_opt2(sb, MB_OPTIMIZE_SCAN);
> +#endif

Making this a compile-time option makes it much harder to test.  Having =
this
managed by the /proc mb_linear_scan tunable or mount option would be =
useful.

Cheers, Andreas






--Apple-Mail=_B9E19B55-BF83-4C77-A59F-5CA85D26A830
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmA9aT8ACgkQcqXauRfM
H+BKsg//ek8qBsXw9SzUheT5v3KrCDOkSE3AWK1YoypzRaOGeLGcKmqSEJuv2vFd
ZLka8ph2htrGsgQMpP0LzLXVCUZh/yd+r5Zpfxa3w+qBTMOE8G5bix8+i3dPqFcv
FlPVOJKUD+Vw449UoZHu5twCA9KtAILm6qrOqtFK4j23YiHMBNWFPRsSDzT53woV
T30Y88hG5gF+ibYl+lqFpO9sHNV4X8rAsgWgKNf0mtjrGBBRG4fgXGlb8wlQMI9n
nmIeOv5BKd4np3p0UBPTYfRyf3Uu3XnQRbN/jjXroUd2G3hVOxkbk4kfVc1UTDs6
0NX2NPBz6/PVeAN0EIgKnqmmshL3ByMEo6hcuTzAkAUnVa4BHWIRrxKz8Y23+pAk
svBozokvvDiFa7JkH26kXb6WijWBAuonVY0ycgt1OpLMvP0tsWIx9JmhqR2J73As
AGY81a5174+pevM9yvPDc6wUAvSyvb1hXPz2/ntEGm0e5yQ0qBPMxc3RHluvgHIL
vPZbfcAiGqWAJNJCFnJkUmYBrxWm9JJYejg9n+5IAdAexO5cAEaLGeis5EJLru9U
j0cMzU5aNNHkcWHipf/VspowB2Ttzo1C4VtnD56Ii6bFw1zd7PKFXNyKbyBOjHte
fMqhhfWlIM+5kidsWrUo36SMnMTuFqMIxvGoUovLN7B3dAd5Lyw=
=AiY6
-----END PGP SIGNATURE-----

--Apple-Mail=_B9E19B55-BF83-4C77-A59F-5CA85D26A830--
