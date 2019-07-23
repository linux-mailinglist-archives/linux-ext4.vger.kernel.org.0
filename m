Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC6D71862
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2019 14:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732336AbfGWMkZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Tue, 23 Jul 2019 08:40:25 -0400
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54508 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726638AbfGWMkZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 23 Jul 2019 08:40:25 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 888FF284F9
        for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2019 12:40:23 +0000 (UTC)
Received: by mail.wl.linuxfoundation.org (Postfix, from userid 486)
        id 7CF2028610; Tue, 23 Jul 2019 12:40:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on
        pdx-wl-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=2.0 tests=BAYES_00,NO_RECEIVED,
        NO_RELAYS autolearn=unavailable version=3.3.1
From:   bugzilla-daemon@bugzilla.kernel.org
To:     linux-ext4@vger.kernel.org
Subject: [Bug 204285] New: ext2fs_check_desc: Corrupt group descriptor: bad
 block for block bitmap (and unable to set superblock flags)
Date:   Tue, 23 Jul 2019 12:40:21 +0000
X-Bugzilla-Reason: None
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: AssignedTo fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Product: File System
X-Bugzilla-Component: ext4
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bonaccos@ee.ethz.ch
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P1
X-Bugzilla-Assigned-To: fs_ext4@kernel-bugs.osdl.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version
 cf_kernel_version rep_platform op_sys cf_tree bug_status bug_severity
 priority component assigned_to reporter cf_regression
Message-ID: <bug-204285-13602@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=204285

            Bug ID: 204285
           Summary: ext2fs_check_desc: Corrupt group descriptor: bad block
                    for block bitmap (and unable to set superblock flags)
           Product: File System
           Version: 2.5
    Kernel Version: 4.9.168
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: ext4
          Assignee: fs_ext4@kernel-bugs.osdl.org
          Reporter: bonaccos@ee.ethz.ch
        Regression: No

Hi

I'm not sure if this just needs to be blamed on possible controller
issues or can/should be looked at as well from kernel side. If not the
latter please let me know and close the bug.

Further disclaimer: The data on that device was used as scratch disc, so
if needed there can be experimented further before we will go and
recreate it.

The affected ext4 filesystem (server running a Debian stretch, with
kernel 4.9.168-1+deb9u3 / 4.9.168-1+deb9u4) lives on LVM device created
on top of volumes provided by an Areca ARC-1882IX-24 controller. The
volumes it provides are created as RAID6. In one of these volumes there
was a disk failure, configured hotspare was used. While rebuilding, there
was a time out error for an other disk. This is for some background
information.

Shortly after that on the system the following was logged:

