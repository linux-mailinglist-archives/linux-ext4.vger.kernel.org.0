Return-Path: <linux-ext4+bounces-2531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6718C71C0
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 08:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C86C1F21B1A
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2024 06:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD4D29424;
	Thu, 16 May 2024 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b="ePPEY0xN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mister-muffin.de (mister-muffin.de [144.76.155.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC417282F4
	for <linux-ext4@vger.kernel.org>; Thu, 16 May 2024 06:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.155.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715842624; cv=none; b=uRazNaEvTGi2NgYb26vfUvLRhORMjjZYyO7B6jXnrISgHWpF+SiHXz5P1WSB5hIUejeNyMUSrDmU0eTSoNO8s8s46AMWkKlq5sP68+/iyvK0/hIvUExxPbtgDWW+v39eaF9rFqRVbjm2LOPpp02boedfK+VQg6oWA4Kw1C0zXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715842624; c=relaxed/simple;
	bh=4LTcZI3NtyKLMF6ajqsiX6Md9k9+SZrxBjaSiG1EoLg=;
	h=Content-Type:MIME-Version:Content-Disposition:In-Reply-To:
	 References:Subject:From:Cc:To:Date:Message-ID; b=qDBcBVapc2vpQmTz7StYFb+LQUPmbz4tDHjsJQeRo+JKXR5GBCTrlRviihsrL/MgYHVXT+aR/5XgWZoBSz+abSBpsWYv0g9OELzdf/TaECKV56JTdW01ZyhpqG2enxEZpERTbjCaCHZqBR/imWhhPQ7QmgC+eEbIPB6o3QBQ4Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de; spf=pass smtp.mailfrom=mister-muffin.de; dkim=pass (1024-bit key) header.d=mister-muffin.de header.i=@mister-muffin.de header.b=ePPEY0xN; arc=none smtp.client-ip=144.76.155.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mister-muffin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mister-muffin.de
Received: from localhost (ip2504e6e1.dynamic.kabel-deutschland.de [37.4.230.225])
	by mister-muffin.de (Postfix) with ESMTPSA id B48192B8;
	Thu, 16 May 2024 08:56:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mister-muffin.de;
	s=mail; t=1715842612;
	bh=4LTcZI3NtyKLMF6ajqsiX6Md9k9+SZrxBjaSiG1EoLg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ePPEY0xNyXG214l+Xu8/qvpsjY/3W7n5xEwrRgNjHt9sqN7WH0QUc10lPQFNRjJDu
	 FwMuPxuAg4olawo1FuYQix5UYXnNTBtbH+ogvoDVG0fxOPqJGdkxNldJeN7s3oSFfB
	 yG2t82fH3VrJA1nVsyMTk5RH45xerFkhuJomCAk8=
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="===============3049226928662926417=="
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240511211111.GA8330@mit.edu>
References: <171483317081.2626447.5951155062757257572@localhost> <171484520952.2626447.2160419274451668597@localhost> <20240505001020.GA3035072@mit.edu> <171540568260.2626447.10970955416649779876@localhost> <20240511211111.GA8330@mit.edu>
Subject: Re: created ext4 disk image differs depending on the underlying filesystem
From: Johannes Schauer Marin Rodrigues <josch@mister-muffin.de>
Cc: linux-ext4@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Date: Thu, 16 May 2024 08:56:52 +0200
Message-ID: <171584261210.153302.13800498533021477492@localhost>
User-Agent: alot/0.10

--===============3049226928662926417==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ted,

Quoting Theodore Ts'o (2024-05-11 23:11:11)
> On Sat, May 11, 2024 at 07:34:42AM +0200, Johannes Schauer Marin Rodrigue=
s wrote:
> >  2. allow resetting fs->super->s_kbytes_written to zero. This patch wor=
ked for
> >     me:
> >=20
> > Would you be happy about a patch for (2.)? If yes, I can send something=
 over
> > once I find some time. :)
> >=20
>=20
> I'm currently going back and forth about whether we should just (a)
> unconditionally set s_kbytes_writes to zero before we write out the
> superblock, or (b) whether we add a new extended operation, or (c) do
> a hack where if SOURCE_DATE_EPOCH is set, use that as implied "set
> s_kbytes_written to zero since the user is probably caring about a
> reproducible file system".
>=20
> (c) is a bit hacky, but it's the most convenient for users, and adding
> Yet Another extended operation.

when changing defaults in my own software I try to think about if and if yes
how users will be able to change that default to get back to how it was bef=
ore
because xkcd #1172 is very real. Your options a) and c) do not give users a=
 way
to tell mke2fs that yes, they *do* want their filesystem to record how much=
 was
written to it during its creation. Even somebody who uses SOURCE_DATE_EPOCH=
 to
get reproducible output might have this need. Now you can argue "but users =
who
want this will be very very rare" and i will not disagree but then i think =
the
need to set s_kbytes_writes to zero because i want reproducible images when
creating an ext4 file system image on top of 9p fs is also very, very rare.=
 And
