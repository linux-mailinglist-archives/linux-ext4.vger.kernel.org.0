Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0262F2E1066
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Dec 2020 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbgLVWyX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Dec 2020 17:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbgLVWyX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Dec 2020 17:54:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48E1C06179C
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 14:53:42 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id v3so8147180plz.13
        for <linux-ext4@vger.kernel.org>; Tue, 22 Dec 2020 14:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=YO16FX3SbwOpHp9E6avBX4EPi6b3Oss4AziJNRobu8U=;
        b=XW/PWPNRouj4tuDHa/VeA1pxSmdESvf7pAV6BJ70j+8kLb5/LJqISpgFmwO8rffcT4
         1m11WLTMF4BkRg+9y+hDXJavCD05qhrjgnbKvYHx2yR26TkPu9w2dfQEuBz43piDeNF3
         +r3qgOBse3+969PRIh/kXQIaotfw9KgUX4ypcHZPA5Ebzx2Wb0Bu7YMFxzisWtSXlYjf
         3Mo62J2LDRuly56XXS9ZJzdnEm/Rn0NTkCHSmRp3OdUmo6/Ia8bTGJJlQ7kyY4hJHf4c
         c70XcmcVk+X5pjMeHGoEJKbhpSHD5/kVPpq7DEaQUq7NK/0JepAIE1IO0SnIctdpQcM8
         9JIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=YO16FX3SbwOpHp9E6avBX4EPi6b3Oss4AziJNRobu8U=;
        b=AgJzhnQ9cHNMtRQAqrm4eKa7KHdv0q2pTPxRydGDjdkw8c3LZDtvpt6TNNwbuxZDqd
         5BnTYaWDNOgtMDzoyd75dyUpAdNCPxNpj3ybsBhURuSrGGfwTuT0IYpNZQ4/q6oTcBTv
         DEUq7KDW4Zm/Q8mdFhZZl9rvfqmyHK+gkQicT2VRTiUF4JutlZx4pFEPhy5THtF5CHz3
         pekuhK44LjgpYGNY4qyndXzaSiCSu4KqF7Pm36ym6im6ge1CUTksJvdbClBIrTE7+Q6a
         WEFldljmwKUSh+JAgU7cwaMquTVdZKzogc7ECIAZE0BFjbUHnKFhCB3PYFVjSeA6eRkt
         kX5w==
X-Gm-Message-State: AOAM5330ga2olFTtFe5Xz1ZkEsB3Hu/p5q1ZyPCcpkuChv/JvN/s3obL
        5FaCN9EyfP+5zSkfRlf8R2WGcw==
X-Google-Smtp-Source: ABdhPJw2fNCukC+nMT0/Mm/gO4jXWbE0pw4aZyvlbN/9Pe2rGOT7+XKWUBHbhTMlQBOn3p2Zd2c+6g==
X-Received: by 2002:a17:902:7242:b029:db:d1ae:46bb with SMTP id c2-20020a1709027242b02900dbd1ae46bbmr23016724pll.77.1608677622338;
        Tue, 22 Dec 2020 14:53:42 -0800 (PST)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id w22sm20544334pfu.33.2020.12.22.14.53.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 14:53:41 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <EA4612BD-D992-4549-9D54-E2A54F9FB939@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_4BD5A894-6C59-4DD6-AE75-DCD1E03756EF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: discard and data=writeback
Date:   Tue, 22 Dec 2020 15:53:39 -0700
In-Reply-To: <X+If/kAwiaMdaBtF@mit.edu>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Wang Shilong <wshilong@ddn.com>,
        "Theodore Y. Ts'o" <tytso@MIT.EDU>
To:     Matteo Croce <mcroce@linux.microsoft.com>
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu>
 <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu>
