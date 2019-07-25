Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C97A74EE4
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 15:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfGYNNq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Jul 2019 09:13:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725808AbfGYNNq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 25 Jul 2019 09:13:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6PDDf7K059727
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jul 2019 09:13:45 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tyc58b29e-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 25 Jul 2019 09:13:42 -0400
Received: from localhost
        by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <chandan@linux.ibm.com>;
        Thu, 25 Jul 2019 14:12:58 +0100
Received: from b03cxnp07028.gho.boulder.ibm.com (9.17.130.15)
        by e33.co.us.ibm.com (192.168.1.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 25 Jul 2019 14:12:55 +0100
Received: from b03ledav001.gho.boulder.ibm.com (b03ledav001.gho.boulder.ibm.com [9.17.130.232])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6PDCsbj20775284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 13:12:54 GMT
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 248506E059;
        Thu, 25 Jul 2019 13:12:54 +0000 (GMT)
Received: from b03ledav001.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 39B656E04C;
        Thu, 25 Jul 2019 13:12:52 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.57.5])
        by b03ledav001.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 25 Jul 2019 13:12:51 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca
Subject: [PATCH] jbd2: flush_descriptor(): Do not decrease buffer head's ref count
Date:   Thu, 25 Jul 2019 18:44:09 +0530
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19072513-0036-0000-0000-00000ADE4816
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00011490; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000287; SDB=6.01237239; UDB=6.00652168; IPR=6.01018613;
 MB=3.00027885; MTD=3.00000008; XFM=3.00000015; UTC=2019-07-25 13:12:56
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19072513-0037-0000-0000-00004CBDDA82
Message-Id: <20190725131409.32172-1-chandan@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-25_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=987 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907250154
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When executing generic/388 on a ppc64le machine, we notice the following
call trace,

VFS: brelse: Trying to free free buffer
WARNING: CPU: 0 PID: 6637 at /root/repos/linux/fs/buffer.c:1195 __brelse+0x84/0xc0

Call Trace:
 __brelse+0x80/0xc0 (unreliable)
 invalidate_bh_lru+0x78/0xc0
 on_each_cpu_mask+0xa8/0x130
 on_each_cpu_cond_mask+0x130/0x170
 invalidate_bh_lrus+0x44/0x60
 invalidate_bdev+0x38/0x70
 ext4_put_super+0x294/0x560
 generic_shutdown_super+0xb0/0x170
 kill_block_super+0x38/0xb0
 deactivate_locked_super+0xa4/0xf0
 cleanup_mnt+0x164/0x1d0
 task_work_run+0x110/0x160
 do_notify_resume+0x414/0x460
 ret_from_except_lite+0x70/0x74

The above occurs due to the following sequence of events,
1. Get a buffer head for holding a descriptor buffer for a Revoke
   record. This causes buffer_head->b_count to have a value of 2,
   - The first ref count corresponds to JBD code holding a reference to the
     buffer head.
   - Another ref count correponds to adding the buffer head to the
     per-cpu LRU list.
   The buffer head is also added to the list of log_bufs tracking the
   buffer heads that need to be written to the on-disk journal.
2. When writing the revoke record to the disk, if journal is aborted,
   flush_descriptor() gives up one ref count by invoking put_bh().
3. jbd2_journal_commit_transaction() then loops across the buffer heads
   in the log_bufs list. While doing so, it decrements the buffer head's ref
   count to 0 by invoking __brelse().
4. On unmount, invalidate_bdev() invokes __brelse() via
   invalidate_bh_lru() to remove the buffer head from the per-cpu LRU
   list. Here __brelse() prints the call trace shown above since
   buffer_head->b_count already has a value of 0.

Hence this commit removes the call to put_bh() inside
flush_descriptor().

Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
 fs/jbd2/revoke.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
index 69b9bc329964..f08073d7bbf5 100644
--- a/fs/jbd2/revoke.c
+++ b/fs/jbd2/revoke.c
@@ -638,10 +638,8 @@ static void flush_descriptor(journal_t *journal,
 {
 	jbd2_journal_revoke_header_t *header;
 
-	if (is_journal_aborted(journal)) {
-		put_bh(descriptor);
+	if (is_journal_aborted(journal))
 		return;
-	}
 
 	header = (jbd2_journal_revoke_header_t *)descriptor->b_data;
 	header->r_count = cpu_to_be32(offset);
-- 
2.19.1

