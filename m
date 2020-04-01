Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9719AE4C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 16:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733032AbgDAOvf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 10:51:35 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33658 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732749AbgDAOvf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 10:51:35 -0400
Received: by mail-qt1-f193.google.com with SMTP id c14so223980qtp.0
        for <linux-ext4@vger.kernel.org>; Wed, 01 Apr 2020 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QVmu8XMJ5T/qJcDA2rfgbGGaKP2EqvrbqUzz8aayEBE=;
        b=tBPeAsbLT11T2WAXwE4SgDxfubZHu1isX3G+nUkzpCC8CalhJNGaIVbR0NfT+zyTHY
         LfQOgiifRmbvxBje7+s37wqaYoqeQH01hlq4QAt5ni0Jflr7G0Q8Ta5JRM92jUtkmgba
         dXXkT0XRw9JkJfiP1GdCu9vubC+95N2XXQJe7BcaGXoJbQGVc3CeWX+j/LzCt5xVmfKs
         Zk2P3l4VB79NMIEMmyDIa63uZrQnvdBhhKMSU3bct0lsJb/Q5gu3yeIY5oS5UN21l4Nb
         pO8GW0Z/lBahTgasDl6bjcVnbw0VQHShIzy2EKXw14PJnsrO8qg/EeXv8uiBovcZwkd6
         v40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QVmu8XMJ5T/qJcDA2rfgbGGaKP2EqvrbqUzz8aayEBE=;
        b=KF10iVlwWt9nBpNgFDWkDefg1seMZi8Ase8rHfDeCuFaqFCLkl1wUih6AS1N9uACZq
         5Pg/0E7MnQxJII3TfHge8pl3eH9JLPTcGSN2R+0wMbFs0z9uQPCfwP4a5xQaiqOlw2gm
         6bBEukUZnczBFbFrnNrMy9B3KOSRuZnbpm6B/r+EbQPCBN7P8NZzN43L4O48rJUN5+14
         pbdedZl/xVwYBag3YfXQ67W2t9N8qD6CkBjyO9ZA67Kq5dlYEjdJPfsWHu8mvka7uzT1
         MyFe4Mhg6KL3XiSWpvPxJ+UBSqH/iQDZPqCGA1Ozi+9vFchKvijor/ooMv8ljxl2wURV
         LWsw==
X-Gm-Message-State: ANhLgQ3n57svOHjyvo/dEEB0WwYaLUfKY/oQ4wKOOgU42rKp1dD96B9X
        iMNv3jedvqbdfEB3TgqSLsNnkQ==
X-Google-Smtp-Source: ADFU+vsz7X45kr2Zre+k6yWtdhptujHVIpYVnRLlk9tdtg99HGwoJc0Ty57ZOgc8TZVwrs/fR1+Ogw==
X-Received: by 2002:aed:24c2:: with SMTP id u2mr10837095qtc.269.1585752693529;
        Wed, 01 Apr 2020 07:51:33 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b145sm1540322qkg.52.2020.04.01.07.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2020 07:51:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: spontaneous crash with "ext4: move ext4 bmap to use iomap
 infrastructure"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200401144145.64E0A5205F@d06av21.portsmouth.uk.ibm.com>
Date:   Wed, 1 Apr 2020 10:51:31 -0400
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A0F94100-14EC-4A22-9500-FB5CB5396BCA@lca.pw>
References: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
 <20200401144145.64E0A5205F@d06av21.portsmouth.uk.ibm.com>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



> On Apr 1, 2020, at 10:41 AM, Ritesh Harjani <riteshh@linux.ibm.com> =
wrote:
>=20
> Hello Qian,
>=20
> Thanks for reporting it. By any chance is it your custom kernel.
> Any more details on the reproducer & your setup pls.

It was running LTP fallocate04 test case on POWER9 PowerNV with this =
config,

https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config

# cat /proc/cmdline (if that does ever matter)

=E2=80=A6 page_poison=3Don page_owner=3Don numa_balancing=3Denable \
systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
page_alloc.shuffle=3D1

