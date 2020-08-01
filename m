Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87925235137
	for <lists+linux-ext4@lfdr.de>; Sat,  1 Aug 2020 10:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgHAItS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 1 Aug 2020 04:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgHAItS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 1 Aug 2020 04:49:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF480C06174A
        for <linux-ext4@vger.kernel.org>; Sat,  1 Aug 2020 01:49:17 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t10so13132897plz.10
        for <linux-ext4@vger.kernel.org>; Sat, 01 Aug 2020 01:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=9b1rnh/dvroHFEnLtnxGqbigOoDOmHcR2aw80vwqap4=;
        b=SN3gV1gtIYbjWZkGFcvArboQpc80oBk/Mf8a5rp6IXxf6qAkoLz/5w2kaI7AxMKwTL
         9mgfhJ0y4rVoZxIRKcy5A1rBIBJKf/PHhSKlXq+J7CmiXNh0tBI/dMBxAKdwIJ15Qm3l
         MwoT/teJbzERsmfS17lgiRe2nGy19dgcgzYEOi0dCepVygMg5tf1JWAF9cSQ5ugN0GER
         F8In+egAYE/P2LIi6JOgfiui3lv/STddodLW+QSTHMDTnEFjHD84ukMhgqDUlsAALej1
         TZdoFUlEMbRN3cRUAhou7r0Ob3pQ5Z4ZZq4r6QyP5DStdvhMm7urMwZkWYjL8wkX9irk
         yCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=9b1rnh/dvroHFEnLtnxGqbigOoDOmHcR2aw80vwqap4=;
        b=YZ2leBL8JhPzwlhqyfqdRYoT0mCuacLKvjCei1OIvYtvezBcRcauyC3j0EpwJhlWlO
         4+8/WvX57T9/0ZrwXYmN9/ZH47nSq9j8za0TUabJt2ElxHiEcmouCpgjLH18gj+u8HrH
         QwdSCjA1HlGgxF5GWMCF2NgzOLDy5DVcmV1qnjlmUIHENyVhzWpVk2EAR27wFG15HP6L
         gXmgEVlpwPKZrp6xFFRr92Sv3V4tb+VT57aLWM0QEQzQKLZKXbDt+tdWoQEuVTQzCbDI
         puGYr2Qw23gWWiZhSCXUm/9VFZpewQ7NgtnMO+aWwC5FfKx1ivpPqEQAzsoe4o/AVgKC
         jnSQ==
X-Gm-Message-State: AOAM533nL3XQLTQyAcZ6H2vmc9cB1UsXkK/sJog6HKArLI7Hbz/da+1g
        JXOzqJwZMSdprsK9EjUE4zb2IA==
X-Google-Smtp-Source: ABdhPJzfLngaa0r59Z5cdqpyWzPLp1/aUKLLarlnfTv8u8JcigXrwKkEazaub38uYISTkOvuKjqzWw==
X-Received: by 2002:a17:902:904a:: with SMTP id w10mr6075307plz.93.1596271757415;
        Sat, 01 Aug 2020 01:49:17 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id x23sm12300195pfi.60.2020.08.01.01.49.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Aug 2020 01:49:16 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <79A96A07-ECA0-410A-8775-457B9C3CFFF1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_ACC36A30-1A0C-452D-AA7F-85EF2D6F8D1B";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] ext4: skip non-loaded groups at cr=0/1 when scanning
 for good groups
Date:   Sat, 1 Aug 2020 02:49:12 -0600
In-Reply-To: <20200731190805.181253-3-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <azhuravlev@whamcloud.com>,
        Artem Blagodarenko <artem.blagodarenko@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200731190805.181253-1-tytso@mit.edu>
 <20200731190805.181253-3-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_ACC36A30-1A0C-452D-AA7F-85EF2D6F8D1B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jul 31, 2020, at 1:08 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> From: Alex Zhuravlev <azhuravlev@whamcloud.com>
>=20
> cr=3D0 is supposed to be an optimization to save CPU cycles, but if
> buddy data (in memory) is not initialized then all this makes no sense
> as we have to do sync IO taking a lot of cycles.  Also, at cr=3D0
> mballoc doesn't choose any avaibale chunk.  cr=3D1 also skips groups

(typo) "available"

