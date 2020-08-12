Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A258243163
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Aug 2020 01:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHLXOj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Aug 2020 19:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXOj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Aug 2020 19:14:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA12C061383
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:14:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o5so1831385pgb.2
        for <linux-ext4@vger.kernel.org>; Wed, 12 Aug 2020 16:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=1eX3DBmkukBX5znbPrsc8Wm8epDoz1vtOOtFpN+BRBg=;
        b=IF18IiGIzezRfyvdHVizl7Fmd4cYlLD2VnBGQEZVnkYXyOufQBKkxU3LQK+R6GoGVd
         Qpz7NtbCexHXV8PyGoYKDX4H4qB44o1kB8wVV82oN6AgTjYw/bCH7hpaTCkYUDbv9uc+
         M15Y9ycdJ5oo9Vs/qz+edHRYXu+tnR7P9Y9VfXgaJ6InM73cOAf/Su+VwHbgVsUCUq3h
         JmPKhlS+LB8r0E5Ey11SvRziEJY07Tj81CUMjDNLkv2uNY5KjsBzw9u3RICqWPBfGyoF
         tNyI3nZyMNpp7dJWN48baqR1YAVtyVGdO+0ZrzfwSs7WgqWQDLbYSZ/gPvbZUGBM0Rh6
         wTBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=1eX3DBmkukBX5znbPrsc8Wm8epDoz1vtOOtFpN+BRBg=;
        b=iqbl0zEJxCY6ytQNXhmuIAq2GO/b6jf/7L9NjON80TcMMDGXrWT/upRqkh+6/Q0hqI
         0q44Khzq2JWkBtjniYYj4tNL2UQ8xzrzcaTLWnsem931yGPpUhN6gIHhPjR2/8zYJeB1
         oGYhoZQatUTpgiN3VHhDHkkfh8C3w40bGgBo3ppquzG4NaIADHjOldwcmYSqAugDPtXK
         7A671EpMO51r/oB9rbM/Otw2D30VYyUzyjOiHWqqAcE0xamK11dQla7ZYD4m4vKDp4ef
         kPj1wLva2GF3qZ31I+L0fdd+FBm+4/7mwH+RaU9lA2mQ/+svRUnZ4NVU0/1zHCbE9f7o
         RdAg==
X-Gm-Message-State: AOAM5333oomnNJY05ZMtD9uoIJazt9DrIF7uRZReqEJQLZBGtL41Luuf
        6Dm6a0xsWtl5D/yfV9fmScvCgg==
X-Google-Smtp-Source: ABdhPJw4yHaqibpys1qH4dZA3Jn2mIjduLLrlX7U+3gol/nH3+Uae9mN3Yxh2LAc/yF8ixffsndq/Q==
X-Received: by 2002:a63:b70c:: with SMTP id t12mr1302324pgf.178.1597274078341;
        Wed, 12 Aug 2020 16:14:38 -0700 (PDT)
