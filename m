Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 527DA149CDF
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Jan 2020 21:44:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgAZUoM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 26 Jan 2020 15:44:12 -0500
Received: from othala.iewc.co.za ([154.73.34.78]:60962 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAZUoM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 26 Jan 2020 15:44:12 -0500
Received: from [165.16.203.62] (helo=tauri.local.uls.co.za)
        by othala.iewc.co.za with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ivolH-00052v-KZ
        for linux-ext4@vger.kernel.org; Sun, 26 Jan 2020 22:44:03 +0200
Received: from [192.168.42.201]
        by tauri.local.uls.co.za with esmtp (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1ivof5-0005Xu-Ck
        for linux-ext4@vger.kernel.org; Sun, 26 Jan 2020 22:37:39 +0200
Subject: Re: e2fsck fails with unable to set superblock
From:   Jaco Kroon <jaco@uls.co.za>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
References: <6d775ef5-31e4-2b48-d5e6-d945de086919@uls.co.za>
Autocrypt: addr=jaco@uls.co.za; prefer-encrypt=mutual; keydata=
 mQENBFXtplYBCADM6RTLCOSPiclevkn/gdf8h9l+kKA6N+WGIIFuUtoc9Gaf8QhXWW/fvUq2
 a3eo4ULVFT1jJ56Vfm4MssGA97NZtlOe3cg8QJMZZhsoN5wetG9SrJvT9Rlltwo5nFmXY3ZY
 gXsdwkpDr9Y5TqBizx7DGxMd/mrOfXeql57FWFeOc2GuJBnHPZQMJsQ66l2obPn36hWEtHYN
 gcUSPH3OOusSEGZg/oX/8WSDQ/b8xz1JKTEgcnu/JR0FxzjY19zSHmbnyVU+/gF3oeJFcEUk
 HvZu776LRVdcZ0lb1bHQB2K9rTZBVeZLitgAefPVH2uERVSO8EZO1I5M7afV0Kd/Vyn9ABEB
 AAG0G0phY28gS3Jvb24gPGphY29AdWxzLmNvLnphPokBNwQTAQgAIQUCVe2mVgIbAwULCQgH
 AgYVCAkKCwIEFgIDAQIeAQIXgAAKCRAILcSxr/fungCPB/sHrfufpRbrVTtHUjpbY4bTQLQE
 bVrh4/yMiKprALRYy0nsMivl16Q/3rNWXJuQ0gR/faC3yNlDgtEoXx8noXOhva9GGHPGTaPT
 hhpcp/1E4C9Ghcaxw3MRapVnSKnSYL+zOOpkGwye2+fbqwCkCYCM7Vu6ws3+pMzJNFK/UOgW
 Tj8O5eBa3DiU4U26/jUHEIg74U+ypYPcj5qXG0xNXmmoDpZweW41Cfo6FMmgjQBTEGzo9e5R
 kjc7MH3+IyJvP4bzE5Paq0q0b5zZ8DUJFtT7pVb3FQTz1v3CutLlF1elFZzd9sZrg+mLA5PM
 o8PG9FLw9ZtTE314vgMWJ+TTYX0kuQENBFXtplYBCADedX9HSSJozh4YIBT+PuLWCTJRLTLu
 jXU7HobdK1EljPAi1ahCUXJR+NHvpJLSq/N5rtL12ejJJ4EMMp2UUK0IHz4kx26FeAJuOQMe
 GEzoEkiiR15ufkApBCRssIj5B8OA/351Y9PFore5KJzQf1psrCnMSZoJ89KLfU7C5S+ooX9e
 re2aWgu5jqKgKDLa07/UVHyxDTtQKRZSFibFCHbMELYKDr3tUdUfCDqVjipCzHmLZ+xMisfn
 yX9aTVI3FUIs8UiqM5xlxqfuCnDrKBJjQs3uvmd6cyhPRmnsjase48RoO84Ckjbp/HVu0+1+
 6vgiPjbe4xk7Ehkw1mfSxb79ABEBAAGJAR8EGAEIAAkFAlXtplYCGwwACgkQCC3Esa/37p7u
 XwgAjpFzUj+GMmo8ZeYwHH6YfNZQV+hfesr7tqlZn5DhQXJgT2NF6qh5Vn8TcFPR4JZiVIkF
 o0je7c8FJe34Aqex/H9R8LxvhENX/YOtq5+PqZj59y9G9+0FFZ1CyguTDC845zuJnnR5A0lw
 FARZaL8T7e6UGphtiT0NdR7EXnJ/alvtsnsNudtvFnKtigYvtw2wthW6CLvwrFjsuiXPjVUX
 825zQUnBHnrED6vG67UG4z5cQ4uY/LcSNsqBsoj6/wsT0pnqdibhCWmgFimOsSRgaF7qsVtg
 TWyQDTjH643+qYbJJdH91LASRLrenRCgpCXgzNWAMX6PJlqLrNX1Ye4CQw==
Organization: Ultimate Linux Solutions (Pty) Ltd
Message-ID: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
Date:   Sun, 26 Jan 2020 22:37:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <6d775ef5-31e4-2b48-d5e6-d945de086919@uls.co.za>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Spam-report: Relay access (othala.iewc.co.za).
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

So working through the dumpe2fs file, the group mentioned by dmesg
contains this:

Group 404160: (Blocks 13243514880-13243547647) csum 0x9546
  Group descriptor at 13243514880
  Block bitmap at 0 (bg #0 + 0), csum 0x00000000
  Inode bitmap at 0 (bg #0 + 0), csum 0x00000000
  Inode table at 0-31 (bg #0 + 0)
  0 free blocks, 0 free inodes, 0 directories
  Free blocks: 13243514880-13243547647
  Free inodes: 206929921-206930432

Based on that it's quite simple to see that during the array
reconstruction we apparently wiped a bunch of data blocks with all
zeroes.  This is obviously bad. During reconstruction we had to zero one
of the disks before we could get the array to reassemble. What I'm
wondering is whether this process was a good choice now, and whether the
right disk was zeroed.  Obviously this implies major data loss (at least
4TB, probably more assuming that directory structures may well have been
destroyed as well, maybe less if some of those blocks weren't in use).

I'm hoping that it's possible to recreate these group descriptors (there
are a few of them) to at least point to the correct locations on disk,
and to then attempt a cleanup with e2fsck.  Again, data loss here is to
be expected, but if we can limit it at least that would be great.

There are unfortunately a large bunch of groups affected (128 cases of
64 consecutive group blocks).

32768 blocks/group => 128 * 64 * 32768 blocks => 268m blocks, at
4KB/block => 1TB of data lost.  However, this is extremely conservative
seeing that this could include directory structures with cascading effect.

Based on the patterns of the first 64 group descriptors (GDs) it looks
like it should be possible to reconstruct the 8192 affected GDs, or
alternatively possibly "uninit" them
(https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Lazy_Block_Group_Initialization). 
I'm inclined to reason that it's probably safer to repair in the GDs the
following fields:

bg_block_bitmap_{lo,hi}
bg_inode_bitmap_{lo,hi}
bg_inode_table_{lo,hi}

I'm not sure about:

bg_flags (I'm guessing the safest is to leave this zeroed).
bg_exclude_bitmap_{lo,hi} (I don't know what this is used for).

The following should (as far as my understanding goes) then be "fixable"
by e2fsck:

bg_free_blocks_count_{lo,hi}
bg_free_inodes_count_{lo,hi}
bg_used_dirs_count_{lo,hi}
bg_block_bitmap_csum_{lo,hi}
bg_inode_bitmap_csum_{lo,hi}
bg_itable_unused_{lo,hi}
bg_checksum

And of course, tracking down the GD on disk will be tricky it seems. It
seems some blocks have the GD in the block, and a bunch of others don't
(nor does dumpe2fs say where exactly they are).  There is 2048 blocks of
GDs (131072 or 2^17 GDs) with every superblock backup, however, rom
group 2^17 onwards there are additional groups simply stating "Group
descriptor at ${frist_block_of_group}", so it's unclear how to track
down the GD for a given block group. 
https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Block_Group_Descriptors
does not describe this particularly well either, and there seems to be
confusion w.r.t. flex_bg and meta_bg features and this.

I do have an LVM snapshot of the affected LV currently, so happy to try
things.

Kind Regards,
Jaco

On 2020/01/26 12:21, Jaco Kroon wrote:

> Hi,
>
> I've got an 85TB ext4 filesystem which I'm unable to fsck.  The only
> cases of same error I could find was from what I can find due to an SD
> card "swallowing" writes (ie, the card goes into a read-only mode but
> doesn't report write failure).
>
> crowsnest ~ # e2fsck -f /dev/lvm/home
>
> e2fsck 1.45.4 (23-Sep-2019)
> ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
> e2fsck: Group descriptors look bad... trying backup blocks...
> /dev/lvm/home: recovering journal
> e2fsck: unable to set superblock flags on /dev/lvm/home
>
>
> /dev/lvm/home: ***** FILE SYSTEM WAS MODIFIED *****
>
> /dev/lvm/home: ********** WARNING: Filesystem still has errors **********
>
> I have also (using dumpe2fs) obtained the location of the backup super
> blocks and tried same against a few other superblocks using -b.  -y (as
> per suggestion from at least one post) make absolutely no difference,
> our understanding is that this simply answers yes to all questions, so
> we didn't expect this to have impact but decided it was worth a try anyway.
>
> Looking at the code for the unable to set superblock error it looks like
> the code is in e2fsck/unix.c, specifically this:
>
> 1765     if (ext2fs_has_feature_journal_needs_recovery(sb)) {
> 1766         if (ctx->options & E2F_OPT_READONLY) {
> ...
> 1771         } else {
> 1772             if (ctx->flags & E2F_FLAG_RESTARTED) {
> 1773                 /*
> 1774                  * Whoops, we attempted to run the
> 1775                  * journal twice.  This should never
> 1776                  * happen, unless the hardware or
> 1777                  * device driver is being bogus.
> 1778                  */
> 1779                 com_err(ctx->program_name, 0,
> 1780                     _("unable to set superblock flags "
> 1781                       "on %s\n"), ctx->device_name);
> 1782                 fatal_error(ctx, 0);
> 1783             }
>
> That comment has me somewhat confused.  I'm assuming the implication
> there is that e2fsck tried to update the superblock, but after reading
> it back, it's either unchanged or still wrong (In line with the
> description of the SD card I found online).  None of our arrays are
> reflecting R/O in /proc/mdstat. We did pick out this in kernel bootup
> (we downgraded back to 5.1.15, which we're on currently, after
> experiencing major performance issues on 5.3.6 and subsequently 5.4.8
> didn't seem to fix those, and the 4.14.13 kernel that was used
> previously is known to cause ext4 corruption of the kind we saw on the
> other filesystems):
>
> [ 3932.271538] EXT4-fs (dm-7): ext4_check_descriptors: Block bitmap for
> group 404160 overlaps superblock
> [ 3932.271539] EXT4-fs (dm-7): group descriptors corrupted!
>
> I created a dumpe2fs file as well:
>
> crowsnest ~ # dumpe2fs /dev/lvm/home > /var/tmp/dump2fs_home.txt
> dumpe2fs 1.45.4 (23-Sep-2019)
> dumpe2fs: Block bitmap checksum does not match bitmap while trying to
> read '/dev/lvm/home' bitmaps
>
> Available at https://downloads.uls.co.za/85T/dump2fs_home.txt.xz (1.2GB,
> md5:79b3250e209c067af2532d5324ff95aa, around 12GB extracted)
>
> A strace of e2fsck -y -f /dev/lvm/home at
> https://downloads.uls.co.za/85T/fsck.strace.txt (13MB,
> md5:60aa91b0c47dd2837260218eb774152d)
>
> crowsnest ~ # tune2fs -l /dev/lvm/home
> tune2fs 1.45.4 (23-Sep-2019)
> Filesystem volume name:   <none>
> Last mounted on:          /home
> Filesystem UUID:          522a9faf-7992-4888-93d5-7fe49a9762d6
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr filetype meta_bg extent
> 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize
> metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              356515840
> Block count:              22817013760
> Reserved block count:     0
> Free blocks:              6874204745
> Free inodes:              202183498
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         512
> Inode blocks per group:   32
> RAID stride:              128
> RAID stripe width:        1024
> First meta block group:   2048
> Flex block group size:    16
> Filesystem created:       Thu Jul 26 12:19:07 2018
> Last mount time:          Sat Jan 18 18:58:50 2020
> Last write time:          Sun Jan 26 11:38:56 2020
> Mount count:              2
> Maximum mount count:      -1
> Last checked:             Wed Oct 30 17:37:27 2019
> Check interval:           0 (<none>)
> Lifetime writes:          976 TB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               256
> Required extra isize:     32
> Desired extra isize:      32
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      876a7d14-bce8-4bef-9569-82e7d573b7aa
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0xfbd895e9
>
> Infrastructure:  3 x RAID6 arrays, 2 of 12 x 4TB disks, and 1 of 4 x
> 10TB disks (100TB usable total).  These are combined into a single VG
> using LVM, and then carved up into a number of LVs, the largest of which
> is this 85TB chunk.  We have tried in the past to carve this into
> smaller LVs but failed.  So we're aware that this is very large and not
> ideal.
>
> We did experience an assembly issue on one of  the underlying RAID6 PVs,
> those have been resolved, and the disk that was giving issues has been
> scrubbed and rebuilt.  rom what we can tell based on other file systems,
> this did not affect data integrity but we can't make that statement with
> 100% certainty, as such we are expecting some data loss here but it
> would be better if we can recover at least some of this data.
>
> Other filesystems which also resides on the same PV that was affected by
> the RAID6 problem either received a clean bill of health, or were
> successfully repaired by e2fsck (the system did crash however, it's
> unclear whether the RAID6 assembly problem was the cause or merely
> another consequence, and as a result, whether the corruption on the
> repaired filesystem was a consequence of the kernel or the RAID).
>
> I'm continuing onwards with e2fsck code to try and figure this out, am
> hopeful though that someone could perhaps provide some much needed
> insight and pointers for me.
>
> Kind Regards,
> Jaco
>
