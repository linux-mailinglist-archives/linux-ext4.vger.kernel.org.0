Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84B991A128B
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Apr 2020 19:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDGRVH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Apr 2020 13:21:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39575 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgDGRVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Apr 2020 13:21:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id k18so1488267pll.6
        for <linux-ext4@vger.kernel.org>; Tue, 07 Apr 2020 10:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=KFskH0SmggCEMwWDYLku8dqVUyaEcKQ6m089cNKv+uE=;
        b=GbE4vWLzSKO+EeAk6rJG4I/bCtVIxRwp0+2Mxu3p+/BS0Xzs3gAL8xwyiBD2+MN89k
         Ln1wuY2b6f0e5o1pz3pLC7+2GsRIyE0sjK4JvxryQOY2eHSLYbyrl+//AnB+v9K20OUu
         1/pYGDWNeNIZCrFT5ZzjmyCeNbXEGcm3eLQw7Etnh6J2iGbhz8FGfuKPfhB8aycW2xF0
         /UgN5bm6BqxiPbfWmuJvExANwQSZUFOl75nDA5rkj+pvpQSWc55kPDeRk9MIie+t0uac
         wEu09408Vzw2Xf+KVxjKR0clbnMFsqG4/w+lf7QgezVtbVYJAw6/5CyqtaoNWSrCIPiV
         Ik8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=KFskH0SmggCEMwWDYLku8dqVUyaEcKQ6m089cNKv+uE=;
        b=HcIMtuTbCeaab4Wmgzj0g/Ak22N0kW2a6cTMCwfVdVqZPTjO79H6gqKAVq69rtO9JK
         J5sjegS/0Y1rLCmeYgx8+SV4tc5mnpFoKwoWrotHy91DTGdMhsGEBrt2mHFfQ3st/ARu
         xtebhAIHP0wHEa/t5/n0A1ni+DpGYMzjQmXyV+2PgtbXyu5dzrqcyaSdyehokKYkwm4q
         f+wvOR2qN7JoVjOFJP3VyEVUNFqcBd1ETwHf52marsM47rHmMhC1+5qOJt/iBm4aavIN
         hxHjkP5g1zjqxtWjxcxJIlGmf8ZZWPb/H20pO912bR06iLCo/SRBWWbfiMkkymdwIYj8
         6kbw==
X-Gm-Message-State: AGi0PuYwfkdAoYQljOXa7N9xYkIkcsdfiEuTsWTZr0ODiCPahAAcjdrI
        8JnWEfHnqJT1LklmFg0lLdOZxVZLXwI=
X-Google-Smtp-Source: APiQypInUBZrG5UYrQAasY792NZF+WREcCKNDFv3rJzAqS6abVKuwa0cEP7BR6M9uIaCbYGiS2WFpg==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr460123pjn.34.1586280065003;
        Tue, 07 Apr 2020 10:21:05 -0700 (PDT)
Received: from [192.168.10.160] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a127sm14518948pfa.111.2020.04.07.10.21.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 10:21:03 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <BFC2DE9E-82FA-4F76-9BD2-B505324F3557@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_0F36E968-5522-4059-B18F-A5654D9A0571";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using
 is_dirent_block_empty
Date:   Tue, 7 Apr 2020 11:21:01 -0600
In-Reply-To: <20200407064616.221459-3-harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Jan Kara <jack@suse.cz>
References: <20200407064616.221459-1-harshadshirwadkar@gmail.com>
 <20200407064616.221459-3-harshadshirwadkar@gmail.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_0F36E968-5522-4059-B18F-A5654D9A0571
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 7, 2020, at 12:46 AM, Harshad Shirwadkar =
<harshadshirwadkar@gmail.com> wrote:
>=20
> The new function added in this patchset adds an efficient way to
> check if a dirent block is empty. Based on that, reimplement
> ext4_empty_dir().
>=20
> This is a new patch added in V2.
>=20
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Again, a very minor style change iff patch is refreshed.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>


