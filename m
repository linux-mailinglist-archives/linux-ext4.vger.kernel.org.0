Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720823D0840
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232473AbhGUErs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:47:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232215AbhGUErl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:41 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L53aLY142228;
        Wed, 21 Jul 2021 01:28:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=P7+4CvfvrOi+e26Mgsv0rRbb9r5BcCUfRTdJ+LSyTKE=;
 b=IZve1yYWJq0qR9udIQgxIdabppY10HeoYhpyIw/PTEd6b03FiiC1P6t4GwvqRZgK539Q
 kJpBOf2DfJ8fSuuryt3HGOS7I5zj8euxbh3YTiZrz4oG2ByTM3JgCt5NajMnlpaQMFYI
 wqWR5OyfwFdbMsXgAVeQYuyJD3uiIrk6hqxK2jRXbUItTmxG1AoHKDJ4ZJAZYaMjijbW
 l9UTE7AIJ8drsZYwvM56g5UPJGeNsL6oaesyltgc1uuDo23WKa4gE2JFGmUOxs7SrZNx
 aVH7faK9uK+O+hVbIKHwkdtMGtVhmQGQZdt8HjZnQCgL/hBgtgSJOcOqZywgorrsBGeg yQ== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xan7bghh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:16 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DhKV028474;
        Wed, 21 Jul 2021 05:28:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 39upu8901t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:13 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5SBiQ27656624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:11 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 453FDAE045;
        Wed, 21 Jul 2021 05:28:11 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF75EAE056;
        Wed, 21 Jul 2021 05:28:10 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:10 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 4/9] ext4/022: exclude this test for dax config on 64KB pagesize platform
Date:   Wed, 21 Jul 2021 10:57:57 +0530
Message-Id: <3e4a18ec37b9a7164cab20b6bf97c65574099f32.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: eCkGId7jvbBrpu_XoVAk1AXJzsRBS0eB
X-Proofpoint-GUID: eCkGId7jvbBrpu_XoVAk1AXJzsRBS0eB
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This test case assumes blocksize to be 4KB and hence it fails
to mount with "-o dax" option on a 64kb pagesize platform (e.g. PPC64).
This leads to test case reported as failed with dax config on PPC64.

This patch exclude this test when pagesize is 64KB and for dax config.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/022 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/ext4/022 b/tests/ext4/022
index fdc19d93..321050b3 100755
--- a/tests/ext4/022
+++ b/tests/ext4/022
@@ -25,10 +25,13 @@ _require_dumpe2fs
 _require_command "$DEBUGFS_PROG" debugfs
 _require_attrs
 
-# Use large inodes to have enough space for experimentation
-INODE_SIZE=1024
 # Block size
 BLOCK_SIZE=4096
+if [[ $(get_page_size) -ne $BLOCK_SIZE ]]; then
+       _exclude_scratch_mount_option dax
+fi
+# Use large inodes to have enough space for experimentation
+INODE_SIZE=1024
 # We leave this amount of bytes for xattrs
 XATTR_SPACE=256
 # We grow extra_isize by this much
-- 
2.31.1