then I look at option b) which is not nice but isn't it okay to have a
cumbersome option for people in very niche situations?

> Related to this is the design question about whether SOURCE_DATE_EPOCH sh=
ould
> imply using a fixed value for s_uuid and s_hash_seed.  Again, it's a litt=
le
> weird to overload SOURCE_DATE_EPOCH to setting the uuid and hash_seed to =
some
> fixed value, which might be a time-based UUID with the ethernet address s=
et
> to all zeroes, or some other fixed value.  But it's a pretty good proxy of
> what the user wants, and if this is this is the default, the user can alw=
ays
> override it via an extended option if they really want something differen=
t.

Beware that generating a fitting uuid can quickly become not so fun anymore=
 if
you want to follow the relevant RFC instead of "just making something up". =
I've
had a talk with the reproducible builds people about this issue as I was
looking for prior art on how to turn a SOURCE_DATE_EPOCH into a predictable
uuid and I was told that the proper way would be to first generate a versio=
n 5
uuid using a DNS name you control and then use that uuid as the namespace f=
or
another uuid together with SOURCE_DATE_EPOCH. It was then discussed whether=
 the
reproducible builds team should formalize a method to turn a SOURCE_DATE_EP=
OCH
into a uuid and document it and how that should be done but it seems to be
tricky to do it right if one wants to follow the relevant RFCs to the lette=
r.

> If it weren't for the fact that I'm considering have SOURCE_DATE_EPOCH
> provide default values for s_uuid and s_hash_seed, I'd be tempted to just
> unconditionally set the s_kbytes_written to zero.
>=20
> I'm curious what your opinions might be on this, as someone who might
> want to use this feature.

Not only "might want to use this" but "actively using it":

https://tracker.debian.org/news/1529763/accepted-mmdebstrap-150-1-source-in=
to-unstable/

As the mmdebstrap upstream author, I would have no problem with mke2fs sett=
ing
s_uuid and s_hash_seed to some reproducible value by default. As you said, =
any
user who doesn't like this can always run mke2fs manually and because
mmdebstrap writes tarballs to stdout, adding custom mke2fs options is really
easy:

mmdebstrap | mke2fs -d - -U $(uuidgen) -E hash_seed=3D$(uuidgen) ...

That being said, I'm not aware of anybody else requiring bit-by-bit
reproducible ext4 images. I never got bit-by-bit reproducible output to work
when using an unpacked filesystem directory as the source for mke2fs. But I=
'm
at MiniDebConf Berlin this week and just yesterday I met somebody from the
Debian Cloud team who said that they are interested in this functionality. I
shall make them aware of this thread today and maybe they have some further
input.

> > As an end-user I am very interested in keeping the functionality of mke=
2fs
> > which keeps track of which parts are actually sparse and which ones are
> > not.  This functionality can be used with tools like "bmaptool" (a more
> > clever dd) to only copy those parts of the image to the flash drive whi=
ch
> > are actually supposed to contain data.
> If the file system where the image is created supports either the FIEMAP
> ioctl or fallocate SEEK_HOLE, then "bmaptool create" can figure out which
> parts of the file is sparse, so we don't need to make any changes to
> e2fsprogs.  If the file system doesn't support FIEMAP or SEEK_HOLE, one c=
ould
> imagine that bmaptool could figure out which parts of the file could be
> sparse simply by looking for blocks that are all zeroes.  This is basical=
ly
> what "cp --sparse=3Dalways" or what the attached make-sparse.c file does =
to
> determine where the holes could be.
>=20
> Yes, I could imagine adding a new io_manager much like test_io and
> undo_io which tracked which blocks had been written, and then would
> write out a BMAP file.  However, the vast majority of constructed file
> systems are quite small, so simply reading all of the blocks to
> determine which blocks were all zeroes ala cp --sparse=3Dalways isn't
> going to invole all that much overhead.  And I'd argue the right thing
> to do would be to teach bmaptool how to do what cp --sparse=3Dalways so
> that the same interface regardless of whether bmaptool is running on a
> modern file system that supports FIEMAP or SEEK_HOLE, or some legacy
> file system like FAT16 or FAT32.

Thank you for your make-sparse.c. I was wondering whether it is really as
simple as finding all 1024 byte blocks that are all zeros and then skipping
them with lseek, creating a "hole". I imagined that maybe there were some
potential issues of the sort that when my filesystem is part of a disk image
together with a partition table, then maybe due to at what offset the
filesystem is stored on that image or what expectations ext4 or other
filesystems on that image have, there could be situations when it really *i=
s*
necessary to write 1024 consecutive zeroes to my flash drive. At the time t=
hat
I was pondering about this, I used fallocate --dig-holes to turn a disk ima=
ge I
had into a sparse one and this made fsck report problems in the filesystem =
that
it was not able to fix. I didn't investigate this further.

