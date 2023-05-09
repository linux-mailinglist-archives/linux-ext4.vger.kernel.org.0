Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA08A6FBF2E
	for <lists+linux-ext4@lfdr.de>; Tue,  9 May 2023 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbjEIGW1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 May 2023 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234859AbjEIGW0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 May 2023 02:22:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F8F9012
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 23:22:25 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348NxChU005868;
        Tue, 9 May 2023 06:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=rZMKKsu16mHqDmBwDEXPax0+msUVKwadkrTOsSG3wGs=;
 b=LJ42r1AU0ZNeIcw9JazpxeeLLUO+sq2kOHhibjc0GVMqmCP6DjTqyWNZJQEPmMssqM3a
 3Gy/gppa+MblP9mcx3KsUxGU2So8oSrLMG5S/Qc2VZYwiZTSri6JsI8giFz8k6N55zrO
 bMZzuWGTA3esktm2U/9ZkDqQMwZAgYas/DkgMrajnGahnVzGMY1tBzoeDWZ8fqbkxG59
 W/FBPXXrfjQQX9VGw2PqvXud5zCpTu5gt3akrVl6aDx2pXlMBY9QcxnAi9nEe5gHJfmA
 zzYTMHO7PNEY8pSELai8oGcqYUQpxuNL0lg5HggTy/OtBpROT7aFPei3VQ3NIMlV4Pf6 Rw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf77d905s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 06:22:21 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 3495ONdQ001677;
        Tue, 9 May 2023 06:22:20 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf82v6nr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 May 2023 06:22:20 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3496KZbL002883;
        Tue, 9 May 2023 06:22:19 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3qf82v6nqh-1;
        Tue, 09 May 2023 06:22:19 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: [RESEND PATCH] debugfs/htree.c: In do_dx_hash() read hash_seed, hash_version directly from superblock
Date:   Tue,  9 May 2023 06:21:29 +0000
Message-Id: <20230509062129.1478823-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-09_03,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305090048
X-Proofpoint-ORIG-GUID: _XqvdA6z30xSwooFZJc6lVPpyIxVDENU
X-Proofpoint-GUID: _XqvdA6z30xSwooFZJc6lVPpyIxVDENU
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

debugfs hash command computes the hash for the given filename. It takes
hash_seed and hash_version (i.e hash algorithm) as arguments. User has
to refer to the superblock to get these values used by the filesystem.
If the arguments are not given then debugfs computes hash assuming both
hash_seed and hash_version are zeros. In most of the cases this assumption
will be different from the actual hash_seed and hash_version used by the
filesystem. In general user will be in need of hash computed from
hash_seed and hash_version of the filesystem. So, instead of assuming
hash_seed and hash_version as zero when the arguments are not provided,
read these directly from the superblock to simplify the task of user.

Example:
Before:-
debugfs:  hash -s 524e5394-e2a3-43fa-b192-79720b1fe3e1 -h half_md4 file1
Hash of file1 is 0x4a8d8c94 (minor 0x17a37f43)

After improvement:-
debugfs:  hash file1
Hash of file1 is 0x4a8d8c94 (minor 0x17a37f43)

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 debugfs/htree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/debugfs/htree.c b/debugfs/htree.c
index 7fae7f11..2d881c74 100644
--- a/debugfs/htree.c
+++ b/debugfs/htree.c
@@ -316,7 +316,12 @@ void do_dx_hash(int argc, char *argv[], int sci_idx EXT2FS_ATTR((unused)),
 	int		hash_flags = 0;
 	const struct ext2fs_nls_table *encoding = NULL;
 
-	hash_seed[0] = hash_seed[1] = hash_seed[2] = hash_seed[3] = 0;
+	hash_seed[0] = current_fs->super->s_hash_seed[0];
+	hash_seed[1] = current_fs->super->s_hash_seed[1];
+	hash_seed[2] = current_fs->super->s_hash_seed[2];
+	hash_seed[3] = current_fs->super->s_hash_seed[3];
+
+	hash_version = current_fs->super->s_def_hash_version;
 
 	reset_getopt();
 	while ((c = getopt(argc, argv, "h:s:ce:")) != EOF) {
-- 
2.31.1

