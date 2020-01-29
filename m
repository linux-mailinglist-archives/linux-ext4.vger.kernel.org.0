Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE6EC14D19D
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jan 2020 21:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgA2UAi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jan 2020 15:00:38 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:42782 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgA2UAh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jan 2020 15:00:37 -0500
Received: by mail-pg1-f178.google.com with SMTP id s64so338157pgb.9
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jan 2020 12:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=fU4BH2rkfMcWgrGYQLC+TPMH91e3jZcSs7CP86noA5o=;
        b=SIHfRMzYkkvjEaoIfYgQHq/y+YKpzqgd74M7hMMXK0HlkAsv/mglz6CJiO9nsFwqfA
         BGzkoFymRJm6pMFWE62k2n2b8tP06xnOtfyWODtu30Fy8v6+r+vzkDYdEDCAWwAaCJ1D
         NddN1UJ0APoX0tZLPcqSeKlPSvtu4XxeaUNxA1K3GDjq4/lDQBgUT81QMhQz1QsNGk7p
         Y07LYRfNUiSTbb/1IB2HFCcxTW1G/cz7zYlzhmrnIQ5M3DXGp33o/SEymzm/89L/2WV0
         TYapH2HwAM1ONsFElR9mWLyQI0BfCOMWY23giA/QyYxTb1bpdcKWdpP7PiX5C0vXbqAY
         lnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=fU4BH2rkfMcWgrGYQLC+TPMH91e3jZcSs7CP86noA5o=;
        b=ccqyb1azjumG1+ZANbo0a1dudBLknIr829NMflJHpuuFpD7tGqw03jjqYjH01zOvs2
         kWy5X23Sx/hd2oQ6hmsGLmJtOfjtLy1Pztvs4oqdNT9kAN7H49pQmUI6/XR4fG/g2HLJ
         L02IMGnGvQcavSCkq4CwCnmGV75J1HEBzHNKbJhXtOeqQFnxhE3x+q4DuB+/xt35jSnf
         KmZ9WTx9EBJAMDsAu14pomNCfY/lxQScZCbqOp7D4iJr2o0JlpzgE8FW0M3z5044a+CN
         U88lfC8qyV0tdkRQjniQoBVrcB3b7hleRAS7dujo/0tUTbIfVwS2EjD25b3srXWkRgAH
         4w4Q==
X-Gm-Message-State: APjAAAUGsc++u2+eBVHpqDJhohRfH3gnTiPiuhX8I5H8uFeiTO44jJ4H
        Ey3mcM4p8gce7SbDe0dwoHkz31M6sNAA7Q==
X-Google-Smtp-Source: APXvYqxWLYzm/AAvX3Jva8JilUzb7UXYVKUM/ZPLgdM7FJc0Xry1vB/vCvW13vPs+0Kmiviywo7GWA==
X-Received: by 2002:a62:cec7:: with SMTP id y190mr1148759pfg.191.1580328035389;
        Wed, 29 Jan 2020 12:00:35 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id q8sm3551492pgg.92.2020.01.29.12.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 12:00:34 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <E995C6CF-FC2F-4079-AA27-81530C0AF489@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_24DDBA91-9A6B-4373-BF01-5960FB55E29A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e2fsck fails with unable to set superblock
Date:   Wed, 29 Jan 2020 13:00:32 -0700
In-Reply-To: <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Jaco Kroon <jaco@uls.co.za>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
 <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
 <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
 <50b83755-3c24-ceff-2529-c89ef4df363b@uls.co.za>
 <7cf0c5cc-7679-41f4-c8e4-e6d79cb88d5f@uls.co.za>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_24DDBA91-9A6B-4373-BF01-5960FB55E29A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Jan 28, 2020, at 9:35 PM, Jaco Kroon <jaco@uls.co.za> wrote:
>=20
> Hi,
>=20
> Inode 181716301 block 33554947 conflicts with critical metadata,
> skipping block checks.
> Inode 181716301 block 524296 conflicts with critical metadata, =
skipping
> block checks.
> Inode 181716301 block 2 conflicts with critical metadata, skipping =
block
> checks.
> Inode 181716301 block 294 conflicts with critical metadata, skipping
> block checks.
> Inode 181716301 block 1247805839 conflicts with critical metadata,
> skipping block checks.
> Inode 181716301 block 288 conflicts with critical metadata, skipping
> block checks.
> Inode 181716301 block 103285040 conflicts with critical metadata,
> skipping block checks.
> Inode 181716301 block 872415232 conflicts with critical metadata,
> skipping block checks.
> Inode 181716301 block 2560 conflicts with critical metadata, skipping
> block checks.
> Inode 181716301 block 479199248 conflicts with critical metadata,
> skipping block checks.
> Inode 181716301 block 1006632963 conflicts with critical metadata,
> skipping block checks.

