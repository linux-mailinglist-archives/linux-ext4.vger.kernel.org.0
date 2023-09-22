Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 867EE7AA74C
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Sep 2023 05:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjIVD15 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Sep 2023 23:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjIVD14 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Sep 2023 23:27:56 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DE102
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 20:27:49 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3ade101217bso1047197b6e.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Sep 2023 20:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1695353269; x=1695958069; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=22/tF80vER4Dpit4l84CSO0X9Je69Vv+m5noynksi1k=;
        b=h6l+3nQlHiLpXePX2kCmtBbQX7RNEFJTHZG9GKwpPD70fwWZaLAlOCVgSlKVrs6BMG
         47Xva2oda6nVhN9KWf/yNmcpHuow5z/3LGrZZTw7WaOn3lmukFRb5hprn6ewQcFILWq6
         FnIZtcYfEuyYKbXkuGTuE7/l4WaI10y0YMpKFQQkjFuiwJgHXoZmFOvFSyaXmRllXxLN
         dbKivUHLHukrBkv8mF2SBSTugaKbQwmWFG2/GhTSpi8GO+RFh86GNl5fQZX+JSWnfUKl
         XyNeYwiYifzBiizwn6kUEyGsMJ3S3WflUljnOuIdUo+GIF2T/UbUJ9Jt+oZlAQ7vzGfS
         7qzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695353269; x=1695958069;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=22/tF80vER4Dpit4l84CSO0X9Je69Vv+m5noynksi1k=;
        b=EWObaCxtxuC6hWFxWznlqUiVVO7BV1BzA/BUw3iVZtCkqMm2+LG1OULO2XdqzcOUz4
         s0tKK19zkiju7uYcoWnfnkM3XuPvh4oe4t6RNPB4D3n6BfasEqH4ZN/57lnyu8jprmd3
         fcmO5QaBTbyxP28777Cd5WCCVU6eU6WQeVylQqwtIAMiM4DYv6H4eK5V2Pw/RbnSJMY9
         fASC1BEJPWQXks9T/mwhxClsi9DubxHaauLLbUPU/Was3fva5EvvdNNn6dIT+U12Uraj
         jFK5KADtsBWymxxCqqMEvuDiUxAPD/UzlWMACNQmqR+Sb9FDo8iU8CCYOKZXqM73AAFp
         O+8A==
X-Gm-Message-State: AOJu0YwE86E01oLvmszUQuEoAR2gjcrwYLsFiWX9y5jKrZ7PBw8wp5nd
        P6cb2ORk1gnZBiRH0xFjDyYWog==
X-Google-Smtp-Source: AGHT+IH407V0qid+a8tgVt4+Feztfu2u0RdxuPhKUzZmafZXriasdLyU92Gksr8/jSO3VmwXyEjEXg==
X-Received: by 2002:a05:6808:1594:b0:3a7:215c:e34 with SMTP id t20-20020a056808159400b003a7215c0e34mr8598520oiw.15.1695353268673;
        Thu, 21 Sep 2023 20:27:48 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id s14-20020a62e70e000000b0068fea7d401esm2180903pfh.177.2023.09.21.20.27.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Sep 2023 20:27:47 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <33E43431-F2B5-4EC1-B2CD-489A10E6778E@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_B4EF979C-FC44-4B73-8C57-9FE274E19582";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v3] ext4: optimize metadata allocation for hybrid LUNs
