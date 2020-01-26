Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88204149D15
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2020 22:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgAZVqC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 16:46:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45430 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgAZVqC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Jan 2020 16:46:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id 2so3950872pfg.12
        for <linux-ext4@vger.kernel.org>; Sun, 26 Jan 2020 13:46:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TxK+2GX4tm5saZBTaxkrkl2/YhPpjXdq0KLSCIX52Os=;
        b=BHqLVdHfSnl7396Lj3vEJFyO3S939Y3Sbxlr26P8pyps8HvvVf/PXDxyZ01qYqDBtO
         mSmBwjNL7PONp/0XL5J+LfkAb6VRFqHcr6NYTeJAWxFA6+PXL4hz7BDJOrRTInmobinU
         D/zbNm5mP6//L3g/fVt/7ulQlNupeBw/Lv8aF88ff50baNWUQjr6Fh4m6kyUfist7M1a
         XfGr9j9JyOv3VU6XoXVzyXrs00LsElL7nQGyCEKkscaIDq77ZVoGaq12yxmyeFIwD3Px
         ESq8Iao+1Sn16TQUJq538Ds+Z0v28HexcYMKF8dEu4Bu6C3uCN3RHurnMxxl6rmNWusA
         efIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TxK+2GX4tm5saZBTaxkrkl2/YhPpjXdq0KLSCIX52Os=;
        b=mBdb1/jIXVuAM4X47g2WRea0QfXVklOWhxgN7+EITYEwnafSgqdwnf4KL8KqEez+gH
         CWWj0BR4f1SLgQeRSMFNFOYv6fHcbLgZTyx8yQ95WjQ0JvVId578cYEAqr2mj5LJQL2G
         qFIonMX6oNBqzJihEV4gjl9i97NTJbF+QKLi04rbm5NdFsCqONNN8BQgP600piMYaAmG
         2v9199YMt7VmwtYc38cf+83NmxM5Ld7lPWEkRASWjq00MR52VBTA9LgQT9cqOTpNKvbQ
         uYuQqzyl920VxpQvMgSAT29uJRAoYgk1G80oJjgQqyxi3a3IPQ0a3hU2wg2LLz/qvAyA
         rfXQ==
X-Gm-Message-State: APjAAAWuzeCoLoqSXqJfS3NX9r2EKkCpA38DLvpzaThDd+v3bZi0D/M0
        i2i4LgaXwwhk67nu9Fd8pnzkcfC4Ipc=
X-Google-Smtp-Source: APXvYqzvq8qCCTwHP+9rc78Y+UuK+Ka/cQWgCS59UMpToleJTzSbwwj4Je8yJNw2ZquGvTVeiV9faw==
X-Received: by 2002:a63:6602:: with SMTP id a2mr15308725pgc.403.1580075161495;
        Sun, 26 Jan 2020 13:46:01 -0800 (PST)
Received: from [192.168.10.175] (S0106a84e3fe4b223.cg.shawcable.net. [70.77.216.213])
        by smtp.gmail.com with ESMTPSA id z26sm13410759pfa.90.2020.01.26.13.46.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2020 13:46:00 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andreas Dilger <adilger@dilger.ca>
Mime-Version: 1.0 (1.0)
Subject: Re: e2fsck fails with unable to set superblock
Date:   Sun, 26 Jan 2020 14:45:59 -0700
Message-Id: <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
In-Reply-To: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
To:     Jaco Kroon <jaco@uls.co.za>
X-Mailer: iPhone Mail (17C54)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

There are backups of all the group descriptors that can be used in such case=
s, immediately following the backup superblocks.=20

Failing that, the group descriptors follow a very regular pattern and could b=
e recreated by hand if needed (eg. all the backups were also corrupted for s=
ome reason).

Cheers, Andreas

