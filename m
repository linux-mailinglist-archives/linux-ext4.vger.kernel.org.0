Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B982E358FAA
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Apr 2021 00:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbhDHWLz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 18:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhDHWLw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 18:11:52 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0768CC061761
        for <linux-ext4@vger.kernel.org>; Thu,  8 Apr 2021 15:11:40 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id a12so2867934pfc.7
        for <linux-ext4@vger.kernel.org>; Thu, 08 Apr 2021 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=C80Mo1mdqkfUGzCOjeM9jPvl7FbavRoAbteSG3nDKMU=;
        b=rS/7l9KUqbfhS64Mq/5Qz9Jhdr8BRjcDNm+1amDclct1i2KnmhNjXcUh8aN7mX3u8M
         wjfDVLZQqCuiCNFc5c0Slf7gUKqlgjMtaQU3Zc0spp+8aA32iBOdj/OV+4FQACsikJMZ
         mUHw0I00Nd/k1Lqjq3q9aMcyAqqKI4ZiDzC5+oOMB4dldqPf5Y3o6B67YN730ibF5acE
         jQDA4JoXl3Wrh9hr7OHCEPasvgjIzS8B3A/p4BJ4co47vaLcZsNq5Mwr/bQn4Dspy3o9
         tQ2za3fY6QjFRWrwq5KXcPQ33yJ5CvelYARobVFQHZdU7Izyu6wpWi2rJyohVr1ASYrB
         sttg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=C80Mo1mdqkfUGzCOjeM9jPvl7FbavRoAbteSG3nDKMU=;
        b=dY+yGjcjjdIybwkSaXten/OAZW23GRDCS2DLkVJMnxWOQdw9lpNzp12fhsXgKEEn3b
         wfR/3327jhcC+hb6RmtLU679kWydb9CtNlzbT3FS+D1VV/+fuOD5Am/SsaZ+l2346VYv
         pAmUB0DXRKQ3iVQDrkHEJScLUA30TX4n2hxJDAx5SS+tlCZmBDscb30jIVHWQE138vjq
         iXvvfqm+RzbisXvGbO2NN2DQGjIIQPilP0cbof4yUE5S2Y7jAl0Up2fgYYtCE0UXaQUO
         NGG/kNqOEq2fNYM0t2wuorJKLwgbbRgtGA5rgIsgMk/bZvYDpYAEIyteldMi/QYmQ3Mf
         eHqQ==
X-Gm-Message-State: AOAM532oadV3RnOQ2lHWYtm/Dlq+EYDEx0VwlRDNTcdfxRGYyf6Huno2
        P9qvdnpbA5CH7IzZqniNy3kGXg==
X-Google-Smtp-Source: ABdhPJwAa3SieigGGLEnrtdfc36+sjUyYL+38gcWbf35dtujOWs9Zg3K7/9GvsbAxjWqreysl0P0hQ==
X-Received: by 2002:a63:da0a:: with SMTP id c10mr10029888pgh.255.1617919899485;
        Thu, 08 Apr 2021 15:11:39 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w17sm368136pfu.29.2021.04.08.15.11.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Apr 2021 15:11:38 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <F46B045A-D207-409A-ACD0-956851B46D6D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1B86BAB9-1EB2-4BD6-AD04-3C4C7927E3D8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Date:   Thu, 8 Apr 2021 16:11:35 -0600
