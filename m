Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94526741B0E
	for <lists+linux-ext4@lfdr.de>; Wed, 28 Jun 2023 23:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbjF1Vl5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 28 Jun 2023 17:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1Vl5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 17:41:57 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEEC9F
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 14:41:54 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-55b1238cab4so1426a12.2
        for <linux-ext4@vger.kernel.org>; Wed, 28 Jun 2023 14:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20221208.gappssmtp.com; s=20221208; t=1687988514; x=1690580514;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Po3xKIjJ7zHDZHXUQDI6Y/HzSGIiwJJaTQqCZcnMvKg=;
        b=wqsKQZlq7h/7FUjL/++Y8Qf0lelp4fYSreHNXWMA5g7w+EztrgDvMcBOEQhzZwS4sS
         Cuo9g0ZBwSnHmHW6W0RgjwaIRv+U394fHsMt00hloKYg1AGBysiTN/0O93D+gvKTUQhD
         CubXxl+rwdtJcDUpFMgi7TksYe7SI1i2Uh05DGvJ96leXTL+UYVdYUotdoLsikyyFajS
         Icc7jRvbvUvBTVzcplaNdpoQPnKzZUvNivlUwZrkDn7SClq5T87pW9Qc0hy1rBgB30tI
         IV/hacHOMiD1zKgkF7y431b7Fpf3GKxQjJP1u6bhELoDxo9E4k8xnshXnMfL7pKMzr/h
         BlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687988514; x=1690580514;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Po3xKIjJ7zHDZHXUQDI6Y/HzSGIiwJJaTQqCZcnMvKg=;
        b=gwFznweOqUZWbzlIo/ZGZy7eiFcQPRA32XDPW4dVsV3nArQB1trWY3rZ/wjGUB4Xy2
         YxOggz0Coihd49XAOLwhrX/YSLI2EM6hoaQQiUC6ZN3Stjh1PxerP8JJFQNJyafZd9gv
         5URYxKKWqmsTGc8aQbmdK46Y0bpHOlSKwkyBOxCCZrfZjf/VVVeXfZxMRW+nBxYeaf7y
         OLqiMywXb6TLgNQocKVaenm/zy6rvu9K60LfN7LZ2L7CaNnPrDLC3gr4eGEnBAfnJcdL
         tF11i16otv3We+4prQ0rMZhKc0p5JjlrL04TqVZZGSBEISbJgmSrV8jL6r8FjLtEfV4g
         +9PA==
X-Gm-Message-State: AC+VfDx+okoD6s/jtvLgaKRPDJs3iTZEBcAFhEno3KBlfgo7SlXsel4k
        eGp1dk7ZSguBDGNnBqmegAh/+T2ki4xTfcDJGbA=
X-Google-Smtp-Source: ACHHUZ4awp4JmhFi5GEzA2SGFYPbC2CNaxy7uw1Y6wtmYjAbRknE+kvrpMhyw3avDGMyjL8IKuiWig==
X-Received: by 2002:a05:6a21:7887:b0:126:2ba7:af61 with SMTP id bf7-20020a056a21788700b001262ba7af61mr13891347pzc.32.1687988513618;
        Wed, 28 Jun 2023 14:41:53 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7869a000000b0063d2dae6247sm5489862pfo.77.2023.06.28.14.41.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2023 14:41:52 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <49C26037-0E6C-474F-BD34-866EBCCAFD47@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_1A22E1FA-3350-45B1-B28D-346B9763139C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: packed_meta_blocks=1 incompatible with resize2fs?
