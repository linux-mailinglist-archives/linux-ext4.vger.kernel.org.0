Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5FEC7B3456
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbjI2OLK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 10:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjI2OLE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 10:11:04 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4394F1A8;
        Fri, 29 Sep 2023 07:11:02 -0700 (PDT)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDDvsh019380;
        Fri, 29 Sep 2023 14:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=w8SJmSny0Zw7pXex9C2zi5+DJoyv5ZO/nLsi0spalII=;
 b=HnAP9FzrYno+GyCptuOatT5/zccTsE0llfrgvLZqy4n1Lt9ksjjp4exoTReuamBUHe2t
 ff9quY+UW0bshBCBB1fhkFHwdP+eA5CyvcVVwL64GUXgvz8GrjaaFngEeTi5KtIBO/CU
 RlySCDx6j0Sfj1DNPbdHKaHTIvyuV0zZ1NIX9Zb9zYP2gMcoQJWhhze4NTIdR+7QHJ3Y
 ixngUXDoI4Z+n33q7K5GenqpFRqpuV2qtx1RCv8VV6TPV1QzC0Nk1qQ+P35yyy3KbgBo
 dxveYAjE1ZVw2aTUxPZF+p/gbVVdkColQDb19biMx6avbN8fwHdN/zzw81BHVHpt9e/S 1g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxtfjvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:58 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDEs9E022682;
        Fri, 29 Sep 2023 14:10:57 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxtfjvt0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:57 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TCuFRT010995;
        Fri, 29 Sep 2023 14:10:56 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabum4wtp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:56 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TEAsmn44892648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:10:54 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61EC720043;
        Fri, 29 Sep 2023 14:10:54 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0CD820040;
        Fri, 29 Sep 2023 14:10:52 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.84.228])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 14:10:52 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] ext4: truncate complete range in pagecache before calling ext4_zero_partial_blocks()
Date:   Fri, 29 Sep 2023 19:40:44 +0530
Message-Id: <f7aaea4a59bc1c69f87e178dae34c38d2bcfee12.1695987265.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1695987265.git.ojaswin@linux.ibm.com>
References: <cover.1695987265.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mLO0E7J62S03FXhdZmwf1R1eOP5SmG0d
X-Proofpoint-GUID: BZ4DcwI7GjGeCo8UQtqWZ2YRaQq4ey4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 bulkscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In ext4_zero_range() and ext4_punch_hole(), the range passed could be unaligned
however we only zero out the pagecache range that is block aligned. These
functions are relying on ext4_zero_partial_blocks() ->
__ext4_block_zero_page_range() to take care of zeroing the unaligned edges in
the pageacache. However, the right thing to do is to properly zero out the whole
range in these functions before and not rely on a different function to do it
for us. Hence, modify ext4_zero_range() and ext4_punch_hole() to zero the
complete range.

This will also allow us to now exit early for unwritten buffer heads in
__ext4_block_zero_page_range(), in upcoming patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 17 +++++++++++------
 fs/ext4/inode.c   |  3 +--
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c79b4c25afc4..2dc681cab6a5 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4582,9 +4582,6 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 
 	/* Zero range excluding the unaligned edges */
 	if (max_blocks > 0) {
-		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
-			  EXT4_EX_NOCACHE);
-
 		/*
 		 * Prevent page faults from reinstantiating pages we have
 		 * released from page cache.
@@ -4609,17 +4606,25 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 		 * disk in case of crash before zeroing trans is committed.
 		 */
 		if (ext4_should_journal_data(inode)) {
-			ret = filemap_write_and_wait_range(mapping, start, end - 1);
+			ret = filemap_write_and_wait_range(mapping, start,
+							   end - 1);
 			if (ret) {
 				filemap_invalidate_unlock(mapping);
 				goto out_mutex;
 			}
 		}
+	}
+
+	/*
+	 * Now truncate the pagecache and zero out non page aligned edges of the
+	 * range (if any)
+	 */
+	truncate_pagecache_range(inode, offset, offset + len - 1);
 
-		/* Now release the pages and zero block aligned part of pages */
-		truncate_pagecache_range(inode, start, end - 1);
+	if (max_blocks > 0) {
 		inode->i_mtime = inode->i_ctime = current_time(inode);
 
+		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
 		ret = ext4_alloc_file_blocks(file, lblk, max_blocks, new_size,
 					     flags);
 		filemap_invalidate_unlock(mapping);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 6c490f05e2ba..de8ea8430d30 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3974,9 +3974,8 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 		ret = ext4_update_disksize_before_punch(inode, offset, length);
 		if (ret)
 			goto out_dio;
-		truncate_pagecache_range(inode, first_block_offset,
-					 last_block_offset);
 	}
+	truncate_pagecache_range(inode, offset, offset + length - 1);
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
 		credits = ext4_writepage_trans_blocks(inode);
-- 
2.39.3

