Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00C6780732
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Aug 2023 10:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243650AbjHRIdJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Aug 2023 04:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358640AbjHRIct (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 18 Aug 2023 04:32:49 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C743C21
        for <linux-ext4@vger.kernel.org>; Fri, 18 Aug 2023 01:32:28 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37I61seg025183;
        Fri, 18 Aug 2023 08:32:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-03-30; bh=yLURkSUt8sDw8aT9AP29hZBFamqMks3yvUMQSIK14mg=;
 b=OfR4ca+DNDKwJXF9VX9n/S7iq/osy5cz7cA2O1ZHHcar55zGTNkD8icSv4KCFklRElR8
 OWG2odxFhad6GkaRvKFn/BMzcuZR8zUKmfvydVJAGf6RfJDkG9QvZ6r5FBTRihquP9sh
 JExYnMVuK22D+h87M541PoBYFM/bdubcLnySREnunlMbxrEF1V+WVTP9vu33qdFOJw7p
 QOe41yBWaf1eFyCbmpUlljDG+OTof+UpDhwkuaepB5C+Eu/5MPX6gL1yHXKZ7O2bxRUs
 NdkgjKX4uu81TfEa4SV2J2iONZ00AtIunWGAbxro0BzhzJyrBvyS24ZR+fFFPDwnvYfS ow== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se314bf7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 08:32:22 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37I6IObx040344;
        Fri, 18 Aug 2023 08:32:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0um6r2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Aug 2023 08:32:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37I8WLmD038655;
        Fri, 18 Aug 2023 08:32:21 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3sey0um6q2-1;
        Fri, 18 Aug 2023 08:32:20 +0000
From:   Srivathsa Dara <srivathsa.d.dara@oracle.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH] misc/mke2fs.8.in: Correct valid cluster-size values
Date:   Fri, 18 Aug 2023 08:31:39 +0000
Message-Id: <20230818083139.843238-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_09,2023-08-17_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308180079
X-Proofpoint-GUID: ECziD63LbftC_NzMC-6zY3aQXi-vhbyi
X-Proofpoint-ORIG-GUID: ECziD63LbftC_NzMC-6zY3aQXi-vhbyi
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