This inode is probably just random garbage.  Erase that inode with:

debugfs -w -R "clri <181716301>" /dev/sdX

There may be multiple such inodes with nearby numbers in the likely
case that a whole block is corrupted.  There has been some discussion
about the best way to handle such corruption of a whole inode table
block, but nothing has been implemented in e2fsck yet.

> So the critical block stuff I'm guessing can be expected since a bunch
> of those tree structures probably got zeroed too.
>=20
> It got killed because it ran out of RAM (OOM killer), 32GB physical +
> 16GB swap.  I've extended swap to 512GB now and restarted.  It's
> probably overkill (I hope).
>=20
> Any ideas on what might be consuming the RAM like this?   =
Unfortunately
> my scroll-back doesn't go back far enough to see what other inodes if
> any are also affected.  I've restarted with 2>&1 | tee =
/var/tmp/fsck.txt
> now.
>=20
> Happy to go hunting to look for possible optimization ideas here ...
>=20
> Another idea is to use debugfs to mark inode 181716301 as deleted, but
> I'm not sure that's safe at this stage?

Marking it "deleted" isn't really the right thing, since (AFAIR) that
will just update the inode bitmap and possibly set the "i_dtime" field
in the inode.  The "clri" command will zero out the inode, which erases
all of the bad block allocation references for that inode.  This is no
"loss" since the inode is already garbage.

Cheers, Andreas