> using heuristic based on avg. fragment size.  It's more useful to skip
> such groups and switch to cr=3D2 where groups will be scanned for
> available chunks.  However, we always read the first block group in a
> flex_bg so metadata blocks will get read into the first flex_bg if
> possible.
>=20
> Using sparse image and dm-slow virtual device of 120TB was
> simulated, then the image was formatted and filled using debugfs to
> mark ~85% of available space as busy.  mount process w/o the patch
> couldn't complete in half an hour (according to vmstat it would take
> ~10-11 hours).  With the patch applied mount took ~20 seconds.
>=20
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
> Signed-off-by: Alex Zhuravlev <azhuravlev@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>
> Reviewed-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Looks good, one trivial cleanup below could also be done before landing.

> ---
> fs/ext4/mballoc.c | 22 +++++++++++++++++++++-
> 1 file changed, 21 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index fcc702f1ff15..b1ef35a9e9f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2195,7 +2196,26 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>=20
> 	/* We only do this if the grp has never been initialized */
> 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> -		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +		struct ext4_group_desc *gdp =3D
> +			ext4_get_group_desc(sb, group, NULL);
> +		int ret;
> +
> +		/* cr=3D0/1 is a very optimistic search to find large
> +		 * good chunks almost for free.  If buddy data is not
> +		 * ready, then this optimization makes no sense.  But
> +		 * we never skip the first block group in a flex_bg,
> +		 * since this gets used for metadata block allocation,
> +		 * and we want to make sure we locate metadata blocks
> +		 * in the first block group in the flex_bg if
> +		 * possible.

(style) "possible" could fit on the previous line?

> +		 */
> +		if (cr < 2 &&
> +		    (!sbi->s_log_groups_per_flex ||
> +		     ((group & ((1 << sbi->s_log_groups_per_flex) - 1)) =
!=3D 0)) &&
> +		    !(ext4_has_group_desc_csum(sb) &&
> +		      (gdp->bg_flags & =
cpu_to_le16(EXT4_BG_BLOCK_UNINIT))))
> +			return 0;
> +		ret =3D ext4_mb_init_group(sb, group, GFP_NOFS);
> 		if (ret)
> 			return ret;
> 	}
> --
> 2.24.1
>=20


Cheers, Andreas






--Apple-Mail=_ACC36A30-1A0C-452D-AA7F-85EF2D6F8D1B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8lLIgACgkQcqXauRfM
H+DsihAAgnhM16BeFWwHlTvPLqYD3xta2IqZwyneoNJZx/moV+jsHRntYyS+z6DJ
25qYHUEBP3nbHPf1b7D5Zvd1yBgolHqfNx1vSR1nNvOBiDc8uL0fSFhySJ5/L/5j
NtAXGLFZU+RP9H4B/2w1y28gFsEinpUlCulIW1TReNM79JcWFBb8m+QPcf+YLOWH
Jlnq7lqHobN8qouzhaB29IBKNKsIRrCtsEdYQaa+dtXw/GLTdmypVJHrzJPVocIv
KTvCsNskn53web8E3047SYyA7phc7lPJNtNWWj+QwXV+E2k5GDtlw6hJy8VdiNr5
oncUDUweoBhu+vzVNPHBcYxEAO4UeuOyDpOnNb3xQyp8uGj95cNLVLnaIUmhzg+i
/b7N5JcDzUtJHDeSzO78cszoStZ9iDMBQI/atVU00vgLVcwKWSarBdhYZK0nMFIJ
kFXgTzzyG203Wv/pMTf+nJrXk+5LbOT0rYTXzhEfdOxPA9VixZ1QFGEIef7wxwSc
nAUrZFJQYZAq1IEVQRdJ++wRqZ35+FH17zv/rlRAwBdOXaC3FSGObBWuuXsdc8oP
NdM49qir/V9iyZs7k5Ut+xGFpQlGAgOAeod9x0Ry3XJr7jkAJ6fDI9DBoeGR9lPa
lxQ46VBxFsmK9Np8s4MSh7rc6rke0cbxW7ODLjdlGY2KhSJhKs8=
=lPC3
-----END PGP SIGNATURE-----

--Apple-Mail=_ACC36A30-1A0C-452D-AA7F-85EF2D6F8D1B--
