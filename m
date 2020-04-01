Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7D19AE2B
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Apr 2020 16:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733091AbgDAOly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Apr 2020 10:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:61818 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1733077AbgDAOly (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Apr 2020 10:41:54 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 031EXaMS091817
        for <linux-ext4@vger.kernel.org>; Wed, 1 Apr 2020 10:41:53 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304edx1096-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 01 Apr 2020 10:41:52 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 1 Apr 2020 15:41:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 1 Apr 2020 15:41:34 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 031Eflqj41877662
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Apr 2020 14:41:47 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CFB8252054;
        Wed,  1 Apr 2020 14:41:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.181.105])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 64E0A5205F;
        Wed,  1 Apr 2020 14:41:45 +0000 (GMT)
Subject: Re: spontaneous crash with "ext4: move ext4 bmap to use iomap
 infrastructure"
To:     Qian Cai <cai@lca.pw>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed, 1 Apr 2020 20:11:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040114-4275-0000-0000-000003B7A7FA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040114-4276-0000-0000-000038CCFB45
Message-Id: <20200401144145.64E0A5205F@d06av21.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-01_01:2020-03-31,2020-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 phishscore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=27 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004010127
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Qian,

Thanks for reporting it. By any chance is it your custom kernel.
Any more details on the reproducer & your setup pls.


On 4/1/20 6:08 PM, Qian Cai wrote:
> It is not always reproducible so far, but it start to show up on today’s linux-next. Look
> Trough the commits and noticed this recent one matched the new call traces,
> 
> ac58e4fb03f9 (“ext4: move ext4 bmap to use iomap infrastructure")
> 
> Thought?
> 
> [  206.744625][T13224] LTP: starting fallocate04
> [  207.601583][T27684] /dev/zero: Can't open blockdev
> [  208.674301][T27684] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> [  208.680347][T27684] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
> [  208.680383][T27684] Faulting instruction address: 0x00000000

 From above two lines this looks like some NULL function ptr was called.
That's why NIP is 0x0.

But LR shown is ext4_iomap_end(). Now, There is nothing in
ext4_iomap_end() which could cause this. It should just simply return
0 in case of iomap_bmap(). In that function (shown below) flags argument
is 0.

<Code snip>
============
static int ext4_iomap_end(struct inode *inode, loff_t offset, loff_t length,
			  ssize_t written, unsigned flags, struct iomap *iomap)
{
	/*
	 * Check to see whether an error occurred while writing out the data to
	 * the allocated blocks. If so, return the magic error code so that we
	 * fallback to buffered I/O and attempt to complete the remainder of
	 * the I/O. Any blocks that may have been allocated in preparation for
	 * the direct I/O will be reused during buffered I/O.
	 */
	if (flags & (IOMAP_WRITE | IOMAP_DIRECT) && written == 0)
		return -ENOTBLK;

	return 0;	 // ==> should simply return from here.
}

<Tried on my setup>
====================
I did try to mount/unmount on my setup with loop0 and mounting ext3
filesystem using ext4 subsystem. It's working fine as expected.
Here are the tracing logs. Couldn't see any crash.


<LOGS>   `(cat trace_pipe |grep iomap_bmap)`
======
       <...>-6370  [008] ....  2524.120361: iomap_apply: dev 7:0 ino 0x8 
pos 0 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] caller 
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
            <...>-6380  [010] ....  2526.230331: iomap_apply: dev 7:0 
ino 0x8 pos 0 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] caller 
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
            mount-6389  [010] ....  2528.200383: iomap_apply: dev 7:0 
ino 0x8 pos 0 length 4096 flags  (0x0) ops ext4_iomap_ops [ext4] caller 
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
            mount-6398  [010] ....  2530.950352: iomap_apply: dev 7:0 
ino 0x8 pos 0 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] caller 
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
     jbd2/loop0-8-6399  [023] ....  2531.958913: iomap_apply: dev 7:0 
ino 0x8 pos 65536 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] 
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
     jbd2/loop0-8-6399  [023] ....  2531.958930: iomap_apply: dev 7:0 
ino 0x8 pos 131072 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] 
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
     jbd2/loop0-8-6399  [023] ....  2531.959001: iomap_apply: dev 7:0 
ino 0x8 pos 196608 length 65536 flags  (0x0) ops ext4_iomap_ops [ext4] 
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
            <...>-6407  [010] ....  2532.960326: iomap_apply: dev 7:0 
ino 0x8 pos 0 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] caller 
iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor
     jbd2/loop0-8-6408  [023] ....  2540.010046: iomap_apply: dev 7:0 
