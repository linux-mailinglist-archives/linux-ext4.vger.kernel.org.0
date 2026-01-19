Return-Path: <linux-ext4+bounces-13054-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DA0D3B4BF
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75FE73059929
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058132BF24;
	Mon, 19 Jan 2026 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hL3Df0UZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC96435CB70;
	Mon, 19 Jan 2026 17:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844619; cv=none; b=XyFH70IyQJbIbnqyxKlQj0zFYXJHQ1vIvCM/xAvffcFXl+Wgp6Dn+2hzzAB5xYplzRF4tCxxl8I8aX8gAzxvvJwve0T3GPm+gXEywRNU0vQ79tFe/iA+d3uRmF4T7aPLVRj7xDRFiYTkLSUcza6lc6gvcb5LYx/Ja1zrWO1vZeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844619; c=relaxed/simple;
	bh=rPpXttzo4vI1QAS/Xj9RU5Z7XzhHlT0/JQTyq66TZpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OrdIG6izdQMORY2c307hGOFAXSgD3GJlwNjMOaySv+bb0wpHaZdxlsKJ9bA3HKLzqbLrjNkvhSa4z66S9vR8ogaC5FB44FmcgOavXHHCTGig+1OpN3+NbQt1P/FKLKDbkT436HkWezaJvUG8pxtdjAJdEcxA2vg1dLYjrvkLctE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hL3Df0UZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDWbOH030226;
	Mon, 19 Jan 2026 17:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VvrMQ1atE32JIWo94
	FXD2K9x/DJd6/XWdF98HGpYtMY=; b=hL3Df0UZz8RBsiCWk3R1ptBEvkqTXNmdd
	fvxhd+GQUJ2SwyIT5ZyucnTHo1lfY+pWREbiVvMKhe3ZIcbUhi7Dre+WwSp8ldjG
	f5bGOV5m+YGDjtITBV5kYb6Fm2+qufyMmg2n4mGcQ1E1jnGngpxSBwz1yjyolQhD
	gDcbeJWGbjW/E5xMRADhhFHTH01PJr/fp10CuJ9dNKCXqtELmlz/hr81AZa/i8uF
	ZnbLEcOAZTX7hhnUwYx9qMao1e0yyGMoUraZExUosAqKvanl1aKPkfxs1Cui24oQ
	TZDsbjiauwoVeBdvD4mPiLHE6dTd0uyFeo5pSXZ5liooEqoQsaLGg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf94as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:25 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHOYj8009360;
	Mon, 19 Jan 2026 17:43:25 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br0uf94am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:25 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGfSVw027220;
	Mon, 19 Jan 2026 17:43:24 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrmr6vg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:24 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHhML133685974
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7610120043;
	Mon, 19 Jan 2026 17:43:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A589520040;
	Mon, 19 Jan 2026 17:43:20 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:20 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] ext4: propagate flags to ext4_convert_unwritten_extents_endio()
Date: Mon, 19 Jan 2026 23:13:01 +0530
Message-ID: <046a3805edd51a910dc827e15aab04998d6bb002.1768844021.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768844021.git.ojaswin@linux.ibm.com>
References: <cover.1768844021.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: F8LsUNCjsaVYFz4hmo4VXs4fJgymmv2e
X-Proofpoint-ORIG-GUID: OOSfyTI8601HJ1NEodSVkXJ1lopk285d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfX4TFdqo6+esV5
 gfkZQW62iCIhsqK/m0RXZURYPUBwWQQR8oQW7q81zWio549srFV8P3/1TQG9jfQyqrZEmZ5LRL1
 MGgyw3J1aSgV16P0oRGISK99ZL58o1AgunAaQUpaq+NT6gVJlfapVxrSnBZ3FWGxuK8KkRLY9jd
 nMZC4MRanUklBvlnDgpIV1/PLg3TkmnEAGiFCDeCK46pK83gmrJELyHQyGuJSX7DTvdNYvwrwRq
 144XPXW3kaUFzu7FGVZ68PTRvaHEi4pdxVK0vwH8Bz1kv9/Qb1E04NjFY/1SCwQVgfTM/a3hR1z
 FimdrgSdekat8ACG47kPriqI3sDYqO9AvXsiLP2+WzLF1bTGySk5d2jD/czi6yj0Nf7nQrObXbi
 1WRQ16rnb3HI6ZMZT4ih4Pa3UAOTEKA62Ga87V6Xc11YYwsTnk+l4uTyHe0phscXUFYvOraES8B
 kj+MbAG9sRHL6yR2YiQ==
X-Authority-Analysis: v=2.4 cv=bopBxUai c=1 sm=1 tr=0 ts=696e6d3d cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=s5sEB8iLFlBga5WgvCgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601190144

Currently, callers like ext4_convert_unwritten_extents() pass
EXT4_EX_NOCACHE flag to avoid caching extents however this is not
respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
accept flags from the caller and to pass the flags on to other extent
manipulation functions it calls. This makes sure the NOCACHE flag is
respected throughout the code path.

Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
we don't need to explicitly pass it anymore.

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3d45abfb13cd..54f45b40fe73 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3784,7 +3784,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
 static struct ext4_ext_path *
 ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 				     struct ext4_map_blocks *map,
-				     struct ext4_ext_path *path)
+				     struct ext4_ext_path *path, int flags)
 {
 	struct ext4_extent *ex;
 	ext4_lblk_t ee_block;
@@ -3801,15 +3801,12 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
 		  (unsigned long long)ee_block, ee_len);
 
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-		int flags = EXT4_GET_BLOCKS_CONVERT |
-			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
-
 		path = ext4_split_convert_extents(handle, inode, map, path,
 						  flags, NULL);
 		if (IS_ERR(path))
 			return path;
 
-		path = ext4_find_extent(inode, map->m_lblk, path, 0);
+		path = ext4_find_extent(inode, map->m_lblk, path, flags);
 		if (IS_ERR(path))
 			return path;
 		depth = ext_depth(inode);
@@ -3942,7 +3939,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
 	/* IO end_io complete, convert the filled extent to written */
 	if (flags & EXT4_GET_BLOCKS_CONVERT) {
 		path = ext4_convert_unwritten_extents_endio(handle, inode,
-							    map, path);
+							    map, path, flags);
 		if (IS_ERR(path))
 			return path;
 		ext4_update_inode_fsync_trans(handle, inode, 1);
-- 
2.52.0


