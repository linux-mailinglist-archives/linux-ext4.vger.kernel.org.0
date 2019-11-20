Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46A751032A8
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 06:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfKTFAi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 00:00:38 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6168 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbfKTFAi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 00:00:38 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAK4vVZ7050041
        for <linux-ext4@vger.kernel.org>; Wed, 20 Nov 2019 00:00:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wcf56yj4f-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-ext4@vger.kernel.org>; Wed, 20 Nov 2019 00:00:36 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-ext4@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 20 Nov 2019 05:00:34 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 05:00:32 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAK50VcQ42009006
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 05:00:31 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1258CA405D;
        Wed, 20 Nov 2019 05:00:31 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AB35FA405F;
        Wed, 20 Nov 2019 05:00:29 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.63.56])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 05:00:29 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        riteshh@linux.ibm.com
Subject: [RFCv3 1/4] ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
Date:   Wed, 20 Nov 2019 10:30:21 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191120050024.11161-1-riteshh@linux.ibm.com>
References: <20191120050024.11161-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112005-0012-0000-0000-0000036956A2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112005-0013-0000-0000-000021A4E34A
Message-Id: <20191120050024.11161-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-19_08:2019-11-15,2019-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 spamscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1911200045
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our dax read/write methods to just do the
trylock for the RWF_NOWAIT case.
This seems to fix AIM7 regression in some scalable filesystems upto ~25%
in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..977ac58dc718 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -88,9 +88,10 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock_shared(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock_shared(inode);
 	}
 	/*
@@ -487,9 +488,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool extend = false;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock(inode);
 	}
 
-- 
2.21.0

