Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30BD4163378
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Feb 2020 21:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgBRUuL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 15:50:11 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44086 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgBRUuL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 15:50:11 -0500
Received: by mail-pg1-f195.google.com with SMTP id g3so11394813pgs.11
        for <linux-ext4@vger.kernel.org>; Tue, 18 Feb 2020 12:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=+G+eoc5mkTLxz1bSNc4NNoti70scuP60FkRndfKzBj4=;
        b=vo/K2hzhfvXHq4THg2oXDBHqypA16maC5hGflZgtjPFBlLK+yfWOkXU+fduSZ4ftkJ
         u03qm/nMlrK0C4Z19t4gWl1UhkhctCjcJMB4FSd4y4+1syFhblOR6g6D3qsk6AYM++BG
         iVb0rSeEhIiadi+ZQswbdBIb4uOb2NDImYXtwwlEabo3fF9/q8OmBcgH4mlH6i0Nf/6d
         OKTN58w8ixb6rxRVq7z6czYCtRaXf6VoWlIZdoUxBb7AT61f1l+c+fZCwsOWg9MlphQl
         gN/BbVt7EyWDdH6JvFUF6iy9WEqWdeTfO0TDY9AdZbJzm/lKINoXzMXaSH8EqmeVovEG
         bWiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=+G+eoc5mkTLxz1bSNc4NNoti70scuP60FkRndfKzBj4=;
        b=SKLIKQu7m9a2CmfVRx4SrLJDFoaKBRvT53g59Y5fBn+yp40JeJzZmtxa8/jczAl0xb
         4zjfbtXWmRWgelc41k4uBQxIfFOOAP/c99fSbYEGz2ycbEtDRgMcdHdKMfvDTNfDmFcN
         C97krnE293dAKLbPCf54v0hf11DPSVkWA4fzyHlk+zkcKZZDtL/+L6QH59unQz3ZNIjZ
         88NkQxC/YtVFSyTyWWgLG2T6PWXeB4xQiind/Vw1QV+qghZdjzRg1WW04VqTdrLqwBy1
         WKVv2vn/AH41ptqcTIemxlIPtAxmLrLJcRU4pon1J+TA/gOFDcbFS72asKt4I0msGF4S
         thPw==
X-Gm-Message-State: APjAAAWp0+6PXcdL3E0lh+CwNByRcXDnqTQSl7ijWpScybH3s68VxpWt
        ym+QAI707gKS9HV+wibOBh1b1g==
X-Google-Smtp-Source: APXvYqxQSSyV8lu+Wus8apMBAzpilNG7zdLjyKq2fpXgb30+DbIef3z+WtQQpG9HibAjlgckREhakw==
X-Received: by 2002:a62:7bcb:: with SMTP id w194mr23619387pfc.216.1582059010537;
        Tue, 18 Feb 2020 12:50:10 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id a9sm4374491pjk.1.2020.02.18.12.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 12:50:09 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <7BA5024A-9600-4D2E-8D23-7A0F900BFE7F@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B5C03D74-E232-4A10-99EF-7BF0C436E71C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 7/7] tune2fs: Update dir checksums when clearing dir_index
 feature
Date:   Tue, 18 Feb 2020 13:50:33 -0700
In-Reply-To: <20200213101602.29096-8-jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
To:     Jan Kara <jack@suse.cz>
References: <20200213101602.29096-1-jack@suse.cz>
 <20200213101602.29096-8-jack@suse.cz>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B5C03D74-E232-4A10-99EF-7BF0C436E71C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Feb 13, 2020, at 3:16 AM, Jan Kara <jack@suse.cz> wrote:
>=20
> When clearing dir_index feature while metadata_csum is enabled, we =
have
> to rewrite checksums of all indexed directories to update checksums of
> internal tree nodes.
>=20
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>=20
> +#define REWRITE_EA_FL		0x01	/* Rewrite EA inodes */
> +#define REWRITE_DIR_FL		0x02	/* Rewrite directories =
*/
> +#define REWRITE_NONDIR_FL	0x04	/* Rewrite other inodes */
> +#define REWRITE_ALL (REWRITE_EA_FL | REWRITE_DIR_FL | =
REWRITE_NONDIR_FL)
> +
> +static void rewrite_inodes_pass(struct rewrite_context *ctx, unsigned =
int flags)
> {

My preference these days is to put constants like the above into a named
enum, and then use the enum as the argument to the function rather than
a very generic "int flags" argument.  That makes it clear to the reader
what values the flags may hold, and can immediately tag to the enum, =
like:

enum rewrite_inodes_flags {
	REWRITE_EA_FL	  =3D 0x01	/* Rewrite EA inodes */
	REWRITE_DIR_FL	  =3D 0x02	/* Rewrite directories */
	REWRITE_NONDIR_FL =3D 0x04	/* Rewrite other inodes */
	REWRITE_ALL	  =3D REWRITE_EA_FL | REWRITE_DIR_FL | =
REWRITE_NONDIR_FL
};

static void rewrite_inodes_pass(struct rewrite_context *ctx,
				enum rewrite_inodes_flags rif_flags)
static void rewrite_inodes(ext2_filsys fs, enum rewrite_inodes_flags =
rif_flags)
static void rewrite_metadata_checksums(ext2_filsys fs,
				       enum rewrite_inodes_flags =
rif_flags)

Otherwise, when looking at a function that takes "int flags" as an =
argument,
you have to dig through the code to see what kind of flags these are, =
and
what possible values they might have.  This is often even more confusing =
when
there are multiple different kinds of flags accessed within a single =
function
(not the case here, but happens often enough).

I'm not _against_ the patch, just thought I'd suggest an improvement and =
see
what people think about it.

Cheers, Andreas






--Apple-Mail=_B5C03D74-E232-4A10-99EF-7BF0C436E71C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl5MThoACgkQcqXauRfM
H+C3ig//e4Rgbo32k7eSrY+DRIVQ68FZPifzBjZ/O13I5ji89YVd+Hy9c0CgssZb
h2qTLIpjcXbtNNsGDI0Qg/Lh7TLhg7AIxFv8AsAudmJv8petoT786ibgfOaMzdkH
ePg02hGZ4GmW05iwWpryAAGzq/PBEz4GvCxyf+hUkRKs0STLDsPLdne2lW2xWyGM
pl5QeoE9WJdjcFeegrnwyNNPoAycO6qepjnHqROwNi6qbHCj3B3LO0pkqjPV4k+h
7RUxaLICIfU8QpAOc/gBqErl7iveCgdxBMh+sNuzbbhLlyHHUoQ2a1SiH/JeOFv8
mL+csDRrEAN+wBQ16Ncjhi9muYlt0KhWq8oLUFI0PWCGomIw51XlfhDtV3sXRM1g
Gpjs9hulVIOV62vfTsbwL3k5W1FOyrAP4S2J+YaYdjPa3RtBm3K40x7vcxvQh2CI
yKaj0H8YSzF/4zIQadNouvVygXR+oEAJLPMl6IJ5GI5jfnwlrKyDBY0KxvTSEN3+
sX6mXCVNLQnqdFv1KXudnOt3MFQxj7DOAx3qoA9J3h9i84nrpIKT1DPuKQYax3hy
o/iq54hs7jEA/tKT85mToVNt/7mkpRV9jbhzXSO7zmNl4dRWkSlBfZ3xUGNDmW3z
tiA+yEiqW3HvZ/xMDQrCzrOlvfUjGwzf12wJy7tTlQpVSBtQPLk=
=j6qi
-----END PGP SIGNATURE-----

--Apple-Mail=_B5C03D74-E232-4A10-99EF-7BF0C436E71C--
