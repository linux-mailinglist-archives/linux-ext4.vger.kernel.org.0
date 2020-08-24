Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D51250AF1
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Aug 2020 23:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbgHXVez (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Aug 2020 17:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXVey (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Aug 2020 17:34:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC816C061574
        for <linux-ext4@vger.kernel.org>; Mon, 24 Aug 2020 14:34:53 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id g6so122054pjl.0
        for <linux-ext4@vger.kernel.org>; Mon, 24 Aug 2020 14:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=ovAyn4Poe4VsI6v8u6x7bM5uzaIaijG/macBqt+tzP8=;
        b=CYndytIs1bzqd+BqGkVWuiC7KVK29GFSZT9yB1e6uumqNWxvtsZuqBPD4jNseVFR96
         ucrL5v5wJ2TzqwJYVhWDZcOC+RR3zqhwRiG76LMu/fPbiT6j83cr8J81nfnzwjuRLpGq
         FyAMYGSaH3vP5dxlN3p2Jl9BaZ4Jrm7hv0yKqYjzksAdQaPOG4idohrU3298gUuE/JN9
         5cSxKFCVdS0BQtbyf0kaJz66h5kZjMct8rVvWk6dpeJvHG+NRTM4ZdUtVvTbicw6uOc1
         vEEKsds+oBDNRRM3R52JB20EAIL2fz21VeuU6EvIpy5kOzClHC91vCT3zSdkbbVFAq93
         dVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=ovAyn4Poe4VsI6v8u6x7bM5uzaIaijG/macBqt+tzP8=;
        b=mrZEH6cvoKKocCNmYG9FjrzsND+XBit528FbfGM26uxfM2FE4FG/8wq7HFnvBtiYXc
         7CO2q3oWKhXwL61MPukUNy++bnhvZGUU/hw/ysjpyxxhJ3iSwmowxEUT/yJx+LUAHvC3
         +Oa401a+A2SxEuYwToNSIpJawBE3mxCMxKPXQIIB9zB5kRY21403Bx80oJUhGotAGfSi
         0qhsgGF3Oi+Hm0CC4iLu3F3e2bV2Ww9bIdRzYEEzgzhddiZP3qzqTUs3p5zytsIe5515
         9m1SLJZOj+fcMGa+SSuQDz2oyH9FM4Ehdng8kZx59wd917vVVJ1kEJHgSCo/hRzGqvkJ
         YERw==
X-Gm-Message-State: AOAM5323hjKfBCW4nRmojIaEMGvHxtlQ/qar8uRgcXPpeQzVoAYIaZu/
        KDoyNx1Q0uzh5XZUcug8EadcDQSE0TYjBWZN
X-Google-Smtp-Source: ABdhPJxJbuXETIeK15L72ChVd3noeyc9Ysebs0NtNGGcvUJGMt4X6nMK3cNdFs9IlfAsPF6M6efLVQ==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr971422pjo.171.1598304893436;
        Mon, 24 Aug 2020 14:34:53 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id na14sm417354pjb.6.2020.08.24.14.34.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 14:34:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C0C75F3E-F34B-4DB9-B139-C93694EF693D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B4C19C5C-A0E1-4B4F-A1FC-6EB055F4EF04";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v5 1/2] ext4: reorganize if statement of
 ext4_mb_release_context()
Date:   Mon, 24 Aug 2020 15:34:49 -0600
In-Reply-To: <5439ac6f-db79-ad68-76c1-a4dda9aa0cc3@gmail.com>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     brookxu <brookxu.cn@gmail.com>
References: <530dadc7-7bee-6d90-38b8-3af56c428297@gmail.com>
 <20200815133212.8D164A4057@d06av23.portsmouth.uk.ibm.com>
 <5439ac6f-db79-ad68-76c1-a4dda9aa0cc3@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B4C19C5C-A0E1-4B4F-A1FC-6EB055F4EF04
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Aug 17, 2020, at 1:36 AM, brookxu <brookxu.cn@gmail.com> wrote:
>=20
> Reorganize the if statement of ext4_mb_release_context(), make it
> easier to read.
>=20
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
> fs/ext4/mballoc.c | 27 +++++++++++++--------------
> 1 file changed, 13 insertions(+), 14 deletions(-)
>=20
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 70b110f..51f37f1 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4567,20 +4567,19 @@ static int ext4_mb_release_context(struct =
ext4_allocation_context *ac)
> 			pa->pa_free -=3D ac->ac_b_ex.fe_len;
> 			pa->pa_len -=3D ac->ac_b_ex.fe_len;
> 			spin_unlock(&pa->pa_lock);
> -		}
> -	}
> -	if (pa) {
> -		/*
> -		 * We want to add the pa to the right bucket.
> -		 * Remove it from the list and while adding
> -		 * make sure the list to which we are adding
> -		 * doesn't grow big.
> -		 */
> -		if ((pa->pa_type =3D=3D MB_GROUP_PA) && =
likely(pa->pa_free)) {
> -			spin_lock(pa->pa_obj_lock);
> -			list_del_rcu(&pa->pa_inode_list);
> -			spin_unlock(pa->pa_obj_lock);
> -			ext4_mb_add_n_trim(ac);
> +
> +			/*
> +			 * We want to add the pa to the right bucket.
> +			 * Remove it from the list and while adding
> +			 * make sure the list to which we are adding
> +			 * doesn't grow big.
> +			 */
> +			if (likely(pa->pa_free)) {
> +				spin_lock(pa->pa_obj_lock);
> +				list_del_rcu(&pa->pa_inode_list);
> +				spin_unlock(pa->pa_obj_lock);
> +				ext4_mb_add_n_trim(ac);
> +			}
> 		}
> 		ext4_mb_put_pa(ac, ac->ac_sb, pa);
> 	}
> --
> 1.8.3.1
>=20
>=20