In-Reply-To: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
Cc:     riteshh@linux.ibm.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        baoyou.xie@alibaba-inc.com
To:     Wen Yang <wenyang@linux.alibaba.com>
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1B86BAB9-1EB2-4BD6-AD04-3C4C7927E3D8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 8, 2021, at 12:50 PM, Wen Yang <wenyang@linux.alibaba.com> wrote:
>=20
> Hi Ritesh and Andreas,
>=20
> Thank you for your reply. Since there is still a faulty machine, we =
have analyzed it again and found it is indeed a very special case:
>=20
>=20
> crash> struct ext4_group_info ffff8813bb5f72d0
> struct ext4_group_info {
>  bb_state =3D 0,
>  bb_free_root =3D {
>    rb_node =3D 0x0
>  },
>  bb_first_free =3D 1681,
>  bb_free =3D 0,
>  bb_fragments =3D 0,
>  bb_largest_free_order =3D -1,
>  bb_prealloc_list =3D {
>    next =3D 0xffff880268291d78,
>    prev =3D 0xffff880268291d78     ---> *** The list is empty
>  },
>  alloc_sem =3D {
>    count =3D {
>      counter =3D 0
>    },
>    wait_list =3D {
>      next =3D 0xffff8813bb5f7308,
>      prev =3D 0xffff8813bb5f7308
>    },
>    wait_lock =3D {
>      raw_lock =3D {
>        {
>          val =3D {
>            counter =3D 0
>          },
>          {
>            locked =3D 0 '\000',
>            pending =3D 0 '\000'
>          },
>          {
>            locked_pending =3D 0,
>            tail =3D 0
>          }
>        }
>      }
>    },
>    osq =3D {
>      tail =3D {
>        counter =3D 0
>      }
>    },
>    owner =3D 0x0
>  },
>  bb_counters =3D 0xffff8813bb5f7328
> }
> crash>
>=20
>=20
> crash> list 0xffff880268291d78  -l ext4_prealloc_space.pa_group_list =
-s ext4_prealloc_space.pa_count
> ffff880268291d78
>  pa_count =3D {
>    counter =3D 1      ---> ****pa->pa_count
>  }
> ffff8813bb5f72f0
>  pa_count =3D {
>    counter =3D -30701
>  }
>=20
>=20
> crash> struct -xo  ext4_prealloc_space
> struct ext4_prealloc_space {
>   [0x0] struct list_head pa_inode_list;
>  [0x10] struct list_head pa_group_list;
>         union {
>             struct list_head pa_tmp_list;
>             struct callback_head pa_rcu;
>  [0x20] } u;
>  [0x30] spinlock_t pa_lock;
>  [0x34] atomic_t pa_count;
>  [0x38] unsigned int pa_deleted;
>  [0x40] ext4_fsblk_t pa_pstart;
>  [0x48] ext4_lblk_t pa_lstart;
>  [0x4c] ext4_grpblk_t pa_len;
>  [0x50] ext4_grpblk_t pa_free;
>  [0x54] unsigned short pa_type;
>  [0x58] spinlock_t *pa_obj_lock;
>  [0x60] struct inode *pa_inode;
> }
> SIZE: 0x68
>=20
>=20
> Before "goto repeat", it is necessary to check whether =
grp->bb_prealloc_list is empty.  This patch may fix it.
> Please kindly give us your comments and suggestions.
> Thanks.

This patch definitely looks more reasonable than the previous one, but
I don't think it is correct?

It isn't clear how the system could get into this state, or stay there.

If bb_prealloc_list is empty, then "busy" should be 0, since busy =3D 1
is only set inside "list_for_each_entry_safe(bb_prealloc_list)", and
that implies the list is *not* empty?  The ext4_lock_group() is held
over this code, so the list should not be changing in this case, and
even if the list changed, it _should_ only affect the loop one time.

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 99bf091..8082e2d 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4290,7 +4290,7 @@ static void ext4_mb_new_preallocation(struct =
ext4_allocation_context *ac)
>        free_total +=3D free;
>=20
>        /* if we still need more blocks and some PAs were used, try =
again */
> -       if (free_total < needed && busy) {
> +       if (free_total < needed && busy && =
!list_empty(&grp->bb_prealloc_list)) {
>                ext4_unlock_group(sb, group);
>                cond_resched();
>                busy =3D 0;
>                goto repeat;

Minor suggestion - moving "busy =3D 0" right after "repeat:" and =
removing
the "int busy =3D 0" initializer would make this code a bit more clear.

Cheers, Andreas




--Apple-Mail=_1B86BAB9-1EB2-4BD6-AD04-3C4C7927E3D8
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmBvf5cACgkQcqXauRfM
H+CJaRAAsJW5zFKob3DjTlJ4M08Edj43NqNjQANTCX2ftnwWuPYLKyssYkM98pSJ
yMWR+Hy34sOUBnB5gk2TCAsyQm0QE5yz/7AY/yA0ddctd01Q07X1/qmzL+p7O/sQ
TO0dUl4ogApeOnJ+bYi1HkqX7akYaX4AnQ609t5NzmjsHobMdptBk2GTB3M9NKex
Lpho0po1tPful85luF9wg2JFVNduFrYngktU4UL24KSzavwb7C02+eXXh716UGCZ
7oqtBaknmMO7lJWwmYJH+/XAVoU6+jPtYdV/YvEDcSUStx1MpA1TNS9jQ4c6tskc
n+uiiG7kjE8OIdL6Rt7uLcxY9jVYNPCAsTFU5hg/CeYS5X6PoKDHSea9tabOxvJV
ssbz1nKXSVhSF5eceMvsygewQHzpKiHwnAdWN/Pj8i6K3WjwUHlWNOcnS8roQo53
UDpn3ZJ3xLuB1afxZCCYZVqOYKY5nC4dm63dGnKilpFeBD7zN4YaYUg0nrKZzlQS
C8njKgq6iZhHb8e1mYWSdx/SoCn0kndENDS0UkWGySGiaepzIEWNfNJQfD7XQpXV
s7/rluDQMVLBJjQd5soLy16lgDNxfhae0HMq6mvN/Tqp4RrGQ3GAwD+su0lqoH92
nTA/IXlTaKvm4r30KSWS4FHj0nMZMND62oknIvywHdpsph7AIoY=
=eiw9
-----END PGP SIGNATURE-----

--Apple-Mail=_1B86BAB9-1EB2-4BD6-AD04-3C4C7927E3D8--
