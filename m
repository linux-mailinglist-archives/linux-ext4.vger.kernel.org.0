Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AEA413CAD
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Sep 2021 23:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbhIUVlb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Sep 2021 17:41:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbhIUVlZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Sep 2021 17:41:25 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285DEC061757
        for <linux-ext4@vger.kernel.org>; Tue, 21 Sep 2021 14:39:56 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id v2so333456plp.8
        for <linux-ext4@vger.kernel.org>; Tue, 21 Sep 2021 14:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=c7M3fa44AB91g/z5IbKpu9IKP6NM85qHUDvEcNGks/w=;
        b=5FzTzPvRfPn8+9Ly7Y3Uju58psmKdW10BVh1xehG5GUyFI5zZ6yGeBwhjyNQ/P8wIx
         l6wbrBHW+JvqUo7Be1adxbMJpkDQYL2vD9Kdv+lBvprClv5Jv2DyvsTZEPDVCDCMhfKW
         byBxPE7j18KrsVG5m3tAcy6D7Mj68VVaO+lzSx/BPa8Wn+w8m1EqI2LuFh3XZNqguCXn
         707JpoOMKhTfbVYfoaE3q+M1kbScUvww3eM4GOPauckGmSBy+Tysg2AbGK6HVJ8S8lcc
         DdEeXTPR6KHB1ryszOmapKnXV0QUrtseQSiRcVAT7esBPOFzvNZ7XqW/23Zwquf+r3Xw
         Dwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=c7M3fa44AB91g/z5IbKpu9IKP6NM85qHUDvEcNGks/w=;
        b=GSaJwAotQp+aL0VhblPSqNGduUHTOqJ5ilFun6e6zkvrt9bt056h8urwjQ/AMvM+oL
         UWpySXvlPyRWBjNB5Ra9dFPr64+R9VDD/3BtwUFwgS0uraSdASkVblCqG3My/0l0ULbV
         rPs3AXOjan7mirXQBFtBzqLQd+jlmhWpMrNedMkFsKmOj/ByGnXk9vSbX1W7TmG+bnlV
         4CZlqAk251xuPGewzbkHflXhN+weYVGRJAeir9+ejpze5DFzFVtsn3m5ka1xjPmAbEoC
         S/sdTAh2ZflzZmHOCUC4AM/W1ZSSBkYPiU/R1zuZxFiKfFqk4ghh4qAqLoLHeI/HhRXh
         VOQQ==
X-Gm-Message-State: AOAM532X3I7KmlYprc+xiXNvi2B94I1VCYjuSt96zVlcvd8zG/22RTs/
        m7ZTbnYS8T/HvR1PXbQVi4lobA==
X-Google-Smtp-Source: ABdhPJyPOiyBJjsxWuTjUQA2H8UCdfgKacb3wt66S9f21zqWrRZX/GJ1cZvB2OoG1eb4v5bo2RVYiA==
X-Received: by 2002:a17:90a:1991:: with SMTP id 17mr7642332pji.149.1632260395314;
        Tue, 21 Sep 2021 14:39:55 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id g19sm3513588pjl.25.2021.09.21.14.39.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Sep 2021 14:39:54 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_6CCBD42F-B0CC-4F3D-9FCF-7D7ABE34EDF1";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] mke2fs: Add extended option for prezeroed storage devices
Date:   Tue, 21 Sep 2021 15:39:51 -0600
In-Reply-To: <20210921034203.323950-1-sarthakkukreti@google.com>
Cc:     linux-ext4@vger.kernel.org, gwendal@chromium.org, tytso@mit.edu
To:     Sarthak Kukreti <sarthakkukreti@chromium.org>
References: <20210921034203.323950-1-sarthakkukreti@google.com>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_6CCBD42F-B0CC-4F3D-9FCF-7D7ABE34EDF1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 20, 2021, at 9:42 PM, Sarthak Kukreti =
<sarthakkukreti@chromium.org> wrote:
>=20
> From: Sarthak Kukreti <sarthakkukreti@chromium.org>
>=20
> This patch adds an extended option "assume_storage_prezeroed" to
> mke2fs. When enabled, this option acts as a hint to mke2fs that
> the underlying block device was zeroed before mke2fs was called.
> This allows mke2fs to optimize out the zeroing of the inode
> table and the journal, which speeds up the filesystem creation
> time.
>=20
> Additionally, on thinly provisioned storage devices (like Ceph,
> dm-thin),