Cheers, Andreas






--Apple-Mail=_B4C19C5C-A0E1-4B4F-A1FC-6EB055F4EF04
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9EMnkACgkQcqXauRfM
H+DINhAApbmuErKVkyGroY7x2EZI5rxfhDQWmJv+2wZ36zz7zNJDzmRdn4sCdgX0
piDJGS2K57tk7rjT0LReiNpe/dMjfF0LOgm7lgj1Qr20HDXVoo6C/D0qUW6AAKTD
NqiFNEAQxOeVEpw1+KjA2KNqpvQdeyF6cAAwxAZGqIqYF55LqnWhkRuTzLE86jKK
Xal+KHd4VoflZP6J7L1m5k9QIUXJqSWb//OxdPsPTP5cWKoW7BCv+4AGbXWvfcBb
KgFvTCLKgZGleo8qWW4mxzG1bduIQCT8yVEKaJx2RZgYZc1cGtRMTmyJH8J66ibY
4NMW83o5KPjhsOxB+mzujZb1sSrkLpgEtfH9MyzF0+81C5YdyBBJCEXrFoIjOQmn
dNNJzKmswURVpHTeeZ44sSRAxq5PpuKpcHJb1msRLo8/tyTH2qJKKW2jPXf0eNli
4LBL1NLSq84bCR2YTgBWrXa6CUeQxLvwRcfZzOreeA0G6Jwvr6lZwTOXLXXDko6b
0fIG/y5BpU62+rHd51AHG0GzbesN2hSwf5sxJKon5p02E+JlkFadww4NBfK1dUe7
Dt3WBHl9w3FFF4iubQaySy94KEweoWIGJhboCdTa9LH1yXNlkeOz5dzp7JHchk+F
xRVZbj/HpdI1txjxMfK5BzjkBzl1wB43cSoLzKeZhYkZ8Aa0aso=
=o8kZ
-----END PGP SIGNATURE-----

--Apple-Mail=_B4C19C5C-A0E1-4B4F-A1FC-6EB055F4EF04--
