Return-Path: <linux-ext4+bounces-12552-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 319D2CF0E7B
	for <lists+linux-ext4@lfdr.de>; Sun, 04 Jan 2026 13:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F0C1302E17B
	for <lists+linux-ext4@lfdr.de>; Sun,  4 Jan 2026 12:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C502C11CB;
	Sun,  4 Jan 2026 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n3MKY3uC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD03A2C08C4;
	Sun,  4 Jan 2026 12:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767529188; cv=none; b=QvZPN/ZbRw00CTFy6R7tU36a026sZXtfaP5W8h1PVsUCdmoxY7CReZRTNoBRTLGhYjIipsiJ3VUZTcmCIY4I2slSFbxPxY7v1NBx7xao3LPy7SWxfYiSe04shRT6b5MuGR+JDSiDLTTDrqi72+wJvGFONDvrGCI7lWfWOfnlPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767529188; c=relaxed/simple;
	bh=1VLRvF3uKXzxa7ed1F7kNs5tAh8fbwnIup2HDrog/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E17Id6E+y3txr4RuiNCPXbP65rKnMO8slcK+4y5VZt+pOgidenZRogcmgApAjP7SMbpFy+7G4G07CLwh6hSw6Tb/KwBQ70rqPwFTJNykTNuU6kvRv760/lGtD6i7CMyqF9YWQl/KlUfYUgpvHWegwELsjLVJkXrAPk/YwbPPiQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n3MKY3uC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6048ugXw028126;
	Sun, 4 Jan 2026 12:19:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WgVdglDwIRdxwZSD8
	BUyyJya9pENkQsK+d5SEr1txL4=; b=n3MKY3uCQl850nES2rrqFCJ9ZNf1MQshl
	YXNNaJcK1pd8xthklPemX6kaLoZwP+mBAX8+wUPBJn6egoPbYRkE32mnaGbfg8aG
	0612zCc+CBMDbD57DFhSFB4HbvJeF1Q2E9flUCS8KND7Tb3b62U0UO6WllYqqb3U
	NWauK9zwa4XLkzsItfVeK6wYyySt8HLMpvl7wbMFbkkQrBcKCByliTH9yAHj114D
	z29Y7xXy9NmR47Co7g19G13nkrHYPRDq24oawt5oQ5O2Pz65LULOrmw55VtJdz6K
	D957JOqUuRtv0pMubrhgprlU+WoH/K2M5SOSwr+8qY+6wkQxDcsGA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjufw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:33 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 604CJXZs015927;
	Sun, 4 Jan 2026 12:19:33 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4berhjufw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:33 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6046WrHJ015202;
	Sun, 4 Jan 2026 12:19:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4bfdes1kx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 Jan 2026 12:19:32 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 604CJU1M30998790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Jan 2026 12:19:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A15E520043;
	Sun,  4 Jan 2026 12:19:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD56620040;
	Sun,  4 Jan 2026 12:19:28 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.49])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 Jan 2026 12:19:28 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] ext4: propagate flags to convert_initialized_extent()
Date: Sun,  4 Jan 2026 17:49:16 +0530
Message-ID: <a8078155d7d97e0fcaae1c576112033c84968aec.1767528171.git.ojaswin@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=P4s3RyAu c=1 sm=1 tr=0 ts=695a5ad5 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=Gs6_2CMPRMJEfPWtLyMA:9
X-Proofpoint-ORIG-GUID: ENUjVrr4ETl4H5qPm5MJ7VTZjQNRGpyx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDExMyBTYWx0ZWRfX3ksZhggApeAp
 QhUyCXFbUA4w8Crs5M3QImgkfOhZt4fBZQFOLrPEIAhIbof6r4WmuW/PMbCypIJXquOk6sRMg55
 VaMxSYn4OWAGlvDl4/OUjttv9GSbqLhO+3poItNYT6hRlDDZHa0AqKGbfzeuU0nh/y88yrFW7Yf
 hv/Pg5mOX6svkS60w2V+2Xtd3Bzv8+lG8OlSN/aQXMg67jOq/lNVHM9XjxGbo9WDrC8e+CJa3kA
 nTQ5nJQmIBO+pXM8d9ffL4UKqqwEOqfeknk+IRGxEAL+L8/OTyeMZxKskxIdVG0BfltId2YlEBC
 stHwbQA/Zy6ZxXrc1dVLEXkluY7iTiE18yQNRyT9zHXS407UnTdy95ZxZ6JlMmIUbHcfbmu9eBj
 mCMkIjVyTT6iYyzrlgzi6CZPnEoWr8lSQ4oddX87NfX7xdiKsxZUcfepC2B6BvCY6p5sunI4Yn5
 +SqNXH8/fbFarpm+jRA==
X-Proofpoint-GUID: 0eE-rH6dBsbwilVxIevuwktHjKQ4QrAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_04,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2512120000 definitions=main-2601040113

Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
extents however this is not respected by convert_initialized_extent().
Hence, modify it to accept flags from the caller and to pass the flags
on to other extent manipulation functions it calls. This makes
sure the NOCACHE flag is respected throughout the code path.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents-test.c | 2 +-
 fs/ext4/extents.c      | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents-test.c b/fs/ext4/extents-test.c
index 4fb94d3c8a1e..54aed3eabfe2 100644
--- a/fs/ext4/extents-test.c
+++ b/fs/ext4/extents-test.c
@@ -422,7 +422,7 @@ static void test_convert_initialized(struct kunit *test)
 
 	map.m_lblk = param->split_map.m_lblk;
 	map.m_len = param->split_map.m_len;
-	convert_initialized_extent(NULL, inode, &map, path, &allocated);
+	convert_initialized_extent(NULL, inode, &map, path, 0, &allocated);
 
 	path = ext4_find_extent(inode, EX_DATA_LBLK, NULL, 0);
 	ex = path->p_ext;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0ad0a9f2e3d4..5228196f5ad4 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3845,6 +3845,7 @@ static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path *path,
+			   int flags,
 			   unsigned int *allocated)
 {
 	struct ext4_extent *ex;
@@ -3870,7 +3871,7 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+				flags | EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
 		if (IS_ERR(path))
 			return path;
 
@@ -4264,7 +4265,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
 				path = convert_initialized_extent(handle,
-					inode, map, path, &allocated);
+					inode, map, path, flags, &allocated);
 				if (IS_ERR(path))
 					err = PTR_ERR(path);
 				goto out;
-- 
2.51.0


