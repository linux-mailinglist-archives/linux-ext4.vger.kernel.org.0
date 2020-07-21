Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0772A2279C7
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Jul 2020 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGUHsM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Jul 2020 03:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgGUHsK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Jul 2020 03:48:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819B9C061794
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:48:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id b92so1247519pjc.4
        for <linux-ext4@vger.kernel.org>; Tue, 21 Jul 2020 00:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=q7wbsHmkbbrUMj7jQhf7+ApmCnS3tdLJ71JmqTaHb5Y=;
        b=vlXNJrHIbEYpEHx+ZZ1UKdMZAebKwf63aLf7sKKNuhJm5Hc1HgMbWh+09DhL1MxyPC
         2BTu7PQKJuaMjhNFqpWzwVWMYnYRL5iDa4mb6HBVuzEbUXCFynTvhOQg5MjsdngDZc/C
         TJ/SOaF9NdkY/X1j3rdlmB3TlsdlFKYBuDD/NtuNgcb2VtSLIzWjBpKWXNquk4Qzmkhm
         XFxxiJkG5lgIInykBfbBMm+ukva7/I4GYIsELHOBYIvre+A3xMJ34Kn08lV0MwOwxxGH
         e8p4jS8YwLIG3UKKiMbKLyyQUHQUo8S2W5RFV/iXsF/5jh9GkoV0NlCzp/yDYIjb2Vej
         9Bxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=q7wbsHmkbbrUMj7jQhf7+ApmCnS3tdLJ71JmqTaHb5Y=;
        b=FJbJG3IUyPVfkKxakTfjz1g+VoYBvC0liKzicYLaUfnR1i2Ngw83mM/VbA7Flq1ZQQ
         9rjRL8/Qck8iRl1+JfeEDPALaOOzxe7EkKQeLpOaHzfTNFH5k1Z2qoG/BZi468cN12yp
         IsnLOE1Uvx3b6WSydau/R/wy4jQqkMyisLMwmNY2wALIcp80p/psSNMVV/S3NRRJv4ss
         uEhECLkFvl/PcyeCfC8RnFeOAy44wBamcmVq7IYz0bxHath1iTIjCNQYpYKtaqVy/UHI
         GDacvamA5UN31SEGEfDNBlQOUBB8dwjY9D2+05z8M00/zimosuaN29pHrqSV6XBv8BAr
         L0ng==
X-Gm-Message-State: AOAM531QWc9ut86nIOP5j3LFmAoTgnAGi5Yuc3cPEYa/Zk3I0ERSMBNS
        p+h16VNFWMDPoY7ijVq05EOxan5DBvA=
X-Google-Smtp-Source: ABdhPJwDYaEPZFQ1FybkZy6AjmALyCRaFMIepTc5yMt7WVBKYaeyXCSI/Dv8LFdB8DFTiw1XZ1ZSqw==
X-Received: by 2002:a17:90a:d086:: with SMTP id k6mr3511316pju.171.1595317689981;
        Tue, 21 Jul 2020 00:48:09 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id e28sm19256838pfm.177.2020.07.21.00.48.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jul 2020 00:48:09 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E73B0C31-4CEC-4C0E-AFD2-48159FA7DE62@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_92306E53-FF68-43A2-8625-065B0D6F4183";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 2/4] ext4: skip non-loaded groups at cr=0/1 when scanning
 for good groups
Date:   Tue, 21 Jul 2020 01:48:07 -0600
In-Reply-To: <20200717155352.1053040-3-tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>
To:     Theodore Ts'o <tytso@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-3-tytso@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_92306E53-FF68-43A2-8625-065B0D6F4183
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Jul 17, 2020, at 9:53 AM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> From: Alex Zhuravlev <azhuravlev@whamcloud.com>
>=20
> cr=3D0 is supposed to be an optimization to save CPU cycles, but if
> buddy data (in memory) is not initialized then all this makes no sense
> as we have to do sync IO taking a lot of cycles.  also, at cr=3D0
> mballoc doesn't store any avaibale chunk. cr=3D1 also skips groups =
using

