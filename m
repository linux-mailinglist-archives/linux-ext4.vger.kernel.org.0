Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6252AF7B8
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Nov 2020 19:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgKKSIg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Nov 2020 13:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKSIf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Nov 2020 13:08:35 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF2C0613D1
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 10:08:35 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id me8so3983049ejb.10
        for <linux-ext4@vger.kernel.org>; Wed, 11 Nov 2020 10:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCE6eskXVGiNS6Z7mi3dAX2lPCEcmCdEYNDRnZ9iUHI=;
        b=DvwIpDiuvG6N/U3wxXpUBZrir7cttw5oJsUDn50ezWTYygWMYcUcnytglpIPrAJXko
         Or/4HZbq5DuBV0ko1hBzzvFN5HtqPFvRY6j6EuAA9QNze0/w+ROWNT0Mde3EqQiLBl5r
         fxBPBEMK9lDagl5rr9SIUPuteCD5HieU5/ueYGHNu5ev/+0kQUjA+J8mE+8OsfWDiM0L
         AofA+NVp01bsa22I8nLMLq2rVSS6PfmTbECzGVcc2x8uP73GydyhFzFx0yeMijaIqbLh
         gi2R1IjsEBrFSusd11iVoyuRDdNepnpeaX4DH85+IMQRPUWNqFv2czo5VYIAAfFtrAkq
         8ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCE6eskXVGiNS6Z7mi3dAX2lPCEcmCdEYNDRnZ9iUHI=;
        b=eZJMd1154wFiwawt/RUl+pJJHEIwxDGOgBKvCFZllp566S+OaSFQ6gY4LPhPyBqPbv
         I+kUWWlHsaLeNi8rHEvwPmslUlFEhVI9ktiu3Tb5xNHypOXV2CAfYUmNs7LP1DOucj7U
         Uy21M3G0pjbOR1CfkuSPanBwWcSNCjf7OckFoH+MASXPnGOUhhlMS8i50/CmjmKr05lA
         V/OthY9c/LE1l25Q9ra39W3HdKeVInAhRjiMsbzhAVVfkS3AIZlm22znv+bNTm1msmGe
         t1WPqjeyx1rPsZtL8Xmw11oWISFPOkO0hXToKw4HD6Gl4E0Ep2M45bqszmWuvJXi75Lm
         etAA==
X-Gm-Message-State: AOAM532ONlNoJgw8ZfXYbqJNqEb600eXHNxAG2QLJSyDBNyeLueNqpEz
        ESrneQE9OM/EiNMLiJb2RCg/VKINvB8bkeiUajU=
X-Google-Smtp-Source: ABdhPJxGX7Qyg+47Gr2G9pWjDo1JI56ifTlwvRNJH2ERPmgtQK3g1ipdsjgUhijZaVV6jPoS16O/4WsQDgUgNPfZm/Y=
X-Received: by 2002:a17:906:6d13:: with SMTP id m19mr26472348ejr.345.1605118113760;
 Wed, 11 Nov 2020 10:08:33 -0800 (PST)
MIME-Version: 1.0
References: <20201111031039.do6syeiam4pgftvu@xzhoux.usersys.redhat.com>
In-Reply-To: <20201111031039.do6syeiam4pgftvu@xzhoux.usersys.redhat.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 11 Nov 2020 10:08:22 -0800
Message-ID: <CAD+ocbwkPKnnaKS25eziNp6Pz0yLSwWyitzSMFWhxjFgi_37aQ@mail.gmail.com>
Subject: Re: [fsdax] kernel BUG at fs/ext4/ext4_extents.h:199!
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the report Murphy. I just realized we have a collision of
mount flags:

#define EXT4_MOUNT2_DAX_NEVER           0x00000008 /* Do not allow
Direct Access */
#define EXT4_MOUNT2_DAX_INODE           0x00000010 /* For printing
options only */

#define EXT4_MOUNT2_EXPLICIT_JOURNAL_CHECKSUM   0x00000008 /* User explicitly
                                                specified journal checksum */

#define EXT4_MOUNT2_JOURNAL_FAST_COMMIT 0x00000010 /* Journal fast commit */

So whenever dax=inode is turned on, fast commit also gets turned on.
I'll send out a fix for this soon.

Thanks,
Harshad

