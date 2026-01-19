Return-Path: <linux-ext4+bounces-13052-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F02D3B4B2
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 18:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BEB85300EE74
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jan 2026 17:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A932ED2E;
	Mon, 19 Jan 2026 17:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TK7XhYn9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2401232D0E6;
	Mon, 19 Jan 2026 17:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768844612; cv=none; b=r23SQTGDDc2EzUknIupdhO7dafWfiBn475MXpNz4iIJCEznWHuEwVVeZvrBaKxHqprzcV4l1ZsKYuTZdUmCaO/LKvGeW+hk3RFQRYUv7Mo66iBK7xCyQCnftDpGmdgm+Tuq7e/40fRN7SnuAkmjc+NMCsUP7JDgFaaMEB7gINJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768844612; c=relaxed/simple;
	bh=6yjg/WWE5GrRXNyyf/T9jL49b3ab1APC0eCCv/iB/f4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqP0XXxh058KCynQ8I9dbZJqrJUdNEj/lWeHaSLyifEg7Z5o+Jln3Y93vbteV7aSLLEvV+rmPEJZOoQoh/Jk9YbN0xZuafox1N5dtt/C8mS0at35SJEc0J8TfIZCM+w+e1/UI6IR+dS5Brc6AHF38dx1m0jVLoEIHDMJ6GuYqeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TK7XhYn9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60JDLOaq009820;
	Mon, 19 Jan 2026 17:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=A0txSm+yOaX8X9l7S
	AP6hmeQlyIyXyPqTJkYpJAzdMc=; b=TK7XhYn9hXOUBvswHF5f30cDlda3CBWkP
	50bWHV/pwgvQKC2jOPL4eNUOsTsDmQbEj1yr450fgzYGj7RYbt296Q8KdK+yCKOq
	BdU8MIs6xllK26oOvkuKDtLebvLUMcLz59NgmDkruoVd5lxEltCi/8pBMc7ViaEi
	YKYKW40IzA0KnIZB2J6palzf2RRHHxW4FnkeQinqOoGFqdgvp4aZ2ANwl7UG7HXf
	G8XRj63rqxjfKEJKpUN4Mk+k9+8KHLpFtUkMnN75fiBXqgtgaErfNDIjKDQZfBQd
	BajwCL6aJzbKHxrq4t4/EXYhIaqnojM9Nb69uEc/YvkBFfPQ0/CGQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk199b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:23 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60JHT5GD020220;
	Mon, 19 Jan 2026 17:43:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bqyuk1998-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60JGXqg1017070;
	Mon, 19 Jan 2026 17:43:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xrbr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 19 Jan 2026 17:43:21 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60JHhJlg21430612
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Jan 2026 17:43:19 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C330F20043;
	Mon, 19 Jan 2026 17:43:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFBEC20040;
	Mon, 19 Jan 2026 17:43:17 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.220.173])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 19 Jan 2026 17:43:17 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/8] ext4: propagate flags to convert_initialized_extent()
Date: Mon, 19 Jan 2026 23:13:00 +0530
Message-ID: <62f6e748689d9136151c9771f4118304550ae4f3.1768844021.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDE0NCBTYWx0ZWRfX4lyWXHkH+0UA
 mqf7YV2A6lS0PJ0YTf/z5AAX7VMKvCz5d+XNU0w2esjkuC3TxbLjgFXpfIn2jUxVwkD98SszjeC
 pjYlOx8xo6F6NVILQs4yyGbSzUYydEGfJqJcthcctT3QlBfjZNdtB64ud1JCrw/U284FKYxzrF4
 OjHaGKKT09FK8mjIHSPdLuXLoTx4bEmmMWpvIVS38/g6dbKhgisJwNWq9GXWusjLvakcfQBiVkJ
 va5nX4yG1ctsE77opffQHAM2823sTeT58+88Lt9TsugamQsUnLtKmJchmWbV1vfSeq0ADB5vEi/
 o1lMU2ZmYtzFgt/fkeyao1yZTqEGgJ6euonUue3gSqNR4BwSNAaLSyCKeFsEO7cu8+xpIgQ6Tgu
 lgT93Ucq/3TidQlgIHmJYXmwDiF/n161XYIjLZ7sKs/wC8a2J1ZJ7OkTVU9qXvXXxfOM4VGlFqq
 rc5YtNgZDdimxEQ8TCw==
X-Authority-Analysis: v=2.4 cv=bsBBxUai c=1 sm=1 tr=0 ts=696e6d3b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=oIlp7qZINqeTlFEOi2UA:9
X-Proofpoint-ORIG-GUID: xQn2vQYeEvnfrJXqvF2m-nntuRkFJZgs
X-Proofpoint-GUID: pbXG9Wax9dzRpAWDyE7yo2MsBjkph8gh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_04,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190144

Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
extents however this is not respected by convert_initialized_extent().
Hence, modify it to accept flags from the caller and to pass the flags
on to other extent manipulation functions it calls. This makes
sure the NOCACHE flag is respected throughout the code path.

Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
care of this.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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