Date:   Wed, 28 Jun 2023 15:41:45 -0600
In-Reply-To: <20230628000327.GG8954@mit.edu>
Cc:     Roberto Ragusa <mail@robertoragusa.it>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
References: <49752bf2-71ec-7fbf-dcdf-93940cfa92c9@robertoragusa.it>
 <20230628000327.GG8954@mit.edu>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_1A22E1FA-3350-45B1-B28D-346B9763139C
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Jun 27, 2023, at 6:03 PM, Theodore Ts'o <tytso@mit.edu> wrote:
>=20
> On Mon, Jun 26, 2023 at 11:15:14AM +0200, Roberto Ragusa wrote:
>> Is there a way to have metadata at the beginning of the disk
>> and be able to enlarge the fs later?
>> Planning to do this on big filesystems, placing the initial part
>> on SSD extents; reformat+copy is not an option.
>=20
> OK, so I think what you're trying to do is to create a RAID0 device
> where the first part of the md raid device is stored on SSD, and after
> that there would be one or more HDD devices.  Is that right?
>=20
> In theory, it would be possible to add a file system extension where
> the first portion of the MD device is not allowed to be used for
> normal block allocations, so that when you later grow the raid0
> device, the SSD blocks are available for use for the extended
> metadata.  This would require adding support for this in the
> superblock format, which would have to be an RO_COMPAT feature (that
> is, kernels that didn't understand the meaning of the feature bit
> would be prohibited from mounting the file system read/write, and
> older versions of fsck.ext4 would be prohibited from touching the file
> system at all).  We would then have to add support for off-line and
> on-line resizing for using the reserved SSD space for this use case.

We already have 600TB+ Lustre storage targets with declustered RAID
volumes and will hit 1 PiB very soon (60 * 18TB drives).  This results
in millions of block groups.  This can cause issues mounting, block
allocation, unlinking large files, etc. due to loading the metadata
from disk.  Being able to store the filesystem metadata on flash will
avoid performance contention from HDD seeking without the cost of
all-flash storage (some Lustre filesystems are over 700PiB already).


We are investigating hybrid flash+HDD OSTs with sparse_super2 to put
all static metadata at the start of the LV on flash, and keep regular
data on HDDs.  I think there isn't a huge amount of work needed to
get this working reasonably well, and it can be done incrementally.


Modify mke2fs to not force meta_bg to be enabled on filesystems over
256TiB.  Locate the sparse_super2 superblock/GDT backup #1 in one of
the sparse_super backup groups (3^n, 5^n, 7^n) instead of always group
#1, so it can be found by e2fsck easily like sparse_super filesystems.

Locate the sparse_super2 backup #2 group in the last ({3,5,7}^n) group
within the filesystem (instead of the *actual* last group).  That puts
it in the "slow" part of the device, but it is rarely accessed, and
is still far enough from the start of the device to avoid corruption.

In addition to avoiding the group #0/#1 GDT collision for backup #1 on
very large filesystems, this separates superblock/GDT copies further
apart for safety, and makes the #2 backup easier to find in case of
filesystem resize.  The current use of the last filesystem group
is not "correct" after a resize, and is not easily found in this case.

This allows "mke2fs -O sparse_super2 -E packed_meta_blocks" allocation
of static metadata (superblocks, GDTs, bitmaps, inode tables, journal)
at the start of the block device, which puts most of the metadata IOPS
onto flash instead of HDD.  No ext4/e2fsck changes are needed for this.


Update e2fsck to check sparse_super groups for backup superblocks/GDTs.
I think is useful independent of sparse_super2 changes.  This was
previously submitted as "ext2fs: automaticlly open backup superblocks"
but needs some updates before it can land:
=
https://patchwork.ozlabs.org/project/linux-ext4/patch/20190129175134.26652=
-5-c17828@cray.com/



To handle the allocation of *dynamic* metadata on the flash device
(indirect/index blocks, directories, xattr blocks) the ext4 mballoc
code needs to be informed about which groups are on the high IOPS
device.  I think it makes sense to add a new EXT4_BG_IOPS =3D 0x0010
group descriptor flag to mark groups that are on "high IOPS" media,
and then mballoc can use these groups when allocating the metadata.
Normal file data blocks would not be allocated from these groups.
Using a flag instead of "last group" marker in the superblock allows
more flexibility (e.g. for resize after filesystem creation).

mke2fs would be modified to add a "-E iops=3D[START-]END[,START-END,...]"
option to know which groups to mark with the IOPS flag.  The START/END
would be given with either block numbers, or with unit suffixes, so
it can be specified easily by the user, and converted internally to
group numbers based on other filesystem parameters.

