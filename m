Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4C9711C5AB
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Dec 2019 06:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbfLLF4R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Dec 2019 00:56:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbfLLF4P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 12 Dec 2019 00:56:15 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC5jWTD102600
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2019 00:56:14 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wsm2gcfam-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Thu, 12 Dec 2019 00:56:14 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 12 Dec 2019 05:56:12 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 05:56:09 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC5u8YO53674056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 05:56:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6BF3FAE051;
        Thu, 12 Dec 2019 05:56:08 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ECEDAE056;
        Thu, 12 Dec 2019 05:56:07 +0000 (GMT)
Received: from dhcp-9-199-158-163.in.ibm.com (unknown [9.199.158.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 05:56:06 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 3/3] ext4: Move to shared i_rwsem even without dioread_nolock mount opt
Date:   Thu, 12 Dec 2019 11:25:57 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212055557.11151-1-riteshh@linux.ibm.com>
References: <20191212055557.11151-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121205-0008-0000-0000-000003400364
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121205-0009-0000-0000-00004A600371
Message-Id: <20191212055557.11151-4-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=588
 clxscore=1015 bulkscore=0 mlxscore=0 impostorscore=0 adultscore=0
 suspectscore=3 lowpriorityscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120036
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We were using shared locking only in case of dioread_nolock mount option in case
of DIO overwrites. This mount condition is not needed anymore with current code,
since:-

1. No race between buffered writes & DIO overwrites. Since buffIO writes takes
exclusive lock & DIO overwrites will take shared locking. Also DIO path will
make sure to flush and wait for any dirty page cache data.

2. No race between buffered reads & DIO overwrites, since there is no block
allocation that is possible with DIO overwrites. So no stale data exposure
should happen. Same is the case between DIO reads & DIO overwrites.

3. Also other paths like truncate is protected, since we wait there for any DIO
in flight to be over.

Reviewed-by: Jan Kara <jack@suse.cz>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 1da49dffa3df..9c2711bce0f9 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -392,8 +392,8 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
  * - For extending writes case we don't take the shared lock, since it requires
  *   updating inode i_disksize and/or orphan handling with exclusive lock.
  *
- * - shared locking will only be true mostly with overwrites in dioread_nolock
- *   mode. Otherwise we will switch to exclusive i_rwsem lock.
+ * - shared locking will only be true mostly with overwrites. Otherwise we will
+ *   switch to exclusive i_rwsem lock.
  */
 static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 				     bool *ilock_shared, bool *extend)
@@ -415,14 +415,11 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
 		*extend = true;
 	/*
 	 * Determine whether the IO operation will overwrite allocated
-	 * and initialized blocks. If so, check to see whether it is
-	 * possible to take the dioread_nolock path.
-	 *
+	 * and initialized blocks.
 	 * We need exclusive i_rwsem for changing security info
 	 * in file_modified().
 	 */
 	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
-	     !ext4_should_dioread_nolock(inode) ||
 	     !ext4_overwrite_io(inode, offset, count))) {
 		inode_unlock_shared(inode);
 		*ilock_shared = false;
-- 
2.21.0

