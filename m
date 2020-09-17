Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3426D0C0
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 03:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgIQBnB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 21:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgIQBnA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 16 Sep 2020 21:43:00 -0400
X-Greylist: delayed 508 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Sep 2020 21:43:00 EDT
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A90C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 18:34:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id l126so186667pfd.5
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 18:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=0B03o0UCC9duSUvGYbtzLtk6nUcgwUNG2VAvbPi76/c=;
        b=HgEQiw+0Bgm7MOqrDOuj687T7srSTq401nypCrRn1EudwqYbNX8e3QIQ+dQcpQnczl
         yDmOSTEq9j1M76LBordD0tkoQzB1khfaQlVVDJ/67q2cNingCXtZqI7TmhBSey+XRWSz
         ajpmblJIbJ7ChgwkWWqlo4APvux7MVOupTWwiZ+H+v/FUFcsGEp5cun0+8K9lkhFURju
         nCWEdeAoBMKxonSI2VfoFcgv65MomjDMyL1AxfgJJy2fFYL5mTSCgskFc0dDqKMGSWu9
         0aBRVDuh1G3WzewawIqH0qzpIn3tjfayFzA7yyHUthtKvDLYZS97OovFPZsdlWNgf1d2
         vJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=0B03o0UCC9duSUvGYbtzLtk6nUcgwUNG2VAvbPi76/c=;
        b=qfpmrhWTwqYyolZaA+dxotyImug5ChHQDy6LTnkrQ/ITfs04LkXgwjw1ipzJvPuKP/
         p+6DkMNUSQDw/LWBEhN53ALOiSxn/1rpEFtMShQnfN3tK3QB6qdg0SxIpi8/0HoF0AKt
         OUG8tdsyOVNe421uOOXuS5NQkwMw7ZRNIr4dm/vHn7TKEBwFMSHLxeFgFE7xk5VYf7n/
         o9ecVuWq8OlreEawxHGgXM53lbo2tM+xzQaBEJ7xepSCY8pZTrArRWfaZnINayeYyooc
         6sOAT0z7VM45FQb637lQVftUPbzOBfQTAXsimz3Sx1g1fCF+Koa7QO2XKKTesvcyrJCv
         yP+A==
X-Gm-Message-State: AOAM532iZINA10S0WGValW91Ln8aKPQYEMuJBbh2sG93R/pv5+2cdBrb
        +rfK2FOOpCfwrIrqpkW0UM3p4XQgbw741Q==
X-Google-Smtp-Source: ABdhPJwDq+lnecnCwLntTDpqUAEeviYH+UUwoBwIz756JgRAlYqcJq3MF3lec6Hr5KpvZAoGQFJkiw==
X-Received: by 2002:a63:5d08:: with SMTP id r8mr20047622pgb.174.1600306470972;
        Wed, 16 Sep 2020 18:34:30 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id a27sm18255180pfk.52.2020.09.16.18.34.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2020 18:34:29 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D9D82475-7B39-4D79-84CA-C246130AD3B1@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4DE3DE0D-DAF6-496F-98BC-71E630523FBA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] [RFC] ext2fs: parallel bitmap loading
Date:   Wed, 16 Sep 2020 19:34:22 -0600
In-Reply-To: <20200916210352.GD38283@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wangshilong1991@gmail.com>,
        saranyamohan@google.com, harshads@google.com
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <CA+OwuSj-WjaPbfOSDpg5Mz2tm_W0p40N-L=meiWEDZ6j1ccq=Q@mail.gmail.com>
 <132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca>
 <20200916210352.GD38283@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4DE3DE0D-DAF6-496F-98BC-71E630523FBA
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 16, 2020, at 3:03 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
>=20
> On Fri, Sep 04, 2020 at 03:34:26PM -0600, Andreas Dilger wrote:
>> This is a patch that is part of the parallel e2fsck series that =
Shilong
>> is working on, and does not work by itself, but was requested during
>> discussion on the ext4 concall today.
>=20
> Andreas, thanks for sending this patch.  (Also available at[1].)
>=20
> [1] =
https://lore.kernel.org/linux-ext4/132401FE-6D25-41B3-99D1-50E7BC746237@di=
lger.ca/
>=20
> I took look at it, and there are a number of issues with it.  First of
> all, there seems to be an assumption that (a) the number of threads is
> less than the number of block groups, and (b) the number of threads
> can evenly divide the number of block groups.  So for example, if the
> number of block groups is prime, or if you are trying to use say, 8 or
> 16 threads, and the number of block groups is odd, the code in
> question will not do the right thing.

Yes, the thread count is checked earlier in the parallel e2fsck patch
series to be <=3D number of block groups.  However, I wasn't aware of =
any
requirement for groups =3D N * threads.  It may be coincidental that we
have never tested that case.

In any case, the patch was never really intended to be used by itself,
only for review and discussion of the general approach.