>=20
>=20
> On 4/1/20 6:08 PM, Qian Cai wrote:
>> It is not always reproducible so far, but it start to show up on =
today=E2=80=99s linux-next. Look
>> Trough the commits and noticed this recent one matched the new call =
traces,
>> ac58e4fb03f9 (=E2=80=9Cext4: move ext4 bmap to use iomap =
infrastructure")
>> Thought?
>> [  206.744625][T13224] LTP: starting fallocate04
>> [  207.601583][T27684] /dev/zero: Can't open blockdev
>> [  208.674301][T27684] EXT4-fs (loop0): mounting ext3 file system =
using the ext4 subsystem
>> [  208.680347][T27684] BUG: Unable to handle kernel instruction fetch =
(NULL pointer?)
>> [  208.680383][T27684] Faulting instruction address: 0x00000000
>=20
> =46rom above two lines this looks like some NULL function ptr was =
called.
> That's why NIP is 0x0.
>=20
> But LR shown is ext4_iomap_end(). Now, There is nothing in
> ext4_iomap_end() which could cause this. It should just simply return
> 0 in case of iomap_bmap(). In that function (shown below) flags =
argument
> is 0.
>=20
> <Code snip>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t =
length,
> 			  ssize_t written, unsigned flags, struct iomap =
*iomap)
> {
> 	/*
> 	 * Check to see whether an error occurred while writing out the =
data to
> 	 * the allocated blocks. If so, return the magic error code so =
that we
> 	 * fallback to buffered I/O and attempt to complete the =
remainder of
> 	 * the I/O. Any blocks that may have been allocated in =
preparation for
> 	 * the direct I/O will be reused during buffered I/O.
> 	 */
> 	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written =3D=3D 0)
> 		return -ENOTBLK;
>=20
> 	return 0;	 // =3D=3D> should simply return from here.
> }
>=20
> <Tried on my setup>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> I did try to mount/unmount on my setup with loop0 and mounting ext3
> filesystem using ext4 subsystem. It's working fine as expected.
> Here are the tracing logs. Couldn't see any crash.
>=20
>=20
> <LOGS>   `(cat trace_pipe |grep iomap_bmap)`
> =3D=3D=3D=3D=3D=3D
>      <...>-6370  [008] ....  2524.120361: iomap_apply: dev 7:0 ino 0x8 =
pos 0 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] caller =
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>           <...>-6380  [010] ....  2526.230331: iomap_apply: dev 7:0 =
ino 0x8 pos 0 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] caller =
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>           mount-6389  [010] ....  2528.200383: iomap_apply: dev 7:0 =
ino 0x8 pos 0 length 4096 flags  (0x0) ops ext4_iomap_ops [ext4] caller =
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>           mount-6398  [010] ....  2530.950352: iomap_apply: dev 7:0 =
ino 0x8 pos 0 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] caller =
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>    jbd2/loop0-8-6399  [023] ....  2531.958913: iomap_apply: dev 7:0 =
ino 0x8 pos 65536 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] =
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>    jbd2/loop0-8-6399  [023] ....  2531.958930: iomap_apply: dev 7:0 =
ino 0x8 pos 131072 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] =
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>    jbd2/loop0-8-6399  [023] ....  2531.959001: iomap_apply: dev 7:0 =
ino 0x8 pos 196608 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] =
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>           <...>-6407  [010] ....  2532.960326: iomap_apply: dev 7:0 =
ino 0x8 pos 0 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] caller =
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>    jbd2/loop0-8-6408  [023] ....  2540.010046: iomap_apply: dev 7:0 =
ino 0x8 pos 1024 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] =
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
>=20
>=20
>> [  208.680406][T27684] Oops: Kernel access of bad area, sig: 11 [#1]
>> [  208.680439][T27684] LE PAGE_SIZE=3D64K MMU=3DRadix SMP NR_CPUS=3D256=
 DEBUG_PAGEALLOC NUMA PowerNV
>> [  208.680474][T27684] Modules linked in: ext4 crc16 mbcache jbd2 =
loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio =
tg3 libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
>> [  208.680576][T27684] CPU: 117 PID: 27684 Comm: fallocate04 Tainted: =
G        W         5.6.0-next-20200401+ #288
>> [  208.680614][T27684] NIP:  0000000000000000 LR: c0080000102c0048 =
CTR: 0000000000000000
>> [  208.680657][T27684] REGS: c000200361def420 TRAP: 0400   Tainted: G =
       W          (5.6.0-next-20200401+)
>> [  208.680700][T27684] MSR:  900000004280b033 =
<SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
>> [  208.680760][T27684] CFAR: c00800001032c494 IRQMASK: 0
>> [  208.680760][T27684] GPR00: c0000000005ac3f8 c000200361def6b0 =
c00000000165c200 c00020107dae0bd0
>> [  208.680760][T27684] GPR04: 0000000000000000 0000000000000400 =
0000000000000000 0000000000000000
>> [  208.680760][T27684] GPR08: c000200361def6e8 c0080000102c0040 =
000000007fffffff c000000001614e80
>> [  208.680760][T27684] GPR12: 0000000000000000 c000201fff671280 =
0000000000000000 0000000000000002
>> [  208.680760][T27684] GPR16: 0000000000000002 0000000000040001 =
c00020030f5a1000 c00020030f5a1548
>> [  208.680760][T27684] GPR20: c0000000015fbad8 c00000000168c654 =
c000200361def818 c0000000005b4c10
>> [  208.680760][T27684] GPR24: 0000000000000000 c0080000103365b8 =
c00020107dae0bd0 0000000000000400
>> [  208.680760][T27684] GPR28: c00000000168c3a8 0000000000000000 =
0000000000000000 0000000000000000
>> [  208.681014][T27684] NIP [0000000000000000] 0x0
>> [  208.681065][T27684] LR [c0080000102c0048] ext4_iomap_end+0x8/0x30 =
[ext4]
>> [  208.681091][T27684] Call Trace:
>> [  208.681129][T27684] [c000200361def6b0] [c0000000005ac3bc] =
iomap_apply+0x20c/0x920 (unreliable)
>> iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
>> [  208.681173][T27684] [c000200361def7f0] [c0000000005b4adc] =
iomap_bmap+0xfc/0x160
>> iomap_bmap at fs/iomap/fiemap.c:142
>> [  208.681228][T27684] [c000200361def850] [c0080000102c2c1c] =
ext4_bmap+0xa4/0x180 [ext4]
>> ext4_bmap at fs/ext4/inode.c:3213
>> [  208.681260][T27684] [c000200361def890] [c0000000004f71fc] =
bmap+0x4c/0x80
>> [  208.681281][T27684] [c000200361def8c0] [c00800000fdb0acc] =
jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
>> jbd2_journal_init_inode at fs/jbd2/journal.c:1255
>> [  208.681326][T27684] [c000200361def960] [c00800001031c808] =
ext4_load_journal+0x440/0x860 [ext4]
>> [  208.681371][T27684] [c000200361defa30] [c008000010322a14] =
ext4_fill_super+0x342c/0x3ab0 [ext4]
>> [  208.681414][T27684] [c000200361defba0] [c0000000004cb0bc] =
mount_bdev+0x25c/0x290
>> [  208.681478][T27684] [c000200361defc40] [c008000010310250] =
ext4_mount+0x28/0x50 [ext4]
>> [  208.681520][T27684] [c000200361defc60] [c00000000053242c] =
legacy_get_tree+0x4c/0xb0
>> [  208.681556][T27684] [c000200361defc90] [c0000000004c864c] =
vfs_get_tree+0x4c/0x130
>> [  208.681593][T27684] [c000200361defd00] [c00000000050a1c8] =
do_mount+0xa18/0xc50
>> [  208.681641][T27684] [c000200361defdd0] [c00000000050a9a8] =
sys_mount+0x158/0x180
>> [  208.681679][T27684] [c000200361defe20] [c00000000000b3f8] =
system_call+0x5c/0x68
>> [  208.681726][T27684] Instruction dump:
>> [  208.681747][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX
>> [  208.681797][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX =
XXXXXXXX XXXXXXXX XXXXXXXX
>> [  208.681839][T27684] ---[ end trace 4e9e2bab7f1d4048 ]---
>> [  208.802259][T27684]
>> [  209.802373][T27684] Kernel panic - not syncing: Fatal exception
>=20
> Others,
> Any clue here?
>=20
>=20
> After this I am definitely setting up full LTP suite too at my end.
> I mostly was using xfstests for my testing.
>=20
>=20
> -ritesh