My need to "dig holes" did not come from the underlying filesystem being a =
dumb
one like fat or 9p but because it turns out that copying an ext4 image onto=
 a
disk image with an offset while preserving its sparse-ness is not something=
 dd
(or any similar utility I found) was able to do. So at the end of this mail=
 is
the program I am now using to copy the output of mke2fs (which is sparse) o=
nto
my disk image while preserving all the holes created by mke2fs exactly as
mke2fs decided they should be placed. After flashing this to a SD-Card whic=
h I
filled with random bytes before, the resulting system booted fine and fsck =
did
not report any issues. Assuming that the underlying filesystem is smart, I
imagine that simply preserving the holes is the safer option than digging n=
ew
ones.

Thanks!

cheers, josch




#define _GNU_SOURCE
#define _LARGEFILE64_SOURCE
#include <sys/types.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


int main(int argc, char *argv[]) {
    if (argc !=3D 3 && argc !=3D 4) {
        fprintf(stderr, "Usage: %s infile outfile [offset]\n", argv[0]);
        exit(EXIT_FAILURE);
    }
    int infd =3D open(argv[1], O_RDONLY);
    if (infd =3D=3D -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }
    off64_t inlength =3D lseek64(infd, 0, SEEK_END);
    if (inlength =3D=3D -1) {
        perror("lseek64");
        exit(EXIT_FAILURE);
    }
    int outfd =3D open(argv[2], O_CREAT | O_WRONLY);
    if (outfd =3D=3D -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }
    off64_t outlength =3D lseek64(outfd, 0, SEEK_END);
    if (outlength =3D=3D -1) {
        perror("lseek64");
        exit(EXIT_FAILURE);
    }
    long long offset =3D 0;
    if (argc =3D=3D 4) {
        offset =3D strtoll(argv[3], NULL, 10);
        if (errno !=3D 0) {
            perror("strtoll");
            exit(EXIT_FAILURE);
        }
    }
    off64_t curr =3D 0;
    while (true) {
        off64_t data =3D lseek64(infd, curr, SEEK_DATA);
        if (data =3D=3D -1) {
            break;
        }
        off64_t hole =3D lseek64(infd, data, SEEK_HOLE);
        if (hole =3D=3D -1) {
            hole =3D inlength;
        }
        off64_t off_out =3D data + offset;
        ssize_t ret =3D copy_file_range(infd, &data, outfd, &off_out, hole =
- data, 0);
        if (ret =3D=3D -1) {
            perror("copy_file_range");
            exit(EXIT_FAILURE);
        }
        curr =3D hole;
    }
    if (outlength < inlength + offset) {
        int ret =3D ftruncate(outfd, inlength + offset);
        if (ret =3D=3D -1) {
            perror("ftruncate");
            exit(EXIT_FAILURE);
        }
    }
    close(infd);
    close(outfd);
    exit(EXIT_SUCCESS);
}
--===============3049226928662926417==
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Description: signature
Content-Type: application/pgp-signature; name="signature.asc"; charset="us-ascii"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElFhU6KL81LF4wVq58sulx4+9g+EFAmZFri4ACgkQ8sulx4+9
g+FUWg//X8Lax/Kd8CMTlTaFyb5wp3LUH1AIGjOhGqc7Tqx7d8MDAzmWIPwdckbK
K90uvlPaEdpOMnn5Q8jRohyatqoVP5xMTP3ggLvBjuVwPa+k9J4u75B0aYNzDhEn
2MZAblc0hdXU84SydY1jOdQIjMdAU4+DTiLFCpci6f42v5huROPWdPZw0YOawna5
t6/SSPH5/Fo28egj61SqY7Je3DTZ8ZvxZGyfTrppCvbN7Zuea2KCLNgnWizxoyb6
UqQEbd5L5stVgJs+hXO2NuxbQzhFpL9xF63Zd9S021JyGf+EBzyARTH+IOqk//q7
qwqDDdZ7nkoUB/J3rsL86DTlhXAjl/8Xv5HOPzpXj5gLO3x1bmHkv1q8DIJOHSSj
M9CeUtMA67mvOVbOLtgVPwQKTm+mxxU+2JGAYS1HjfOfM7gXRm2yMhh4pqUjKBL2
X1ZLyRDxH6m+R45AUy//cBThIqJeRACorNdZ9ni/hVLOnl/s7P5rTLHRu6+c4Z/t
9i1C+aVsMj+cMQoh1w7gFMo2OYbtPfeFeyD3tQmQO2ZrpJoEs+nl08ic+vlJqNqN
wyBveys3Ssqi7v5g3zYIIF0sOcgiPHq1ZOJJdqyx7C3sENZFjaTMIj4ROfjuDc0T
jyjOc+WFln3HlQA7dDSXoqaMStdlFBzS4/vPuH2gscNWwoePQLQ=
=tu6F
-----END PGP SIGNATURE-----

--===============3049226928662926417==--

