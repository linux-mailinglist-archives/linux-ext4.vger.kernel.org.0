Return-Path: <linux-ext4+bounces-1405-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7754869176
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 14:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C441C26546
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Feb 2024 13:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1444213B280;
	Tue, 27 Feb 2024 13:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ok8r1ZdE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31A013AA35
	for <linux-ext4@vger.kernel.org>; Tue, 27 Feb 2024 13:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039635; cv=none; b=gc4Cbs6UEM5IDfUX7yH6yjcSxa4HKJ/GA9g1RvBVXsYxf0OQO6UCvi5HzuNPhn/fT4vaSKdmrvnSNVhtGanIiliZK48qVn/dd50srsZ3sQCEAZ17jWTWcbHewNMdkzxPzlgqrgpAMsttxCgojf8IBaGQRlK085zAzZFmGPEoM1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039635; c=relaxed/simple;
	bh=WQHmBMw/po0dZD8MJ/cpYcIogz4s7nOg9ipiJgBEQHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=szshWVYW4vb+8JAg/wPZBr6vhYY2DCveW9uyLJyJn2BHuZkcAUCkk386QU+Xo0DTQXPjP5SG9JyZx8FBjHOjVXviYnDaAjqn0VKi3UrKVvXU6Vu2fDTFAxYZ17CS3JoUipUcnJdAKA1OgEbkuWl+gfDQfYsuxpPUydGpUC4N8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ok8r1ZdE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41R9ItVU000780;
	Tue, 27 Feb 2024 13:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=/njIASSv7F6paA7qHQSr/oE0nYWdhOwr6Q567iOml9U=;
 b=Ok8r1ZdEdNcxSolKpLsR6TX0dfL5k/4MkzEX7p+MluvUjfkYbfh8kaEFn3OyCXCQuEGZ
 P2w92BBLXJzc8G2kd6TCeuk/naoyy3fLOTltHDrwj6l4o8/SaoGCig3ppw21baDdrvEt
 DyFnusw8dkX0w8Y2yt0YChWe/yEHVzkMDMMIQXMk75plObcEvHsCc9z10xygBlVbGs5V
 nQtVkENHtVzZE4Bz5PhLtdS4dvtKJZHDNeENivYONALD8VwWBo0Mv8yG1y/ltdDDJCOF
 Yfdtq458dQxCL8EWkdGGm9h3Ohgu0UtxE9TK0N2jHIO3zFJZHmmJAVqjGduVVNE3IEBB Rw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wf784fat8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 13:13:49 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 41RBfl6m019175;
	Tue, 27 Feb 2024 13:13:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wgbdk0qb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Feb 2024 13:13:48 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41RDDmYY026047;
	Tue, 27 Feb 2024 13:13:48 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wgbdk0qb0-1;
	Tue, 27 Feb 2024 13:13:48 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com
Subject: [PATCH] ext4: Enable meta_bg only when new desc blocks are needed
Date: Tue, 27 Feb 2024 13:13:29 +0000
Message-Id: <20240227131329.2608466-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-02-26_11,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402270102
X-Proofpoint-GUID: Fjx2eVWfdSxVwvRDXtebNAOWd3y7sKZO
X-Proofpoint-ORIG-GUID: Fjx2eVWfdSxVwvRDXtebNAOWd3y7sKZO

This patch addresses an issue observed when resize_inode is disabled
and an online extension of a filesysyem is performed. When a filesystem
is expanded to a size that does not require a addition of a new
descriptor block, the meta_bg feature is being enabled even though no
part of the filesystem uses this layout.

This patch ensures that the meta_bg feature is only enabled if
any of the added block groups utilize meta_bg layout.

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 fs/ext4/resize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 928700d57eb6..99b52f26e818 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1996,7 +1996,7 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		}
 	}
 
-	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
+	if ((!resize_inode && !meta_bg && n_desc_blocks > o_desc_blocks) || n_blocks_count == o_blocks_count) {
 		err = ext4_convert_meta_bg(sb, resize_inode);
 		if (err)
 			goto out;
-- 
2.39.3


