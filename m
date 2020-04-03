Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9CC19D5E0
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Apr 2020 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDCLeS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Apr 2020 07:34:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25009 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728023AbgDCLeS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Apr 2020 07:34:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033BXZjU029930
        for <linux-ext4@vger.kernel.org>; Fri, 3 Apr 2020 07:34:17 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 305s838ky8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Fri, 03 Apr 2020 07:34:16 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Fri, 3 Apr 2020 12:34:02 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 3 Apr 2020 12:33:59 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 033BYCSo55705780
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 3 Apr 2020 11:34:12 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E51BCAE051;
        Fri,  3 Apr 2020 11:34:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6ECFFAE045;
        Fri,  3 Apr 2020 11:34:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.79.188.92])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  3 Apr 2020 11:34:10 +0000 (GMT)
Subject: Re: spontaneous crash with "ext4: move ext4 bmap to use iomap
 infrastructure"
To:     Qian Cai <cai@lca.pw>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-ext4@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>
References: <B97A26CF-3511-40D2-82B6-D8BCC7F2DE74@lca.pw>
 <0024FD7B-D28A-4158-B9F8-76FDD6E6CF98@lca.pw>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Fri, 3 Apr 2020 17:04:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <0024FD7B-D28A-4158-B9F8-76FDD6E6CF98@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20040311-0008-0000-0000-00000369AFCF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20040311-0009-0000-0000-00004A8B3F52