(typo) "available", but "doesn't store any available chunk" is still
a bit confusing.  Maybe "doesn't *choose* any available chunk"?

> heuristic based on avg. fragment size. it's more useful to skip such
> groups and switch to cr=3D2 where groups will be scanned for available
> chunks.
>=20
> using sparse image and dm-slow virtual device of 120TB was
> simulated. then the image was formatted and filled using debugfs to
> mark ~85% of available space as busy.  mount process w/o the patch
> couldn't complete in half an hour (according to vmstat it would take
> ~10-11 hours).  With the patch applied mount took ~20 seconds.
>=20
> Lustre-bug-id: https://jira.whamcloud.com/browse/LU-12988
> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
> Reviewed-by: Andreas Dilger <adilger@whamcloud.com>

Purely cosmetic fix below, but still fine otherwise.

> ---
> fs/ext4/mballoc.c | 13 ++++++++++++-
> 1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 8a1e6e03c088..172994349bf6 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2195,7 +2195,18 @@ static int ext4_mb_good_group_nolock(struct =
ext4_allocation_context *ac,
>=20
> 	/* We only do this if the grp has never been initialized */
> 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
> -		ret =3D ext4_mb_init_group(ac->ac_sb, group, GFP_NOFS);
> +		struct ext4_group_desc *gdp =3D ext4_get_group_desc(sb, =
group,
> +								  NULL);
> +		int ret;

(style) this might be nicer to read like:

		struct ext4_group_desc *gdp =3D
			ext4_get_group_desc(sb, group, NULL);
		int ret;

> +		/* cr=3D0/1 is a very optimistic search to find large
> +		 * good chunks almost for free. if buddy data is
> +		 * not ready, then this optimization makes no sense */
> +		if (cr < 2 &&
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






--Apple-Mail=_92306E53-FF68-43A2-8625-065B0D6F4183
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl8WnbgACgkQcqXauRfM
H+DX1BAArExAgWaa04FjW+rbJFZ4b35GbeqiQvQPIyQ7NehOX05l3Rk+XrZufxFm
YWAhPiGp6q5EUUqKuop9pKBdbdkjCpWdcNkPlAQLIJfWVZO+4B2YodUqJxT1nq9t
DEDMJCFRb7aUylgObYX9TE4mz1jUh3dga2Dm1e5PKflgQFPLoxpvlR+PKtqzRq/p
G0ptTu+c0V5JRC2c2lmHpB2c6kq5e6ms2MSgnvnGRKAEA7P4jTdMFFwQ3NzxEAGc
NmdHUeqpv2ZffRUJic06P40vsp694e0xw6vv3NLa7w/2pSMSfFP0jXdYklpdzYzm
PhFpH5XKnl+h1ImegYBGN2h7PCRYYTs88JFH1L1jVupyUdkcjAGNZWyUPmiJ7Tpe
iRO+LjkvSkL5ZPUvd18jRhW4SxbK/P33Pyhu9xAsI4KFDfmSWTVAb9+oyJuN+iKK
malN0+Lnt5Vbfoz/o4YVk49D8y+fAcI0JmUEjOAW+P8Rjb62rcoRjCNOc9jzea6J
5b9aLSs9hMCrv+dyRzKDPBvGkvmDn2H4MKTjRgX1n/Ly48bjuTyrE+aAN7O5Fz1u
4Winr2YQDcsKgIACoZBpjG0tOJ64E843SDt6aJBIMekk7myojgSQNyjPRCqtUeHh
RagaMFh0cpJis7e8cALY73UdD9x74TBlVo4XwQ0cgHS1POMF3Gw=
=mroK
-----END PGP SIGNATURE-----

--Apple-Mail=_92306E53-FF68-43A2-8625-065B0D6F4183--