Date:   Thu, 21 Sep 2023 21:27:45 -0600
In-Reply-To: <877col770d.fsf@doe.com>
Cc:     Bobi Jam <bobijam@hotmail.com>, Li Dongyang <dongyangli@ddn.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
To:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
References: <877col770d.fsf@doe.com>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_B4EF979C-FC44-4B73-8C57-9FE274E19582
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Sep 19, 2023, at 11:23 PM, Ritesh Harjani (IBM) =
<ritesh.list@gmail.com> wrote:
>=20
> Andreas Dilger <adilger@dilger.ca> writes:
>=20
>> On Sep 12, 2023, at 12:59 AM, Bobi Jam <bobijam@hotmail.com> wrote:
>>>=20
>>> With LVM it is possible to create an LV with SSD storage at the
>>> beginning of the LV and HDD storage at the end of the LV, and use =
that
>>> to separate ext4 metadata allocations (that need small random IOs)
>>> from data allocations (that are better suited for large sequential
>>> IOs) depending on the type of underlying storage.  Between 0.5-1.0% =
of
>>> the filesystem capacity would need to be high-IOPS storage in order =
to
>>> hold all of the internal metadata.
>>>=20
>>> This would improve performance for inode and other metadata access,
>>> such as ls, find, e2fsck, and in general improve file access =
latency,
>>> modification, truncate, unlink, transaction commit, etc.
>>>=20
>>> This patch split largest free order group lists and average fragment
>>> size lists into other two lists for IOPS/fast storage groups, and
>>> cr 0 / cr 1 group scanning for metadata block allocation in =
following
>>> order:
>>>=20
>>> if (allocate metadata blocks)
>>>     if (cr =3D=3D 0)
>>>             try to find group in largest free order IOPS group list
>>>     if (cr =3D=3D 1)
>>>             try to find group in fragment size IOPS group list
>>>     if (above two find failed)
>>>             fall through normal group lists as before
>>> if (allocate data blocks)
>>>     try to find group in normal group lists as before
>>>     if (failed to find group in normal group && mb_enable_iops_data)
>>>             try to find group in IOPS groups
>>>=20
>>> Non-metadata block allocation does not allocate from the IOPS groups
>>> if non-IOPS groups are not used up.
>>=20
>> Hi Ritesh,
>> I believe this updated version of the patch addresses your original
>> request that it is possible to allocate blocks from the IOPS block
>> groups if the non-IOPS groups are full.  This is currently disabled
>> by default, because in cases where the IOPS groups make up only a
>> small fraction of the space (e.g. < 1% of total capacity) having data
>> blocks allocated from this space would not make a big improvement
>> to the end-user usage of the filesystem, but would semi-permanently
>> hurt the ability to allocate metadata into the IOPS groups.
>>=20
>> We discussed on the ext4 concall various options to make this more
>> useful (e.g. allowing the root user to allocate from the IOPS groups
>> if the filesystem is out of space, having a heuristic to balance IOPS
>> vs. non-IOPS allocations for small files, having a BPF rule that can
>> specify which UID/GID/procname/filename/etc. can access this space,
>> but everyone was reluctant to put any complex policy into the kernel
>> to make any decision, since this eventually is wrong for some usage.
>>=20
>> For now, there is just a simple on/off switch, and if this is enabled
>> the IOPS groups are only used when all of the non-IOPS groups are =
full.
>> Any more complex policy can be deferred to a separate patch, I think.
>=20
> I think having a on/off switch for any user to enable/disable =
allocation
> of data from iops groups is good enough for now. Atleast users with
> larger iops disk space won't run out of ENOSPC if they enable with =
this feature.
>=20
> So, thanks for addressing it. I am going through the series. I will =
provide
> my review comments shortly.
>=20
> Meanwhile, here is my understanding of your usecase. Can you please
> correct add your inputs to this -
>=20
> 1. You would like to create a FS with a combination of high iops =
storage
> disk and non-high iops disk. With high iops disk space to be around 1 =
%
> of the total disk capacity. (well this is obvious as it is stated in =
the
> patch description itself)
>=20

> 2. Since ofcourse ext4 currently does not support multi-drive, so we
> will use it using LVM and place high iops disk in front.
>=20

> 3. Then at the creation of the FS we will use a cmd like this
>   mkfs.ext4 -O sparse_super2 -E packed_meta_blocks,iops=3D0-1024G =
/path/to/lvm
>=20
> Is this understanding right?

Correct.  Note that for filesystems larger than 256 TiB, when the group
descriptor table grows larger than the size of group 0, an few extra
patches that Dongyang developed are needed to fix the sparse_super2
option in mke2fs to allow this to pack all metadata at the start of the
device and move the GDT backup to further out.  For example, a 2TiB
filesystem it would use group 9 as the start of the first GDT backup.

I don't expect this will be a problem for most users, and is somewhat
an independent issue from the IOPS groups, so it has been kept separate.

I couldn't find a version of that patch series pushed to the list,
but it is in our Gerrit (the first one is already pushed):

https://review.whamcloud.com/52219 ("e2fsck: check all sparse_super =
backups")
https://review.whamcloud.com/52273 ("mke2fs: set free blocks accurately =
...")
https://review.whamcloud.com/52274 ("mke2fs: do not set BLOCK_UNINIT =
...")
https://review.whamcloud.com/51295 ("mke2fs: try to pack GDT blocks =
together")

(Dongyang, could you please submit the last three patches in this =
series).

> I have few followup queries as well -
>=20
> 1. What about Thin Provisioned LVM? IIUC, the space in that is
> pre-allocated, but allocation happens at the time of write and it =
might
> so happen that both data/metadata allocations will start to sit in
> iops/non-iops group randomly?

I think the underlying storage type would be controlled by LVM in that
case.  I don't know what kind of policy options are available with thin
provisioned LVs, but my first thought is "don't do that with IOPS =
groups"
since there is no way to know/control what the underlying storage is.

> 2. Even in case of taditional LVM, the mapping of the physical blocks
> can be changed during an overwrite or discard sort of usecase right? =
So
> do we have a gurantee of the metadata always sitting on high iops =
groups
> after filesystem ages?

No, I don't think that would happen under normal usage.  The PV/LV maps
are static after the LV is created, so overwriting a block at runtime
with ext4 would give the same type of storage as at mke2fs time.

The exception would be with LVM snapshots, in which case I'd suggest to
use flash PV space for the snapshot (assuming there is enough) to avoid
overhead when blocks are COW'd.  Even so, AFAIK the chunks written to
the snapshot LV are the *old* blocks and the current blocks are kept on
the main PV, so the IOPS groups would still work properly in this case.

> 3. With this options of mkfs to utilize this feature, we do loose the
> ability to resize right? I am guessing resize will be disabled with
> sparse_super2 and/or packed_meta_blocks itself?

Online resize was disabled in commit v5.13-rc5-20-gb1489186cc83
"ext4: add check to prevent attempting to resize an fs with =
sparse_super2".
However, I think that was a misunderstanding.  It looks like online =
resize
was getting confused by sparse_super2 together with resize_inode, =
because
there are only 2 backup group descriptor tables, and resize_inode =
expects
there to be a bunch more backups.  I suspect resize would "work" if
resize_inode was disabled completely.

The drawback is that online resize would almost immediately fall back
to meta_bg (as it does anyway for > 16TiB filesystems anyway), and spew
the GDT blocks and other metadata across the non-IOPS storage device.
This would "work" (give you a larger filesystem), but is not ideal.


I think the long-term solution for this would be to fix the interaction
with sparse_super2, so that the resize_inode could reserve GDT blocks
on the flash storage for the primary GDT and backup_bgs[0], and also
backup_bgs[1] would be kept in a group < 2M so that it does not need
to store 64-bit block numbers.  That would actually allow resize_inode
to work with > 16TiB filesystems and continue to avoid using meta_bg.

For the rest of the static metadata (bitmaps, inode tables) it would be
possible to add more IOPS groups at the end of the current filesystem
and add a "resize2fs -E iops=3Dx-yG" option to have it allocate the =
static
metadata from any of the IOPS groups.  That said, it has been a while
since I looked at the online resize code in the kernel, so I'm not sure
whether it is resize2fs or ext4 that is making these decisions anymore.

Cheers, Andreas






--Apple-Mail=_B4EF979C-FC44-4B73-8C57-9FE274E19582
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmUNCbEACgkQcqXauRfM
H+Bdhw/+KaFAC/nn7yUeCdjSRai+najMxqqhEyr9b2o3eHZIeB8OnpYqVy3ZEkHE
T4vIsev4q2VdD2iWw1VNXWAycLVZxKcMfMnFq1HgvlGlt1NxIFF1kVjVvS6SjRpf
cvfOji4y3/fpU8/CNtunneVYQM+FyDxoLInyLAZioE3vk3Y+H/y7M7k3VqLzNOSE
lDN3dSjHmg0Y6RDDhSU3UE4bVZrCq/VEf5Zg1Lq/1ZqpojFncA3yzpupyR/nOtHL
cEKpYOi9RjKpx7JMO4jVQZJUoQjDYMs21xTavMtzXF5538CS5KuS/ETFN9bfNLky
9MULw4/gRm2SCi2JlEwnecPPiuUPHseW950sc3cw906egtnh+CmIYecoNniyI6QR
mGeOZoJaf1UvlVpZBhgpr3aWaIAF81jruALOm0KnP/hDr92MzCW2J0gOwwTyDfOD
lJS8SJ4CTgSXgRjKM9UC0QMyUA2taCipmGAu6z6NCUqsxbavV9cWv/Qi01DF9Q8x
vA4FlPDvyJOW6WtUQBbdrdPpY2qD7Ln2LtPrx5AMvB0nDuMy+pNfLQEM9GbyEf0e
CY/khZ+upfF/wYC1MhSeiVsthQvJQsrd3U9MKZ+/DTBfKicw+rnLsYX9QnbH/hSs
qbBVHXsTc6+w6icMi/buvcVZw943E4A5tzwHMLqNMlzFsI0Z2hM=
=hDgS
-----END PGP SIGNATURE-----

--Apple-Mail=_B4EF979C-FC44-4B73-8C57-9FE274E19582--
