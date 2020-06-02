Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0D91EBBEF
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Jun 2020 14:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgFBMlu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 Jun 2020 08:41:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21986 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725940AbgFBMlp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 Jun 2020 08:41:45 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 052CX7tD061173;
        Tue, 2 Jun 2020 08:41:36 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31dheku6mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 08:41:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 052Ca5gS008002;
        Tue, 2 Jun 2020 12:41:34 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma01fra.de.ibm.com with ESMTP id 31bf47tf9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Jun 2020 12:41:33 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 052CfVUN65339640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jun 2020 12:41:31 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A973642041;
        Tue,  2 Jun 2020 12:41:31 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 256274203F;
        Tue,  2 Jun 2020 12:41:30 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.137])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  2 Jun 2020 12:41:29 +0000 (GMT)
Subject: Re: linux-next test error: BUG: using smp_processor_id() in
 preemptible [ADDR] code: syz-fuzzer/6792
To:     syzbot <syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
References: <0000000000008ff8ea05a71818b5@google.com>
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Tue, 2 Jun 2020 18:11:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <0000000000008ff8ea05a71818b5@google.com>
Content-Type: multipart/mixed;
 boundary="------------8CCD057140658DF24F4D91CA"
Content-Language: en-US
Message-Id: <20200602124130.256274203F@d06av24.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-02_13:2020-06-02,2020-06-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 suspectscore=0 cotscore=-2147483648 phishscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006020089
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is a multi-part message in MIME format.
--------------8CCD057140658DF24F4D91CA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test: 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 
0e21d4620dd047da7952f44a2e1ac777ded2d57e

--------------8CCD057140658DF24F4D91CA
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-ext4-mballoc-Use-raw_cpu_ptr-in-case-if-preemption-i.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-ext4-mballoc-Use-raw_cpu_ptr-in-case-if-preemption-i.pa";
 filename*1="tch"

From cc1cf67d99d5fa61db0651c89c288df31bad6b8e Mon Sep 17 00:00:00 2001
From: Ritesh Harjani <riteshh@linux.ibm.com>
Date: Tue, 2 Jun 2020 17:54:12 +0530
Subject: [PATCH 1/1] ext4: mballoc: Use raw_cpu_ptr in case if preemption is enabled

It doesn't matter really in ext4_mb_new_blocks() about whether the code
is rescheduled on any other cpu due to preemption. Because we care
about discard_pa_seq only when the block allocation fails and then too
we add the seq counter of all the cpus against the initial sampled one
to check if anyone has freed any blocks while we were doing allocation.

So just use raw_cpu_ptr to not trigger this BUG.

BUG: using smp_processor_id() in preemptible [00000000] code: syz-fuzzer/6927
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 6927 Comm: syz-fuzzer Not tainted 5.7.0-next-20200602-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
 ext4_append+0x153/0x360 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
 vfs_mkdir+0x419/0x690 fs/namei.c:3632
 do_mkdirat+0x21e/0x280 fs/namei.c:3655
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reported-by: syzbot+82f324bb69744c5f6969@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a9083113a8c0..b79b32dbe3ea 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4708,7 +4708,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	}
 
 	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
-	seq = *this_cpu_ptr(&discard_pa_seq);
+	seq = *raw_cpu_ptr(&discard_pa_seq);
 	if (!ext4_mb_use_preallocated(ac)) {
 		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
 		ext4_mb_normalize_request(ac, ar);
-- 
2.21.3


--------------8CCD057140658DF24F4D91CA--