On Tue, Nov 10, 2020 at 7:10 PM Murphy Zhou <jencce.kernel@gmail.com> wrote:
>
> Hi,
>
> A corner case panic starts since the fast-commit merge.
>
> ------
> kernel BUG at fs/ext4/ext4_extents.h:199!
> invalid opcode: 0000 [#1] SMP PTI
> CPU: 5 PID: 1184 Comm: t_mmap_dio Tainted: G            E     5.10.0-rc3-master-407ab579637c+ #37
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-2.fc32 04/01/2014
> RIP: 0010:ext4_fc_write_inode_data+0x1d0/0x1e0 [ext4]
> Code: 7f 00 00 74 25 66 81 ca 00 80 66 89 54 24 30 e9 62 ff ff ff 4c 89 ff e8 9e 63 4d c1 31 c0 eb 84 b8 83 ff ff ff e9 7a ff ff ff <0f> 0b e8 79 c8 4c c1 66 0f 1f 84 00 00 00 00 00 66 66 66 66 90 41
> RSP: 0018:ffff9bc200d53d88 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000008000
> RDX: 0000000000008000 RSI: 0000000000060002 RDI: 000032ee98c0aa2c
> RBP: 0000000000008000 R08: ffffffffc0559158 R09: ffffffffc054cdc0
> R10: 0000000000008000 R11: 0000000000000000 R12: 0000000000007fff
> R13: ffff9bc200d53e6c R14: ffff88d2e0cf3420 R15: ffff88d2e0cf33a8
> FS:  00007f20006cab80(0000) GS:ffff88d367140000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f2000937000 CR3: 00000003db940002 CR4: 0000000000020ee0
> Call Trace:
>  ext4_fc_commit+0x874/0x900 [ext4]
>  ? file_check_and_advance_wb_err+0x2e/0xc0
>  ext4_sync_file+0xd4/0x350 [ext4]
>  __x64_sys_fsync+0x34/0x60
>  do_syscall_64+0x33/0x40
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f20008d1ef7
> ------
>
> Bisect result shows the first bad commit:
>   [aa75f4d3daaeb1389b9cce9d6b84401eaf228d4e] ext4: main fast-commit commit path
>
> It's hit by running xfstests generic/605 on pmem ramdisk, fsdax enabled.
> I've narrowed down to a simplified reproducer, which requires a pmem ramdisk
> been setup first, eg /dev/pmem10. And /root/xfstests-dev is built.
>
> --------------------- Reproducer start -----------
> #! /bin/bash
> SCRATCH_DEV=/dev/pmem10
> SCRATCH_MNT=/daxmnt
> SRC_FILE=$SCRATCH_MNT/src
> DST_FILE=$SCRATCH_MNT/dst
> XFS_IO_PROG=/usr/sbin/xfs_io
> tsize=$((128 * 1024 * 1024))
> wipefs -af $SCRATCH_DEV > out.full 2>&1
> mkfs.ext4 -b 4096 $SCRATCH_DEV >> out.full 2>&1 || exit
> mkdir -p $SCRATCH_MNT
> mount -t ext4 -o dax=inode,context=system_u:object_r:nfs_t:s0 $SCRATCH_DEV $SCRATCH_MNT || exit
> prep_files()
> {
>         rm -f $SRC_FILE $DST_FILE
>         $XFS_IO_PROG -f -c "falloc 0 $tsize" $SRC_FILE $DST_FILE >> out.full 2>&1 || exit
> }
> prep_files
> # with O_DIRECT first
> /root/xfstests-dev/src/t_mmap_dio $SRC_FILE $DST_FILE 1024 "dio both dax" && echo pass dio
> prep_files
> # again with buffered IO
> /root/xfstests-dev/src/t_mmap_dio -b $SRC_FILE $DST_FILE 1024 "buffered both dax" && echo pass bio
> umount /daxmnt
> --------------------- Reproducer end -----------
>
> The "context=xx" and "dax=inode" mount option are *necessary* to reproduce.
>
> NO panic reproduced if mount with "-o dax" or "dax=always" or "dax=never".
>
> The context value seems irrelevant. Other value can also trigger this panic.
> The inode size value seems irrelevant. Tested with 128 and 256, both panic.
>
> Some gdb info and fs info paste below for you ref.
>
> Thanks,
> Murphy
>
> ------------ gdb info -----------
> (gdb) l *(ext4_fc_write_inode_data+0x1d0/0x1e0)
> 0x64fd0 is in ext4_fc_write_inode_data (fs/ext4/fast_commit.c:787).
> 782     /*
> 783      * Writes updated data ranges for the inode in question. Updates CRC.
> 784      * Returns 0 on success, error otherwise.
> 785      */
> 786     static int ext4_fc_write_inode_data(struct inode *inode, u32 *crc)
> 787     {
> 788             ext4_lblk_t old_blk_size, cur_lblk_off, new_blk_size;
> 789             struct ext4_inode_info *ei = EXT4_I(inode);
> 790             struct ext4_map_blocks map;
> 791             struct ext4_fc_add_range fc_ext;
> (gdb) l *(ext4_fc_write_inode_data+0x1d0)
> 0x651a0 is in ext4_fc_write_inode_data (fs/ext4/ext4_extents.h:199).
> 194     }
> 195
> 196     static inline void ext4_ext_mark_unwritten(struct ext4_extent *ext)
> 197     {
> 198             /* We can not have an unwritten extent of zero length! */
> 199             BUG_ON((le16_to_cpu(ext->ee_len) & ~EXT_INIT_MAX_LEN) == 0);
> 200             ext->ee_len |= cpu_to_le16(EXT_INIT_MAX_LEN);
> 201     }
> 202
> 203     static inline int ext4_ext_is_unwritten(struct ext4_extent *ext)
> (gdb) l *(ext4_fc_commit+0x874/0x900)
> 0x67460 is in ext4_fc_commit (fs/ext4/fast_commit.c:1072).
> 1067     * commit_tid if needed. If it's not possible to perform a fast commit
> 1068     * due to various reasons, we fall back to full commit. Returns 0
> 1069     * on success, error otherwise.
> 1070     */
> 1071    int ext4_fc_commit(journal_t *journal, tid_t commit_tid)
> 1072    {
> 1073            struct super_block *sb = (struct super_block *)(journal->j_private);
> 1074            struct ext4_sb_info *sbi = EXT4_SB(sb);
> 1075            int nblks = 0, ret, bsize = journal->j_blocksize;
> 1076            int subtid = atomic_read(&sbi->s_fc_subtid);
> (gdb) l *(ext4_fc_commit+0x874)
> 0x67cd4 is in ext4_fc_commit (fs/ext4/fast_commit.c:972).
> 967                      */
> 968                     ret = ext4_fc_write_inode(inode, crc);
> 969                     if (ret)
> 970                             goto lock_and_exit;
> 971
> 972                     ret = ext4_fc_write_inode_data(inode, crc);
> 973                     if (ret)
> 974                             goto lock_and_exit;
> 975
> 976                     if (!ext4_fc_add_dentry_tlv(
> (gdb)
> -------------gdb info end ------------
>
> --------------- tune2fs -l outout --------
> tune2fs 1.45.5 (07-Jan-2020)
> Filesystem volume name:   <none>
> Last mounted on:          <not available>
> Filesystem UUID:          281dc870-a1ac-4f0e-85ec-e5cecd3d0f88
> Filesystem magic number:  0xEF53
> Filesystem revision #:    1 (dynamic)
> Filesystem features:      has_journal ext_attr resize_inode dir_index filetype needs_recovery extent 64bit flex_bg sparse_super large_file huge_file dir_nlink extra_isize metadata_csum
> Filesystem flags:         signed_directory_hash
> Default mount options:    user_xattr acl
> Filesystem state:         clean
> Errors behavior:          Continue
> Filesystem OS type:       Linux
> Inode count:              655360
> Block count:              2621440
> Reserved block count:     131072
> Free blocks:              2554687
> Free inodes:              655349
> First block:              0
> Block size:               4096
> Fragment size:            4096
> Group descriptor size:    64
> Reserved GDT blocks:      1024
> Blocks per group:         32768
> Fragments per group:      32768
> Inodes per group:         8192
> Inode blocks per group:   512
> Flex block group size:    16
> Filesystem created:       Wed Nov 11 10:20:53 2020
> Last mount time:          Wed Nov 11 10:20:53 2020
> Last write time:          Wed Nov 11 10:20:53 2020
> Mount count:              1
> Maximum mount count:      -1
> Last checked:             Wed Nov 11 10:20:53 2020
> Check interval:           0 (<none>)
> Lifetime writes:          4137 kB
> Reserved blocks uid:      0 (user root)
> Reserved blocks gid:      0 (group root)
> First inode:              11
> Inode size:               256
> Required extra isize:     32
> Desired extra isize:      32
> Journal inode:            8
> Default directory hash:   half_md4
> Directory Hash Seed:      b7a0f1fd-a3fa-4669-ab23-3d63df2b16ef
> Journal backup:           inode blocks
> Checksum type:            crc32c
> Checksum:                 0x555540b3
> --------------- tune2fs -l output end --------
>
> --------------- mount info ----------
> /dev/pmem10 on /daxmnt type ext4 (rw,relatime,context=system_u:object_r:nfs_t:s0,dax=inode,fast_commit)
> --------------- mount info end ----------
> --
> Murphy
