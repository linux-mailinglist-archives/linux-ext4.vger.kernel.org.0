Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0823E14AC7C
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 00:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgA0XPi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jan 2020 18:15:38 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:43121 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgA0XPh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jan 2020 18:15:37 -0500
Received: by mail-pf1-f180.google.com with SMTP id s1so5024540pfh.10
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jan 2020 15:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=Qfdq43x+Gx6Nm5WyQzuNz6i1pD15/+ekEMqcVz9l5m8=;
        b=rCoPOklxj60GwSmpwb+zE1sqikuXb5fWpOOL0azAbarP4WM/mw8Iz8PLMKFfHXt+MQ
         NJddxNDqzfPoDHZz+kpzYZTzUECv5/QuyQA4C4TOoX+DeSyJLHpi6cKo8357ADr72HCY
         0KNrLQq/m/8h8n1egOak7EsumTVQDa0aqYVGQqX3L/Xm42tcOEz1y5si17X2m5cYneR8
         DHaFXSbJvTBnyXaKEhdSPVnuYgNoUIYCEP3W8JyNMbJ5xw6OLSThWtAbdIe6GG3wAA9c
         Jeo7RPQs3r1aX/iX4Qv++0IeZMn/e7CZQTTVxISUBty8yOxKDSEMOMaNhTaO1Q7tBVwz
         l51Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=Qfdq43x+Gx6Nm5WyQzuNz6i1pD15/+ekEMqcVz9l5m8=;
        b=K638BT0yBvpDHfozrKRHANvbq0hwdj1AwPCY59aSGpMe8AoQ/edcDDbiyWEVaAISHw
         /1IYmLS0w241TOPZv8QUeblYYDa4LKibbhEpPmwWVlBIY2MfCbkib3iOZ0gDr1pP7aFM
         ULGaiqlAEfqbOqMPuYdnpk5Z7sk0s2uqgdK7rx0abqymUM7Ctofs1SGg8oXEpHFj4DHV
         xNUVoMULRlUxLPUmN9/jQU9rKfxUY/YqmkjXKsJceQlK/BYZOVQ7CfIKVcc9ILcLYXuH
         42oDTfSGpxaoHbEQT8d+9S1TpYZmkLNLAg7R3zfyL7YQpWVqfw5ghJxjguJWV2uQ1T5V
         AFNA==
X-Gm-Message-State: APjAAAW/WlZPeGet/TddRaISZLWbl1dS8zPveZCtTeiJYbsHjflKLt4d
        rSXMvd+Ofx92dOoVKJnd9CXFzwQ1bIA=
X-Google-Smtp-Source: APXvYqz3jas626CjfBP5VIrrMP4AR9SQT1X81kO09Mn4K1FCc5TEHmyx4g0yfZcILsYnHY9FriO00A==
X-Received: by 2002:a62:6c6:: with SMTP id 189mr1008972pfg.224.1580166935596;
        Mon, 27 Jan 2020 15:15:35 -0800 (PST)