The normal case would be a single "END" argument (default START=3D0)
puts all the IOPS capacity at the start of the device.  The ability
to specify multiple [,START-END] ranges is only there for completeness
and flexibility, I don't expect that we would be using it ourselves.

This dynamic metadata allocation on flash is not strictly necessary,
but still covers about 1/5 of metadata IOPS per write in my testing.

> The downside of this particular approach is that the SSD space would
> be "wasted" until the file system is resized, and you have to know up
> front how big you might want to grow the file system eventually.

I agree it doesn't make sense to hugely over-provision flash capacity.
It could be used for dynamic metadata allocations (as above), but that
also defeats the purpose of reserving this space.  My calculations is
that the IOPS capacity should be about 0.5% of the filesystem size to
handle the static and dynamic metadata, depending on inode size/count,
journal size, etc.

> I could imagine another approach might be that when you grow the file
> system, if you are using an LVM-type approach, you would append a
> certain number of LVM stripes backed by SSD, and a certain number
> backed by HDD's, and then give a hint to the resizing code where the
> metadata blocks should be allocated, and you would need to know ahead
> of time how many SSD-backed LV stripes to allocate to support the
> additional number of HDD-backed LV stripes.

That is what I was thinking also - if you are resizing (which is itself
an uncommon operation), then it makes sense to also add a large chunk
of flash at the end of the current device followed by the bulk of the
capacity on HDDs, and then have the resize code locate all of the new
static metadata on the new flash groups, like '-E packed_meta_blocks'.

In the past I also tried 1x 128MiB flash + 255x 128MiB HDD, and match
the flex_bg layout exactly to this, but it became complex very quickly.
LVM block remapping also slows down significantly with thousands of
segments, probably due to linear list walking, and still didn't get
to the level of 100k different segments needed for a 1PiB+ fs.


> This would require a bunch of abstraction violations, and it's a
> little bit gross.  More to the point, it would require a bunch of
> development work, and I'm not sure there is interest in the ext4
> development community, or the companies that back those developers,
> for implementing such a feature.

We're definitely interested in hybrid storage devices like this, but
resizing is not a priority for us.


Cheers, Andreas






--Apple-Mail=_1A22E1FA-3350-45B1-B28D-346B9763139C
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmScqRoACgkQcqXauRfM
H+A2SBAAk+6+UB8NUD0lzDPhaZF0mR+EHeMpKuWlhhdPrc3SRI1YV2KPREqMLRRZ
ePPtu1Jj9Lp8LUBT1MpxToDb7oFTeEOCNisjBQ9/pynIrnuDbmo3FV6r83fo5bGb
lGn59w3/bRToaus0+WtQYpnhi8JLme6smYSyi3srLsbUrYOw8dcpnan0eXDcKcZ8
XFljmBSX1hF1XLxsRA2o2GF+6R/fyhb5Z0QFYqVEtktha9nPS0kf1r6Dknx9Q9hh
t8LbjQKm1UC8b41sKWbb4SRhZX3cMJdupJ++Cl7Grk9pXWOk9DtMuC/TaogV9T8f
r6tFRw9KuKpwCvj3fqrvFEqmw1yCd50uloFT1o/jUjjtMMjAw0mxrVZ4oHPOsvsY
lCIS7A/+4XfN0Idi5uxSbQXgmhLf6X3vev8MNYwmj2fD5wRnKarqhi5sRnpKnMT2
l5ZayTmVInbxwD+AVTUWgiQ9ZmhO6k8tjCcdxg1hQKq5CX3sW9EFNl4ZWQL7m43Y
PYzokDXR9IZ5cGeJtFDK69mzyBW+hJ0vi0tr1PfpuzcKTUmuDMaKA2+01Vcvqvhz
7d2F3f7sj58JynbgTcWtwGGz9mNZid+y67cJ9Pc6pIp+MrEVKOO3o4NFykh4pawR
/J23rtb7bBB3FictQz32VSK/fIsRe7OcN5EwaQqfVphUZFRYnnk=
=SqT9
-----END PGP SIGNATURE-----

--Apple-Mail=_1A22E1FA-3350-45B1-B28D-346B9763139C--