Received: from [192.168.10.160] (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s125sm3712828pfc.63.2020.08.12.16.14.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 16:14:35 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <D62A3E5E-F3D6-4972-9ADB-43E45557172E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_D72C40BE-B801-46C1-AC9B-787700A1883D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Date:   Wed, 12 Aug 2020 17:14:32 -0600
In-Reply-To: <20200810132457.GA14208@mit.edu>
Cc:     Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
To:     tytso@mit.edu
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
 <20200806044703.GC7657@mit.edu>
 <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
 <20200808151801.GA284779@mit.edu>
 <9789BE11-11FB-42B2-A5BE-D4887838ED10@dilger.ca>
 <20200810132457.GA14208@mit.edu>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_D72C40BE-B801-46C1-AC9B-787700A1883D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Aug 10, 2020, at 7:24 AM, tytso@mit.edu wrote:
>=20
> On Sat, Aug 08, 2020 at 10:33:08PM -0600, Andreas Dilger wrote:
>> What about storing "s_min_freed_blocks_to_trim" persistently in the
>> superblock, and then the admin can adjust this as desired?  If it is
>> set =3D1, then the "lazy trim" optimization would be disabled (every
>> FITRIM request would honor the trim requests whenever there is a
>> freed block in a group).  I suppose we could allow =3D0 to mean "do =
not
>> store the WAS_TRIMMED flag persistently", so there would be no change
>> for current behavior, and it would require a tune2fs option to set =
the
>> new value into the superblock (though we might consider setting this
>> to a non-zero value in mke2fs by default).
>=20
> Currently the the minimum blocks to trim is passed in to FITRIM from
> userspace; so we would need to define how the passed-in value from the
> fstrim program interacts with the value stored in the sueprblock.
> Would we always ignore the value passed-in from userspace?  That
> doesn't seem right...

The s_min_freed_blocks_to_trim value would decide whether the persistent
WAS_TRIMMED flag is cleared from the group or not when blocks are freed.
If =3D1 then every block freed in a group will clear the WAS_TRIMMED =
flag
(this is essentially the current behavior).  If > 1 (the default with
the second patch in the series) then multiple blocks need to be freed
from a group before it is reconsidered for trim, which is reasonable,
since few underlying devices have 1-block TRIM granularity and issuing
a new TRIM each time is just overhead.  If =3D0 then the WAS_TRIMMED =
flag
is never saved, and every FITRIM call will result in every group being
trimmed again, which is what currently happens when the filesystem is
newly mounted.

>> The other thing we were thinkgin about was changing the "-o discard" =
code
>> to leverage the WAS_TRIMMED flag, and just do bulk trim periodically
>> in the filesystem as blocks are freed from groups, rather than =
tracking
>> freed extents in memory and submitting trims actively during IO.  =
Instead,
>> it would track groups that exceed "s_min_freed_blocks_to_trim", and =
trim
>> the whole group in the background when the filesystem is not active.
>=20
> Hmm, maybe.  That's an awful lot of complexity, which is my concern
> with that approach.
>=20
> Part of the problem here is that discard is being used for different
> things for different use cases and devices with different discard
> speeds.  Right now, one of the primary uses of -o discard is for
> people who have fast discard implementations and/or people who really
> want to make sure every freed block is immediately discard --- perhaps
> to meet security / privacy requirements (such as HIPPA compliance,
> etc.).   I don't want to break that.
>=20
> We now have a requirement of people who have very slow discards --- I
> think at one point people mentioned something about for devices using
> HDD, probably in some kind of dm-thin use case?  One solution that we
> can use for those is simply use fstrim -m 8M or some such.  But it
> appears that part of the problem is people do want more precision than
> that?

At least in the DDN case it isn't for HDDs but just for huge NVMe RAID
devices where the many millions of TRIM requests take a noticeable time.
Also, even if the TRIM is done by mke2fs, fstrim will TRIM the whole
filesystem again after each mount because this state is not persistently
stored in the group descriptors.

> Another solution might be to skip trimming block groups if there have
> been blocks that have been freshly freed that are pending a commit,
> and skip that block group until the commit has completed.  That might
> also help reduce contention on a busy file system.

I think even with fast TRIM devices, sending lots of them inline with
other requests causes IO serialization, so "-o discard" is bad for
performance and has complex in-memory tracking of extents to TRIM.  The
other drawback of "-o discard" is even with "perfect" TRIM, the size
or alignment may not be suitable for the underlying NAND, so TRIMs that
eventually cover the entire group could in fact release none of the
underlying space because individually they weren't the right =
size/offset.

The proposal is to allow efficiently (i.e. 1 bit per group on disk, one
int per group in memory) aggregating and tracking which groups can
benefit from a TRIM request (e.g. after multi-MB of blocks are freed
there), rather than "-o discard" sending hundreds of TRIMs when =
individual
blocks/extents are freed.  The alternative of running "fstrim" from cron
is also not ideal, because it is hard to know what interval to use, and
there is no way to know if the filesystem is idle and it is a good time
to run, or if it *was* idle but suddenly becomes busy after fstrim =
starts.


Adding filesystem load-detection for fstrim, so that it only trims =
groups
while idle and stops when there is IO, would solve the contention issue
with actual filesystem usage.  At that point, the "enhancement" would
just be to essentially have fstrim restart periodically internally when
"-o discard" is used (or maybe "-o fstrim" instead?), with optimizations
to speed up finding groups that need to be trimmed as opposed to a full
scan each time.  Maybe the optimizations are premature, and a full scan
is easy enough even when there are millions of groups?  I guess if =
mballoc
can do full-group scans then fstrim can do the same easily enough.


> Yet another solution might be bias block allocations towards LBA
> ranges that have been deleted recently --- since another way to avoid
> trims is to simply overwrite those LBA's.  But then the question is
> how much memory are we willing to dedicate towards tracking recently
> released LBA's, and to what level of granularity?  Perhaps we just
> track the freed extents, and if they don't get used within a certain
> period, or if we start getting put under memory pressure, we then send
> the discards at that point.

I'd think that overwriting just-freed blocks is the opposite of what we
want?  Overwriting NAND blocks results in an erase cycle, and TRIM is
intended to pre-erase the blocks so that this doesn't need to be done
when there is a new write.

> Ultimately, though, this is a space full of trade offs, and I'm
> reminded of one of my father's favorite Chinese sayings: "You're
> demanding a horse which can run fast, but which doesn't eat much
> grass." (=E5=8F=88=E8=A6=81=E9=A9=AC=E5=84=BF=E8=B7=91=EF=BC=8C=E5=8F=88=
=E8=A6=81=E9=A9=AC=E5=84=BF=E4=B8=8D=E5=90=83=E8=8D=89).  Or translated =
more
> idiomatically, you can't have your cake and eat it too.  It seems
> this desire transcends all cultures.  :-)


