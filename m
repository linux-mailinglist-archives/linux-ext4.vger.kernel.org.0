Return-Path: <linux-ext4+bounces-1745-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4155888A3CA
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 15:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CA22E057F
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Mar 2024 14:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F9116F0F7;
	Mon, 25 Mar 2024 11:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ggz+A3sB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92B16FF48
	for <linux-ext4@vger.kernel.org>; Mon, 25 Mar 2024 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362991; cv=none; b=Uexp3JnLeJifFh10Qz0pUI3H6OATaJELEmd/oDTJdfeL+/eI9NOKmSslVz0c0C8CdtCYga+e80LYDvvX6/TlFtcukvc1+tGU93uEitUIvAhsdm2Z6m122GCLB2ds+H+qRlDTrYfUBr/jamlOuiMi3+B2I5JwztqeCB08VZWkkOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362991; c=relaxed/simple;
	bh=/Eher8QBlGLiF4zWEV7aDBM9ckJ8I2us6sPQVJLSyzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6z/q/m8aTodudmkgWi7JC/qjvvIkaEDaXs1Pq5KCgQahcAKFgzRFJltb5GFcKSYzyD/aDXwynTe+0noGnKDg5FvWWAacHdrhNhrB+tXgKlZy5YeKSbvXUhSp23b26JpH8KOBwDps/4nZ/gzyeDX5woIy3EgcFxkgq1HX8UkMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ggz+A3sB; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42P8pnKB024883;
	Mon, 25 Mar 2024 10:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=Ia6fIZJyL93NVOr0VUVSAK6AaON7NF5mlk/K3vRB4QI=;
 b=Ggz+A3sB4hAyZMCXdSyU30N2hDX7yKwoN8Ik0QF/qjTe4vrxUMEzKa6wXzhb/5xMmws5
 q3PR/BnFuiYHa1gwYdv1qjYDEorlfpZOUUkG23i1TQKsNIGxACZA+ENxTElF7EQ51zMT
 SgpsF2FjPx1vaI2JItljwc9MxkzYwhV7yoMU8q7+0Sm7fr274+AtY7jqGsGgaCZgqkne
 poTyV//t+tGD2QasGofDvibEiqXHQG0DIIlGUWGqLk+9eXPkdPnHte+FgyM7ZCtDcyMH
 GNbYTslRjpz0hu/fB8JSxh6zgecDQ1qiTTzEueQI0sDsEu2k3hfhcV7bZq6aedJ0qWr+ 3w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x1q4dtd4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 10:36:25 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PA4Xuv006910;
	Mon, 25 Mar 2024 10:36:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nhbjhuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Mar 2024 10:36:24 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42PAaO9g032138;
	Mon, 25 Mar 2024 10:36:24 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3x1nhbjhu4-1;
	Mon, 25 Mar 2024 10:36:24 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: adilger@dilger.ca, rajesh.sivaramasubramaniom@oracle.com,
        junxiao.bi@oracle.com
Subject: [PATCH v2] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-size values
Date: Mon, 25 Mar 2024 10:36:21 +0000
Message-Id: <20240325103621.1266289-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 malwarescore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250058
X-Proofpoint-ORIG-GUID: T76Goh-G81KKTmkjlCv7HcGJXsEuafzb
X-Proofpoint-GUID: T76Goh-G81KKTmkjlCv7HcGJXsEuafzb

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
index 30f97bb5..8194cc41 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -232,9 +232,9 @@ test is used instead of a fast read-only test.
 .TP
 .B \-C " cluster-size"
 Specify the size of cluster in bytes for file systems using the bigalloc
-feature.  Valid cluster-size values are from 2048 to 256M bytes per
-cluster.  This can only be specified if the bigalloc feature is
-enabled.  (See the
+feature.  Valid cluster-size values range from 2 to 32768 times the
+filesystem blocksize per cluster.  This can only be specified if the
+bigalloc feature is enabled.  (See the
 .B ext4 (5)
 man page for more details about bigalloc.)   The default cluster size if
 bigalloc is enabled is 16 times the block size.
-- 
2.39.3