Message-Id: <20200403113410.6ECFFAE045@d06av26.portsmouth.uk.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-03_07:2020-04-02,2020-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 suspectscore=27 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004030101
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 4/3/20 4:56 PM, Qian Cai wrote:
> 
> 
>> On Apr 1, 2020, at 8:38 AM, Qian Cai <cai@lca.pw> wrote:
>>
>> It is not always reproducible so far, but it start to show up on today’s linux-next. Look
>> Trough the commits and noticed this recent one matched the new call traces,
>>
>> ac58e4fb03f9 (“ext4: move ext4 bmap to use iomap infrastructure")
>>
>> Thought?
> 
> FYI, this starts to become more reproducible that happens again with today’s linux-next as well.


Do you have the crash dump and vmlinux for this crash pls?
Could you share it somehow with me.

I tried reproducing this (fallocate04) for more than 6000 iterations.
But I couldn't see this on my setup.

Let me try it again with today's linux-next.

-ritesh


> 
> [  375.277947][T13110] LTP: starting fallocate04
> [  375.892545][T27575] /dev/zero: Can't open blockdev
> [  376.899021][T27575] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
> [  376.905283][T27575] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
> [  376.905308][T27575] Faulting instruction address: 0x00000000
> [  376.905333][T27575] Oops: Kernel access of bad area, sig: 11 [#1]
> [  376.905346][T27575] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA PowerNV
> [  376.905371][T27575] Modules linked in: ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci tg3 mdio libahci libphy libata firmware_class dm_mirror dm_region_hash dm_log dm_mod
> [  376.905419][T27575] CPU: 64 PID: 27575 Comm: fallocate04 Tainted: G        W    L    5.6.0-next-20200403+ #347
> [  376.905456][T27575] NIP:  0000000000000000 LR: c008000010b90048 CTR: 0000000000000000
> [  376.905479][T27575] REGS: c000200aaeb0f3b0 TRAP: 0400   Tainted: G        W    L     (5.6.0-next-20200403+)
> [  376.905513][T27575] MSR:  900000004280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
> [  376.905545][T27575] CFAR: c008000010bfc494 IRQMASK: 0
> [  376.905545][T27575] GPR00: c0000000005af3b8 c000200aaeb0f640 c00000000165ce00 c000201aa7924ec0
> [  376.905545][T27575] GPR04: 0000000000000000 0000000000000400 0000000000000000 0000000000000000
> [  376.905545][T27575] GPR08: c000200aaeb0f678 c008000010b90040 000000007fffffff c00000000163c580
> [  376.905545][T27575] GPR12: 0000000000000000 c000201fff7fb380 0000000000000000 0000000000000002
> [  376.905545][T27575] GPR16: 0000000000000002 0000000000040001 c000201bd4ee4000 c000201bd4ee4548
> [  376.905545][T27575] GPR20: c0000000015fbd18 c00000000168c654 c000200aaeb0f7a8 c0000000005b7bf0
> [  376.905545][T27575] GPR24: 0000000000000000 c008000010c065b8 c000201aa7924ec0 0000000000000400
> [  376.905545][T27575] GPR28: c00000000168c3a8 0000000000000000 0000000000000000 0000000000000000
> [  376.905768][T27575] NIP [0000000000000000] 0x0
> [  376.905798][T27575] LR [c008000010b90048] ext4_iomap_end+0x8/0x30 [ext4]
> [  376.905820][T27575] Call Trace:
> [  376.905844][T27575] [c000200aaeb0f640] [c0000000005af37c] iomap_apply+0x20c/0x920 (unreliable)
> [  376.905870][T27575] [c000200aaeb0f780] [c0000000005b7abc] iomap_bmap+0xfc/0x160
> [  376.905911][T27575] [c000200aaeb0f7e0] [c008000010b92c1c] ext4_bmap+0xa4/0x180 [ext4]
> [  376.905937][T27575] [c000200aaeb0f820] [c0000000004fa22c] bmap+0x4c/0x80
> [  376.905962][T27575] [c000200aaeb0f850] [c00800000fcf0acc] jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
> [  376.906005][T27575] [c000200aaeb0f8f0] [c008000010bec808] ext4_load_journal+0x440/0x860 [ext4]
> [  376.906059][T27575] [c000200aaeb0f9c0] [c008000010bf2a14] ext4_fill_super+0x342c/0x3ab0 [ext4]
> [  376.906086][T27575] [c000200aaeb0fb30] [c0000000004ce0ec] mount_bdev+0x25c/0x290
> [  376.906107][T27575] [c000200aaeb0fbd0] [c008000010be0250] ext4_mount+0x28/0x50 [ext4]
> [  376.906143][T27575] [c000200aaeb0fbf0] [c0000000005353cc] legacy_get_tree+0x4c/0xb0
> [  376.906177][T27575] [c000200aaeb0fc20] [c0000000004cb67c] vfs_get_tree+0x4c/0x130
> [  376.906213][T27575] [c000200aaeb0fc90] [c00000000050d1f8] do_mount+0xa18/0xc50
> [  376.906257][T27575] [c000200aaeb0fd60] [c00000000050d9d8] sys_mount+0x158/0x180
> [  376.906307][T27575] [c000200aaeb0fdb0] [c00000000003cc30] system_call_exception+0x110/0x1e0
> [  376.906334][T27575] [c000200aaeb0fe20] [c00000000000c9f0] system_call_common+0xf0/0x278
> [  376.906367][T27575] Instruction dump:
> [  376.906387][T27575] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  376.906434][T27575] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
> [  376.906472][T27575] ---[ end trace fa91408cebc70be1 ]---
> [  377.389381][T27575]
> [  378.389480][T27575] Kernel panic - not syncing: Fatal exception
> [  379.824028][
> 
>>
>> [  206.744625][T13224] LTP: starting fallocate04
>> [  207.601583][T27684] /dev/zero: Can't open blockdev
>> [  208.674301][T27684] EXT4-fs (loop0): mounting ext3 file system using the ext4 subsystem
>> [  208.680347][T27684] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
>> [  208.680383][T27684] Faulting instruction address: 0x00000000
>> [  208.680406][T27684] Oops: Kernel access of bad area, sig: 11 [#1]
>> [  208.680439][T27684] LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=256 DEBUG_PAGEALLOC NUMA PowerNV
>> [  208.680474][T27684] Modules linked in: ext4 crc16 mbcache jbd2 loop kvm_hv kvm ip_tables x_tables xfs sd_mod bnx2x ahci libahci mdio tg3 libata libphy firmware_class dm_mirror dm_region_hash dm_log dm_mod
>> [  208.680576][T27684] CPU: 117 PID: 27684 Comm: fallocate04 Tainted: G        W         5.6.0-next-20200401+ #288
>> [  208.680614][T27684] NIP:  0000000000000000 LR: c0080000102c0048 CTR: 0000000000000000
>> [  208.680657][T27684] REGS: c000200361def420 TRAP: 0400   Tainted: G        W          (5.6.0-next-20200401+)
>> [  208.680700][T27684] MSR:  900000004280b033 <SF,HV,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 42022228  XER: 20040000
>> [  208.680760][T27684] CFAR: c00800001032c494 IRQMASK: 0
>> [  208.680760][T27684] GPR00: c0000000005ac3f8 c000200361def6b0 c00000000165c200 c00020107dae0bd0
>> [  208.680760][T27684] GPR04: 0000000000000000 0000000000000400 0000000000000000 0000000000000000
>> [  208.680760][T27684] GPR08: c000200361def6e8 c0080000102c0040 000000007fffffff c000000001614e80
>> [  208.680760][T27684] GPR12: 0000000000000000 c000201fff671280 0000000000000000 0000000000000002
>> [  208.680760][T27684] GPR16: 0000000000000002 0000000000040001 c00020030f5a1000 c00020030f5a1548
>> [  208.680760][T27684] GPR20: c0000000015fbad8 c00000000168c654 c000200361def818 c0000000005b4c10
>> [  208.680760][T27684] GPR24: 0000000000000000 c0080000103365b8 c00020107dae0bd0 0000000000000400
>> [  208.680760][T27684] GPR28: c00000000168c3a8 0000000000000000 0000000000000000 0000000000000000
>> [  208.681014][T27684] NIP [0000000000000000] 0x0
>> [  208.681065][T27684] LR [c0080000102c0048] ext4_iomap_end+0x8/0x30 [ext4]
>> [  208.681091][T27684] Call Trace:
>> [  208.681129][T27684] [c000200361def6b0] [c0000000005ac3bc] iomap_apply+0x20c/0x920 (unreliable)
>> iomap_apply at fs/iomap/apply.c:80 (discriminator 4)
>> [  208.681173][T27684] [c000200361def7f0] [c0000000005b4adc] iomap_bmap+0xfc/0x160
>> iomap_bmap at fs/iomap/fiemap.c:142
>> [  208.681228][T27684] [c000200361def850] [c0080000102c2c1c] ext4_bmap+0xa4/0x180 [ext4]
>> ext4_bmap at fs/ext4/inode.c:3213
>> [  208.681260][T27684] [c000200361def890] [c0000000004f71fc] bmap+0x4c/0x80
>> [  208.681281][T27684] [c000200361def8c0] [c00800000fdb0acc] jbd2_journal_init_inode+0x44/0x1a0 [jbd2]
>> jbd2_journal_init_inode at fs/jbd2/journal.c:1255
>> [  208.681326][T27684] [c000200361def960] [c00800001031c808] ext4_load_journal+0x440/0x860 [ext4]
>> [  208.681371][T27684] [c000200361defa30] [c008000010322a14] ext4_fill_super+0x342c/0x3ab0 [ext4]
>> [  208.681414][T27684] [c000200361defba0] [c0000000004cb0bc] mount_bdev+0x25c/0x290
>> [  208.681478][T27684] [c000200361defc40] [c008000010310250] ext4_mount+0x28/0x50 [ext4]
>> [  208.681520][T27684] [c000200361defc60] [c00000000053242c] legacy_get_tree+0x4c/0xb0
>> [  208.681556][T27684] [c000200361defc90] [c0000000004c864c] vfs_get_tree+0x4c/0x130
>> [  208.681593][T27684] [c000200361defd00] [c00000000050a1c8] do_mount+0xa18/0xc50
>> [  208.681641][T27684] [c000200361defdd0] [c00000000050a9a8] sys_mount+0x158/0x180
>> [  208.681679][T27684] [c000200361defe20] [c00000000000b3f8] system_call+0x5c/0x68
>> [  208.681726][T27684] Instruction dump:
>> [  208.681747][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> [  208.681797][T27684] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX
>> [  208.681839][T27684] ---[ end trace 4e9e2bab7f1d4048 ]---
>> [  208.802259][T27684]
>> [  209.802373][T27684] Kernel panic - not syncing: Fatal exception
> 

