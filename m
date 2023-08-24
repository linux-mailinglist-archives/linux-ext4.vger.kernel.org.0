Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08797867F0
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbjHXG5b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 02:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbjHXG5P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 02:57:15 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03AF6E4B
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 23:57:12 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwXUg025053;
        Thu, 24 Aug 2023 06:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=0JksWpxWEJCADoFiWutnVlNbT8v2qTI1llaHquf8Xh0=;
 b=gfpA3x7bp9Z906Rsw4wY+CFRa+k9lgO+TKy3E8oI8QW4hLjgOeks53KGohYTEAss7Yph
 Rad50xogU6/dEhNE4lcgGmVZq9eb+3H/OezPeoyXgizTc7hJlkt8ZgTjO1QppkJkXTvb
 hppWtCAdB84Y9M4xnPa/ObOkJ1zLvFxadKRW4mfg9Q6ma5XdtIwTzEfyTnrWlL0J51fP
 cY9/7glxIzwQlzdemlb0lgYpw8ujg0SbxtXmTTMm+/AzQRoVVWguTi12+/A0uITDXQ10
 qT7LaiOPP32tqmcyTvXL6iVe1xKvunY2gkZSWKb4cX1KaDqTcV1nh9xoncHhYzYtafFs gA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn20ckdys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 06:57:06 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O606j9035768;
        Thu, 24 Aug 2023 06:57:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yp2tey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 06:57:06 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O6v5tF013266;
        Thu, 24 Aug 2023 06:57:05 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yp2tdq-1;
        Thu, 24 Aug 2023 06:57:05 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
        junxiao.bi@oracle.com
Subject: [RESEND PATCH] debugfs/htree.c: In do_dx_hash() read hash_seed, hash_version directly from superblock
Date:   Thu, 24 Aug 2023 06:56:34 +0000
Message-Id: <20230824065634.2662858-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240056
X-Proofpoint-ORIG-GUID: iVAasXZc5CsQepTSgiIYpS2f9RWJ9SH-
X-Proofpoint-GUID: iVAasXZc5CsQepTSgiIYpS2f9RWJ9SH-
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

debugfs hash command computes the hash for the given filename. It takes hash_seed and
hash_version (i.e hash algorithm) as arguments. User has to refer to the superblock to
get these values used by the filesystem. If the arguments are not given then debugfs
computes hash assuming both hash_seed and hash_version are zeros. In most of the cases
this assumption will be different from the actual hash_seed and hash_version used by the
filesystem. In general user will be in need of hash computed from hash_seed and hash_version
of the filesystem. So, instead of assuming hash_seed and hash_version as zero when the
arguments are not provided, read these directly from the superblock to simplify the task of user.

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