[Sun Jul 21 16:54:38 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78943420: comm nfsd: checksum invalid
[Sun Jul 21 16:54:38 2019] ------------[ cut here ]------------
[Sun Jul 21 16:54:38 2019] WARNING: CPU: 0 PID: 1542 at
/build/linux-s3NwpH/linux-4.9.168/fs/nfsd/nfsproc.c:801 nfserrno+0x71/0x80
[nfsd]
[Sun Jul 21 16:54:38 2019] nfsd: non-standard errno: -74
[Sun Jul 21 16:54:38 2019] Modules linked in: ip6table_filter ip6_tables
xt_tcpudp iptable_filter binfmt_misc rpcsec_gss_krb5 nfsv4 dns_resolver nfs
fscache quota_v2 quota_tree intel_rapl sb_edac edac_core x86_pkg_temp_thermal
intel_powerclamp coretemp kvm irqbypass crct10dif_pclmul joydev crc32_pclmul
ghash_clmulni_intel iTCO_wdt mgag200 sg iTCO_vendor_support evdev intel_cstate
intel_uncore ttm drm_kms_helper intel_rapl_perf wmi drm pcspkr lpc_ich mfd_core
mei_me shpchp mei ioatdma button nfsd auth_rpcgss oid_registry nfs_acl lockd
grace sunrpc loop ip_tables x_tables autofs4 ext4 crc16 jbd2 fscrypto ecb
mbcache raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear
md_mod dm_mod hid_generic usbhid hid sd_mod crc32c_intel aesni_intel
[Sun Jul 21 16:54:38 2019]  aes_x86_64 glue_helper lrw gf128mul ablk_helper
cryptd isci libsas ahci scsi_transport_sas libahci ehci_pci ehci_hcd igb
i2c_algo_bit dca ptp libata usbcore arcmsr i2c_i801 pps_core usb_common
i2c_smbus scsi_mod
[Sun Jul 21 16:54:38 2019] CPU: 0 PID: 1542 Comm: nfsd Not tainted
4.9.0-9-amd64 #1 Debian 4.9.168-1+deb9u3
[Sun Jul 21 16:54:38 2019] Hardware name: Intel Corporation S2600CP
V-13.09.100/S2600CP, BIOS SE5C600.86B.01.08.0003.022620131521 02/26/2013
[Sun Jul 21 16:54:38 2019]  0000000000000000 ffffffffa1135504 ffffb7b085defba0
0000000000000000
[Sun Jul 21 16:54:38 2019]  ffffffffa0e7a6ab ffff9fc9ea61d418 ffffb7b085defbf8
ffff9fc9e95bd000
[Sun Jul 21 16:54:38 2019]  000000000000356c 0000000000000800 ffff9fc9b1705818
ffffffffa0e7a72f
[Sun Jul 21 16:54:38 2019] Call Trace:
[Sun Jul 21 16:54:38 2019]  [<ffffffffa1135504>] ? dump_stack+0x5c/0x78
[Sun Jul 21 16:54:38 2019]  [<ffffffffa0e7a6ab>] ? __warn+0xcb/0xf0
[Sun Jul 21 16:54:38 2019]  [<ffffffffa0e7a72f>] ? warn_slowpath_fmt+0x5f/0x80
[Sun Jul 21 16:54:38 2019]  [<ffffffffa1018372>] ?
lookup_one_len_unlocked+0xe2/0x110
[Sun Jul 21 16:54:38 2019]  [<ffffffffc081e001>] ? nfserrno+0x71/0x80 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc0838f5d>] ?
nfsd4_encode_dirent+0x34d/0x3b0 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc0838c10>] ?
nfsd4_encode_secinfo+0x10/0x10 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc0822346>] ? nfsd_readdir+0x186/0x230
[nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc081fde0>] ?
nfsd_direct_splice_actor+0x20/0x20 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc08307ea>] ?
nfsd4_encode_readdir+0x11a/0x200 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc0839176>] ?
nfsd4_encode_operation+0x76/0x180 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc082ee02>] ?
nfsd4_proc_compound+0x272/0x6d0 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc081c2a6>] ? nfsd_dispatch+0xc6/0x260
[nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc07d83c7>] ?
svc_process_common+0x487/0x6d0 [sunrpc]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc081bc40>] ? nfsd_destroy+0x60/0x60
[nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc07d94f6>] ? svc_process+0xf6/0x1a0
[sunrpc]
[Sun Jul 21 16:54:38 2019]  [<ffffffffc081bd29>] ? nfsd+0xe9/0x150 [nfsd]
[Sun Jul 21 16:54:38 2019]  [<ffffffffa0e9a969>] ? kthread+0xd9/0xf0
[Sun Jul 21 16:54:38 2019]  [<ffffffffa141aa64>] ? __switch_to_asm+0x34/0x70
[Sun Jul 21 16:54:38 2019]  [<ffffffffa0e9a890>] ? kthread_park+0x60/0x60
[Sun Jul 21 16:54:38 2019]  [<ffffffffa141aaf7>] ? ret_from_fork+0x57/0x70
[Sun Jul 21 16:54:38 2019] ---[ end trace 02fdf18b3bf04daf ]---
[Sun Jul 21 16:54:38 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78582838: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78781637: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78781637: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78582886: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78582964: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78781450: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78781517: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78781517: comm nfsd: checksum invalid
[Sun Jul 21 16:54:39 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78943471: comm nfsd: checksum invalid
[Sun Jul 21 16:54:47 2019] EXT4-fs error: 2 callbacks suppressed
[Sun Jul 21 16:54:47 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78943420: comm nfsd: checksum invalid
[Sun Jul 21 16:54:59 2019] EXT4-fs error (device dm-11): ext4_iget:4528: inode
#78943420: comm nfsd: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069817: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069820: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069810: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069823: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069811: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069822: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069809: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069818: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069813: comm du: checksum invalid
[Mon Jul 22 05:29:11 2019] EXT4-fs error (device dm-12): ext4_iget:4528: inode
#23069814: comm du: checksum invalid
[Mon Jul 22 10:32:01 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:32:01 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:32:01 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:32:01 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:40:17 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:40:17 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:40:17 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:40:17 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:49:13 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:49:13 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:49:13 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:49:13 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:52:37 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:52:37 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 10:52:37 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 10:52:37 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 11:00:54 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 11:00:54 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum
[Mon Jul 22 11:00:54 2019] EXT4-fs warning (device dm-11):
ext4_dirent_csum_verify:353: inode #115382198: comm nfsd: No space for
directory leaf checksum. Please run e2fsck -D.
[Mon Jul 22 11:00:54 2019] EXT4-fs error (device dm-11):
htree_dirblock_to_tree:963: inode #115382198: block 3: comm nfsd: Directory
block failed checksum

The server was rebooted, to perform a filesystem check. This leads though to:

# fsck.ext4 -v /dev/mapper/vgb-lvb1
e2fsck 1.43.4 (31-Jan-2017)
ext2fs_check_desc: Corrupt group descriptor: bad block for block bitmap
fsck.ext4: Group descriptors look bad... trying backup blocks...
/dev/mapper/vgb-lvb1: recovering journal
fsck.ext4: unable to set superblock flags on /dev/mapper/vgb-lvb1


/dev/mapper/vgb-lvb1: ***** FILE SYSTEM WAS MODIFIED *****

/dev/mapper/vgb-lvb1: ********** WARNING: Filesystem still has errors
**********

Trying to fsck from alternative superblock failed with the exact same
failure (tried every possible one as reported in the dumpe2fs output).

# mount -t ext4 /dev/mapper/vgb-lvb1 /mnt
[ 5910.570712] EXT4-fs (dm-11): ext4_check_descriptors: Block bitmap for group
6080 overlaps superblock
[ 5910.580989] EXT4-fs (dm-11): group descriptors corrupted!
mount: mount /dev/mapper/vgb-lvb1 on /mnt failed: Structure needs cleaning
#

Mounting the filesystem with

# mount -t ext4 -o ro,errors=continue,,norecovery /dev/mapper/vgb-lvb1 /mnt 

succeeds, but spawning a lot of

[...]
[ 2072.269808] EXT4-fs (dm-11): ext4_check_descriptors: Inode table for group
105335 overlaps superblock
[ 2072.280683] EXT4-fs (dm-11): ext4_check_descriptors: Block bitmap for group
105336 overlaps superblock
[ 2072.291668] EXT4-fs (dm-11): ext4_check_descriptors: Inode bitmap for group
105336 overlaps superblock
[ 2072.302635] EXT4-fs (dm-11): ext4_check_descriptors: Inode table for group
105336 overlaps superblock
[ 2072.313509] EXT4-fs (dm-11): ext4_check_descriptors: Block bitmap for group
105337 overlaps superblock
[ 2072.324493] EXT4-fs (dm-11): ext4_check_descriptors: Inode bitmap for group
105337 overlaps superblock
[ 2072.335466] EXT4-fs (dm-11): ext4_check_descriptors: Inode table for group
105337 overlaps superblock
[...]

On the mounted filesystem a lot of directories of files will be
inaccessible. 

# ls: cannot access 'foo': Bad message

Trying to save metadata via e2image for further analysis does not
succeed (generate 0 byte output file):

# e2image -r /dev/mapper/vgb-lvb1 /scratch/vgb-lvb1.e2i 
e2image 1.43.4 (31-Jan-2017)
e2image: A block group is missing an inode table while getting next inode

A dump via dumpe2fs though can be generated (which I could provide
seprately).

If you think it *might* indicate a kernel issue, then what further
information can I provide to you?

Regards,
Salvatore

-- 
You are receiving this mail because:
You are watching the assignee of the bug.