X-Mailer: Apple Mail (2.3273)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_4BD5A894-6C59-4DD6-AE75-DCD1E03756EF
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Dec 22, 2020, at 9:34 AM, Theodore Y. Ts'o <tytso@MIT.EDU> wrote:
>=20
> On Tue, Dec 22, 2020 at 03:59:29PM +0100, Matteo Croce wrote:
>>=20
>> I'm issuing sync + sleep(10) after the extraction, so the writes
>> should all be flushed.
>> Also, I repeated the test three times, with very similar results:
>=20
> So that means the problem is not due to page cache writeback
> interfering with the discards.  So it's most likely that the problem
> is due to how the blocks are allocated and laid out when using
> data=3Dordered vs data=3Dwriteback.
>=20
> Some experiments to try next.  After extracting the files with
> data=3Dordered and data=3Dwriteback on a freshly formatted file =
system,
> use "e2freefrag" to see how the free space is fragmented.  This will
> tell us how the file system is doing from a holistic perspective, in
> terms of blocks allocated to the extracted files.  (E2freefrag is
> showing you the blocks *not* allocated, of course, but that's a mirror
> image dual of the blocks that *are* allocated, especially if you start
> from an identical known state; hence the use of a freshly formatted
> file system.)
>=20
> Next, we can see how individual files look like with respect to
> fragmentation.  This can be done via using filefrag on all of the
> files, e.g:
>=20
>       find . -type f -print0  | xargs -0 filefrag
>=20
> Another way to get similar (although not identical) information is via
> running "e2fsck -E fragcheck" on a file system.  How they differ is
> especially more of a big deal on ext3 file systems without extents and
> flex_bg, since filefrag tries to take into account metadata blocks
> such as indirect blocks and extent tree blocks, and e2fsck -E
> fragcheck does not; but it's good enough for getting a good gestalt
> for the files' overall fragmentation --- and note that as long as the
> average fragment size is at least a megabyte or two, some
> fragmentation really isn't that much of a problem from a real-world
> performance perspective.  People can get way too invested in trying to
> get to perfection with 100% fragmentation-free files.  The problem
> with doing this at the expense of all else is that you can end up
> making the overall free space fragmentation worse as the file system
> ages, at which point the file system performance really dives through
> the floor as the file system approaches 100%, or even 80-90% full,
> especially on HDD's.  For SSD's fragmentation doesn't matter quite so
> much, unless the average fragment size is *really* small, and when you
> are discarded freed blocks.
>=20
> Even if the files are showing no substantial difference in
> fragmentation, and the free space is equally A-OK with respect to
> fragmentation, the other possibility is the *layout* of the blocks are
> such that the order in which they are deleted using rm -rf ends up
> being less friendly from a discard perspective.  This can happen if
> the directory hierarchy is big enough, and/or the journal size is
> small enough, that the rm -rf requires multiple journal transactions
> to complete.  That's because with mount -o discard, we do the discards
> after each transaction commit, and it might be that even though the
> used blocks are perfectly contiguous, because of the order in which
> the files end up getting deleted, we end up needing to discard them in
> smaller chunks.
>=20
> For example, one could imagine a case where you have a million 4k
> files, and they are allocated contiguously, but if you get
> super-unlucky, such that in the first transaction you delete all of
> the odd-numbered files, and in second transaction you delete all of
> the even-numbered files, you might need to do a million 4k discards
> --- but if all of the deletes could fit into a single transaction, you
> would only need to do a single million block discard operation.
>=20
> Finally, you may want to consider whether or not mount -o discard
> really makes sense or not.  For most SSD's, especially high-end SSD's,
> it probably doesn't make that much difference.  That's because when
> you overwrite a sector, the SSD knows (or should know; this might not
> be some really cheap, crappy low-end flash devices; but on those
> devices, discard might not be making uch of a difference anyway), that
> the old contents of the sector is no longer needed.  Hence an
> overwrite effectively is an "implied discard".  So long as there is a
> sufficient number of free erase blocks, the SSD might be able to keep
> up doing the GC for those "implied discards", and so accelerating the
> process by sending explicit discards after every journal transaction
> might not be necessary.  Or, maybe it's sufficient to run "fstrim"
> every week at Sunday 3am local time; or maybe even fstrim once a night
> or fstrim once a month --- your mileage may vary.
>=20
> It's going to vary from SSD to SSD and from workload to workload, but
> you might find that mount -o discard isn't buying you all that much
> --- if you run a random write workload, and you don't notice any
> performance degradation, and you don't notice an increase in the SSD's
> write amplification numbers (if they are provided by your SSD), then
> you might very well find that it's not worth it to use mount -o
> discard.
>=20
> I personally don't bother using mount -o discard, and instead
> periodically run fstrim, on my personal machines.  Part of that is
> because I'm mostly just reading and replying to emails, building
> kernels and editing text files, and that is not nearly as stressful on
> the FTL as a full-blown random write workload (for example, if you
> were running a database supporting a transaction processing workload).

