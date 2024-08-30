Return-Path: <linux-ext4+bounces-3981-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A06A1965847
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 09:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B80B1F2246F
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Aug 2024 07:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD106157A61;
	Fri, 30 Aug 2024 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="otpo5ntJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7511509A0;
	Fri, 30 Aug 2024 07:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725002487; cv=none; b=K+ZP8fL8QZH7hlvr8mbFfP8qGRjbLn1UdFQzHOuKfsl3mPGxCZOOBydGI7+uOE+lPeLakxolwGMJNATujUXNlALt5/EeptBSMTmoLb4oi5TyotvL5dXXL9O3EhoWPK3P//TQnhgo6uxsKHDIyyFqqZmPXYHhGcq4/KfLBA9rFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725002487; c=relaxed/simple;
	bh=ye98vENoZQWZsbEkLBJ/fd2Wa4qBGtCugOCMhivSlRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcz0pCWs5rcrkFQaK4CpG6/zhJvcx6dIeDYAgooxZZednLBbzlEsXGLO9NUj8E0hKYZ3Hh6RoC4Gvd0BYYVLAreKrIFk4/l6788FDcwbHzgzFlNycpWTtupFGjN4riTgn5lF1Qw5vuXzlYn1z98BcEV9gys+4nLpwAReLHhpYjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=otpo5ntJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U3wMV5030922;
	Fri, 30 Aug 2024 07:21:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=E9z3t2ZIOLzOn
	aDx3SE/JLHQ+NnkXcAGW/xdWKQ5sUc=; b=otpo5ntJB8Dlt4C5NMWv30hQR0DVc
	CDL3CjEXXganKIBT/XGzLi451tK4ko+6uCFReV9+6K3a/u2Q5S5T449kQ0MO7RFd
	Zl5admTz853gmRFIPubtBdYpO5izeJYehAO6jvrJAgir4hsYn2jWIm2EYzw3BcnO
	NC8kgCAn0i3vTaex07RrSYIR2BBRO+DhxjReJbg0dS3eJNdyAVg7fjA19B70sngR
	KNeygerCEfgQWjtA9bRgUF/wDrBYZg0RalIWOMQYMbD2BL4EuTe96B5D4h5R8gre
	gSGbeJGniywUPLnJ1znHZHcZW+4ZwZ4eXjRmNMgE3qmMHXkk1+nkt7xvw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r58ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:21:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47U7Henk016655;
	Fri, 30 Aug 2024 07:21:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 419q8r58au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:21:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47U4rPwv021770;
	Fri, 30 Aug 2024 07:21:14 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 417suutf5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 07:21:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47U7LCwu18153738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 30 Aug 2024 07:21:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB6162004B;
	Fri, 30 Aug 2024 07:21:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF5E620040;
	Fri, 30 Aug 2024 07:21:11 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.195.46.118])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 30 Aug 2024 07:21:11 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH v3 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
Date: Fri, 30 Aug 2024 12:50:58 +0530
Message-ID: <e0c0a3b58a40935a1361f668851d041575861411.1725002410.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3a493bb503c3598e25dcfbed2936bb2dff3fece7.1725002410.git.ojaswin@linux.ibm.com>
References: <3a493bb503c3598e25dcfbed2936bb2dff3fece7.1725002410.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nzaFG1Xp5nuO8zikZJux-3dhNF5d0TMn
X-Proofpoint-ORIG-GUID: 2J2pQ1nt6Z5eFMqY3wzWEG9A5P0H1Fuk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-30_02,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408300051

Although we have checks to make sure s_stripe is a multiple of cluster
size, in case we accidentally end up with a scenario where this is not
the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
cases where EXT4_B2C(stripe) becomes 0.

Also make the is_stripe_aligned check in regular_allocator a bit more
robust while we are at it. This should ideally have no functional change
unless we have a bug somewhere causing (stripe % cluster_size != 0)

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2008d2d524c9..6dc0a9bb29a7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2356,7 +2356,7 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
 	ex.fe_logical = 0xDEADFA11; /* debug value */
 
 	if (max >= ac->ac_g_ex.fe_len &&
-	    ac->ac_g_ex.fe_len == EXT4_B2C(sbi, sbi->s_stripe)) {
+	    ac->ac_g_ex.fe_len == EXT4_NUM_B2C(sbi, sbi->s_stripe)) {
 		ext4_fsblk_t start;
 
 		start = ext4_grp_offs_to_block(ac->ac_sb, &ex);
@@ -2553,7 +2553,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	do_div(a, sbi->s_stripe);
 	i = (a * sbi->s_stripe) - first_group_block;
 
-	stripe = EXT4_B2C(sbi, sbi->s_stripe);
+	stripe = EXT4_NUM_B2C(sbi, sbi->s_stripe);
 	i = EXT4_B2C(sbi, i);
 	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
 		if (!mb_test_bit(i, bitmap)) {
@@ -2928,9 +2928,11 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 			if (cr == CR_POWER2_ALIGNED)
 				ext4_mb_simple_scan_group(ac, &e4b);
 			else {
-				bool is_stripe_aligned = sbi->s_stripe &&
+				bool is_stripe_aligned =
+					(sbi->s_stripe >=
+					 sbi->s_cluster_ratio) &&
 					!(ac->ac_g_ex.fe_len %
-					  EXT4_B2C(sbi, sbi->s_stripe));
+					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
 
 				if ((cr == CR_GOAL_LEN_FAST ||
 				     cr == CR_BEST_AVAIL_LEN) &&
@@ -3706,7 +3708,7 @@ int ext4_mb_init(struct super_block *sb)
 	 */
 	if (sbi->s_stripe > 1) {
 		sbi->s_mb_group_prealloc = roundup(
-			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
+			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
 	}
 
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
-- 
2.43.5


