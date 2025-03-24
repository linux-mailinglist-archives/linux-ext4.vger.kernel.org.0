Return-Path: <linux-ext4+bounces-6961-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A089AA6D52E
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 08:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32E081892AF1
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Mar 2025 07:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C9C2580DF;
	Mon, 24 Mar 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D8Rr+OzB"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CC5257AD5;
	Mon, 24 Mar 2025 07:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742801854; cv=none; b=n1LgogBScbK2mFrN45NeRFsqzM3xJvz836E7uQgoazWP50NKiUfY7xSW7UhmmlBrGM2Y6Iq0LqtYLFWsvraseQ/hhz/7gRNleyIPaeNgmaFUWDPIoYdhRiS/PSmyMe+IA6bvuSZWrjPYAFGSWjI/OdNFlI0xpQZw7ViIuRiFFeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742801854; c=relaxed/simple;
	bh=OSp+5BCtTy+VEm4pp+V79KcV5vtn402aXiaRe1kUOkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lD/AmAfc0G0kEIGjaJBY/DOhkFse4zBC9FeTYF/ey1BvvqKazvjMOwYVsth4vqeXJO4R5YJpZMyOviYUEEhMj2G8A4YoKcoKg3he4gH0BHlgvKbjYgDrRYiDdfLels30MabkbXakqnPcEwzJBBKlH6zLyA1Ja3cVvH1xtjn7dLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D8Rr+OzB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52NMELtQ005746;
	Mon, 24 Mar 2025 07:37:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cjG6AOq812JXkrPde
	dr6WDePRENKLzimjdgYKKgqwUk=; b=D8Rr+OzBlFJHGLGHjNOvfsk6uuDXAW0kK
	U/Jm6Ptk2sHH+xuYylPRkdN3sAeeWnR1s8YmrdVrNdNTdf/FneHu2i1RUTvNBIFQ
	h8HfgSO9tYAqydQvrjMZWvBQA9/OSWynshsdSgKJVGKRVFYSiE5KWO8hoKaXitDd
	xGVbiteRWMx/s99kONItiiPk8TnR29ta4T/UCS1Q5ghOFNiCraZhD3lDaF1AyatI
	tqU6NFCu9sNsrBwBFl63u5J7kN5AVaYeTTBRY6ZqHXHopRVk9h+R8UsfOG6jWlb3
	EKuTGgpD3z1ebkZ/ap+VqX5JxNJrzYg3gnrQ44USkaBDqxUuo8/yQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:24 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 52O7bOt9029962;
	Mon, 24 Mar 2025 07:37:24 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jpfwthey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52O7VmLE025666;
	Mon, 24 Mar 2025 07:37:23 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j7wywacy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 07:37:23 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52O7bLga52691432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 07:37:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33D932004B;
	Mon, 24 Mar 2025 07:37:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409AB20040;
	Mon, 24 Mar 2025 07:37:19 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.29.200])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 07:37:19 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: John Garry <john.g.garry@oracle.com>, dchinner@redhat.com,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org
Subject: [RFC v3 04/11] ext4: pass lblk and len explicitly to ext4_split_extent*()
Date: Mon, 24 Mar 2025 13:07:02 +0530
Message-ID: <7b4e15e314dc4d247fc19c12f76bbbc66a23faa5.1742800203.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1742800203.git.ojaswin@linux.ibm.com>
References: <cover.1742800203.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Fm2dMLe22p30YzL2602oRBEKx513aDyO
X-Proofpoint-GUID: QX0jPpP_KjHjYg8lQAweQy4r9eRW6qkn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_03,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=603 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503240053

Since these functions only use the map to determine lblk and len of
the split, pass them explicitly. This is in preparation for making
them work with extent size hints cleanly.

No functional change in this patch.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 57 +++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..4e604ce6ce35 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3347,7 +3347,8 @@ static struct ext4_ext_path *ext4_split_extent_at(handle_t *handle,
 static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 					       struct inode *inode,
 					       struct ext4_ext_path *path,
-					       struct ext4_map_blocks *map,
+					       ext4_lblk_t lblk,
+					       unsigned int len,
 					       int split_flag, int flags,
 					       unsigned int *allocated)
 {
@@ -3363,7 +3364,7 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 	ee_len = ext4_ext_get_actual_len(ex);
 	unwritten = ext4_ext_is_unwritten(ex);
 
-	if (map->m_lblk + map->m_len < ee_block + ee_len) {
+	if (lblk + len < ee_block + ee_len) {
 		split_flag1 = split_flag & EXT4_EXT_MAY_ZEROOUT;
 		flags1 = flags | EXT4_GET_BLOCKS_PRE_IO;
 		if (unwritten)
@@ -3372,28 +3373,28 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 		if (split_flag & EXT4_EXT_DATA_VALID2)
 			split_flag1 |= EXT4_EXT_DATA_VALID1;
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk + map->m_len, split_flag1, flags1);
+				lblk + len, split_flag1, flags1);
 		if (IS_ERR(path))
 			return path;
 		/*
 		 * Update path is required because previous ext4_split_extent_at
 		 * may result in split of original leaf or extent zeroout.
 		 */
-		path = ext4_find_extent(inode, map->m_lblk, path, flags);
+		path = ext4_find_extent(inode, lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
 		ex = path[depth].p_ext;
 		if (!ex) {
 			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
-					(unsigned long) map->m_lblk);
+					(unsigned long) lblk);
 			ext4_free_ext_path(path);
 			return ERR_PTR(-EFSCORRUPTED);
 		}
 		unwritten = ext4_ext_is_unwritten(ex);
 	}
 