ino 0x8 pos 1024 length 1024 flags  (0x0) ops ext4_iomap_ops [ext4] 
caller iomap_bmap+0xb0/0xe0 actor iomap_bmap_actor


> [  208.680406][T27684] Oops: Kernel access of bad area, sig: 11 [#1]
> [  208.680439][T27684] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA PowerNV
> [  208.680474][T27684] Modules linked in: ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [  208.680576][T27684] CPU: 117 PID: 27684 Comm: fallocate04 Tainted: G        W         5.6.0-next-20200401+ #288
> [  208.680614][T27684] NIP:  0000000000000000 LR: c0080000102c0048 CTR: 0000000000000000
> [  208.680657][T27684] REGS: c000200361def420 TRAP: 0400   Tainted: G        W          (5.6.0-next-20200401+)
> [  208.680700][T27684] MSR:  900000004280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
> [  208.680760][T27684] CFAR: c00800001032c494 IRQMASK: 0
> [  208.680760][T27684] GPR00: c0000000005ac3f8 c000200361def6b0 c00000000165c200 c00020107dae0bd0
> [  208.680760][T27684] GPR04: 0000000000000000 0000000000000400 0000000000000000 0000000000000000
> [  208.680760][T27684] GPR08: c000200361def6e8 c0080000102c0040 000000007fffffff c000000001614e80
> [  208.680760][T27684] GPR12: 0000000000000000 c000201fff671280 0000000000000000 0000000000000002
> [  208.680760][T27684] GPR16: 0000000000000002 0000000000040001 c00020030f5a1000 c00020030f5a1548
> [  208.680760][T27684] GPR20: c0000000015fbad8 c00000000168c654 c000200361def818 c0000000005b4c10
> [  208.680760][T27684] GPR24: 0000000000000000 c0080000103365b8 c00020107dae0bd0 0000000000000400
> [  208.680760][T27684] GPR28: c00000000168c3a8 0000000000000000 0000000000000000 0000000000000000
> [  208.681014][T27684] NIP [0000000000000000] 0x0
> [  208.681065][T27684] LR [c0080000102c0048] ext4_iomap_end+0x8/0x30 [ext4]
> [  208.681091][T27684] Call Trace:
> [  208.681129][T27684] [c000200361def6b0] [c0000000005ac3bc] iomap_apply+0x20c/0x920 (unreliable)
> iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
> [  208.681173][T27684] [c000200361def7f0] [c0000000005b4adc] iomap_bmap+0xfc/0x160
> iomap_bmap at fs/iomap/fiemap.c:142
> [  208.681228][T27684] [c000200361def850] [c0080000102c2c1c] ext4_bmap+0xa4/0x180 [ext4]
> ext4_bmap at fs/ext4/inode.c:3213
> [  208.681260][T27684] [c000200361def890] [c0000000004f71fc] bmap+0x4c/0x80
> [  208.681281][T27684] [c000200361def8c0] [c00800000fdb0acc] jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
> jbd2_journal_init_inode at fs/jbd2/journal.c:1255
> [  208.681326][T27684] [c000200361def960] [c00800001031c808] ext4_load_journal+0x440/0x860 [ext4]
> [  208.681371][T27684] [c000200361defa30] [c008000010322a14] ext4_fill_super+0x342c/0x3ab0 [ext4]
> [  208.681414][T27684] [c000200361defba0] [c0000000004cb0bc] mount_bdev+0x25c/0x290
> [  208.681478][T27684] [c000200361defc40] [c008000010310250] ext4_mount+0x28/0x50 [ext4]
> [  208.681520][T27684] [c000200361defc60] [c00000000053242c] legacy_get_tree+0x4c/0xb0
> [  208.681556][T27684] [c000200361defc90] [c0000000004c864c] vfs_get_tree+0x4c/0x130
> [  208.681593][T27684] [c000200361defd00] [c00000000050a1c8] do_mount+0xa18/0xc50
> [  208.681641][T27684] [c000200361defdd0] [c00000000050a9a8] sys_mount+0x158/0x180
> [  208.681679][T27684] [c000200361defe20] [c00000000000b3f8] system_call+0x5c/0x68
> [  208.681726][T27684] Instruction dump:
> [  208.681747][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  208.681797][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  208.681839][T27684] ---[ end trace 4e9e2bab7f1d4048 ]---
> [  208.802259][T27684]
> [  209.802373][T27684] Kernel panic - not syncing: Fatal exception
> 

Others,
Any clue here?


After this I am definitely setting up full LTP suite too at my end.
I mostly was using xfstests for my testing.


-ritesh