... and newly-created sparse loopback files

> reads on unmapped extents return zero. This property
> allows mke2fs (with assume_storage_prezeroed) to avoid
> pre-allocating metadata space for inode tables for the entire
> filesystem and saves space that would normally be preallocated
> for zero inode tables.
>=20
> Testing on ChromeOS (running linux kernel 4.19) with dm-thin
> and 200GB thin logical volumes using 'mke2fs -t ext4 <dev>':
>=20
> - Time taken by mke2fs drops from 1.07s to 0.08s.
> - Avoiding zeroing out the inode table and journal reduces the
>  initial metadata space allocation from 0.48% to 0.01%.
> - Lazy inode table zeroing results in a further 1.45% of logical
>  volume space getting allocated for inode tables, even if not file
>  data is added to the filesystem. With assume_storage_prezeroed,
>  the metadata allocation remains at 0.01%.

This seems beneficial, but I'm wondering if this could also be
done automatically when TRIM/DISCARD is used by mke2fs to erase
a device?

One safe option to do this automatically would be to start by
*reading* the disk blocks and check if they are all zero, and only
switch to zero-block writes if any block is found with non-zero
data.  That would avoid the extra space usage from zero-block
writes in the above cases, and also work for the huge majority of
users that won't know the "assume_storage_prezeroed" option even
exits, though it won't necessarily reduce the runtime.

> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index 04b2fbce..5293d9b0 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -3095,6 +3102,18 @@ int main (int argc, char *argv[])
> 		io_channel_set_options(fs->io, opt_string);
> 	}
>=20
> +	if (assume_storage_prezeroed) {
> +	  if (verbose)
> +			printf("%s",
> +				       _("Assuming the storage device is =
prezeroed "
> +                         "- skipping inode table and journal =
wipe\n"));
> +
> +	  lazy_itable_init =3D 1;
> +	  itable_zeroed =3D 1;
> +	  zero_hugefile =3D 0;
> +	  journal_flags |=3D EXT2_MKJOURNAL_LAZYINIT;
> +	}

Indentation appears to be broken here - only 2 spaces instead of a tab.

This is also missing any kind of test case.  Since a large number of
the e2fsck test cases are using loopback filesystems created on a sparse
file, this would both be good test cases, as well as reducing time/space
used during testing.

Cheers, Andreas






--Apple-Mail=_6CCBD42F-B0CC-4F3D-9FCF-7D7ABE34EDF1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmFKUScACgkQcqXauRfM
H+DN6g/7BhgD6+brPgKGGJrpuHJXA9JgssbDTY5yUjF9oR0mxf8Zv5Cl6SAONX90
iV3QK9BJlCdwauBES50mo6x5sfSVIb+OZiw7h5O+RbdDffWixbGf1ehW3oDdKL3Y
Tpg2iopVw7hTD4SBIsf3yCosEegWIpZbXijC9iw30Sc5BUshDuwRdzeLocDmSR5K
Muj3xFaQZaqU56q/F8uTVdG9PU/t7mCCH2Ibm9rA7MEHoc0ByVQsGWKfsuRiXpt/
MGg3bEqwfjZy53AYLKxAmQL5QfQ7Vfk02/xkAaklP9Gr4gCanQTH7NmFKE9hlGVT
2ysULMrC+IczOAkyxu8YqV6yMfcwVVZwon6QYz6IWIVVpu6aA8B5ts3GLy00JeH/
gfCisnEUEA99GmqfsCYIKRUoXUfCL0hVE/YcjENQ3Y2JC8q3wEG0ZoQpyHEyPecX
/cDI3JAoNkO5dUMBQ9qWGjvETTz93dDixrmyW6ucUJnBpYurEKO/Azad88uRzwHl
YiirE56o8ssIDz8/88KKejNgJ3+Oyoy6nboXkISuUK0nsb8rmRwF++YYSLXwYaUo
GtValeSqbSmzvntgnDx67idrs8V+9vho/8qLhMw5WzTystIvTEDmeVF8KmgWEogK
kTyq2TOC2XdNcMeKxvGPvuGVHkI67paykSREbOQaVICBvtPA7Wg=
=poiY
-----END PGP SIGNATURE-----

--Apple-Mail=_6CCBD42F-B0CC-4F3D-9FCF-7D7ABE34EDF1--
