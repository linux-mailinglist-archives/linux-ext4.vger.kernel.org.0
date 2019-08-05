Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16A03810A8
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Aug 2019 06:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfHEEGl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Aug 2019 00:06:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36280 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725613AbfHEEGl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Aug 2019 00:06:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7542DlQ082537;
        Mon, 5 Aug 2019 00:06:34 -0400
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u680n1qcs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 00:06:34 -0400
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x7545Xxf024419;
        Mon, 5 Aug 2019 04:06:33 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma04wdc.us.ibm.com with ESMTP id 2u51w699ry-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Aug 2019 04:06:33 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7546Vqd11993478
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 5 Aug 2019 04:06:31 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A8EB46A04D;
        Mon,  5 Aug 2019 04:06:31 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3635B6A05F;
        Mon,  5 Aug 2019 04:06:29 +0000 (GMT)
Received: from dhcp-9-109-213-20.in.ibm.com (unknown [9.109.213.20])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon,  5 Aug 2019 04:06:28 +0000 (GMT)
From:   Chandan Rajendra <chandan@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     Chandan Rajendra <chandan@linux.ibm.com>, tytso@mit.edu,
        adilger.kernel@dilger.ca, harish@linux.ibm.com, jack@suse.cz
Subject: [PATCH V2] jbd2: flush_descriptor(): Do not decrease buffer head's ref count
Date:   Mon,  5 Aug 2019 09:38:00 +0530
Message-Id: <20190805040800.31743-1-chandan@linux.ibm.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=18 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=781 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908050043
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

The warning happens because flush_descriptor() drops bh reference it
does not own. The bh reference acquired by
jbd2_journal_get_descriptor_buffer() is owned by the log_bufs list and
gets released when this list is processed. The reference for doing IO is
only acquired in write_dirty_buffer() later in flush_descriptor().

Reported-by: Harish Sriram <harish@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chandan Rajendra <chandan@linux.ibm.com>
---
Changelog:
V1 -> V2:
1. Fix commit message.

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

