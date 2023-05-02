Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A9E6F43FE
	for <lists+linux-ext4@lfdr.de>; Tue,  2 May 2023 14:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjEBMlk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 2 May 2023 08:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEBMli (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 2 May 2023 08:41:38 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1152F59D8
        for <linux-ext4@vger.kernel.org>; Tue,  2 May 2023 05:41:36 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342AKnmc022302
        for <linux-ext4@vger.kernel.org>; Tue, 2 May 2023 12:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=rZMKKsu16mHqDmBwDEXPax0+msUVKwadkrTOsSG3wGs=;
 b=w9VCY9C0oxf/Q//PCEsPo/ykDWHMszzJj68XsDiKHX1nz7VJvI23m7ZAISM5GxzrY2zJ
 8EYkNat+5/40scbxTKTGVAz5spcqj9OzqAO4XJeZHkfMwJ0cyxYedjeH+6F9XNV1Dgin
 JcPA77zCsNuJ0OqKOvofpzzVgc1GLqDblC9B+TFhUCW7ndl0zNu46G72NqTQq45GSi4f
 jtCuZ4LRcO59tp4E5MMfxPAZjcNEjyreP4kGHDJXv6bSGf7EcN2zmVoA4PXPY1B4o1Ez
 1i2L26I5ybj463RDV4e6QD5j/xy/JrJiR99Z4hF+wbN92a8gpO50r6E+c7cNlUwwEXzg rg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8sne4m9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-ext4@vger.kernel.org>; Tue, 02 May 2023 12:41:36 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 342CKitO027489
        for <linux-ext4@vger.kernel.org>; Tue, 2 May 2023 12:41:35 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spbxm1y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-ext4@vger.kernel.org>; Tue, 02 May 2023 12:41:35 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 342CfY89005686
        for <linux-ext4@vger.kernel.org>; Tue, 2 May 2023 12:41:34 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3q8spbxm1j-1;
        Tue, 02 May 2023 12:41:34 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     linux-ext4@vger.kernel.org
Cc:     rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        srivathsa.d.dara@oracle.com
Subject: [PATCH] debugfs/htree.c: In do_dx_hash() read hash_seed, hash_version directly from superblock
Date:   Tue,  2 May 2023 12:41:04 +0000
Message-Id: <20230502124103.428884-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305020109
X-Proofpoint-GUID: YngWMG-wB3ZNOMwmHNt7j8B6qw42lAMt
X-Proofpoint-ORIG-GUID: YngWMG-wB3ZNOMwmHNt7j8B6qw42lAMt
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

