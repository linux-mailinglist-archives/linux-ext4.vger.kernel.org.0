Return-Path: <linux-ext4+bounces-12551-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D53CF0E78
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEDA33028D8A
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236632C11C2;
	Sun,  4 Jan 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hlL8qagE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEE827586C;
	Sun,  4 Jan 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529187; cv=none; b=uz8B7z6OaadhnIZqLNfDe7x4ZWJA25SXBenSjE4s6olj99gycvyNOG0qJd/Gq/2X2Y6zIaLe/cn6E4HwFM1MwDyURKc6j7Hw4wuS/Ug7OeWx7BwKaXs7E1Xdj9yvkjw1b9oBrMFBCaEf697c/QTXu2imH8nxZtbG1Tr3Da4HXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529187; c=relaxed/simple;
	bh=axXA8M6cAdwb/sjxqK3ImN2L8fLNkWNuc8663ICDQ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H9glylTMFYw9CamYXTK/ilA8AOOKrBy3W92rN+Zw0HNrVlc6sEbKKsFVANdcBearD6BOIgZuF7Vli0OccsR/oFfYcVD7gGR0nzTlrQXmdKZ8CQZsRYtYuQjfpboFmpGmIbt8lDml+DTeNkzM+W8d4NuAkeZwh6RStv6jJpKaXqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hlL8qagE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 604BvDLB014985;
	Sun, 4 Jan 2026 12:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n0Ulcyu5HDzeGjMc/
	EcoBuQJtUnXf+/BFFCmXTW4p7E=; b=hlL8qagE6WymtIwGhT/0QO3Yba4omYo7b
	4OVM7DmZXqIej7ibMw0iAxK55Vk0gLLNgbIQpPrVhBhR/3Gm1HY3VzuJpIB08yFw
	UeUhhxcEn4s6DnBnad2IbEFpJXA78VRIMcKNRELaLQrIPiOp+Iumpn9IF1e9Qw9p
	onZzzHWT3vNU4RbxDGpIsVcHtGCTsC2G4QUPND9F9nXjic9YkMCMz7ta/2nASX18
	8yfjiLrZbD3DFrSP8s1VimsLlIzPibAupX4rrwi/SPGJQXvJ+5WyNc/B9jvyviCV
	EQtXsqrKQI1CmLSxoD2pv9Wh858aClVKEOzeHUcFS3GuAVWZKw3fw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspumke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:36 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJZQk021993;
	Sun, 4 Jan 2026 12:19:35 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4betspumka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 604ABGwJ019161;
	Sun, 4 Jan 2026 12:19:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfg50s684-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:34 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJXue54985198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 034BC20043;
	Sun,  4 Jan 2026 12:19:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F5B820040;
	Sun,  4 Jan 2026 12:19:31 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:30 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] ext4: propagate flags to ext4_convert_unwritten_extents_endio()
Date: Sun,  4 Jan 2026 17:49:17 +0530
Message-ID: <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1767528171.git.ojaswin@linux.ibm.com>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Za3VVNH6nquaZ9ijwlGkO47c7xOEYXnM
X-Authority-Analysis: v=2.4 cv=Jvf8bc4C c=1 sm=1 tr=0 ts=695a5ad8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=NfIhE_ZiNg-gg9J_640A:9
X-Proofpoint-ORIG-GUID: YE88aybABx33wAiy1KX_qopQZw_g6Vgg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfXwckPe9PzLSQy
 /JsxiOURdbxdKQWfZmx1qfTolWM4w7+aUMc/ZL6LLvBLbWG3fFQOTRcJSvFM1KOLRLfySQBkv1I
 9K6MijX2c7iKuZyE7d9hPbuqO1yrheail/M75MwrJCABzGJs3k0zKfIBGfv8yB/cb0cBfparXMa
 PDMT2zS5CoC/OTXaKI4Bjq1vVMe1cwRFAuMIzJ+p/GfAqrglq8hreAWPJM/X7S8geb7pWtzrxzN
 uBAOrM3uWMa0MAgl5ZSckD2EWDBt1aCCRdPkPYqcGwIyHn0wo88JG16+V4oY8fTDQBV1qtHezuA
 +AVXA4oFEmixIDBXGyJjiXlpJ4p57IsKOajATz+C4D10Te+iHGQcXQQ+0umdtFfcYwpPrYtkJdS
 JLCrkI6rIblgQaARlJGBIHEcjMlxcSTklnNBxPigrMPOeZ99rOlQUsqexGZEFlCYb9nBHjsLPcR
 79id7SxDh9uJ68/NbLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601040113

Currently, callers like ext4_convert_unwritten_extents() pass
EXT4_EX_NOCACHE flag to avoid caching extents however this is not
respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
accept flags from the caller and to pass the flags on to other extent
manipulation functions it calls. This makes sure the NOCACHE flag is
respected throughout the code path.

Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
we don't need to explicitly pass it anymore.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 5228196f5ad4..460a70e6dae0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3785,7 +3785,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 static struct ext4_ext_path *
 ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 				     struct ext4_map_blocks *map,
-				     struct ext4_ext_path *path)
+				     struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
@@ -3802,9 +3802,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		int flags = EXT4_GET_BLOCKS_CONVERT |
-			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
-
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, NULL);
 		if (IS_ERR(path))
@@ -3943,7 +3940,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
-							    map, path);
+							    map, path, flags);
 		if (IS_ERR(path))
 			return path;
 		ext4_update_inode_fsync_trans(handle, inode, 1);
-- 
2.51.0


