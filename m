Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7F171FFF4D
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jun 2020 02:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFSAd4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Jun 2020 20:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFSAd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Jun 2020 20:33:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6ABC06174E
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 17:33:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id v14so3733490pgl.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jun 2020 17:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=GWq9hQj1oVAEsVH8UG7iKVK7PbU2/KDYlhxhMu6sEMw=;
        b=hMeh5FBPMArn9pHGGID0OppLi3aeM4esWFDzwVc6fJ14zl+re8h4Tvox+8eLvVRgh6
         H/LHYw9CRGU8A4G80r7vZHec0qX8AqaCIvj3lDLCRSLmNVTxKHIfoctVrv7RW3Oop5JX
         QeU3ZZGmsNOCV0HssF4tnqnHVKJniecCE46mVJpTerl1g9MHTxD1JDWRVodxHchlkLsg
         vt6zTI8PEBA//pxag+MModugfutGT+ujvfas5us1wErC3ujkJiXJub5qLUAHPIocuguw
         5RPLVHtLebTJeqsNRE4dNCm+LUmCi2uPHdp+2lP0+pfZmyrrp+hRbGg2mpHp2p5UTrfm
         UdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=GWq9hQj1oVAEsVH8UG7iKVK7PbU2/KDYlhxhMu6sEMw=;
        b=g6lZ5AZDAhPHwRWnpBh4I6X9ZHq+mKS1avsukJU48pQ+JUaOLnibLei1RQBPDTqBIX
         rJWjgmE8rP29o/2xEtSLU0+s3/M5uh5QAbgnzOw/f8IE51qqT3naJz5lTJCqzMA/qBl/
         gpAVt0A56HZY6Dn0b+gRfCxYoMAYlx8ybjN85Ae7iyjnTBLvVqbzz8vYWKlaKS5xKsJm
         Eh4gYFIgluYgEn8bitXxhjn95GSEJQVO25bawKduFgeGKNnu2jwRW33zJgqtW1tdUYJ8
         nEoPl9CZ/XZVQZznsUJHUzG2Sa9Pd7tOpUISxyK/B19atOgwGQ0LwD+UeemulX+IIbCU
         ol8A==
X-Gm-Message-State: AOAM532Af0JCb1e3FEo0tSjv1Utvf7fTO+93wdgaRrZevLh7JIjWgL6L
        tWqnGJ5hcEDBthONJwcLH3JxEQ==
X-Google-Smtp-Source: ABdhPJzweyXWVA7CRyFiO+7xGn51c5DpH756MAIJlERoLjMr9haMNmH7tmif5cDSX+YzA0iSGCfGHA==
X-Received: by 2002:a63:d848:: with SMTP id k8mr904088pgj.82.1592526834466;
        Thu, 18 Jun 2020 17:33:54 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id n69sm3823544pjc.25.2020.06.18.17.33.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jun 2020 17:33:53 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <9322DADB-8C6F-4595-AB6E-A92F627CDC82@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_A4FC813E-9D6C-4F8A-A294-89BD4933F8E2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 1/1] ext4: fix potential negative array index in
 do_split()
Date:   Thu, 18 Jun 2020 18:33:50 -0600
In-Reply-To: <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
Cc:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Eric Sandeen <sandeen@redhat.com>
References: <d08d63e9-8f74-b571-07c7-828b9629ce6a@redhat.com>
 <f53e246b-647c-64bb-16ec-135383c70ad7@redhat.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_A4FC813E-9D6C-4F8A-A294-89BD4933F8E2
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 17, 2020, at 1:19 PM, Eric Sandeen <sandeen@redhat.com> wrote:
>=20
> If for any reason a directory passed to do_split() does not have =
enough
> active entries to exceed half the size of the block, we can end up
> iterating over all "count" entries without finding a split point.
>=20
> In this case, count =3D=3D move, and split will be zero, and we will
> attempt a negative index into map[].
>=20
> Guard against this by detecting this case, and falling back to
> split-to-half-of-count instead; in this case we will still have
> plenty of space (> half blocksize) in each split block.
>=20
> Fixes: ef2b02d3e617 ("ext34: ensure do_split leaves enough free space =
in both blocks")
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Andreas Dilger <adilger@dilger.ca>

> ---
>=20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a8aca4772aaa..8b60881f07ee 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -1858,7 +1858,7 @@ static struct ext4_dir_entry_2 =
*do_split(handle_t *handle, struct inode *dir,
> 			     blocksize, hinfo, map);
> 	map -=3D count;
> 	dx_sort_map(map, count);
> -	/* Split the existing block in the middle, size-wise */
> +	/* Ensure that neither split block is over half full */
> 	size =3D 0;
> 	move =3D 0;
> 	for (i =3D count-1; i >=3D 0; i--) {
> @@ -1868,8 +1868,18 @@ static struct ext4_dir_entry_2 =
*do_split(handle_t *handle, struct inode *dir,
> 		size +=3D map[i].size;
> 		move++;
> 	}
> -	/* map index at which we will split */
> -	split =3D count - move;
> +	/*
> +	 * map index at which we will split
> +	 *
> +	 * If the sum of active entries didn't exceed half the block =
size, just
> +	 * split it in half by count; each resulting block will have at =
least
> +	 * half the space free.
> +	 */
> +	if (i > 0)
> +		split =3D count - move;
> +	else
> +		split =3D count/2;
> +
> 	hash2 =3D map[split].hash;
> 	continued =3D hash2 =3D=3D map[split - 1].hash;
> 	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
>=20
>=20


Cheers, Andreas






--Apple-Mail=_A4FC813E-9D6C-4F8A-A294-89BD4933F8E2
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl7sB+4ACgkQcqXauRfM
H+Aw5Q//V2VVirDRQx+jHGVeKywFA/brLzxEyJKfMT3E7Txi3Nv16HM4iPGpWTif
lzplhl/H5aHn6DyvW5rVAnMzSiq9SLFctfzpX1UYZYhNvsq1rd9f5dX3iLy4AVPl
UCJnp2EPjKd6WYBndj0w5hNa/P+goRZFERTOJH8NnG22+FnVrDnDZaSZqgWqWX+G
JZ4Ozx98fWsjbpUXff8pI5rvJKzWlOE9eN5uGYi7phGOszWpG28KIOzM8LDLiEBM
HJD+Acc9rkMzjN7/6+mG8Le7F26VnZ+wgFltRvvMrf92pYaZRfqZccOzO37MHmbi
L+6TULvXd7FGLROXdeAJp7J8ARyY+a/YOraf9xH/oekwn2DwZnbl1i/OWL5ppyuR
hCniZCICDooaBEwQEP0STI2YJtS9ABWiv+dwCsod3rOIupH7ARPEpDe87TJ7L+Su
60YPIdchYKs03WVC8OBkEEWkfgQie9Bzh79ves65Xp84sfwGlseWiqovIac/CcCo
Fl9EZML6HBqY1Q7Yz0moGWhwDJhywdzGs1jF0ZLlibXJIcazEt/CaReGDjNsvbS0
Pya3PMHPhEQQOGpTs2LAFS8JR25cTSCShuKX0IiRq4XHbX++sg3q1r6iRdVe+hZ6
mdc85nPKuhiLY1bJHKb0mOZ4oilNEIvAca8LPn75DqpqHt44qFw=
=MUns
-----END PGP SIGNATURE-----

--Apple-Mail=_A4FC813E-9D6C-4F8A-A294-89BD4933F8E2--
