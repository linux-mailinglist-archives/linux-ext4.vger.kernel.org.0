Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDF1138FB6
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Jan 2020 12:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgAMLEe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Jan 2020 06:04:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48116 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725992AbgAMLEe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 13 Jan 2020 06:04:34 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00DAvbrO062323
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:32 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfa255uty-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Mon, 13 Jan 2020 06:04:32 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Mon, 13 Jan 2020 11:04:30 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 11:04:27 -0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00DB4QdO56492180
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 11:04:26 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8A2542047;
        Mon, 13 Jan 2020 11:04:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6D9A4204C;
        Mon, 13 Jan 2020 11:04:25 +0000 (GMT)
Received: from dhcp-9-199-159-93.in.ibm.com (unknown [9.199.159.93])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 11:04:25 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before filemap_write_and_wait_range
Date:   Mon, 13 Jan 2020 16:34:21 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1578907890.git.riteshh@linux.ibm.com>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011311-0012-0000-0000-0000037CE15B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011311-0013-0000-0000-000021B90AE0
Message-Id: <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_03:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=18 mlxscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 mlxlogscore=476
 malwarescore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130094
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some filesystems (e.g. ext4) need to know in it's writeback path, that
whether DIO is in progress or not. This info may be needed to avoid the
stale data exposure race with DIO reads.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/iomap/direct-io.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 23837926c0c5..d1c159bd3854 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -468,9 +468,18 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		flags |= IOMAP_NOWAIT;
 	}
 
+	/*
+	 * Call inode_dio_begin() before we write out and wait for writeback to
+	 * complete. This may be needed by some filesystems to prevent race
+	 * like stale data exposure by DIO reads.
+	 */
+	inode_dio_begin(inode);
+	/* So that i_dio_count is incremented before below operation */
+	smp_mb__after_atomic();
+
 	ret = filemap_write_and_wait_range(mapping, pos, end);
 	if (ret)
-		goto out_free_dio;
+		goto out_end_dio;
 
 	/*
 	 * Try to invalidate cache pages for the range we're direct
@@ -488,11 +497,9 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	    !inode->i_sb->s_dio_done_wq) {
 		ret = sb_init_dio_done_wq(inode->i_sb);
 		if (ret < 0)
-			goto out_free_dio;
+			goto out_end_dio;
 	}
 
-	inode_dio_begin(inode);
-
 	blk_start_plug(&plug);
 	do {
 		ret = iomap_apply(inode, pos, count, flags, ops, dio,
@@ -568,6 +575,8 @@ iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 
 	return iomap_dio_complete(dio);
 
+out_end_dio:
+	inode_dio_end(inode);
 out_free_dio:
 	kfree(dio);
 	return ret;
-- 
2.21.0