> On Jan 26, 2020, at 13:44, Jaco Kroon <jaco@uls.co.za> wrote:
>=20
> =EF=BB=BFHi,
>=20
> So working through the dumpe2fs file, the group mentioned by dmesg
> contains this:
>=20
> Group 404160: (Blocks 13243514880-13243547647) csum 0x9546
>   Group descriptor at 13243514880
>   Block bitmap at 0 (bg #0 + 0), csum 0x00000000
>   Inode bitmap at 0 (bg #0 + 0), csum 0x00000000
>   Inode table at 0-31 (bg #0 + 0)
>   0 free blocks, 0 free inodes, 0 directories
>   Free blocks: 13243514880-13243547647
>   Free inodes: 206929921-206930432
>=20
> Based on that it's quite simple to see that during the array
> reconstruction we apparently wiped a bunch of data blocks with all
> zeroes.  This is obviously bad. During reconstruction we had to zero one
> of the disks before we could get the array to reassemble. What I'm
> wondering is whether this process was a good choice now, and whether the
> right disk was zeroed.  Obviously this implies major data loss (at least
> 4TB, probably more assuming that directory structures may well have been
> destroyed as well, maybe less if some of those blocks weren't in use).
>=20
> I'm hoping that it's possible to recreate these group descriptors (there
> are a few of them) to at least point to the correct locations on disk,
> and to then attempt a cleanup with e2fsck.  Again, data loss here is to
> be expected, but if we can limit it at least that would be great.
>=20
> There are unfortunately a large bunch of groups affected (128 cases of
> 64 consecutive group blocks).
>=20
> 32768 blocks/group =3D> 128 * 64 * 32768 blocks =3D> 268m blocks, at
> 4KB/block =3D> 1TB of data lost.  However, this is extremely conservative
> seeing that this could include directory structures with cascading effect.=

>=20
> Based on the patterns of the first 64 group descriptors (GDs) it looks
> like it should be possible to reconstruct the 8192 affected GDs, or
> alternatively possibly "uninit" them
> (https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Lazy_Block_Group_=
Initialization).=20
> I'm inclined to reason that it's probably safer to repair in the GDs the
> following fields:
>=20
> bg_block_bitmap_{lo,hi}
> bg_inode_bitmap_{lo,hi}
> bg_inode_table_{lo,hi}
>=20
> I'm not sure about:
>=20
> bg_flags (I'm guessing the safest is to leave this zeroed).
> bg_exclude_bitmap_{lo,hi} (I don't know what this is used for).
>=20
> The following should (as far as my understanding goes) then be "fixable"
> by e2fsck:
>=20
> bg_free_blocks_count_{lo,hi}
> bg_free_inodes_count_{lo,hi}
> bg_used_dirs_count_{lo,hi}
> bg_block_bitmap_csum_{lo,hi}
> bg_inode_bitmap_csum_{lo,hi}
> bg_itable_unused_{lo,hi}
> bg_checksum
>=20
> And of course, tracking down the GD on disk will be tricky it seems. It
> seems some blocks have the GD in the block, and a bunch of others don't
> (nor does dumpe2fs say where exactly they are).  There is 2048 blocks of
> GDs (131072 or 2^17 GDs) with every superblock backup, however, rom
> group 2^17 onwards there are additional groups simply stating "Group
> descriptor at ${frist_block_of_group}", so it's unclear how to track
> down the GD for a given block group.=20
> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Block_Group_Descri=
ptors
> does not describe this particularly well either, and there seems to be
> confusion w.r.t. flex_bg and meta_bg features and this.
>=20
> I do have an LVM snapshot of the affected LV currently, so happy to try
> things.
>=20
> Kind Regards,
> Jaco
>=20
>> On 2020/01/26 12:21, Jaco Kroon wrote:
>>=20
>> Hi,
>>=20
>> I've got an 85TB ext4 filesystem which I'm unable to fsck.  The only
>> cases of same error I could find was from what I can find due to an SD
>> card "swallowing" writes (ie, the card goes into a read-only mode but
>> doesn't report write failure).
>>=20
>> crowsnest ~ # e2fsck -f /dev/lvm/home
>>=20
>> e2fsck 1.45.4 (23-Sep-2019)
>> ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
>> e2fsck: Group descriptors look bad... trying backup blocks...
>> /dev/lvm/home: recovering journal
>> e2fsck: unable to set superblock flags on /dev/lvm/home
>>=20
>>=20
>> /dev/lvm/home: ***** FILE SYSTEM WAS MODIFIED *****
>>=20
>> /dev/lvm/home: ********** WARNING: Filesystem still has errors **********=

>>=20
>> I have also (using dumpe2fs) obtained the location of the backup super
>> blocks and tried same against a few other superblocks using -b.  -y (as
>> per suggestion from at least one post) make absolutely no difference,
>> our understanding is that this simply answers yes to all questions, so
>> we didn't expect this to have impact but decided it was worth a try anywa=
y.
>>=20
>> Looking at the code for the unable to set superblock error it looks like
>> the code is in e2fsck/unix.c, specifically this:
>>=20
>> 1765     if (ext2fs_has_feature_journal_needs_recovery(sb)) {
>> 1766         if (ctx->options & E2F_OPT_READONLY) {
>> ...
>> 1771         } else {
>> 1772             if (ctx->flags & E2F_FLAG_RESTARTED) {
>> 1773                 /*
>> 1774                  * Whoops, we attempted to run the
>> 1775                  * journal twice.  This should never
>> 1776                  * happen, unless the hardware or
>> 1777                  * device driver is being bogus.
>> 1778                  */
>> 1779                 com_err(ctx->program_name, 0,
>> 1780                     _("unable to set superblock flags "
>> 1781                       "on %s\n"), ctx->device_name);
>> 1782                 fatal_error(ctx, 0);
>> 1783             }
>>=20
>> That comment has me somewhat confused.  I'm assuming the implication
>> there is that e2fsck tried to update the superblock, but after reading
>> it back, it's either unchanged or still wrong (In line with the
>> description of the SD card I found online).  None of our arrays are
>> reflecting R/O in /proc/mdstat. We did pick out this in kernel bootup
>> (we downgraded back to 5.1.15, which we're on currently, after
>> experiencing major performance issues on 5.3.6 and subsequently 5.4.8
>> didn't seem to fix those, and the 4.14.13 kernel that was used
>> previously is known to cause ext4 corruption of the kind we saw on the
>> other filesystems):
>>=20
>> [ 3932.271538] EXT4-fs (dm-7): ext4_check_descriptors: Block bitmap for
>> group 404160 overlaps superblock
>> [ 3932.271539] EXT4-fs (dm-7): group descriptors corrupted!
>>=20
>> I created a dumpe2fs file as well:
>>=20
>> crowsnest ~ # dumpe2fs /dev/lvm/home > /var/tmp/dump2fs_home.txt
>> dumpe2fs 1.45.4 (23-Sep-2019)
>> dumpe2fs: Block bitmap checksum does not match bitmap while trying to
>> read '/dev/lvm/home' bitmaps
>>=20
>> Available at https://downloads.uls.co.za/85T/dump2fs_home.txt.xz (1.2GB,
>> md5:79b3250e209c067af2532d5324ff95aa, around 12GB extracted)
>>=20
>> A strace of e2fsck -y -f /dev/lvm/home at
>> https://downloads.uls.co.za/85T/fsck.strace.txt (13MB,
>> md5:60aa91b0c47dd2837260218eb774152d)
>>=20
>> crowsnest ~ # tune2fs -l /dev/lvm/home
>> tune2fs 1.45.4 (23-Sep-2019)
>> Filesystem volume name:   <none>
>> Last mounted on:          /home
>> Filesystem UUID:          522a9faf-7992-4888-93d5-7fe49a9762d6
>> Filesystem magic number:  0xEF53
>> Filesystem revision #:    1 (dynamic)
>> Filesystem features:      has_journal ext_attr filetype meta_bg extent
>> 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize
>> metadata_csum
>> Filesystem flags:         signed_directory_hash
>> Default mount options:    user_xattr acl
>> Filesystem state:         clean
>> Errors behavior:          Continue
>> Filesystem OS type:       Linux
>> Inode count:              356515840
>> Block count:              22817013760
>> Reserved block count:     0
>> Free blocks:              6874204745
>> Free inodes:              202183498
>> First block:              0
>> Block size:               4096
>> Fragment size:            4096
>> Group descriptor size:    64
>> Blocks per group:         32768
>> Fragments per group:      32768
>> Inodes per group:         512
>> Inode blocks per group:   32
>> RAID stride:              128
>> RAID stripe width:        1024
>> First meta block group:   2048
>> Flex block group size:    16
>> Filesystem created:       Thu Jul 26 12:19:07 2018
>> Last mount time:          Sat Jan 18 18:58:50 2020
>> Last write time:          Sun Jan 26 11:38:56 2020
>> Mount count:              2
>> Maximum mount count:      -1
>> Last checked:             Wed Oct 30 17:37:27 2019
>> Check interval:           0 (<none>)
>> Lifetime writes:          976 TB
>> Reserved blocks uid:      0 (user root)
>> Reserved blocks gid:      0 (group root)
>> First inode:              11
>> Inode size:               256
>> Required extra isize:     32
>> Desired extra isize:      32
>> Journal inode:            8
>> Default directory hash:   half_md4
>> Directory Hash Seed:      876a7d14-bce8-4bef-9569-82e7d573b7aa
>> Journal backup:           inode blocks
>> Checksum type:            crc32c
>> Checksum:                 0xfbd895e9
>>=20
>> Infrastructure:  3 x RAID6 arrays, 2 of 12 x 4TB disks, and 1 of 4 x
>> 10TB disks (100TB usable total).  These are combined into a single VG
>> using LVM, and then carved up into a number of LVs, the largest of which
>> is this 85TB chunk.  We have tried in the past to carve this into
>> smaller LVs but failed.  So we're aware that this is very large and not
>> ideal.
>>=20
>> We did experience an assembly issue on one of  the underlying RAID6 PVs,
>> those have been resolved, and the disk that was giving issues has been
>> scrubbed and rebuilt.  rom what we can tell based on other file systems,
>> this did not affect data integrity but we can't make that statement with
>> 100% certainty, as such we are expecting some data loss here but it
>> would be better if we can recover at least some of this data.
>>=20
>> Other filesystems which also resides on the same PV that was affected by
>> the RAID6 problem either received a clean bill of health, or were
>> successfully repaired by e2fsck (the system did crash however, it's
>> unclear whether the RAID6 assembly problem was the cause or merely
>> another consequence, and as a result, whether the corruption on the
>> repaired filesystem was a consequence of the kernel or the RAID).
>>=20
>> I'm continuing onwards with e2fsck code to try and figure this out, am
>> hopeful though that someone could perhaps provide some much needed
>> insight and pointers for me.
>>=20
>> Kind Regards,
>> Jaco
>>=20
