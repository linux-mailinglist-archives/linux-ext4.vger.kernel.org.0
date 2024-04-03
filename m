Return-Path: <linux-ext4+bounces-1842-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA790896380
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 06:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9971C2257F
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 04:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708A2AE8E;
	Wed,  3 Apr 2024 04:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FuEdviFY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966881373
	for <linux-ext4@vger.kernel.org>; Wed,  3 Apr 2024 04:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118660; cv=none; b=J/Xw0Ra3Z8CXGzgrXjeRzFXLAlUYFq6Vyy6tGAb6ULHJQ9d6WGrO6SJj4OeD2iqIDabpc/WaltuFkg6tjGnQT8dUYPPcXz0cP6BolyXwfpXCZaz39pCFeUZIfwvdvGJ5tYVzwKKVAbc4ZPoX2gTmz8SDQmCJDeoYPD5nLcDi4bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118660; c=relaxed/simple;
	bh=xJshLuWOGGbhtAQGYokr1xcm8WxYktsyGNgAq3CE+jM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PYH0/Ralm2tlT/7Lr1hRKRyihi5ZyU1KgeCokxws/qg3F74sfru3EU4+lTuInhFJbnl3q3cFXoQ3JQSTb5nips3GKEVBxF5AhvcWCcRB/QqyBCiVBbpAofRbsPRJ9lsMSjBVedFQY8IhRquWwKHmahjTwG+4pLkRLOVfuY1ETsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FuEdviFY; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432L2iND020054;
	Wed, 3 Apr 2024 04:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=GpKOvr6Rt5gpWDUrPCXj6QUYuMHVAebCCBpIk+ZSNr4=;
 b=FuEdviFY+vgf+QxBLlA/d+XXjFh4D7P3jeFJ94wwrKfQimieGOEfj6W3OlyUv7Dfji4Y
 dACvcu3h32419vGVeaGbl4zRW8Ae1k4t1umuTx4p4LBZizS5IKN/WWrTYm8hxyL6gJUC
 TgQx0KcjN+p1oynTnXAx1V1Vr9u0+JY36gLkGPRCm1i9zxcRmzD7No1HMNN8R/dYniiC
 djDddV0gMmnUeP+tK5pe5o8eAuG2JNYIu/TTJZJF43wAi0t7Mqrfs4BV7+xGL0NVzpNc
 dqkXwCY71ZH/jOJb1fSpsBR5UIxV8uVQy0IHVE/fi7EaHhptiW/EJPSqcS9oNOIgE6j0 mA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9v8sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 04:30:52 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4333BA5G007158;
	Wed, 3 Apr 2024 04:30:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x696806q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 04:30:51 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4334Upip019247;
	Wed, 3 Apr 2024 04:30:51 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3x696806pk-1;
	Wed, 03 Apr 2024 04:30:51 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger@dilger.ca, djwong@kernel.org,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH v3] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-size values
Date: Wed,  3 Apr 2024 04:30:37 +0000
Message-Id: <20240403043037.3992724-1-srivathsa.d.dara@oracle.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_03,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030027
X-Proofpoint-GUID: CBz8nx-Fmq4lCFQsQG9I8Vc_34rT0z_K
X-Proofpoint-ORIG-GUID: CBz8nx-Fmq4lCFQsQG9I8Vc_34rT0z_K

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

v2->v3:
Remove redundant words and add info about how cluster-sizes that are
not powers of 2 are rounded.
---
 misc/mke2fs.8.in | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 30f97bb5..c7b21f9d 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -232,9 +232,13 @@ test is used instead of a fast read-only test.
 .TP
 .B \-C " cluster-size"
 Specify the size of cluster in bytes for file systems using the bigalloc
-feature.  Valid cluster-size values are from 2048 to 256M bytes per
-cluster.  This can only be specified if the bigalloc feature is
-enabled.  (See the
+feature. Valid cluster-size values range from 2 to 32768 times the
+filesystem blocksize and must be a power of 2. If a cluster-size that is
+not a power of 2 is provided, it will be rounded down to the nearest
+power of 2 that is less than the given cluster-size. For example,
+specifying '-C 20k', '-C 30k', or '-C 17k' will result in a cluster-size
+of 16k. The cluster-size can only be specified if the
+bigalloc feature is enabled.  (See the
 .B ext4 (5)
 man page for more details about bigalloc.)   The default cluster size if
 bigalloc is enabled is 16 times the block size.
-- 
2.39.3