The problem (IMHO) with "-o discard" is that if it is only trimming
*blocks* that were deleted, these may be too small to effectively be
processed by the underlying device (e.g. the "super-unlucky" example
above where interleaved 4KB file deletes result in 1M separate 4KB
trim requests to the device, even when the *space* that is freed by
the unlinks could be handled with far fewer large trim requests.

There was a discussion previously ("introduce EXT4_BG_WAS_TRIMMED ...")

=
https://patchwork.ozlabs.org/project/linux-ext4/patch/1592831677-13945-1-g=
it-send-email-wangshilong1991@gmail.com/

about leveraging the persistent EXT4_BG_WAS_TRIMMED flag in the group
descriptors, and having "-o discard" only track trim on a per-group
basis rather than its current mode of doing trim on a per-block basis,
and then use the same code internally as fstrim to do a trim of free
blocks in that block group.

Using EXT4_BG_WAS_TRIMMED and tracking *groups* to be trimmed would be
a bit more lazy than the current "-o discard" implementation, but would
be more memory efficient, and also more efficient for the device (fewer,
larger trim requests submitted).  It would only need to track groups
that have at least a reasonable amount of free space to be trimmed.  If
the group doesn't have enough free blocks to trim now, it will be =
checked
again in the future when more blocks are freed.

Cheers, Andreas






--Apple-Mail=_4BD5A894-6C59-4DD6-AE75-DCD1E03756EF
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl/iePMACgkQcqXauRfM
H+AMEhAAjTmn0bZ58JTHs4Gffzo7vmztBTJDhaHljIwh0Cf9QV7ZewXRSAK70Jng
qJeoQ7/5EN6uR31D94VK15jMGO3wvmmt66AHbeBlE3KenlXS8JqHG03y8X6THCbN
07rzXJEA8lmAr6mEgDiRdrXUkx2yidHNBDbMjyFL+GF5IN/hRpaasXE/OnOvyfla
MaWXFJqoC5rUDY2LddtoSny/cHpy1wruYtK4FZ0SCZWoXWrBiApQ7YEeQbk9/ijH
bkIY9DuounV7fRB7SgG4r3g+KeWtwBFiV3c9yNh9gKh9pBwP2unhtQbQJ3R9C0W8
EPxVyFtch4olfe8eSIQNfAL+YlNioC/6AcL/w5Z4rVjhqV1IOjQyzxv9yP7We742
iRXoPyhUpFmpBHeKksgGasfTY1t7a6X7zleIEX7Zod2ZagP/rV592pxC1nLdm1me
DxfxgOQDtJknT9lM95kjDhRMS2GiEfbUs+IHcbflsMHEuLwCyLD9e+jaEBfK1BWC
kyJKBNluFxZYfmIobUBRdVeH3PzdC2Vs1kYD21cRj48xrjdexCD4Sqq4ZpcLOYlX
265z5/2sPDH2sre4otnjn5S/2De/z+y9qsPlgg3hu6H/+KH75MV0VN3o9s9rJ1Wm
/oNfB2a/wqeXRqumiHt/5NTzuNg2oBM8M9X1tCYjLM70wcyjkwE=
=jDw2
-----END PGP SIGNATURE-----

--Apple-Mail=_4BD5A894-6C59-4DD6-AE75-DCD1E03756EF--
