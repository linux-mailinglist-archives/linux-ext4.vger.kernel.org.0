Return-Path: <linux-ext4+bounces-13260-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLXHEuUVc2l3sAAAu9opvQ
	(envelope-from <linux-ext4+bounces-13260-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:32:05 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EA97103E
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 07:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C9513021E80
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Jan 2026 06:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF68396B99;
	Fri, 23 Jan 2026 06:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kiBDprsW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D86395275;
	Fri, 23 Jan 2026 06:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769149576; cv=none; b=XKggEcnZw3pxWNlvohU3pbrkTtIT0sEU5IVSRoBauRp48OjZKJ0qN8I5obS+o2no006n0dzOx9nEtARYb6A5PZeZx47mFP87aKhHCuWRUYV8UcW5sjCl4FIntMCJ5q7gy+rewAxpOOknpvSqOVhfLGa7MtE7radczsCBOhuMxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769149576; c=relaxed/simple;
	bh=DGEjxdJl6LH0VdK1UgAhBH2d9x0bUVT0Z1AeZwFYQHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fk3abP5377PAAQo8LYWMeMgqetuIrfBwCnuskgFrNWfsDiU1i3OTdNJUDUZxXrJd11ze3mv1odr1fJaN4yYW6dqJyYujLD4F7X96trEJvrjZyH7XK3V0dsAud/mxm2/ZRvacUcOGBAnqKN/fcABuS+YdCRU2+1QP1EF8OeiKr5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kiBDprsW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60N1EdLA006245;
	Fri, 23 Jan 2026 06:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8/YfEzgiDEZV1CDSv
	O5rfWZx+fuiJ1qSRWERCJ/BGBA=; b=kiBDprsWhHlUYci5ckAT3siMdgj9Huaja
	61HGqiGncsD8RoCV7jPIoLNeCmZVRx61J+15fBQWbYVUUKEJMwtJzIWQ+7s9VtBH
	i5HX/Le6JTGRBLvtBN+QkEy7Umj880OzcZvHe0WV3ujWcj9DpK742ZWb/xJn4aBb
	80newayymhYFHhtVcAWIKBY3eEyeDenNI7XbWElWK7PJGfiz7Er5iTZ3fqpUlCTi
	aVVXiXCrk+g3QJ7kRth0ZHpkjBr/VDGZM1yxVORSQ1zSReLtPSsolVs5lJ2jcqkp
	nW8+4RKfFqsXeuGzLZA+K4sgjTqYc30E+gsFmaUeqFvg4Ywuf91OQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sec82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:55 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60N6CPQ7022476;
	Fri, 23 Jan 2026 06:25:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23sec7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60N3dieV027334;
	Fri, 23 Jan 2026 06:25:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brnrnfg54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Jan 2026 06:25:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60N6PpWL20840732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Jan 2026 06:25:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB42A20043;
	Fri, 23 Jan 2026 06:25:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B906720040;
	Fri, 23 Jan 2026 06:25:49 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.26.206])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Jan 2026 06:25:49 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        Jan Kara <jack@suse.cz>, libaokun1@huawei.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/8] ext4: propagate flags to convert_initialized_extent()
Date: Fri, 23 Jan 2026 11:55:35 +0530
Message-ID: <07008fbb14db727fddcaf4c30e2346c49f6c8fe0.1769149131.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769149131.git.ojaswin@linux.ibm.com>
References: <cover.1769149131.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: q6NIIIHeHljo8CbmaaVCjKn666foaKpS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA0NiBTYWx0ZWRfXxaNlTKAnMI4u
 FCXc4jCP4cNUJ788teBWfOEYNSLFo9qf1qlhDId9oUCccBYg/QdzMGBMa7YpiEwt45wdqIJm5PB
 WITtbuI3hG+jkuonR9AWCV/8VxO1S6Ij02qjBeUmqfoUGEf3SZGkdQKMNzsuI8TqcCnhdI7J1Uf
 GwhYTuOoyGHzVk9o1p+JvBc72nuwIMhR0cbkv7afzTKzaBs1NYWF4NUtfq8XyUBZTjI2NIil/4L
 BSKIHS3a3vGYX+svKNSuicwbsGJlRhM64pbspHSNjCfjpudximx3L/1j2UYGgj5yWiiasA8SZKT
 pEo2kL/gAaikmcv60vkdyjYBWvqJjlHT+4AlyGOs+gXdpFAxDuHksqsTnAgA7T/lPM1DXHKAQ1l
 K0yT4cBzm2l7BKRj03dsoZySSRQAHSwT6RybVLV7Lv6sGkfE+RFP8CdT3Dd5hiT1fux9xXCYJ2g
 yvxbYZ5tzKOy4PR+tRQ==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=69731473 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=i0EeH86SAAAA:8 a=VnNF1IyMAAAA:8
 a=oIlp7qZINqeTlFEOi2UA:9
X-Proofpoint-ORIG-GUID: 1f0L7Cq82ESU_bb4j6HB_m1VTBvSSOR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_06,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601230046
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13260-lists,linux-ext4=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,huawei.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[13];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.989];
	TAGGED_RCPT(0.00)[linux-ext4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9EA97103E
X-Rspamd-Action: no action

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
index 16326d7f09b9..2747af91e78e 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3840,6 +3840,7 @@ static struct ext4_ext_path *
 convert_initialized_extent(handle_t *handle, struct inode *inode,
 			   struct ext4_map_blocks *map,
 			   struct ext4_ext_path *path,
+			   int flags,
 			   unsigned int *allocated)
 {
 	struct ext4_extent *ex;
@@ -3865,11 +3866,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
 
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
@@ -4259,7 +4260,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
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