>=20
>=20
> Kind Regards,
> Jaco
>=20
>=20
> On 2020/01/28 23:12, Jaco Kroon wrote:
>=20
>> Hi,
>>=20
>> Just to provide feedback, and perhaps some usage tips for anyone =
reading
>> the thread (and before I forget how all of this stuck together in the =
end).
>>=20
>> I used the code at http://downloads.uls.co.za/85T/ext4_rebuild_gds.c =
to
>> recover.  Firstly I generated a list of GDs that needed to be =
repaired:
>>=20
>> ./ext4_rebuild_gds /dev/lvm/snap_home 2>&1 | tee =
/var/tmp/rebuild_checks.txt
>>=20
>> snap_home is marked read-only in LVM (my safety/as close to a
>> block-level backup I can come).
>>=20
>> cd /var/tmp
>> grep differs: rebuild_checks.txt | grep -v bg_flags | sed -re =
's/^Group
>> ([0-9]+), .*/\1/p' | uniq | awk 'BEGIN{ start=3D-1; prev=3D-10 } { if =
(prev
>> < $1-1) { if (start >=3D 0) { print start " " prev }; start=3D$1 }; =
prev=3D$1
>> } END{ print start " " prev }' > blocks.txt
>>=20
>> exec 3<blocks.txt; while read A B <&3; do oblock=3D$(~/ext4_rebuild_gds=

>> /dev/lvm/snap_home $A $B 2>&1 > .$A.tmp | sed -nre 's/^Physical GD =
block
>> for output start: //p') && mv .$A.tmp $A-$oblock.block; done
>>=20
>> for i in *.block; do sblock=3D$(basename ${i#*-} .block); for o in 0
>> 32768; do dd if=3D$i of=3D/dev/lvm/home bs=3D4096 seek=3D$(( sblock + =
o ));
>> done; done
>>=20
>> I also did validate that for all pairs in blocks.txt B-A =3D=3D 64, =
and A%64
>> =3D=3D 0 (to make sure it's a full GDT block that I need to update).  =
If
>> this is not the case, you should reduce A such that it becomes a
>> multiple of 64, then adjust B such that B-A=3D=3D64 (add additional =
pairs
>> such that the entire original A to B range is covered).  This may set
>> ZEROED bg_flags value on some GDs as a side effect but hopefully this
>> won't cause problems.  I also verified that all A >=3D first_meta_bg =
-
>> else you need to find appropriate block directly following =
super-block.
>>=20
>> I only replaced the first two copies of the GDT blocks in each case,
>> could replace the third as well by adding a 32768*63 entry for o in =
the
>> inner for loop.
>>=20
>> fsck is now running and getting past the previous failure point.  I =
am
>> hopeful that we'll at least recover some data.
>>=20
>> I do have a few questions regarding fsck though:
>>=20
>> 1.  Will it notice that the backups GDT blocks are not the same as =
the
>> primaries and replace the backup blocks?
>>=20
>> 2.  I'm assuming it will rebuild the reachability for all inodes
>> starting at / and thus be able to determine which inodes should be
>> free/in use, and rebuild bitmaps accordingly (as well as mark the =
inodes
>> themselves free)?
>>=20
>> 3.  Sort out all buggered up checksums in the GDs I've changed?
>>=20
>> Anyway, perhaps someone can answer out of hand, otherwise time will
>> tell, to date:
>>=20
>> # e2fsck -y -f /dev/lvm/home
>> e2fsck 1.45.4 (23-Sep-2019)
>> Pass 1: Checking inodes, blocks, and sizes
>> Inodes that were part of a corrupted orphan linked list found.  Fix? =
yes
>>=20
>> Inode 13844923 was part of the orphaned inode list.  FIXED.
>> Inode 13844932 has an invalid extent node (blk 13666881850, lblk =
27684864)
>> Clear? yes
>>=20
>> Kind Regards,
>> Jaco
>>=20
>> On 2020/01/28 14:53, Jaco Kroon wrote:
>>=20
>>> Hi Andreas,
>>>=20
>>> On 2020/01/28 01:15, Andreas Dilger wrote:
>>>> On Jan 27, 2020, at 10:52 AM, Jaco Kroon <jaco@uls.co.za> wrote:
>>>>> Hi Andreas,
>>>>>=20
>>>>> Ok, so there were a few calc errors below.  I believe I've =
rectified those.  I've written code to both locate and read the GD, as =
well as generate the fields I plan to update, comparing the fields I =
plan to update against those of all known-good blocks.  The only issue =
I've picked up is that I've realised I don't understand bg_flags at all. =
 Extract from output of my program (it uses the read GD as template and =
then just overwrites the fields I'm calculating).
>>>>> Group 65542, bg_flags differs: 0 (actual) !=3D 4 (generated)
>>>> The EXT2_BG_{INODE,BLOCK}_UNINIT flags mean that the inode/block =
bitmaps are
>>>> all zero and do not need to be read from disk.  That should only be =
used for
>>>> groups that have no blocks or inodes allocated to them.
>>>>=20
>>>> The EXT2_BG_INODE_ZEROED flag means that the inode table has been =
zeroed out
>>>> on disk after the filesystem has been formatted.  It is safest to =
set this
>>>> flag on the group, so that the kernel does not try to zero out the =
inode tables
>>>> again, especially if your bitmaps are not correct.
>>> That makes sense.  Good explanation thank you.
>>>=20
>>>>> and to possibly inspect the data at inode_table looking for some =
kind of "magic" as to whether or not it's already initialized or not...
>>>> The group descriptors also have a checksum that needs to be valid.
>>> I'm hoping fsck will fix this after I've actioned mine?
>>>>> My code is available at =
http://downloads.uls.co.za/85T/ext4_rebuild_gds.c for anyone that cares. =
 Currently some work pending.
>>>> It probably makes more sense to include this into e2fsck, so that =
it will be
>>>> usable for everyone.
>>> I agree.  For now I needed quick and nasty.  I have no objection to =
do a
>>> patch at some point on e2fsck, or someone else can use my throw-away
>>> code and refine it.  For now I'm taking stdout from that and using =
dd to
>>> clobber the meta_bg GDT blocks, as well as replace the backups.  One
>>> reason for not doing that from the start was simply that I had no =
idea
>>> where exactly this would need to go into e2fsck.
>>>>  IMHO, there is a design flaw in the meta_bg disk format,
>>>> in that the last group(s) of the filesystem may have few/no backup =
copies, so
>>>> cannot easily be recovered in case of an error.
>>> 1 copy if there is only one group, 2 of fewer than meta_bg groups =
... 3
>>> otherwise.  Frankly I'm OK(ish) with three backups, one of which is
>>> typically ~128MB away from the first two.  Perhaps not quite good
>>> enough.  I get where you're coming from.  This is the first time =
that
>>> I've personally experienced GD corruption failures, or at least, =
that I
>>> *know* what I'm looking at.  Having said that, in >15 years this is =
only
>>> the third ext* filesystem that I've managed to corrupt to the point
>>> where fsck would not recover it.  The previous one was a few years =
back,
>>> and that was due to a major hardware issue.  The time before that =
was
>>> sheer incompetence and stupidity.
>>>=20
>>>> There is also the secondary
>>>> issue that meta_bg causes the metadata to be spread out over the =
whole disk,
>>>> which causes a *LOT* of seeking on a very large filesystem, on the =
order of
>>>> millions of seeks, which takes a lot of time to read.
>>> I can't comment to that.  I don't know how often these things are
>>> actually read from disk, whether it's once-off during mount time, or
>>> whether there are further reads of these blocks after that.  If it's
>>> once off I don't particularly care personally, if an 85TB file =
system
>>> takes a minute to mount ... so be it.  If it's continuous ... yes =
that
>>> can become problematic I reckon.
>>>=20
>>> Thank you very much for the information, you've managed to (even =
though
>>> not tell me how to fix my issue) at the very least confirm some =
things
>>> for me.  Aware this is goodwill, and that's more than I could ask =
for in
>>> all reality.
>>>=20
>>> Kind Regards,
>>> Jaco
>>>=20
>>>>> On 2020/01/27 12:24, Jaco Kroon wrote:
>>>>>> Hi Andreas,
>>>>>>=20
>>>>>> Thank you.  The filesystem uses meta_bg and is larger than 16TB, =
my issue also doesn't exhibit in the first 16TB covered by those blocks.
>>>>>> On 2020/01/26 23:45, Andreas Dilger wrote:
>>>>>>> There are backups of all the group descriptors that can be used =
in such cases, immediately following the backup superblocks.
>>>>>>>=20
>>>>>>> Failing that, the group descriptors follow a very regular =
pattern and could be recreated by hand if needed (eg. all the backups =
were also corrupted for some reason).
>>>>>>>=20
>>>>>> You are right.  It's however tricky to wrap your head around it.  =
I think I've got it, but if you don't mind double checking me please:
>>>>>>=20
>>>>>> Given a group number g.  sb =3D superblock.
>>>>>> gds_per_block =3D 2^(10+sb.s_log_block_size) / sb.s_desc_size =3D =
4096 / 64 =3D 64
>>>>>> gd_block =3D floor(g / gds_per_block)
>>>>>> if (gd_block < ${sb.s_reserved_gdt_blocks})
>>>>>>  phys_gd_block =3D gd_block + 1;
>>>>>> else
>>>>>>  phys_gd_block =3D floor(gd_block / gds_per_block) * =
gds_per_block * sb.s_blocks_per_group
>>>>>>=20
>>>>>> phys_gd_block_offset =3D sb.s_desc_size * (g % gds_per_block)
>>>>>>=20
>>>>>> Backup blocks, are either with every superblock backup (groups 0, =
and groups being a power of 3, 5 and 7, ie, 0, 1, 3, 5, 7, 9, 25, 27, =
...) where gd_block < ${sb.s_reserved_gdt_blocks); or
>>>>>> phys_gd_backup1 =3D phys_gd_block + sb.s_blocks_per_group
>>>>>> phys_gd_backup2 =3D phys_gd_block + sb.s_blocks_per_group * =
(gds_per_block - 1)
>>>>>>=20
>>>>>> offset stays the same.
>>>>>>=20
>>>>>> To reconstruct it's critical to fill the following fields, with =
the required calculations (gd =3D group descriptor, calculations for =
groups < 2^17, using 131072 as example):
>>>>>>=20
>>>>>> bitmap_group =3D floor(g / flex_groups) * flex_groups
>>>>>>    =3D> floor(131072 / 16) * 16 =3D> 131072
>>>>>> gd.bg_block_bitmap =3D bitmap_group * blocks_per_group + g % =
flex_groups
>>>>>>    =3D> 131072 * 3768 + 131072 % 16
>>>>>>    =3D> 493879296
>>>>>> if (bitmap_group % gds_per_block =3D=3D 0) /* if bitmap_group =
also houses a meta group block */
>>>>>>    gd.bg_block_bitmap++;
>>>>>> =3D> if (131072 % 64 =3D=3D 0)
>>>>>> =3D> if (0 =3D=3D 0)
>>>>>> =3D> gd.bg_block_bitmap =3D 493879297
>>>>>>=20
>>>>>> gd.bg_inode_bitmap =3D gd.bg_block_bitmap + flex_groups
>>>>>> =3D> gd.bg_inode_bitmap =3D 493879297 + 16 =3D 493879313
>>>>>> gd.bg_inode_table =3D gd.bg_inode_bitmap + flex_groups - (g % =
flex_groups) + (g % flex_groups * inode_blocks_per_group)
>>>>>> =3D> 493879313 + 16 - 0 + 0 * 32 =3D 493879329
>>>>>> Bad example, for g=3D131074:
>>>>>> =3D>493879315 + 16 - 2 + 2 * 32 =3D 493879393
>>>>>>=20
>>>>>> gd.bg_flags =3D 0x4
>>>>>>=20
>>>>>> I suspect it's OK to just zero (or leave them zero) these:
>>>>>>=20
>>>>>> bg_free_blocks_count
>>>>>> bg_free_inodes_count
>>>>>> bg_used_dirs_count
>>>>>> bg_exclude_bitmap
>>>>>> bg_itable_unused
>>>>>>=20
>>>>>> As well as all checksum fields (hopefully e2fsck will correct =
those).
>>>>>> I did action this calculation for a few non-destructed GDs and my =
manual calculations seems OK for the groups I checked (all into meta_bg =
area):
>>>>>>=20
>>>>>> 131072 (multiple of 64, meta_bg + fleg_bg)
>>>>>> 131073 (multiple of 64 + 1 - first meta_bg backup)
>>>>>> 131074 (none of the others, ie, plain group with data blocks =
only)
>>>>>> 131088 (multiple of 16 but not 64, flex_bg)
>>>>>> 131089 (multiple of 16 but not 64, +1)
>>>>>> 131135 (multiple of 64 + 63 - second meta_bg backup)
>>>>>> It is however a very limited sample, but should cover all the =
corner cases I could think of based on the specification and my =
understanding thereof.
>>>>>>=20
>>>>>> Given the above I should be able to write a small program that =
will produce the 128 4KiB blocks that's required, and then I can use dd =
to place them into the correct locations.
>>>>>> As an aside, debugfs refuses to open the filesystem:
>>>>>>=20
>>>>>> crowsnest ~ # debugfs /dev/lvm/home
>>>>>> debugfs 1.45.4 (23-Sep-2019)
>>>>>> /dev/lvm/home: Block bitmap checksum does not match bitmap while =
reading allocation bitmaps
>>>>>> debugfs:  chroot /
>>>>>> chroot: Filesystem not open
>>>>>> debugfs:  quit
>>>>>> Which is probably fair.  So for this one I'll have to go make =
modifications using either some programatic tool that opens the =
underlying block device, or use dd trickery (ie, construct a GD and dd =
it into the right location, a a sequence of 64 GDs as it's always 64 GDs =
that's destroyed in my case, exactly 1 4KiB block).
>>>>>>=20
>>>>>> Kind Regards,
>>>>>> Jaco
>>>>>>> Cheers, Andreas
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On Jan 26, 2020, at 13:44, Jaco Kroon <jaco@uls.co.za>
>>>>>>>> wrote:
>>>>>>>>=20
>>>>>>>> =EF=BB=BFHi,
>>>>>>>>=20
>>>>>>>> So working through the dumpe2fs file, the group mentioned by =
dmesg
>>>>>>>> contains this:
>>>>>>>>=20
>>>>>>>> Group 404160: (Blocks 13243514880-13243547647) csum 0x9546
>>>>>>>>  Group descriptor at 13243514880
>>>>>>>>  Block bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>>>>>  Inode bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>>>>>  Inode table at 0-31 (bg #0 + 0)
>>>>>>>>  0 free blocks, 0 free inodes, 0 directories
>>>>>>>>  Free blocks: 13243514880-13243547647
>>>>>>>>  Free inodes: 206929921-206930432
>>>>>>>>=20
>>>>>>>> Based on that it's quite simple to see that during the array
>>>>>>>> reconstruction we apparently wiped a bunch of data blocks with =
all
>>>>>>>> zeroes.  This is obviously bad. During reconstruction we had to =
zero one
>>>>>>>> of the disks before we could get the array to reassemble. What =
I'm
>>>>>>>> wondering is whether this process was a good choice now, and =
whether the
>>>>>>>> right disk was zeroed.  Obviously this implies major data loss =
(at least
>>>>>>>> 4TB, probably more assuming that directory structures may well =
have been
>>>>>>>> destroyed as well, maybe less if some of those blocks weren't =
in use).
>>>>>>>>=20
>>>>>>>> I'm hoping that it's possible to recreate these group =
descriptors (there
>>>>>>>> are a few of them) to at least point to the correct locations =
on disk,
>>>>>>>> and to then attempt a cleanup with e2fsck.  Again, data loss =
here is to
>>>>>>>> be expected, but if we can limit it at least that would be =
great.
>>>>>>>>=20
>>>>>>>> There are unfortunately a large bunch of groups affected (128 =
cases of
>>>>>>>> 64 consecutive group blocks).
>>>>>>>>=20
>>>>>>>> 32768 blocks/group =3D> 128 * 64 * 32768 blocks =3D> 268m =
blocks, at
>>>>>>>> 4KB/block =3D> 1TB of data lost.  However, this is extremely =
conservative
>>>>>>>> seeing that this could include directory structures with =
cascading effect.
>>>>>>>>=20
>>>>>>>> Based on the patterns of the first 64 group descriptors (GDs) =
it looks
>>>>>>>> like it should be possible to reconstruct the 8192 affected =
GDs, or
>>>>>>>> alternatively possibly "uninit" them
>>>>>>>> (
>>>>>>>> =
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Lazy_Block_Group_I=
nitialization
>>>>>>>> ).
>>>>>>>> I'm inclined to reason that it's probably safer to repair in =
the GDs the
>>>>>>>> following fields:
>>>>>>>>=20
>>>>>>>> bg_block_bitmap_{lo,hi}
>>>>>>>> bg_inode_bitmap_{lo,hi}
>>>>>>>> bg_inode_table_{lo,hi}
>>>>>>>>=20
>>>>>>>> I'm not sure about:
>>>>>>>>=20
>>>>>>>> bg_flags (I'm guessing the safest is to leave this zeroed).
>>>>>>>> bg_exclude_bitmap_{lo,hi} (I don't know what this is used for).
>>>>>>>>=20
>>>>>>>> The following should (as far as my understanding goes) then be =
"fixable"
>>>>>>>> by e2fsck:
>>>>>>>>=20
>>>>>>>> bg_free_blocks_count_{lo,hi}
>>>>>>>> bg_free_inodes_count_{lo,hi}
>>>>>>>> bg_used_dirs_count_{lo,hi}
>>>>>>>> bg_block_bitmap_csum_{lo,hi}
>>>>>>>> bg_inode_bitmap_csum_{lo,hi}
>>>>>>>> bg_itable_unused_{lo,hi}
>>>>>>>> bg_checksum
>>>>>>>>=20
>>>>>>>> And of course, tracking down the GD on disk will be tricky it =
seems. It
>>>>>>>> seems some blocks have the GD in the block, and a bunch of =
others don't
>>>>>>>> (nor does dumpe2fs say where exactly they are).  There is 2048 =
blocks of
>>>>>>>> GDs (131072 or 2^17 GDs) with every superblock backup, however, =
rom
>>>>>>>> group 2^17 onwards there are additional groups simply stating =
"Group
>>>>>>>> descriptor at ${frist_block_of_group}", so it's unclear how to =
track
>>>>>>>> down the GD for a given block group.
>>>>>>>>=20
>>>>>>>> =
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Block_Group_Descri=
ptors
>>>>>>>>=20
>>>>>>>> does not describe this particularly well either, and there =
seems to be
>>>>>>>> confusion w.r.t. flex_bg and meta_bg features and this.
>>>>>>>>=20
>>>>>>>> I do have an LVM snapshot of the affected LV currently, so =
happy to try
>>>>>>>> things.
>>>>>>>>=20
>>>>>>>> Kind Regards,
>>>>>>>> Jaco
>>>>>>>>=20
>>>>>>>>=20
>>>>>>>>> On 2020/01/26 12:21, Jaco Kroon wrote:
>>>>>>>>>=20
>>>>>>>>> Hi,
>>>>>>>>>=20
>>>>>>>>> I've got an 85TB ext4 filesystem which I'm unable to fsck.  =
The only
>>>>>>>>> cases of same error I could find was from what I can find due =
to an SD
>>>>>>>>> card "swallowing" writes (ie, the card goes into a read-only =
mode but
>>>>>>>>> doesn't report write failure).
>>>>>>>>>=20
>>>>>>>>> crowsnest ~ # e2fsck -f /dev/lvm/home
>>>>>>>>>=20
>>>>>>>>> e2fsck 1.45.4 (23-Sep-2019)
>>>>>>>>> ext2fs_check_desc: Corrupt group descriptor: bad block for =
block bitmap
>>>>>>>>> e2fsck: Group descriptors look bad... trying backup blocks...
>>>>>>>>> /dev/lvm/home: recovering journal
>>>>>>>>> e2fsck: unable to set superblock flags on /dev/lvm/home
>>>>>>>>>=20
>>>>>>>>>=20
>>>>>>>>> /dev/lvm/home: ***** FILE SYSTEM WAS MODIFIED *****
>>>>>>>>>=20
>>>>>>>>> /dev/lvm/home: ********** WARNING: Filesystem still has errors =
**********
>>>>>>>>>=20
>>>>>>>>> I have also (using dumpe2fs) obtained the location of the =
backup super
>>>>>>>>> blocks and tried same against a few other superblocks using =
-b.  -y (as
>>>>>>>>> per suggestion from at least one post) make absolutely no =
difference,
>>>>>>>>> our understanding is that this simply answers yes to all =
questions, so
>>>>>>>>> we didn't expect this to have impact but decided it was worth =
a try anyway.
>>>>>>>>>=20
>>>>>>>>> Looking at the code for the unable to set superblock error it =
looks like
>>>>>>>>> the code is in e2fsck/unix.c, specifically this:
>>>>>>>>>=20
>>>>>>>>> 1765     if (ext2fs_has_feature_journal_needs_recovery(sb)) {
>>>>>>>>> 1766         if (ctx->options & E2F_OPT_READONLY) {
>>>>>>>>> ...
>>>>>>>>> 1771         } else {
>>>>>>>>> 1772             if (ctx->flags & E2F_FLAG_RESTARTED) {
>>>>>>>>> 1773                 /*
>>>>>>>>> 1774                  * Whoops, we attempted to run the
>>>>>>>>> 1775                  * journal twice.  This should never
>>>>>>>>> 1776                  * happen, unless the hardware or
>>>>>>>>> 1777                  * device driver is being bogus.
>>>>>>>>> 1778                  */
>>>>>>>>> 1779                 com_err(ctx->program_name, 0,
>>>>>>>>> 1780                     _("unable to set superblock flags "
>>>>>>>>> 1781                       "on %s\n"), ctx->device_name);
>>>>>>>>> 1782                 fatal_error(ctx, 0);
>>>>>>>>> 1783             }
>>>>>>>>>=20
>>>>>>>>> That comment has me somewhat confused.  I'm assuming the =
implication
>>>>>>>>> there is that e2fsck tried to update the superblock, but after =
reading
>>>>>>>>> it back, it's either unchanged or still wrong (In line with =
the
>>>>>>>>> description of the SD card I found online).  None of our =
arrays are
>>>>>>>>> reflecting R/O in /proc/mdstat. We did pick out this in kernel =
bootup
>>>>>>>>> (we downgraded back to 5.1.15, which we're on currently, after
>>>>>>>>> experiencing major performance issues on 5.3.6 and =
subsequently 5.4.8
>>>>>>>>> didn't seem to fix those, and the 4.14.13 kernel that was used
>>>>>>>>> previously is known to cause ext4 corruption of the kind we =
saw on the
>>>>>>>>> other filesystems):
>>>>>>>>>=20
>>>>>>>>> [ 3932.271538] EXT4-fs (dm-7): ext4_check_descriptors: Block =
bitmap for
>>>>>>>>> group 404160 overlaps superblock
>>>>>>>>> [ 3932.271539] EXT4-fs (dm-7): group descriptors corrupted!
>>>>>>>>>=20
>>>>>>>>> I created a dumpe2fs file as well:
>>>>>>>>>=20
>>>>>>>>> crowsnest ~ # dumpe2fs /dev/lvm/home > =
/var/tmp/dump2fs_home.txt
>>>>>>>>> dumpe2fs 1.45.4 (23-Sep-2019)
>>>>>>>>> dumpe2fs: Block bitmap checksum does not match bitmap while =
trying to
>>>>>>>>> read '/dev/lvm/home' bitmaps
>>>>>>>>>=20
>>>>>>>>> Available at
>>>>>>>>> https://downloads.uls.co.za/85T/dump2fs_home.txt.xz
>>>>>>>>> (1.2GB,
>>>>>>>>> md5:79b3250e209c067af2532d5324ff95aa, around 12GB extracted)
>>>>>>>>>=20
>>>>>>>>> A strace of e2fsck -y -f /dev/lvm/home at
>>>>>>>>>=20
>>>>>>>>> https://downloads.uls.co.za/85T/fsck.strace.txt
>>>>>>>>> (13MB,
>>>>>>>>> md5:60aa91b0c47dd2837260218eb774152d)
>>>>>>>>>=20
>>>>>>>>> crowsnest ~ # tune2fs -l /dev/lvm/home
>>>>>>>>> tune2fs 1.45.4 (23-Sep-2019)
>>>>>>>>> Filesystem volume name:   <none>
>>>>>>>>> Last mounted on:          /home
>>>>>>>>> Filesystem UUID:          522a9faf-7992-4888-93d5-7fe49a9762d6
>>>>>>>>> Filesystem magic number:  0xEF53
>>>>>>>>> Filesystem revision #:    1 (dynamic)
>>>>>>>>> Filesystem features:      has_journal ext_attr filetype =
meta_bg extent
>>>>>>>>> 64bit flex_bg sparse_super large_file huge_file dir_nlink =
extra_isize
>>>>>>>>> metadata_csum
>>>>>>>>> Filesystem flags:         signed_directory_hash
>>>>>>>>> Default mount options:    user_xattr acl
>>>>>>>>> Filesystem state:         clean
>>>>>>>>> Errors behavior:          Continue
>>>>>>>>> Filesystem OS type:       Linux
>>>>>>>>> Inode count:              356515840
>>>>>>>>> Block count:              22817013760
>>>>>>>>> Reserved block count:     0
>>>>>>>>> Free blocks:              6874204745
>>>>>>>>> Free inodes:              202183498
>>>>>>>>> First block:              0
>>>>>>>>> Block size:               4096
>>>>>>>>> Fragment size:            4096
>>>>>>>>> Group descriptor size:    64
>>>>>>>>> Blocks per group:         32768
>>>>>>>>> Fragments per group:      32768
>>>>>>>>> Inodes per group:         512
>>>>>>>>> Inode blocks per group:   32
>>>>>>>>> RAID stride:              128
>>>>>>>>> RAID stripe width:        1024
>>>>>>>>> First meta block group:   2048
>>>>>>>>> Flex block group size:    16
>>>>>>>>> Filesystem created:       Thu Jul 26 12:19:07 2018
>>>>>>>>> Last mount time:          Sat Jan 18 18:58:50 2020
>>>>>>>>> Last write time:          Sun Jan 26 11:38:56 2020
>>>>>>>>> Mount count:              2
>>>>>>>>> Maximum mount count:      -1
>>>>>>>>> Last checked:             Wed Oct 30 17:37:27 2019
>>>>>>>>> Check interval:           0 (<none>)
>>>>>>>>> Lifetime writes:          976 TB
>>>>>>>>> Reserved blocks uid:      0 (user root)
>>>>>>>>> Reserved blocks gid:      0 (group root)
>>>>>>>>> First inode:              11
>>>>>>>>> Inode size:               256
>>>>>>>>> Required extra isize:     32
>>>>>>>>> Desired extra isize:      32
>>>>>>>>> Journal inode:            8
>>>>>>>>> Default directory hash:   half_md4
>>>>>>>>> Directory Hash Seed:      876a7d14-bce8-4bef-9569-82e7d573b7aa
>>>>>>>>> Journal backup:           inode blocks
>>>>>>>>> Checksum type:            crc32c
>>>>>>>>> Checksum:                 0xfbd895e9
>>>>>>>>>=20
>>>>>>>>> Infrastructure:  3 x RAID6 arrays, 2 of 12 x 4TB disks, and 1 =
of 4 x
>>>>>>>>> 10TB disks (100TB usable total).  These are combined into a =
single VG
>>>>>>>>> using LVM, and then carved up into a number of LVs, the =
largest of which
>>>>>>>>> is this 85TB chunk.  We have tried in the past to carve this =
into
>>>>>>>>> smaller LVs but failed.  So we're aware that this is very =
large and not
>>>>>>>>> ideal.
>>>>>>>>>=20
>>>>>>>>> We did experience an assembly issue on one of  the underlying =
RAID6 PVs,
>>>>>>>>> those have been resolved, and the disk that was giving issues =
has been
>>>>>>>>> scrubbed and rebuilt.  rom what we can tell based on other =
file systems,
>>>>>>>>> this did not affect data integrity but we can't make that =
statement with
>>>>>>>>> 100% certainty, as such we are expecting some data loss here =
but it
>>>>>>>>> would be better if we can recover at least some of this data.
>>>>>>>>>=20
>>>>>>>>> Other filesystems which also resides on the same PV that was =
affected by
>>>>>>>>> the RAID6 problem either received a clean bill of health, or =
were
>>>>>>>>> successfully repaired by e2fsck (the system did crash however, =
it's
>>>>>>>>> unclear whether the RAID6 assembly problem was the cause or =
merely
>>>>>>>>> another consequence, and as a result, whether the corruption =
on the
>>>>>>>>> repaired filesystem was a consequence of the kernel or the =
RAID).
>>>>>>>>>=20
>>>>>>>>> I'm continuing onwards with e2fsck code to try and figure this =
out, am
>>>>>>>>> hopeful though that someone could perhaps provide some much =
needed
>>>>>>>>> insight and pointers for me.
>>>>>>>>>=20
>>>>>>>>> Kind Regards,
>>>>>>>>> Jaco
>>>>>>>>>=20
>>>>>>>>>=20
>>>> Cheers, Andreas
>>>>=20
>>>>=20
>>>>=20
>>>>=20
>>>>=20


Cheers, Andreas






--Apple-Mail=_24DDBA91-9A6B-4373-BF01-5960FB55E29A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4x5GAACgkQcqXauRfM
H+DBFg/+Lw5ZkGP/jhPDZLsTMYB6I60bVzpNoJn6FsrbISPPjd1B1tFRqwxS7ruZ
PG4xjhPWg388A4vDtX6MmWElkb4MWJ/70PXlgBx5+j85/DBwlVT8pgbl06NAIZye
U0K0FR3n+PnhaXfeFPyDWWS5ak3NI6Ngr4+yE4fu8JzbXEdJfGEaPVN07C/74JOk
R2IXNKBY6VuB6HQnsx7cbCsUQZJO6Rro0kmxKry/57WI97pG+lj4pwlRYvQqucHG
+nJ5mzt9LA/klmjqk1KZHXpw6ch3QuU7yh6N2zEySzNkJ5GEkJEE/O4Acf6Ew48G
zxAg8wbeX1UaiqmFL/sSbUsNa1xgcqovlvfJ0b+cPa/j4MlZginOBud731fEIYpe
jwI7hwvPpJ+qh7b+oHTMkH/wGb8vRIS0oqzvdbq0du5ZVovGnOPR+CT+svzKI9XE
2dqPh5c/aKmYc8snfg8aAfvuLLXSq2qyaAJlk+yUHC/X/0Rqw8+rabqT6ddYCEDz
Y7EMzkPLeeR7NvUvmFXaK6zDIHPyMw13EjqbilSBW8rel5XLMScJD5KKGe1N6+vo
NHRgAx7sGAzWHynk7MfIpBlEBMvyiArq0P/krzvm6Py7EMi6UV09efsb0DVY2n/h
BWSO7PeH7i8jnjvlZ/gaZHSntK0pJlgwCrnt1wqbds5zmApeHpo=
=6Nsc
-----END PGP SIGNATURE-----

--Apple-Mail=_24DDBA91-9A6B-4373-BF01-5960FB55E29A--
