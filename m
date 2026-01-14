Return-Path: <linux-ext4+bounces-12832-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CDCD1F93A
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 15:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D4F130141CB
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jan 2026 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211363101B0;
	Wed, 14 Jan 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k4EgkeH/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D838C311973;
	Wed, 14 Jan 2026 14:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768402701; cv=none; b=kiSaxh/r4/3cj7ebNHFBueow24bwhKrcAAGmHbqnz48e9iVpjHNUdo6l+b57lDr90J3F1l9AALuk29+5k/T/8BbM39aA0aKX62ivoq61JGXdh7HV5IV2uTml6VfjPt1QnzyCWwivvBeN8PauWqz/A5HA/5ZGrjN1tOcJJm8HOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768402701; c=relaxed/simple;
	bh=O0LGMJtf/kRplcKwu5wnXJJQMqpnt7Z72I+Wsr7Xqp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpMtISNbVokllh3exNZEpcypfcmGJ8iHidVaQkkNB3gTfo97xv0VJWV8H8YCYH5bmhUc+XdsGnEM6P5p6W/Nj+LDRcQMd1hVNiIqCoEAES2HpyVx16SyaOKH7Bf5EI/sgfLcqMm+ak0DcflhSP/MbzktM66AwBM/sQayvfG1jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k4EgkeH/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60E7lP2B013535;
	Wed, 14 Jan 2026 14:58:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qGjlgQw83Z8QBDy7U
	1VgRwAokqw++73WBqlViiMDo6c=; b=k4EgkeH/6y81CbTaxBE/CmIsWuO4/BAiO
	NqSWRsumwEO+iaqMCLuBvw7h6zEXnyAa5fLscLleABW3erg5Kji4DZzpibiWu/Cx
	Lbaa3ad3Yu5uZt/z0zMY/xAgpULQ/okBkMoC6CJQaNB3U7qKxNiSx2WewGFISJxY
	HP8DMYrLIg3uJl0JkEha59pZWY/P6kvAfqT5BKcfMXvdAhy+KSvwhINRidFVlOth
	ijX0rL4q8aB8APnUL2iDBq42nidIZfASuEyM+hqjnQcezvxkraYKQtKJHLVYPzZh
	dujdsC8epQWLr0lREDpXbGR4Y1skdCdpw8YKI3WWGHWqLfMr26NDA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt1h7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:08 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60EErg1O006662;
	Wed, 14 Jan 2026 14:58:08 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bkedt1h7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60EEZpOl025546;
	Wed, 14 Jan 2026 14:58:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bm23nakat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Jan 2026 14:58:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60EEw5fM49086900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 14:58:05 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85E742004B;
	Wed, 14 Jan 2026 14:58:05 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BBF420040;
	Wed, 14 Jan 2026 14:58:03 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.19.170])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Jan 2026 14:58:03 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/8] ext4: propagate flags to convert_initialized_extent()
Date: Wed, 14 Jan 2026 20:27:48 +0530
Message-ID: <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768402426.git.ojaswin@linux.ibm.com>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDEyMyBTYWx0ZWRfXw/zHAUcqhnr6
 e07PWPIfJEIbX68L7xFZYAKQll328LFiMmiMfHElIBjtRvmuizEVDDlKw3+rJJ366jSVHumOoSI
 A30u9bFtshHp9HuBtoeObrPdJeMqEtLuaAMAZgCTx3L+JxoARdYp7Kc/NxUkt9elpd3QN4fJ0W3
 Habh8yTPuFlxkVtEn3GTebvLXjqSo9AE5q1e64gcdHxYzJTYoeLoL5/12OfldU9JkQxpHuSExxL
 O/uGDIuNJ7x1dce8hPNnqUbhXwBgcBskc0F2XoNcwEp70F/gFEuMXdVXI/GYtoXsNPidfn5nWYV
 5l4RuHFzTsNpw3GL5/fsvia3/157rPThEYtdha99TZDN5w7TyBgsDerHUgbRy/znTj93NHpds28
 k1biQhAl7q0oEZq+mnTwoDHITui+i2zse3qIwhRSDjy7gq6KzDtHqIHKonebyCGmzS6abBFgSaX
 NrLjJPdBVK89DzMiVdg==
X-Proofpoint-GUID: Q5ynRPYkISEGZWeAZP5sQTmu3Bgyeahz
X-Authority-Analysis: v=2.4 cv=WLJyn3sR c=1 sm=1 tr=0 ts=6967af00 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=oIlp7qZINqeTlFEOi2UA:9
X-Proofpoint-ORIG-GUID: dlogcgg-AR-WY5FskEANh5jUJwHw7QoM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_04,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2601140123

Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
extents however this is not respected by convert_initialized_extent().
Hence, modify it to accept flags from the caller and to pass the flags
on to other extent manipulation functions it calls. This makes
sure the NOCACHE flag is respected throughout the code path.

Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
care of this. Account this behavior in Kunit tests as well.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index a581e9278d48..3d45abfb13cd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3844,6 +3844,7 @@ static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path *path,
+			   int flags,
 			   unsigned int *allocated)
 {
 	struct ext4_extent *ex;
@@ -3869,11 +3870,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
 		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
@@ -4263,7 +4264,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 			if ((!ext4_ext_is_unwritten(ex)) &&
 			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
 				path = convert_initialized_extent(handle,
-					inode, map, path, &allocated);
+					inode, map, path, flags, &allocated);
 				if (IS_ERR(path))
 					err = PTR_ERR(path);
 				goto out;
-- 
2.52.0


