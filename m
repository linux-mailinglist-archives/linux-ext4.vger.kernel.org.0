Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555643D0844
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhGUEsN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:48:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3324 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232323AbhGUErn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L5EjpR030863;
        Wed, 21 Jul 2021 01:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=+vw/7gKN0LmiBw5e83d/WZLglU6zOKQTmJQZKg6TM3A=;
 b=PK7uC4lg8FIicmMK3JZ/c/lQnIdEL2sGpTG5pCxN0tE7P+XLiDMgJJOQ8nks6yl15uPC
 vlyGHm5LxifJub2kCv0hX7y58sv5vmHXvnEPb/eyPP/F73ZmZ1cfZ5iNTIH0v2XQGcL8
 R+v6hC4e+udV2UkIVSyKiTbUnvUQ6/Ri9j+P0tMBbPpN77/fbowoHy5wrmXXlsGnTJPs
 rv0QTMC9a7ViX8AstMfxPcL/KeHSpTQG4W1MvDcqvdOhR6RhTKBMpMoqKKLDa8EmLn6X
 hVukzmzLwJgG2jnpeMpkN/iwhG3QgtnxmsOwvSP1VfBa668ziqhMT54kDnnflu/Zr1Jg xw== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xd8k880y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:14 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5FgoJ004331;
        Wed, 21 Jul 2021 05:28:12 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 39upu890d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:11 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5S93U35783094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:09 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7AAD7AE04D;
        Wed, 21 Jul 2021 05:28:09 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1B040AE053;
        Wed, 21 Jul 2021 05:28:09 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:08 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 3/9] ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
Date:   Wed, 21 Jul 2021 10:57:56 +0530
Message-Id: <c673d13fae1ad215e5b2856ee041ac731ec3d680.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ps8IPZDqK5IKn5ifa7IOLPTNA1kUUUOG
X-Proofpoint-ORIG-GUID: ps8IPZDqK5IKn5ifa7IOLPTNA1kUUUOG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

mkfs.ext4 by default uses 4K blocksize. On DAX config with a 64K
pagesize platform (PPC64), this will fail to mount since DAX requires bs
== ps.
Hence add the -b blocksize paramter in ext4/306.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/306 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/306 b/tests/ext4/306
index 4a339570..2ff88537 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -33,7 +33,10 @@ features="^extents"
 if grep -q 64bit /etc/mke2fs.conf ; then
     features="^extents,^64bit"
 fi
-$MKFS_EXT4_PROG -F -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
+
+blksz=$(get_page_size)
+
+$MKFS_EXT4_PROG -F -b $blksz -O "$features" $SCRATCH_DEV 512m >> $seqres.full 2>&1
 _scratch_mount
 
 # Create a small non-extent-based file
-- 
2.31.1