Cheers, Andreas






--Apple-Mail=_D72C40BE-B801-46C1-AC9B-787700A1883D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl80d9gACgkQcqXauRfM
H+BOPg/+PDwdj5g14O0hVQU+wB8sZ1RIIW+OOnMdYZjuWYwge0ls7UoEcgrijwcd
ZmceTPA92/yjiFa/KeQhvA7w/MbD1PfeNinSlsRPxhD0pUVYHT7E51wxJ4igIGn8
lrmGNdPK2/CEWhDr73FRRl0a9+UCQd+J4svITt8q5FhosoUBg1YB0Gucnjp4kwME
vpraj3OZLu19UURljesjO4xOPEExYrdTBu3cO3q8rEQbfmF6fBBpsgX2+WDMnzTw
zab9pPAY/Du1+OugNo74vtRa3nFOP8HaM6ycgtcyUcXzVTUE4daKnwNHOd11Fh0m
+eaajym5lzPerXJc5lmw2AfSVA0JSMAbFNG6oyEu/HaxCSZ4+jXBdyviliOFezS4
9ic5L44Mh3GFSHGb8Q1+xI0rZ0NCB21EEg5mF5HlWzdAWFBPkh/J+EgzpQo9xqfQ
sl2XTRdjCjLMmR8+07AWsqfvCe8OfBoAg0qn4S/nJXCDM29Ut5KPD9bmyuzLRB4r
XGLz6AmJVCZpth7TaCweNSZtyu2JTc9rDcUA4caMbuDn7ZB7GqlafifYa7x5DN7G
CU8a3d13AKLcTAyUZgUi1wgvg2sKKPg9o8TI2hZA5aL66veV6JFZIo9Gq6meqTtB
BG+tp0QlHaEWArKUWfVEBhhPIaybAvXoO4F5Zr9Te+AICvtpawA=
=3eL7
-----END PGP SIGNATURE-----

--Apple-Mail=_D72C40BE-B801-46C1-AC9B-787700A1883D--