> (a) meant that attempting to run the e2fsprogs regression test suite
> caused most of the test cases to fail with e2fsck crashing due to
> buffer overruns.  I fixed this by changing the number of threads to be
> 16, or if 16 was greater than the number of block groups, to be the
> number of block groups, just for debugging purposes.  However, there
> were still a few regression test failures.
>=20
> I also then tried to use a file system that we had been using for
> testing fragmentation issues.  The file system was creating a 10GB
> virtual disk, and then running these commands:
>=20
>   DEV=3D/dev/sdc
>   mke2fs -t ext4 $DEV 10G
>   mount $DEV /mnt
>   pushd /mnt
>   for t in $(seq 1 6144) ; do
>       for i in $(seq 1 25) ; do
>           fallocate tb$t-8mb-$i -l 8M
>       done
>       for i in $(seq 1 2) ; do
>           fallocate tb$t-400mb-$i -l 400M
>       done
>   done
>   popd
>   umount /mnt
>=20
> With the patch applied, all of the threads failed with error code 22
> (EINVAL), except for one which failed with a bad block group checksum
> error.  I haven't had a chance to dig into further; but I was hoping
> that Shilong and/or Saranya might be able to take closer look at that.

There may very well be other issues with the patch that make it not
useful as-is in isolation.  I'd have to let Shilong comment on that.

> But the other thing that we might want to consider is to add
> demand-loading of the block (or inode) bitmap.  We got a complaint
> that "e2fsck -E journal_only" was super-slow whereas running the
> journal by mounting and unmounting the file system was much faster.
> The reason, of course, was because the kernel was only reading those
> bitmap blocks that are needed to be modified by the orphaned inode
> processing, whereas with e2fsprogs, we have to read in all of the
> bitmap blocks whether this is necessary or not.

Forking threads to do on-demand loading may have a high overhead, so
it would be interesting to investigate a libext2fs IO engine that is
using libaio.  That would allow O_DIRECT reading of filesystem metadata
without double caching, as well as avoid blocking threads.  Alternately,
there is already a "readahead" method exported that could be used to
avoid changing the code too much, using posix_fadvise(WILLNEED), but I
have no idea on how that would perform.

> So another idea that we've talked about is teaching libext2fs to be
> able to demand load the bitmap, and then when we write out the block
> bitmap, we only need to write out those blocks that were loaded.  This
> would also speed up running debugfs to examine the file system, as
> well as running fuse2fs.  Fortunately, we have abstractions in front
> of all of the bitmap accessor functions, and the code paths that would
> need to be changed to add demand-loading of bitmaps should be mostly
> exclusive of the changes needed for parallel bitmap loading.  So if
> Shilong has time to look at making the parallel bitmap loader more
> robust, perhaps Saranya could work on the demand-loading idea.
>=20
> Or if Shilong doesn't have time to try to polish this parallel bitmap
> loading changes, we could have Saranya look at clean it up --- since
> regardless of whether we implement demand-loading or not, parallel
> bitmap reading is going to be useful for some use cases (e.g., a full
> fsck, dumpe2fs, or e2image).

I don't think Shilong will have time to work on major code changes for
the next few weeks at least, due to internal deadlines, after which we
can finish cleaning up and submitting the pfsck patch series upstream.
If you are interested in the whole 59-patch series, it is available via:

git pull https://review.whamcloud.com/tools/e2fsprogs =
refs/changes/14/39914/1

or viewable online via Gerrit at:

https://review.whamcloud.com/39914

Getting some high-level review/feedback of that patch series would avoid
spending time to rework/rebase it and finding it isn't in the form that
you would prefer, or if it needs major architectural changes.

Note that this is currently based on top of the Lustre e2fsprogs branch.
While these shouldn't cause any problems with non-Lustre filesystems,
there are other patches in the series that are not necessarily ready
for submission (e.g. dirdata, Lustre xattr decoding, inode badness, =
etc).

Cheers, Andreas






--Apple-Mail=_4DE3DE0D-DAF6-496F-98BC-71E630523FBA
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl9ivR4ACgkQcqXauRfM
H+BMGw//fbzXtt3NwiZsjyxeuosxBGWgQJXQdxzH+MgV4WTvbERXJuoGD+oI4fGi
ux/d1e/P7SE3dVZVlNEpGsqs4Sia9MWDR5b+JqxYnx/322VowiEajpoVq6uVTxa5
y5r3sr0hriP2wfA7CRnjyoGdHWvrQp59Ul3SZPV51BHNztebuJu74Hpd6lXvekvB
j01tHdStrakdQZSpOGKvdU83yn7MLO+LWPyHiBSzQbk8TI4A49mz5DAeFRdB6wpZ
Cdr76TSdaQjyRbS4G/7pdBuxw0UCdZnEwsAerUxnQNIwD2UId4YxQUwMaYsYsqDv
5TxzoILZHogoPjC2U/RTa172uRH9tR63E+Zq2XNJC+xL3lMTx6MaOL5c3haQRbhI
pVKSGa0ay1ugQPVvJ58Xd7z032JdmfpONtINYrsqLpTSDFbmDXieIhiSXnu6Ax9C
pEGgiqWA6txxuKg+b9RchJbxiqcoewUS+k1N1dup54RtbAZGTq6+VZ57c9NhTX0T
CHSXFIDsqpjtkG7n5W9NU0lfjxYzL9Ay+Bve34d2uGM/Ik1V0RKHgZ0ylQ5vpdE1
kZOHHNcpVe4Bf1SqW05E+p2J/Bo8hiJZn/VyZntXDfzRXElmC3RcIwOJ8OgpteV3
th+fm3KqCp2ZgCz+JNOGxLJ6VmAq0Pzv81k3rkhnzABiPf5804g=
=r3pU
-----END PGP SIGNATURE-----

--Apple-Mail=_4DE3DE0D-DAF6-496F-98BC-71E630523FBA--
