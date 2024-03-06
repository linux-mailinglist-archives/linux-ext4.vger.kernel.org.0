Return-Path: <linux-ext4+bounces-1523-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC53E872FDE
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 08:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE6A51C21886
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 07:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B996E5CDC3;
	Wed,  6 Mar 2024 07:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CVLDUMb3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC75C90C
	for <linux-ext4@vger.kernel.org>; Wed,  6 Mar 2024 07:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710795; cv=none; b=dpk0KjsjcKQxidORkb0+CJy6Cvw9Tjd68K0HhKEawosfexp7QfEjfuONSsyZ3R2astw5B2Xj1G2nw9eRizkwM/Kn5bMi+/g4VgcOU9ULTC2EUTDa+NSkaNsahm5cadBO2+777/oYRvrc+rCBBUQolumAMt+x60Clhifv/E7zcBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710795; c=relaxed/simple;
	bh=LXO3v+TrSu6JFBxpSZDPPqGo6+3BUpY1z+H3WMoQhXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxV8Klgt/ilDdiQ0QlvRARXtQEXYxgdDoIgj9JujBRqsqYuQLe8O7PSZm2fBA921dNyHYmXc53AEYZuO1a0XObIaq5r3QtnfTF0Xzsel0kc+jCLkj7xIk9n5haR7W3oPqcHJRxSUo6cEQ3cEFOsfrARyMtANjM0H7g/WdMusF74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CVLDUMb3; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4261EKTX026766;
	Wed, 6 Mar 2024 07:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2023-11-20; bh=eEphe5MX325kVO5k2hYl2xfpJZQs/tVN/U09mN35BsI=;
 b=CVLDUMb3H6hS0KXV3xORB9hLOeDbB843QNCFziNlJD2iG/YOWXwV98THY6Ww8BxduSUo
 BCeOKoJ3RZBRivA2ggY5QLg0yw7d+epnu2w0HPrb9R+lhxk5ER0R80wVlu8Ih4iJKWlC
 B+xN/pedgOfH4P4TMqIE32Lk2eU/Q62giGXk68n0uWfvf28LTUfG/qH7qtWIhkt3FwPx
 2ZMiuEHykcuf7EhU8NwOR0wXxXT037h33WYIVmMcz/2molI22pdGMgv3QTr9sZbH5Je7
 wSmkwbUOuVZ+EJhKrHpiDIEtVfrtn+rOzzSPxc08rU7hrsAmu6+9OFXfQr7pXBjAMv5z yQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3wkvnv09f5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 07:39:48 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4266clW1005260;
	Wed, 6 Mar 2024 07:39:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3wp7nrp2na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Mar 2024 07:39:46 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4267dkAO036280;
	Wed, 6 Mar 2024 07:39:46 GMT
Received: from sridara-s.osdevelopmeniad.oraclevcn.com (sridara-s.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.252.75])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3wp7nrp2n2-1;
	Wed, 06 Mar 2024 07:39:46 +0000
From: Srivathsa Dara <srivathsa.d.dara@oracle.com>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca,
        rajesh.sivaramasubramaniom@oracle.com, junxiao.bi@oracle.com,
        ritesh.list@gmail.com
Subject: [PATCH v2] ext4: Enable meta_bg only when new desc blocks are needed
Date: Wed,  6 Mar 2024 07:39:23 +0000
Message-Id: <20240306073923.333086-1-srivathsa.d.dara@oracle.com>
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
 definitions=2024-03-06_04,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403060059
X-Proofpoint-ORIG-GUID: GDZFcG94PdCPSVCvd9VO3YYqdETLt1k-
X-Proofpoint-GUID: GDZFcG94PdCPSVCvd9VO3YYqdETLt1k-

This patch addresses an issue observed when resize_inode is disabled
and an online extension of a filesysyem is performed. When a filesystem
is expanded to a size that does not require a addition of a new
descriptor block, the meta_bg feature is being enabled even though no
part of the filesystem uses this layout.

This patch ensures that the meta_bg feature is only enabled if
any of the added block groups utilize meta_bg layout.

Signed-off-by: Srivathsa Dara <srivathsa.d.dara@oracle.com>
---
 fs/ext4/resize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 928700d57eb6..b46a1c492c3f 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1996,7 +1996,8 @@ int ext4_resize_fs(struct super_block *sb, ext4_fsblk_t n_blocks_count)
 		}
 	}
 
-	if ((!resize_inode && !meta_bg) || n_blocks_count == o_blocks_count) {
+	if ((!resize_inode && !meta_bg && n_desc_blocks > o_desc_blocks) || 
+			n_blocks_count == o_blocks_count) {
 		err = ext4_convert_meta_bg(sb, resize_inode);
 		if (err)
 			goto out;
-- 
2.39.3


