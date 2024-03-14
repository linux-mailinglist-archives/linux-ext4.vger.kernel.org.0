Return-Path: <linux-ext4+bounces-1623-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ACA687BA71
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD0CA1C221FF
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 09:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB76CDBF;
	Thu, 14 Mar 2024 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fKOaFeXh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62AA6E5E0
	for <linux-ext4@vger.kernel.org>; Thu, 14 Mar 2024 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408697; cv=none; b=LYzzH66VaruH1+uSBCDdvDmllW5Y4FOzXn1hzQEQYVapgZlNsTcsnHeJFyDWiIqJmAN18XL7RRX2twwrmtvlBMo1A5NLn6VlCM/ttt1i3Bzfq8T/ekF8SFHfogskHxcbuNLydW6DLs8yc6fRnN8/7NpjAr+dgRIJzeIaNdLkZBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408697; c=relaxed/simple;
	bh=J9RXwTPmFoJKDKUunbn7j5jjS/Z1SmvbH3lMkCrgSWY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HE2FST5WtAK4la/WUwnMb556r+Hs030+pb8KfJNVPUXNXl6TBn9d56f4vvp7GwxWO5AZ0tLBw3M62wG8GOzloN/U/BYDjaxT9V8hYxlH8IfVpptFYwKXpyF+4YxOGKN1Qq+n+MD25ItThMksb30puh/eL3ElFCw7EsknFjTEa/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fKOaFeXh; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42E7nCvJ015163;
	Thu, 14 Mar 2024 09:31:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=yLURkSUt8sDw8aT9AP29hZBFamqMks3yvUMQSIK14mg=;
 b=fKOaFeXhkmZ8xV+3h9YUMHc9tpAGD2JfuxbhnXldLioJQJrZemolB16SnrlDFw1aJxzJ
 lTt2iM/A4GSHyYWmoxtX44opGvKaFKgiz7g1tCsZgGD975tl5hJgzqPiQxEzF0eLfnHT
 Ezma/yzdeZPL1PDDtrWzOe31NxFGrkZwmMKWvbKfydBYxRhZyHeQqhz6lTyJxmgA+boV
 PPX0pYf1km6jUNo61HB2RiYRC5bsu2drLRvJb8bEIN+SXh/XkJF50A6BFBuBM+fTaPdZ
 ma8pCgXAHG1lW5yGX6mX503ds8RL17js2Blt/BOK978V9BMEFOutTdd2DCfJ3LnpIt0n kA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wrec2jykb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:31:32 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42E9UgL1009089;
	Thu, 14 Mar 2024 09:31:31 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wre7gbab9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 09:31:31 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42E9VVkC038530;
	Thu, 14 Mar 2024 09:31:31 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wre7gbab5-1;
	Thu, 14 Mar 2024 09:31:31 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, rajesh.sivaramasubramaniom@oracle.com,
        junxiao.bi@oracle.com
Subject: [RESEND PATCH] e2fsprogs: misc/mke2fs.8.in: Correct valid cluster-size values
Date: Thu, 14 Mar 2024 09:31:27 +0000
Message-Id: <20240314093127.2100974-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-03-14_07,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140066
X-Proofpoint-ORIG-GUID: oarwaRE29yyKL0OU3vrqypu6AcOEZMAe
X-Proofpoint-GUID: oarwaRE29yyKL0OU3vrqypu6AcOEZMAe

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