Received: from cabot-wlan.adilger.int (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id c14sm17265219pfn.8.2020.01.27.15.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jan 2020 15:15:34 -0800 (PST)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_56CB4B75-C940-4B1E-9D7F-CD4DE81D24D3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: e2fsck fails with unable to set superblock
Date:   Mon, 27 Jan 2020 16:15:32 -0700
In-Reply-To: <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
To:     Jaco Kroon <jaco@uls.co.za>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
X-Mailer: Apple Mail (2.3273)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_56CB4B75-C940-4B1E-9D7F-CD4DE81D24D3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

On Jan 27, 2020, at 10:52 AM, Jaco Kroon <jaco@uls.co.za> wrote:
>=20
> Hi Andreas,
>=20
> Ok, so there were a few calc errors below.  I believe I've rectified =
those.  I've written code to both locate and read the GD, as well as =
generate the fields I plan to update, comparing the fields I plan to =
update against those of all known-good blocks.  The only issue I've =
picked up is that I've realised I don't understand bg_flags at all.  =
Extract from output of my program (it uses the read GD as template and =
then just overwrites the fields I'm calculating).
> Group 65542, bg_flags differs: 0 (actual) !=3D 4 (generated)

The EXT2_BG_{INODE,BLOCK}_UNINIT flags mean that the inode/block bitmaps =
are
all zero and do not need to be read from disk.  That should only be used =
for
groups that have no blocks or inodes allocated to them.

The EXT2_BG_INODE_ZEROED flag means that the inode table has been zeroed =
out
on disk after the filesystem has been formatted.  It is safest to set =
this
flag on the group, so that the kernel does not try to zero out the inode =
tables
again, especially if your bitmaps are not correct.

> Group 65542 (actual):
> Block Bitmap:             2147483654 (0x80000006)
> Inode Bitmap:             2147483670 (0x80000016)
> Inode Table:              2147483872 (0x800000e0)
> Free Blocks:              0 (0x0)
> Free Inodes:              315 (0x13b)
> Dirs Count:               197 (0xc5)
> Flags:                    0 (0x0)
> Exclusion Bmap:           0 (0x0)
> Block Bitmap Csum:        629120042 (0x257f9c2a)
> Inode Bitmap Csum:        330504133 (0x13b317c5)
> itable unused:            0 (0x0)
> checksum:                 17392 (0x43f0)
> Group 65542 (calculated):
> Block Bitmap:             2147483654 (0x80000006)
> Inode Bitmap:             2147483670 (0x80000016)
> Inode Table:              2147483872 (0x800000e0)
> Free Blocks:              0 (0x0)
> Free Inodes:              315 (0x13b)
> Dirs Count:               197 (0xc5)
> Flags:                    4 (0x4)
> Exclusion Bmap:           0 (0x0)
> Block Bitmap Csum:        629120042 (0x257f9c2a)
> Inode Bitmap Csum:        330504133 (0x13b317c5)
> itable unused:            0 (0x0)
> checksum:                 17392 (0x43f0)
> Basically, I'm not sure how I should go about "setting" (or unsetting) =
the bg_flags values.  Advise would be greatly appreciated.  My =
best-effort guess after this is to set BOTH the UNINIT flags (to force =
recalc of the bitmaps),

e2fsck will already regenerate the bitmaps on each full run.  Setting =
the
UNINIT flags will confuse the kernel and should be avoided.

> and to possibly inspect the data at inode_table looking for some kind =
of "magic" as to whether or not it's already initialized or not...

The group descriptors also have a checksum that needs to be valid.

> My code is available at =
http://downloads.uls.co.za/85T/ext4_rebuild_gds.c for anyone that cares. =
 Currently some work pending.

It probably makes more sense to include this into e2fsck, so that it =
will be
usable for everyone.  IMHO, there is a design flaw in the meta_bg disk =
format,
in that the last group(s) of the filesystem may have few/no backup =
copies, so
cannot easily be recovered in case of an error.  There is also the =
secondary
issue that meta_bg causes the metadata to be spread out over the whole =
disk,
which causes a *LOT* of seeking on a very large filesystem, on the order =
of
millions of seeks, which takes a lot of time to read.

> On 2020/01/27 12:24, Jaco Kroon wrote:
>> Hi Andreas,
>>=20
>> Thank you.  The filesystem uses meta_bg and is larger than 16TB, my =
issue also doesn't exhibit in the first 16TB covered by those blocks.
>> On 2020/01/26 23:45, Andreas Dilger wrote:
>>> There are backups of all the group descriptors that can be used in =
such cases, immediately following the backup superblocks.
>>>=20
>>> Failing that, the group descriptors follow a very regular pattern =
and could be recreated by hand if needed (eg. all the backups were also =
corrupted for some reason).
>>>=20
>> You are right.  It's however tricky to wrap your head around it.  I =
think I've got it, but if you don't mind double checking me please:
>>=20
>> Given a group number g.  sb =3D superblock.
>> gds_per_block =3D 2^(10+sb.s_log_block_size) / sb.s_desc_size =3D =
4096 / 64 =3D 64
>> gd_block =3D floor(g / gds_per_block)
>> if (gd_block < ${sb.s_reserved_gdt_blocks})
>>   phys_gd_block =3D gd_block + 1;
>> else
>>   phys_gd_block =3D floor(gd_block / gds_per_block) * gds_per_block * =
sb.s_blocks_per_group
>>=20
>> phys_gd_block_offset =3D sb.s_desc_size * (g % gds_per_block)
>>=20
>> Backup blocks, are either with every superblock backup (groups 0, and =
groups being a power of 3, 5 and 7, ie, 0, 1, 3, 5, 7, 9, 25, 27, ...) =
where gd_block < ${sb.s_reserved_gdt_blocks); or
>> phys_gd_backup1 =3D phys_gd_block + sb.s_blocks_per_group
>> phys_gd_backup2 =3D phys_gd_block + sb.s_blocks_per_group * =
(gds_per_block - 1)
>>=20
>> offset stays the same.
>>=20
>> To reconstruct it's critical to fill the following fields, with the =
required calculations (gd =3D group descriptor, calculations for groups =
< 2^17, using 131072 as example):
>>=20
>> bitmap_group =3D floor(g / flex_groups) * flex_groups
>>     =3D> floor(131072 / 16) * 16 =3D> 131072
>> gd.bg_block_bitmap =3D bitmap_group * blocks_per_group + g % =
flex_groups
>>     =3D> 131072 * 3768 + 131072 % 16
>>     =3D> 493879296
>> if (bitmap_group % gds_per_block =3D=3D 0) /* if bitmap_group also =
houses a meta group block */
>>     gd.bg_block_bitmap++;
>> =3D> if (131072 % 64 =3D=3D 0)
>> =3D> if (0 =3D=3D 0)
>> =3D> gd.bg_block_bitmap =3D 493879297
>>=20
>> gd.bg_inode_bitmap =3D gd.bg_block_bitmap + flex_groups
>>  =3D> gd.bg_inode_bitmap =3D 493879297 + 16 =3D 493879313
>> gd.bg_inode_table =3D gd.bg_inode_bitmap + flex_groups - (g % =
flex_groups) + (g % flex_groups * inode_blocks_per_group)
>>  =3D> 493879313 + 16 - 0 + 0 * 32 =3D 493879329
>> Bad example, for g=3D131074:
>>  =3D>493879315 + 16 - 2 + 2 * 32 =3D 493879393
>>=20
>> gd.bg_flags =3D 0x4
>>=20
>> I suspect it's OK to just zero (or leave them zero) these:
>>=20
>> bg_free_blocks_count
>> bg_free_inodes_count
>> bg_used_dirs_count
>> bg_exclude_bitmap
>> bg_itable_unused
>>=20
>> As well as all checksum fields (hopefully e2fsck will correct those).
>> I did action this calculation for a few non-destructed GDs and my =
manual calculations seems OK for the groups I checked (all into meta_bg =
area):
>>=20
>> 131072 (multiple of 64, meta_bg + fleg_bg)
>> 131073 (multiple of 64 + 1 - first meta_bg backup)
>> 131074 (none of the others, ie, plain group with data blocks only)
>> 131088 (multiple of 16 but not 64, flex_bg)
>> 131089 (multiple of 16 but not 64, +1)
>> 131135 (multiple of 64 + 63 - second meta_bg backup)
>> It is however a very limited sample, but should cover all the corner =
cases I could think of based on the specification and my understanding =
thereof.
>>=20
>> Given the above I should be able to write a small program that will =
produce the 128 4KiB blocks that's required, and then I can use dd to =
place them into the correct locations.
>> As an aside, debugfs refuses to open the filesystem:
>>=20
>> crowsnest ~ # debugfs /dev/lvm/home
>> debugfs 1.45.4 (23-Sep-2019)
>> /dev/lvm/home: Block bitmap checksum does not match bitmap while =
reading allocation bitmaps
>> debugfs:  chroot /
>> chroot: Filesystem not open
>> debugfs:  quit
>> Which is probably fair.  So for this one I'll have to go make =
modifications using either some programatic tool that opens the =
underlying block device, or use dd trickery (ie, construct a GD and dd =
it into the right location, a a sequence of 64 GDs as it's always 64 GDs =
that's destroyed in my case, exactly 1 4KiB block).
>>=20
>> Kind Regards,
>> Jaco
>>> Cheers, Andreas
>>>=20
>>>=20
>>>> On Jan 26, 2020, at 13:44, Jaco Kroon <jaco@uls.co.za>
>>>>  wrote:
>>>>=20
>>>> =EF=BB=BFHi,
>>>>=20
>>>> So working through the dumpe2fs file, the group mentioned by dmesg
>>>> contains this:
>>>>=20
>>>> Group 404160: (Blocks 13243514880-13243547647) csum 0x9546
>>>>   Group descriptor at 13243514880
>>>>   Block bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>   Inode bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>   Inode table at 0-31 (bg #0 + 0)
>>>>   0 free blocks, 0 free inodes, 0 directories
>>>>   Free blocks: 13243514880-13243547647
>>>>   Free inodes: 206929921-206930432
>>>>=20
>>>> Based on that it's quite simple to see that during the array
>>>> reconstruction we apparently wiped a bunch of data blocks with all
>>>> zeroes.  This is obviously bad. During reconstruction we had to =
zero one
>>>> of the disks before we could get the array to reassemble. What I'm
>>>> wondering is whether this process was a good choice now, and =
whether the
>>>> right disk was zeroed.  Obviously this implies major data loss (at =
least
>>>> 4TB, probably more assuming that directory structures may well have =
been
>>>> destroyed as well, maybe less if some of those blocks weren't in =
use).
>>>>=20
>>>> I'm hoping that it's possible to recreate these group descriptors =
(there
>>>> are a few of them) to at least point to the correct locations on =
disk,
>>>> and to then attempt a cleanup with e2fsck.  Again, data loss here =
is to
>>>> be expected, but if we can limit it at least that would be great.
>>>>=20
>>>> There are unfortunately a large bunch of groups affected (128 cases =
of
>>>> 64 consecutive group blocks).
>>>>=20
>>>> 32768 blocks/group =3D> 128 * 64 * 32768 blocks =3D> 268m blocks, =
at
>>>> 4KB/block =3D> 1TB of data lost.  However, this is extremely =
conservative
>>>> seeing that this could include directory structures with cascading =
effect.
>>>>=20
>>>> Based on the patterns of the first 64 group descriptors (GDs) it =
looks
>>>> like it should be possible to reconstruct the 8192 affected GDs, or
>>>> alternatively possibly "uninit" them
>>>> (
>>>> =
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Lazy_Block_Group_I=
nitialization
>>>> ).
>>>> I'm inclined to reason that it's probably safer to repair in the =
GDs the
>>>> following fields:
>>>>=20
>>>> bg_block_bitmap_{lo,hi}
>>>> bg_inode_bitmap_{lo,hi}
>>>> bg_inode_table_{lo,hi}
>>>>=20
>>>> I'm not sure about:
>>>>=20
>>>> bg_flags (I'm guessing the safest is to leave this zeroed).
>>>> bg_exclude_bitmap_{lo,hi} (I don't know what this is used for).
>>>>=20
>>>> The following should (as far as my understanding goes) then be =
"fixable"
>>>> by e2fsck:
>>>>=20
>>>> bg_free_blocks_count_{lo,hi}
>>>> bg_free_inodes_count_{lo,hi}
>>>> bg_used_dirs_count_{lo,hi}
>>>> bg_block_bitmap_csum_{lo,hi}
>>>> bg_inode_bitmap_csum_{lo,hi}
>>>> bg_itable_unused_{lo,hi}
>>>> bg_checksum
>>>>=20
>>>> And of course, tracking down the GD on disk will be tricky it =
seems. It
>>>> seems some blocks have the GD in the block, and a bunch of others =
don't
>>>> (nor does dumpe2fs say where exactly they are).  There is 2048 =
blocks of
>>>> GDs (131072 or 2^17 GDs) with every superblock backup, however, rom
>>>> group 2^17 onwards there are additional groups simply stating =
"Group
>>>> descriptor at ${frist_block_of_group}", so it's unclear how to =
track
>>>> down the GD for a given block group.
>>>>=20
>>>> =
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Block_Group_Descri=
ptors
>>>>=20
>>>> does not describe this particularly well either, and there seems to =
be
>>>> confusion w.r.t. flex_bg and meta_bg features and this.
>>>>=20
>>>> I do have an LVM snapshot of the affected LV currently, so happy to =
try
>>>> things.
>>>>=20
>>>> Kind Regards,
>>>> Jaco
>>>>=20
>>>>=20
>>>>> On 2020/01/26 12:21, Jaco Kroon wrote:
>>>>>=20
>>>>> Hi,
>>>>>=20
>>>>> I've got an 85TB ext4 filesystem which I'm unable to fsck.  The =
only
>>>>> cases of same error I could find was from what I can find due to =
an SD
>>>>> card "swallowing" writes (ie, the card goes into a read-only mode =
but
>>>>> doesn't report write failure).
>>>>>=20
>>>>> crowsnest ~ # e2fsck -f /dev/lvm/home
>>>>>=20
>>>>> e2fsck 1.45.4 (23-Sep-2019)
>>>>> ext2fs_check_desc: Corrupt group descriptor: bad block for block =
bitmap
>>>>> e2fsck: Group descriptors look bad... trying backup blocks...
>>>>> /dev/lvm/home: recovering journal
>>>>> e2fsck: unable to set superblock flags on /dev/lvm/home
>>>>>=20
>>>>>=20
>>>>> /dev/lvm/home: ***** FILE SYSTEM WAS MODIFIED *****
>>>>>=20
>>>>> /dev/lvm/home: ********** WARNING: Filesystem still has errors =
**********
>>>>>=20
>>>>> I have also (using dumpe2fs) obtained the location of the backup =
super
>>>>> blocks and tried same against a few other superblocks using -b.  =
-y (as
>>>>> per suggestion from at least one post) make absolutely no =
difference,
>>>>> our understanding is that this simply answers yes to all =
questions, so
>>>>> we didn't expect this to have impact but decided it was worth a =
try anyway.
>>>>>=20
>>>>> Looking at the code for the unable to set superblock error it =
looks like
>>>>> the code is in e2fsck/unix.c, specifically this:
>>>>>=20
>>>>> 1765     if (ext2fs_has_feature_journal_needs_recovery(sb)) {
>>>>> 1766         if (ctx->options & E2F_OPT_READONLY) {
>>>>> ...
>>>>> 1771         } else {
>>>>> 1772             if (ctx->flags & E2F_FLAG_RESTARTED) {
>>>>> 1773                 /*
>>>>> 1774                  * Whoops, we attempted to run the
>>>>> 1775                  * journal twice.  This should never
>>>>> 1776                  * happen, unless the hardware or
>>>>> 1777                  * device driver is being bogus.
>>>>> 1778                  */
>>>>> 1779                 com_err(ctx->program_name, 0,
>>>>> 1780                     _("unable to set superblock flags "
>>>>> 1781                       "on %s\n"), ctx->device_name);
>>>>> 1782                 fatal_error(ctx, 0);
>>>>> 1783             }
>>>>>=20
>>>>> That comment has me somewhat confused.  I'm assuming the =
implication
>>>>> there is that e2fsck tried to update the superblock, but after =
reading
>>>>> it back, it's either unchanged or still wrong (In line with the
>>>>> description of the SD card I found online).  None of our arrays =
are
>>>>> reflecting R/O in /proc/mdstat. We did pick out this in kernel =
bootup
>>>>> (we downgraded back to 5.1.15, which we're on currently, after
>>>>> experiencing major performance issues on 5.3.6 and subsequently =
5.4.8
>>>>> didn't seem to fix those, and the 4.14.13 kernel that was used
>>>>> previously is known to cause ext4 corruption of the kind we saw on =
the
>>>>> other filesystems):
>>>>>=20
>>>>> [ 3932.271538] EXT4-fs (dm-7): ext4_check_descriptors: Block =
bitmap for
>>>>> group 404160 overlaps superblock
>>>>> [ 3932.271539] EXT4-fs (dm-7): group descriptors corrupted!
>>>>>=20
>>>>> I created a dumpe2fs file as well:
>>>>>=20
>>>>> crowsnest ~ # dumpe2fs /dev/lvm/home > /var/tmp/dump2fs_home.txt
>>>>> dumpe2fs 1.45.4 (23-Sep-2019)
>>>>> dumpe2fs: Block bitmap checksum does not match bitmap while trying =
to
>>>>> read '/dev/lvm/home' bitmaps
>>>>>=20
>>>>> Available at
>>>>> https://downloads.uls.co.za/85T/dump2fs_home.txt.xz
>>>>>  (1.2GB,
>>>>> md5:79b3250e209c067af2532d5324ff95aa, around 12GB extracted)
>>>>>=20
>>>>> A strace of e2fsck -y -f /dev/lvm/home at
>>>>>=20
>>>>> https://downloads.uls.co.za/85T/fsck.strace.txt
>>>>>  (13MB,
>>>>> md5:60aa91b0c47dd2837260218eb774152d)
>>>>>=20
>>>>> crowsnest ~ # tune2fs -l /dev/lvm/home
>>>>> tune2fs 1.45.4 (23-Sep-2019)
>>>>> Filesystem volume name:   <none>
>>>>> Last mounted on:          /home
>>>>> Filesystem UUID:          522a9faf-7992-4888-93d5-7fe49a9762d6
>>>>> Filesystem magic number:  0xEF53
>>>>> Filesystem revision #:    1 (dynamic)
>>>>> Filesystem features:      has_journal ext_attr filetype meta_bg =
extent
>>>>> 64bit flex_bg sparse_super large_file huge_file dir_nlink =
extra_isize
>>>>> metadata_csum
>>>>> Filesystem flags:         signed_directory_hash
>>>>> Default mount options:    user_xattr acl
>>>>> Filesystem state:         clean
>>>>> Errors behavior:          Continue
>>>>> Filesystem OS type:       Linux
>>>>> Inode count:              356515840
>>>>> Block count:              22817013760
>>>>> Reserved block count:     0
>>>>> Free blocks:              6874204745
>>>>> Free inodes:              202183498
>>>>> First block:              0
>>>>> Block size:               4096
>>>>> Fragment size:            4096
>>>>> Group descriptor size:    64
>>>>> Blocks per group:         32768
>>>>> Fragments per group:      32768
>>>>> Inodes per group:         512
>>>>> Inode blocks per group:   32
>>>>> RAID stride:              128
>>>>> RAID stripe width:        1024
>>>>> First meta block group:   2048
>>>>> Flex block group size:    16
>>>>> Filesystem created:       Thu Jul 26 12:19:07 2018
>>>>> Last mount time:          Sat Jan 18 18:58:50 2020
>>>>> Last write time:          Sun Jan 26 11:38:56 2020
>>>>> Mount count:              2
>>>>> Maximum mount count:      -1
>>>>> Last checked:             Wed Oct 30 17:37:27 2019
>>>>> Check interval:           0 (<none>)
>>>>> Lifetime writes:          976 TB
>>>>> Reserved blocks uid:      0 (user root)
>>>>> Reserved blocks gid:      0 (group root)
>>>>> First inode:              11
>>>>> Inode size:               256
>>>>> Required extra isize:     32
>>>>> Desired extra isize:      32
>>>>> Journal inode:            8
>>>>> Default directory hash:   half_md4
>>>>> Directory Hash Seed:      876a7d14-bce8-4bef-9569-82e7d573b7aa
>>>>> Journal backup:           inode blocks
>>>>> Checksum type:            crc32c
>>>>> Checksum:                 0xfbd895e9
>>>>>=20
>>>>> Infrastructure:  3 x RAID6 arrays, 2 of 12 x 4TB disks, and 1 of 4 =
x
>>>>> 10TB disks (100TB usable total).  These are combined into a single =
VG
>>>>> using LVM, and then carved up into a number of LVs, the largest of =
which
>>>>> is this 85TB chunk.  We have tried in the past to carve this into
>>>>> smaller LVs but failed.  So we're aware that this is very large =
and not
>>>>> ideal.
>>>>>=20
>>>>> We did experience an assembly issue on one of  the underlying =
RAID6 PVs,
>>>>> those have been resolved, and the disk that was giving issues has =
been
>>>>> scrubbed and rebuilt.  rom what we can tell based on other file =
systems,
>>>>> this did not affect data integrity but we can't make that =
statement with
>>>>> 100% certainty, as such we are expecting some data loss here but =
it
>>>>> would be better if we can recover at least some of this data.
>>>>>=20
>>>>> Other filesystems which also resides on the same PV that was =
affected by
>>>>> the RAID6 problem either received a clean bill of health, or were
>>>>> successfully repaired by e2fsck (the system did crash however, =
it's
>>>>> unclear whether the RAID6 assembly problem was the cause or merely
>>>>> another consequence, and as a result, whether the corruption on =
the
>>>>> repaired filesystem was a consequence of the kernel or the RAID).
>>>>>=20
>>>>> I'm continuing onwards with e2fsck code to try and figure this =
out, am
>>>>> hopeful though that someone could perhaps provide some much needed
>>>>> insight and pointers for me.
>>>>>=20
>>>>> Kind Regards,
>>>>> Jaco
>>>>>=20
>>>>>=20


Cheers, Andreas






--Apple-Mail=_56CB4B75-C940-4B1E-9D7F-CD4DE81D24D3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAl4vbxQACgkQcqXauRfM
H+CLnQ//XDQJH2LQHbB7umX5DXWxg1a+ziXFz3v0z46uVaGVxDLTuGOhP3Vtsx29
gDRcFjOa7f9AeHwZ5TsTRSUXDyFjzrRaCuoAkEZKbfp+DsH+hqJp7jhVhuvWSwKM
EfvKcQDBTETLB9yZ+VLlXwnXZAiD0brgU8ENAOdwBkISEaJIXOM9wrezdcVgx9X5
whe8gaIKcVogh/wugItjE0NMaSuoPAydr7l8uND7iq49uC9Te04WMNGTscM/vvfd
hBNB6ZBzjNTnVva+lpODll/nhEMH+QGo7iazHj776GQy5o71MfKNgjKLZRm+PlTq
Q7cTXwfL/9ICiQUdGYiTbheiFD5LEm+Pgd4aQMuNsylCIfmFYbsh9pwt5NB/Ylsy
qau2MlO0CFKkDhlP3y/Kh4DLvjgfNsGEie619YxgtClaJhhiDPS5M3Jfpvo1MM5t
tu/LzOit+OFrHhbeZzpfyv8a8j2WYFtHZj2idlDJV2RGt8KrPaH7qJ88MeO/citd
qkkjA32WiSEPQatypaQkz9PNf4NtYmrPRpUtuDm5OGIyLsS398nFcf8sR7ff9xkl
VW/Vre51VrFk26NysjekcwDgyP7wMDxP4lj1ngk0YFl/yQcn4DeMASjOfz9z5/Jk
/m4Y8CESLcYFirtxNwI2mWwZoNCGR6jdQMJLXJZ75pc8Lg5iBNA=
=eWch
-----END PGP SIGNATURE-----

--Apple-Mail=_56CB4B75-C940-4B1E-9D7F-CD4DE81D24D3--
