Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B39514C1E7
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2020 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgA1VMz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jan 2020 16:12:55 -0500
Received: from othala.iewc.co.za ([154.73.34.78]:59882 "EHLO othala.iewc.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgA1VMy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jan 2020 16:12:54 -0500
Received: from [165.16.203.62] (helo=tauri.local.uls.co.za)
        by othala.iewc.co.za with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1iwYA4-0007j5-A5; Tue, 28 Jan 2020 23:12:40 +0200
Received: from [192.168.42.201]
        by tauri.local.uls.co.za with esmtp (Exim 4.92.2)
        (envelope-from <jaco@uls.co.za>)
        id 1iwYA3-0005FA-M8; Tue, 28 Jan 2020 23:12:39 +0200
Subject: Re: e2fsck fails with unable to set superblock
From:   Jaco Kroon <jaco@uls.co.za>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>
References: <20b3e5da-b3ac-edae-ffe0-f6d097c2e309@uls.co.za>
 <91A26A7C-557D-497B-A5ED-B8981B562C24@dilger.ca>
 <90b76473-8ca5-e50a-6c8c-31ea418df7ed@uls.co.za>
 <ebc2dd95-1020-1f6c-f435-f53cf907f9e6@uls.co.za>
 <57CCDA98-4334-469B-B6D8-364417E69423@dilger.ca>
 <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
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
Message-ID: <50b83755-3c24-ceff-2529-c89ef4df363b@uls.co.za>
Date:   Tue, 28 Jan 2020 23:12:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <61127f04-96bf-58ff-983d-f4b87b7d88f8@uls.co.za>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-Spam-report: Relay access (othala.iewc.co.za).
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

Just to provide feedback, and perhaps some usage tips for anyone reading
the thread (and before I forget how all of this stuck together in the end).

I used the code at http://downloads.uls.co.za/85T/ext4_rebuild_gds.c to
recover.  Firstly I generated a list of GDs that needed to be repaired:

./ext4_rebuild_gds /dev/lvm/snap_home 2>&1 | tee /var/tmp/rebuild_checks.txt

snap_home is marked read-only in LVM (my safety/as close to a
block-level backup I can come).

cd /var/tmp
grep differs: rebuild_checks.txt | grep -v bg_flags | sed -re 's/^Group
([0-9]+), .*/\1/p' | uniq | awk 'BEGIN{ start=-1; prev=-10 } { if (prev
< $1-1) { if (start >= 0) { print start " " prev }; start=$1 }; prev=$1
} END{ print start " " prev }' > blocks.txt

exec 3<blocks.txt; while read A B <&3; do oblock=$(~/ext4_rebuild_gds
/dev/lvm/snap_home $A $B 2>&1 > .$A.tmp | sed -nre 's/^Physical GD block
for output start: //p') && mv .$A.tmp $A-$oblock.block; done

for i in *.block; do sblock=$(basename ${i#*-} .block); for o in 0
32768; do dd if=$i of=/dev/lvm/home bs=4096 seek=$(( sblock + o ));
done; done

I also did validate that for all pairs in blocks.txt B-A == 64, and A%64
== 0 (to make sure it's a full GDT block that I need to update).  If
this is not the case, you should reduce A such that it becomes a
multiple of 64, then adjust B such that B-A==64 (add additional pairs
such that the entire original A to B range is covered).  This may set
ZEROED bg_flags value on some GDs as a side effect but hopefully this
won't cause problems.  I also verified that all A >= first_meta_bg -
else you need to find appropriate block directly following super-block.

I only replaced the first two copies of the GDT blocks in each case,
could replace the third as well by adding a 32768*63 entry for o in the
inner for loop.

fsck is now running and getting past the previous failure point.  I am
hopeful that we'll at least recover some data.

I do have a few questions regarding fsck though:

1.  Will it notice that the backups GDT blocks are not the same as the
primaries and replace the backup blocks?

2.  I'm assuming it will rebuild the reachability for all inodes
starting at / and thus be able to determine which inodes should be
free/in use, and rebuild bitmaps accordingly (as well as mark the inodes
themselves free)?

3.  Sort out all buggered up checksums in the GDs I've changed?

Anyway, perhaps someone can answer out of hand, otherwise time will
tell, to date:

# e2fsck -y -f /dev/lvm/home
e2fsck 1.45.4 (23-Sep-2019)
Pass 1: Checking inodes, blocks, and sizes
Inodes that were part of a corrupted orphan linked list found.  Fix? yes

Inode 13844923 was part of the orphaned inode list.  FIXED.
Inode 13844932 has an invalid extent node (blk 13666881850, lblk 27684864)
Clear? yes

Kind Regards,
Jaco

On 2020/01/28 14:53, Jaco Kroon wrote:

> Hi Andreas,
>
> On 2020/01/28 01:15, Andreas Dilger wrote:
>> On Jan 27, 2020, at 10:52 AM, Jaco Kroon <jaco@uls.co.za> wrote:
>>> Hi Andreas,
>>>
>>> Ok, so there were a few calc errors below.  I believe I've rectified those.  I've written code to both locate and read the GD, as well as generate the fields I plan to update, comparing the fields I plan to update against those of all known-good blocks.  The only issue I've picked up is that I've realised I don't understand bg_flags at all.  Extract from output of my program (it uses the read GD as template and then just overwrites the fields I'm calculating).
>>> Group 65542, bg_flags differs: 0 (actual) != 4 (generated)
>> The EXT2_BG_{INODE,BLOCK}_UNINIT flags mean that the inode/block bitmaps are
>> all zero and do not need to be read from disk.  That should only be used for
>> groups that have no blocks or inodes allocated to them.
>>
>> The EXT2_BG_INODE_ZEROED flag means that the inode table has been zeroed out
>> on disk after the filesystem has been formatted.  It is safest to set this
>> flag on the group, so that the kernel does not try to zero out the inode tables
>> again, especially if your bitmaps are not correct.
> That makes sense.  Good explanation thank you.
>
>>> and to possibly inspect the data at inode_table looking for some kind of "magic" as to whether or not it's already initialized or not...
>> The group descriptors also have a checksum that needs to be valid.
> I'm hoping fsck will fix this after I've actioned mine?
>>> My code is available at http://downloads.uls.co.za/85T/ext4_rebuild_gds.c for anyone that cares.  Currently some work pending.
>> It probably makes more sense to include this into e2fsck, so that it will be
>> usable for everyone.
> I agree.  For now I needed quick and nasty.  I have no objection to do a
> patch at some point on e2fsck, or someone else can use my throw-away
> code and refine it.  For now I'm taking stdout from that and using dd to
> clobber the meta_bg GDT blocks, as well as replace the backups.  One
> reason for not doing that from the start was simply that I had no idea
> where exactly this would need to go into e2fsck.
>>   IMHO, there is a design flaw in the meta_bg disk format,
>> in that the last group(s) of the filesystem may have few/no backup copies, so
>> cannot easily be recovered in case of an error.
> 1 copy if there is only one group, 2 of fewer than meta_bg groups ... 3
> otherwise.  Frankly I'm OK(ish) with three backups, one of which is
> typically ~128MB away from the first two.  Perhaps not quite good
> enough.  I get where you're coming from.  This is the first time that
> I've personally experienced GD corruption failures, or at least, that I
> *know* what I'm looking at.  Having said that, in >15 years this is only
> the third ext* filesystem that I've managed to corrupt to the point
> where fsck would not recover it.  The previous one was a few years back,
> and that was due to a major hardware issue.  The time before that was
> sheer incompetence and stupidity.
>
>> There is also the secondary
>> issue that meta_bg causes the metadata to be spread out over the whole disk,
>> which causes a *LOT* of seeking on a very large filesystem, on the order of
>> millions of seeks, which takes a lot of time to read.
> I can't comment to that.  I don't know how often these things are
> actually read from disk, whether it's once-off during mount time, or
> whether there are further reads of these blocks after that.  If it's
> once off I don't particularly care personally, if an 85TB file system
> takes a minute to mount ... so be it.  If it's continuous ... yes that
> can become problematic I reckon.
>
> Thank you very much for the information, you've managed to (even though
> not tell me how to fix my issue) at the very least confirm some things
> for me.  Aware this is goodwill, and that's more than I could ask for in
> all reality.
>
> Kind Regards,
> Jaco
>
>>> On 2020/01/27 12:24, Jaco Kroon wrote:
>>>> Hi Andreas,
>>>>
>>>> Thank you.  The filesystem uses meta_bg and is larger than 16TB, my issue also doesn't exhibit in the first 16TB covered by those blocks.
>>>> On 2020/01/26 23:45, Andreas Dilger wrote:
>>>>> There are backups of all the group descriptors that can be used in such cases, immediately following the backup superblocks.
>>>>>
>>>>> Failing that, the group descriptors follow a very regular pattern and could be recreated by hand if needed (eg. all the backups were also corrupted for some reason).
>>>>>
>>>> You are right.  It's however tricky to wrap your head around it.  I think I've got it, but if you don't mind double checking me please:
>>>>
>>>> Given a group number g.  sb = superblock.
>>>> gds_per_block = 2^(10+sb.s_log_block_size) / sb.s_desc_size = 4096 / 64 = 64
>>>> gd_block = floor(g / gds_per_block)
>>>> if (gd_block < ${sb.s_reserved_gdt_blocks})
>>>>   phys_gd_block = gd_block + 1;
>>>> else
>>>>   phys_gd_block = floor(gd_block / gds_per_block) * gds_per_block * sb.s_blocks_per_group
>>>>
>>>> phys_gd_block_offset = sb.s_desc_size * (g % gds_per_block)
>>>>
>>>> Backup blocks, are either with every superblock backup (groups 0, and groups being a power of 3, 5 and 7, ie, 0, 1, 3, 5, 7, 9, 25, 27, ...) where gd_block < ${sb.s_reserved_gdt_blocks); or
>>>> phys_gd_backup1 = phys_gd_block + sb.s_blocks_per_group
>>>> phys_gd_backup2 = phys_gd_block + sb.s_blocks_per_group * (gds_per_block - 1)
>>>>
>>>> offset stays the same.
>>>>
>>>> To reconstruct it's critical to fill the following fields, with the required calculations (gd = group descriptor, calculations for groups < 2^17, using 131072 as example):
>>>>
>>>> bitmap_group = floor(g / flex_groups) * flex_groups
>>>>     => floor(131072 / 16) * 16 => 131072
>>>> gd.bg_block_bitmap = bitmap_group * blocks_per_group + g % flex_groups
>>>>     => 131072 * 3768 + 131072 % 16
>>>>     => 493879296
>>>> if (bitmap_group % gds_per_block == 0) /* if bitmap_group also houses a meta group block */
>>>>     gd.bg_block_bitmap++;
>>>> => if (131072 % 64 == 0)
>>>> => if (0 == 0)
>>>> => gd.bg_block_bitmap = 493879297
>>>>
>>>> gd.bg_inode_bitmap = gd.bg_block_bitmap + flex_groups
>>>>  => gd.bg_inode_bitmap = 493879297 + 16 = 493879313
>>>> gd.bg_inode_table = gd.bg_inode_bitmap + flex_groups - (g % flex_groups) + (g % flex_groups * inode_blocks_per_group)
>>>>  => 493879313 + 16 - 0 + 0 * 32 = 493879329
>>>> Bad example, for g=131074:
>>>>  =>493879315 + 16 - 2 + 2 * 32 = 493879393
>>>>
>>>> gd.bg_flags = 0x4
>>>>
>>>> I suspect it's OK to just zero (or leave them zero) these:
>>>>
>>>> bg_free_blocks_count
>>>> bg_free_inodes_count
>>>> bg_used_dirs_count
>>>> bg_exclude_bitmap
>>>> bg_itable_unused
>>>>
>>>> As well as all checksum fields (hopefully e2fsck will correct those).
>>>> I did action this calculation for a few non-destructed GDs and my manual calculations seems OK for the groups I checked (all into meta_bg area):
>>>>
>>>> 131072 (multiple of 64, meta_bg + fleg_bg)
>>>> 131073 (multiple of 64 + 1 - first meta_bg backup)
>>>> 131074 (none of the others, ie, plain group with data blocks only)
>>>> 131088 (multiple of 16 but not 64, flex_bg)
>>>> 131089 (multiple of 16 but not 64, +1)
>>>> 131135 (multiple of 64 + 63 - second meta_bg backup)
>>>> It is however a very limited sample, but should cover all the corner cases I could think of based on the specification and my understanding thereof.
>>>>
>>>> Given the above I should be able to write a small program that will produce the 128 4KiB blocks that's required, and then I can use dd to place them into the correct locations.
>>>> As an aside, debugfs refuses to open the filesystem:
>>>>
>>>> crowsnest ~ # debugfs /dev/lvm/home
>>>> debugfs 1.45.4 (23-Sep-2019)
>>>> /dev/lvm/home: Block bitmap checksum does not match bitmap while reading allocation bitmaps
>>>> debugfs:  chroot /
>>>> chroot: Filesystem not open
>>>> debugfs:  quit
>>>> Which is probably fair.  So for this one I'll have to go make modifications using either some programatic tool that opens the underlying block device, or use dd trickery (ie, construct a GD and dd it into the right location, a a sequence of 64 GDs as it's always 64 GDs that's destroyed in my case, exactly 1 4KiB block).
>>>>
>>>> Kind Regards,
>>>> Jaco
>>>>> Cheers, Andreas
>>>>>
>>>>>
>>>>>> On Jan 26, 2020, at 13:44, Jaco Kroon <jaco@uls.co.za>
>>>>>>  wrote:
>>>>>>
>>>>>> ﻿Hi,
>>>>>>
>>>>>> So working through the dumpe2fs file, the group mentioned by dmesg
>>>>>> contains this:
>>>>>>
>>>>>> Group 404160: (Blocks 13243514880-13243547647) csum 0x9546
>>>>>>   Group descriptor at 13243514880
>>>>>>   Block bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>>>   Inode bitmap at 0 (bg #0 + 0), csum 0x00000000
>>>>>>   Inode table at 0-31 (bg #0 + 0)
>>>>>>   0 free blocks, 0 free inodes, 0 directories
>>>>>>   Free blocks: 13243514880-13243547647
>>>>>>   Free inodes: 206929921-206930432
>>>>>>
>>>>>> Based on that it's quite simple to see that during the array
>>>>>> reconstruction we apparently wiped a bunch of data blocks with all
>>>>>> zeroes.  This is obviously bad. During reconstruction we had to zero one
>>>>>> of the disks before we could get the array to reassemble. What I'm
>>>>>> wondering is whether this process was a good choice now, and whether the
>>>>>> right disk was zeroed.  Obviously this implies major data loss (at least
>>>>>> 4TB, probably more assuming that directory structures may well have been
>>>>>> destroyed as well, maybe less if some of those blocks weren't in use).
>>>>>>
>>>>>> I'm hoping that it's possible to recreate these group descriptors (there
>>>>>> are a few of them) to at least point to the correct locations on disk,
>>>>>> and to then attempt a cleanup with e2fsck.  Again, data loss here is to
>>>>>> be expected, but if we can limit it at least that would be great.
>>>>>>
>>>>>> There are unfortunately a large bunch of groups affected (128 cases of
>>>>>> 64 consecutive group blocks).
>>>>>>
>>>>>> 32768 blocks/group => 128 * 64 * 32768 blocks => 268m blocks, at
>>>>>> 4KB/block => 1TB of data lost.  However, this is extremely conservative
>>>>>> seeing that this could include directory structures with cascading effect.
>>>>>>
>>>>>> Based on the patterns of the first 64 group descriptors (GDs) it looks
>>>>>> like it should be possible to reconstruct the 8192 affected GDs, or
>>>>>> alternatively possibly "uninit" them
>>>>>> (
>>>>>> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Lazy_Block_Group_Initialization
>>>>>> ).
>>>>>> I'm inclined to reason that it's probably safer to repair in the GDs the
>>>>>> following fields:
>>>>>>
>>>>>> bg_block_bitmap_{lo,hi}
>>>>>> bg_inode_bitmap_{lo,hi}
>>>>>> bg_inode_table_{lo,hi}
>>>>>>
>>>>>> I'm not sure about:
>>>>>>
>>>>>> bg_flags (I'm guessing the safest is to leave this zeroed).
>>>>>> bg_exclude_bitmap_{lo,hi} (I don't know what this is used for).
>>>>>>
>>>>>> The following should (as far as my understanding goes) then be "fixable"
>>>>>> by e2fsck:
>>>>>>
>>>>>> bg_free_blocks_count_{lo,hi}
>>>>>> bg_free_inodes_count_{lo,hi}
>>>>>> bg_used_dirs_count_{lo,hi}
>>>>>> bg_block_bitmap_csum_{lo,hi}
>>>>>> bg_inode_bitmap_csum_{lo,hi}
>>>>>> bg_itable_unused_{lo,hi}
>>>>>> bg_checksum
>>>>>>
>>>>>> And of course, tracking down the GD on disk will be tricky it seems. It
>>>>>> seems some blocks have the GD in the block, and a bunch of others don't
>>>>>> (nor does dumpe2fs say where exactly they are).  There is 2048 blocks of
>>>>>> GDs (131072 or 2^17 GDs) with every superblock backup, however, rom
>>>>>> group 2^17 onwards there are additional groups simply stating "Group
>>>>>> descriptor at ${frist_block_of_group}", so it's unclear how to track
>>>>>> down the GD for a given block group.
>>>>>>
>>>>>> https://ext4.wiki.kernel.org/index.php/Ext4_Disk_Layout#Block_Group_Descriptors
>>>>>>
>>>>>> does not describe this particularly well either, and there seems to be
>>>>>> confusion w.r.t. flex_bg and meta_bg features and this.
>>>>>>
>>>>>> I do have an LVM snapshot of the affected LV currently, so happy to try
>>>>>> things.
>>>>>>
>>>>>> Kind Regards,
>>>>>> Jaco
>>>>>>
>>>>>>
>>>>>>> On 2020/01/26 12:21, Jaco Kroon wrote:
>>>>>>>
>>>>>>> Hi,
>>>>>>>
>>>>>>> I've got an 85TB ext4 filesystem which I'm unable to fsck.  The only
>>>>>>> cases of same error I could find was from what I can find due to an SD
>>>>>>> card "swallowing" writes (ie, the card goes into a read-only mode but
>>>>>>> doesn't report write failure).
>>>>>>>
>>>>>>> crowsnest ~ # e2fsck -f /dev/lvm/home
>>>>>>>
>>>>>>> e2fsck 1.45.4 (23-Sep-2019)
>>>>>>> ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
>>>>>>> e2fsck: Group descriptors look bad... trying backup blocks...
>>>>>>> /dev/lvm/home: recovering journal
>>>>>>> e2fsck: unable to set superblock flags on /dev/lvm/home
>>>>>>>
>>>>>>>
>>>>>>> /dev/lvm/home: ***** FILE SYSTEM WAS MODIFIED *****
>>>>>>>
>>>>>>> /dev/lvm/home: ********** WARNING: Filesystem still has errors **********
>>>>>>>
>>>>>>> I have also (using dumpe2fs) obtained the location of the backup super
>>>>>>> blocks and tried same against a few other superblocks using -b.  -y (as
>>>>>>> per suggestion from at least one post) make absolutely no difference,
>>>>>>> our understanding is that this simply answers yes to all questions, so
>>>>>>> we didn't expect this to have impact but decided it was worth a try anyway.
>>>>>>>
>>>>>>> Looking at the code for the unable to set superblock error it looks like
>>>>>>> the code is in e2fsck/unix.c, specifically this:
>>>>>>>
>>>>>>> 1765     if (ext2fs_has_feature_journal_needs_recovery(sb)) {
>>>>>>> 1766         if (ctx->options & E2F_OPT_READONLY) {
>>>>>>> ...
>>>>>>> 1771         } else {
>>>>>>> 1772             if (ctx->flags & E2F_FLAG_RESTARTED) {
>>>>>>> 1773                 /*
>>>>>>> 1774                  * Whoops, we attempted to run the
>>>>>>> 1775                  * journal twice.  This should never
>>>>>>> 1776                  * happen, unless the hardware or
>>>>>>> 1777                  * device driver is being bogus.
>>>>>>> 1778                  */
>>>>>>> 1779                 com_err(ctx->program_name, 0,
>>>>>>> 1780                     _("unable to set superblock flags "
>>>>>>> 1781                       "on %s\n"), ctx->device_name);
>>>>>>> 1782                 fatal_error(ctx, 0);
>>>>>>> 1783             }
>>>>>>>
>>>>>>> That comment has me somewhat confused.  I'm assuming the implication
>>>>>>> there is that e2fsck tried to update the superblock, but after reading
>>>>>>> it back, it's either unchanged or still wrong (In line with the
>>>>>>> description of the SD card I found online).  None of our arrays are
>>>>>>> reflecting R/O in /proc/mdstat. We did pick out this in kernel bootup
>>>>>>> (we downgraded back to 5.1.15, which we're on currently, after
>>>>>>> experiencing major performance issues on 5.3.6 and subsequently 5.4.8
>>>>>>> didn't seem to fix those, and the 4.14.13 kernel that was used
>>>>>>> previously is known to cause ext4 corruption of the kind we saw on the
>>>>>>> other filesystems):
>>>>>>>
>>>>>>> [ 3932.271538] EXT4-fs (dm-7): ext4_check_descriptors: Block bitmap for
>>>>>>> group 404160 overlaps superblock
>>>>>>> [ 3932.271539] EXT4-fs (dm-7): group descriptors corrupted!
>>>>>>>
>>>>>>> I created a dumpe2fs file as well:
>>>>>>>
>>>>>>> crowsnest ~ # dumpe2fs /dev/lvm/home > /var/tmp/dump2fs_home.txt
>>>>>>> dumpe2fs 1.45.4 (23-Sep-2019)
>>>>>>> dumpe2fs: Block bitmap checksum does not match bitmap while trying to
>>>>>>> read '/dev/lvm/home' bitmaps
>>>>>>>
>>>>>>> Available at
>>>>>>> https://downloads.uls.co.za/85T/dump2fs_home.txt.xz
>>>>>>>  (1.2GB,
>>>>>>> md5:79b3250e209c067af2532d5324ff95aa, around 12GB extracted)
>>>>>>>
>>>>>>> A strace of e2fsck -y -f /dev/lvm/home at
>>>>>>>
>>>>>>> https://downloads.uls.co.za/85T/fsck.strace.txt
>>>>>>>  (13MB,
>>>>>>> md5:60aa91b0c47dd2837260218eb774152d)
>>>>>>>
>>>>>>> crowsnest ~ # tune2fs -l /dev/lvm/home
>>>>>>> tune2fs 1.45.4 (23-Sep-2019)
>>>>>>> Filesystem volume name:   <none>
>>>>>>> Last mounted on:          /home
>>>>>>> Filesystem UUID:          522a9faf-7992-4888-93d5-7fe49a9762d6
>>>>>>> Filesystem magic number:  0xEF53
>>>>>>> Filesystem revision #:    1 (dynamic)
>>>>>>> Filesystem features:      has_journal ext_attr filetype meta_bg extent
>>>>>>> 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize
>>>>>>> metadata_csum
>>>>>>> Filesystem flags:         signed_directory_hash
>>>>>>> Default mount options:    user_xattr acl
>>>>>>> Filesystem state:         clean
>>>>>>> Errors behavior:          Continue
>>>>>>> Filesystem OS type:       Linux
>>>>>>> Inode count:              356515840
>>>>>>> Block count:              22817013760
>>>>>>> Reserved block count:     0
>>>>>>> Free blocks:              6874204745
>>>>>>> Free inodes:              202183498
>>>>>>> First block:              0
>>>>>>> Block size:               4096
>>>>>>> Fragment size:            4096
>>>>>>> Group descriptor size:    64
>>>>>>> Blocks per group:         32768
>>>>>>> Fragments per group:      32768
>>>>>>> Inodes per group:         512
>>>>>>> Inode blocks per group:   32
>>>>>>> RAID stride:              128
>>>>>>> RAID stripe width:        1024
>>>>>>> First meta block group:   2048
>>>>>>> Flex block group size:    16
>>>>>>> Filesystem created:       Thu Jul 26 12:19:07 2018
>>>>>>> Last mount time:          Sat Jan 18 18:58:50 2020
>>>>>>> Last write time:          Sun Jan 26 11:38:56 2020
>>>>>>> Mount count:              2
>>>>>>> Maximum mount count:      -1
>>>>>>> Last checked:             Wed Oct 30 17:37:27 2019
>>>>>>> Check interval:           0 (<none>)
>>>>>>> Lifetime writes:          976 TB
>>>>>>> Reserved blocks uid:      0 (user root)
>>>>>>> Reserved blocks gid:      0 (group root)
>>>>>>> First inode:              11
>>>>>>> Inode size:               256
>>>>>>> Required extra isize:     32
>>>>>>> Desired extra isize:      32
>>>>>>> Journal inode:            8
>>>>>>> Default directory hash:   half_md4
>>>>>>> Directory Hash Seed:      876a7d14-bce8-4bef-9569-82e7d573b7aa
>>>>>>> Journal backup:           inode blocks
>>>>>>> Checksum type:            crc32c
>>>>>>> Checksum:                 0xfbd895e9
>>>>>>>
>>>>>>> Infrastructure:  3 x RAID6 arrays, 2 of 12 x 4TB disks, and 1 of 4 x
>>>>>>> 10TB disks (100TB usable total).  These are combined into a single VG
>>>>>>> using LVM, and then carved up into a number of LVs, the largest of which
>>>>>>> is this 85TB chunk.  We have tried in the past to carve this into
>>>>>>> smaller LVs but failed.  So we're aware that this is very large and not
>>>>>>> ideal.
>>>>>>>
>>>>>>> We did experience an assembly issue on one of  the underlying RAID6 PVs,
>>>>>>> those have been resolved, and the disk that was giving issues has been
>>>>>>> scrubbed and rebuilt.  rom what we can tell based on other file systems,
>>>>>>> this did not affect data integrity but we can't make that statement with
>>>>>>> 100% certainty, as such we are expecting some data loss here but it
>>>>>>> would be better if we can recover at least some of this data.
>>>>>>>
>>>>>>> Other filesystems which also resides on the same PV that was affected by
>>>>>>> the RAID6 problem either received a clean bill of health, or were
>>>>>>> successfully repaired by e2fsck (the system did crash however, it's
>>>>>>> unclear whether the RAID6 assembly problem was the cause or merely
>>>>>>> another consequence, and as a result, whether the corruption on the
>>>>>>> repaired filesystem was a consequence of the kernel or the RAID).
>>>>>>>
>>>>>>> I'm continuing onwards with e2fsck code to try and figure this out, am
>>>>>>> hopeful though that someone could perhaps provide some much needed
>>>>>>> insight and pointers for me.
>>>>>>>
>>>>>>> Kind Regards,
>>>>>>> Jaco
>>>>>>>
>>>>>>>
>> Cheers, Andreas
>>
>>
>>
>>
>>
