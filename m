Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805477867F9
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Aug 2023 09:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbjHXG7j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Aug 2023 02:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240306AbjHXG7F (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Aug 2023 02:59:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3AEE45
        for <linux-ext4@vger.kernel.org>; Wed, 23 Aug 2023 23:59:02 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37NKwZmC003334;
        Thu, 24 Aug 2023 06:59:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=yLURkSUt8sDw8aT9AP29hZBFamqMks3yvUMQSIK14mg=;
 b=t8UH6GS1rOlKJxWlG+snQdaY4Zh+LsRpMINvGaAyZq/lmNML6DzlC4Me7ztYVCSMD6Sq
 2x4z/77h+Hu7N5EQue+HJ7wgtVv+leVRuyPWBaZ5dV5OotrBJQq24i0pUT5EUU3bOLru
 ozhNOYZOHwoDsQN/Rnk7plOMp2/SgIkPH3LKqJPZJ5MJZwyGYLBTH2P8yiWWJqJ3gKFx
 L4Na6GeUDo5fZubWSssTxwJeY8cEl5qXcfrSdqp47kF2dgm/bCbJJuRcIX7GOR7UvDPJ
 GNFtNF+A192RV4IHEi8FC0cS3Jzyb7ZUBubg7yiAXoXG9nDizK30iWn+Ny+t+uudI8Rw Wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sn1ytufh4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 06:59:00 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37O5prlB036234;
        Thu, 24 Aug 2023 06:58:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3sn1yvk6b6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Aug 2023 06:58:59 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37O6wxo5004395;
        Thu, 24 Aug 2023 06:58:59 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3sn1yvk6ag-1;
        Thu, 24 Aug 2023 06:58:59 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, rajesh.sivaramasubramaniom@oracle.com,
        junxiao.bi@oracle.com
Subject: [RESEND PATCH] misc/mke2fs.8.in: Correct valid cluster-size values
Date:   Thu, 24 Aug 2023 06:58:37 +0000
Message-Id: <20230824065837.2663322-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-24_03,2023-08-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2308240056
X-Proofpoint-ORIG-GUID: O2YeZblKS5QE3OX5MK5MuVoWZPIvWsmd
X-Proofpoint-GUID: O2YeZblKS5QE3OX5MK5MuVoWZPIvWsmd
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

According to the mke2fs man page, the supported cluster-size values
for an ext4 filesystem are 2048 to 256M bytes. However, this is not
the case.

When mkfs is run to create a filesystem with following specifications:
* 1k blocksize and cluster-size greater than 32M
* 2k blocksize and cluster-size greater than 64M
* 4k blocksize and cluster-size greater than 128M
mkfs fails with "Invalid argument passed to ext2 library while trying
to create journal" error. In general, when the cluster-size to blocksize
ratio is greater than 32k, mkfs fails with this error.

Went through the code and found out that the function
`ext2fs_new_range()` is the source of this error. This is because when
the cluster-size to blocksize ratio exceeds 32k, the length argument
to the function `ext2fs_new_range()` results in 0. Hence, the error.

This patch corrects the valid cluster-size values.
---
 misc/mke2fs.8.in | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index e6bfc6d6..b5b02144 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -230,9 +230,9 @@ test is used instead of a fast read-only test.
 .TP
 .B \-C " cluster-size"
 Specify the size of cluster in bytes for filesystems using the bigalloc
-feature.  Valid cluster-size values are from 2048 to 256M bytes per
-cluster.  This can only be specified if the bigalloc feature is
-enabled.  (See the
+feature.  Valid cluster-size values are from 2048 to 128M bytes per 
+cluster based on filesystem blocksize. This can only be specified if the
+bigalloc feature is enabled.  (See the
 .B ext4 (5)
 man page for more details about bigalloc.)   The default cluster size if
 bigalloc is enabled is 16 times the block size.
-- 
2.31.1