-	if (map->m_lblk >= ee_block) {
+	if (lblk >= ee_block) {
 		split_flag1 = split_flag & EXT4_EXT_DATA_VALID2;
 		if (unwritten) {
 			split_flag1 |= EXT4_EXT_MARK_UNWRIT1;
@@ -3401,16 +3402,16 @@ static struct ext4_ext_path *ext4_split_extent(handle_t *handle,
 						     EXT4_EXT_MARK_UNWRIT2);
 		}
 		path = ext4_split_extent_at(handle, inode, path,
-				map->m_lblk, split_flag1, flags);
+				lblk, split_flag1, flags);
 		if (IS_ERR(path))
 			return path;
 	}
 
 	if (allocated) {
-		if (map->m_lblk + map->m_len > ee_block + ee_len)
-			*allocated = ee_len - (map->m_lblk - ee_block);
+		if (lblk + len > ee_block + ee_len)
+			*allocated = ee_len - (lblk - ee_block);
 		else
-			*allocated = map->m_len;
+			*allocated = len;
 	}
 	ext4_ext_show_leaf(inode, path);
 	return path;
@@ -3658,8 +3659,8 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
 	}
 
 fallback:
-	path = ext4_split_extent(handle, inode, path, &split_map, split_flag,
-				 flags, NULL);
+	path = ext4_split_extent(handle, inode, path, split_map.m_lblk,
+				 split_map.m_len, split_flag, flags, NULL);
 	if (IS_ERR(path))
 		return path;
 out:
@@ -3699,11 +3700,11 @@ ext4_ext_convert_to_initialized(handle_t *handle, struct inode *inode,
  * allocated pointer. Return an extent path pointer on success, or an error
  * pointer on failure.
  */
-static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
-					struct inode *inode,
-					struct ext4_map_blocks *map,
-					struct ext4_ext_path *path,
-					int flags, unsigned int *allocated)
+static struct ext4_ext_path *
+ext4_split_convert_extents(handle_t *handle, struct inode *inode,
+			   ext4_lblk_t lblk, unsigned int len,
+			   struct ext4_ext_path *path, int flags,
+			   unsigned int *allocated)
 {
 	ext4_lblk_t eof_block;
 	ext4_lblk_t ee_block;
@@ -3712,12 +3713,12 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 	int split_flag = 0, depth;
 
 	ext_debug(inode, "logical block %llu, max_blocks %u\n",
-		  (unsigned long long)map->m_lblk, map->m_len);
+		  (unsigned long long)lblk, len);
 
 	eof_block = (EXT4_I(inode)->i_disksize + inode->i_sb->s_blocksize - 1)
 			>> inode->i_sb->s_blocksize_bits;
-	if (eof_block < map->m_lblk + map->m_len)
-		eof_block = map->m_lblk + map->m_len;
+	if (eof_block < lblk + len)
+		eof_block = lblk + len;
 	/*
 	 * It is safe to convert extent to initialized via explicit
 	 * zeroout only if extent is fully inside i_size or new_size.
@@ -3737,8 +3738,8 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 		split_flag |= (EXT4_EXT_MARK_UNWRIT2 | EXT4_EXT_DATA_VALID2);
 	}
 	flags |= EXT4_GET_BLOCKS_PRE_IO;
-	return ext4_split_extent(handle, inode, path, map, split_flag, flags,
-				 allocated);
+	return ext4_split_extent(handle, inode, path, lblk, len, split_flag,
+				 flags, allocated);
 }
 
 static struct ext4_ext_path *
@@ -3773,7 +3774,7 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);
 #endif
-		path = ext4_split_convert_extents(handle, inode, map, path,
+		path = ext4_split_convert_extents(handle, inode, map->m_lblk, map->m_len, path,
 						EXT4_GET_BLOCKS_CONVERT, NULL);
 		if (IS_ERR(path))
 			return path;
@@ -3837,8 +3838,9 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
+		path = ext4_split_convert_extents(
+			handle, inode, map->m_lblk, map->m_len, path,
+			EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
 		if (IS_ERR(path))
 			return path;
 
@@ -3909,8 +3911,9 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 
 	/* get_block() before submitting IO, split the extent */
 	if (flags & EXT4_GET_BLOCKS_PRE_IO) {
-		path = ext4_split_convert_extents(handle, inode, map, path,
-				flags | EXT4_GET_BLOCKS_CONVERT, allocated);
+		path = ext4_split_convert_extents(
+			handle, inode, map->m_lblk, map->m_len, path,
+			flags | EXT4_GET_BLOCKS_CONVERT, allocated);
 		if (IS_ERR(path))
 			return path;
 		/*
-- 
2.48.1