While looking at this code, I noticed that ext4_empty_dir() considers a
directory without a "." or ".." entry to be empty.  I see this was =
changed
in 64d4ce8923 ("ext4: fix ext4_empty_dir() for directories with holes").
I can understand that we want to not die on corrupted leaf blocks, but =
it
isn't clear to me that it is a good idea to allow deleting an entire
directory tree if the first block has an error (missing "." or ".." as =
the
first and second entries) but is otherwise valid.  There were definitely
bugs in the past that made "." or ".." not be the first and second =
entries.

That isn't a problem in this patch, but seems dangerous in general.  It
doesn't seem like the directory shrinking would trigger this case, since =
it
is checking for individual empty blocks rather than using =
ext4_empty_dir().

> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> @@ -3218,34 +3219,26 @@ bool ext4_empty_dir(struct inode *inode)
> 		brelse(bh);
> 		return true;
> 	}
> +	de =3D ext4_next_entry(de, sb->s_blocksize);
> +	if (!is_empty_dirent_block(inode, bh, de)) {
> +		brelse(bh);
> +		return false;
> +	}
> +	brelse(bh);
> +
> +	for (lblk =3D 1; lblk < inode->i_size >> =
EXT4_BLOCK_SIZE_BITS(sb);
> +			lblk++) {

(style) should be aligned after '(' on previous line

> +		bh =3D ext4_read_dirblock(inode, lblk, EITHER);
> +		if (bh =3D=3D NULL)
> 			continue;
> -		}
> -		if (le32_to_cpu(de->inode)) {
> +		if (IS_ERR(bh))
> +			return true;
> +		if (!is_empty_dirent_block(inode, bh, NULL)) {
> 			brelse(bh);
> 			return false;
> 		}
> -		offset +=3D ext4_rec_len_from_disk(de->rec_len, =
sb->s_blocksize);
> +		brelse(bh);
> 	}
> -	brelse(bh);
> 	return true;
> }

Cheers, Andreas






--Apple-Mail=_0F36E968-5522-4059-B18F-A5654D9A0571
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl6Mtn0ACgkQcqXauRfM
H+Ay3BAAuf9cNqYO6j9OpQk5vuS9lmKkevgiwYH8znhwDmLyjtNkDM4pSbCsPr84
mU8Gyflbqg3zNZbMRVi5Glr6B6ZSMQltXACksE5VGjjGW8uvzNMUtQLwJVvb20OW
SuCJt91Z9BWSUMAcMQwYHLqQrttqcEogiYm10lHPwMUnqnVqSCdjvxtFx+lvK0HJ
nt7N/n1nPBfHuCdH6dgyomGMD0dmIIv28P6ynHqus7MU130z/Wtj22CQn4kzGdeA
an4Mh8pZ7tI5GO5Kf8K8vUtwepAB/ITdDyRgXLsNUqH0nE8qhCxXCeGNs2jY5ToA
AHucg3Gj9mDfQ6wD2IH2Jp6QHoPnVvbku5/oC4pLXE9jO0aTz9VsunMbKRYnz96Z
SNg1gMpo/txXszvcsdGYa/iehQI+qd6hYIDimZcVp6M5E3k4ixwiXjmVgWslgH1U
6xIyNBDiZUgpuqhclhm5zmxjsY/T8+UriWoj6XUb6k8w+knRP68tQ5fLCPYG/Cc7
XbQkJX+kpc/ARj1BjGhx4Mzy3gaez1fZDy+9tA2PCCd+lJtATP8E6CX4CIKrjZR9
ph4xp99uLt+vFmGhiY6k3NaBmnqyT+HUXU1u97Huvbzlr6ovuIXq+dsQRJ0JhHi3
QQ6pWkw/k9bYJA33ipE4TbHJE9HCRC7dTAA07v83qGnGEkAjnOE=
=R+wy
-----END PGP SIGNATURE-----

--Apple-Mail=_0F36E968-5522-4059-B18F-A5654D9A0571--
