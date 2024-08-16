Return-Path: <linux-ext4+bounces-3740-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6050C95438D
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 09:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABD8282DA5
	for <lists+linux-ext4@lfdr.de>; Fri, 16 Aug 2024 07:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9E384FAD;
	Fri, 16 Aug 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qmsd2Bg3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F2F7BAF4;
	Fri, 16 Aug 2024 07:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723795064; cv=none; b=KoZL3p1RUeU2LaCw2mbUXrGOm7Crx+Dqq8lHA8ur9srq7Y3ArqoMhdAnK/TR+UMiB4Gc/mvAa9gqRymh7lNYKUzZkPSH32/U1XyQnsiPQ7BUBgAo37yAvZ122EkK2SAAEpvp1Fm5i+GFvrR/r421YOQgMtTT00xkcPHOOwR/6xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723795064; c=relaxed/simple;
	bh=DTQOvLkphWFnN1Cmk92b4y3tH9rSbe4haRl9fA+jnY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=isQT3xuvgowop1tsTemx7hdkAXan+3OquDpdzpJX5fwH87PDYN0maQOQjnxCu2x2T/+SMxhRWR1sQOI1p32XbiSD9DYbDwY3HYV79OuUwEp5yxvL3MLTVGcAcCK44QI+FNeJTUa748fs/xWbKWG1Kl3Z24831nosY31sGfnNDrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qmsd2Bg3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FLqWhD001403;
	Fri, 16 Aug 2024 07:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=S53l/6iWEd/02
	gr+iv2B9Gaa2Q92BrYDwZZl6joZ79o=; b=qmsd2Bg3Hu4CPSkVUo0V6yOFDRxGr
	w+vBSMjRvfz8c8jtc81xTEsSQqccy245Xav3sinHtaUUfZvgq2fZb7H25KX3a0vJ
	cXDPSXl/s1ZeG7XKh9HPtmPzXtkhyEQ8PEYdzHCysNiKjovfi/ezYniwYNAd/2AU
	N71Jw7i+ymz3yo5sHH6gCXCigxUEpLOWybYfyBYw5BZ/xoDa8PdIyHYKoRpAv3IV
	87hml4U937KiIWviatKFvjKHC1hLIqwSkQe+SFAOMFDFGsU+6hrbHDQoV4A9VLdl
	dfVTsbKUAvR0IYbpbDlhXDBR0drXrhSanVfK78gBbG4NUN/J8Z843VFEA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5yf7h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:57:32 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47G7vVO6028310;
	Fri, 16 Aug 2024 07:57:31 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111j5yf7g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:57:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47G40AFR029932;
	Fri, 16 Aug 2024 07:57:30 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xmrmtdh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 07:57:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47G7vRKx52560340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 07:57:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8FFD2004F;
	Fri, 16 Aug 2024 07:57:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C89D320067;
	Fri, 16 Aug 2024 07:57:25 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.124.216.104])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 07:57:25 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
Date: Fri, 16 Aug 2024 13:27:15 +0530
Message-ID: <02e5b5139294897985f2b99729c5f3da3dd4f6f9.1723794770.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
References: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NyAt9dqMUqpKuAuVPoJ7DKLX3ykZMzCS
X-Proofpoint-GUID: QyKqe-V6349UYjNB8MRRfWZ7KMZqW-BJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_18,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408160053

Although we have checks to make sure s_stripe is a multiple of cluster
size, in case we accidentally end up with a scenario where this is not
the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
cases where EXT4_B2C(stripe) becomes 0.

Also make the is_stripe_aligned check in regular_allocator a bit more
robust while we are at it. This should ideally have no functional change
unless we have a bug somewhere causing (stripe % cluster_size != 0)

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..b2e836a4bd18 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2553,7 +2553,7 @@ void ext4_mb_scan_aligned(struct ext4_allocation_context *ac,
 	do_div(a, sbi->s_stripe);
 	i = (a * sbi->s_stripe) - first_group_block;
 
-	stripe = EXT4_B2C(sbi, sbi->s_stripe);
+	stripe = EXT4_NUM_B2C(sbi, sbi->s_stripe);
 	i = EXT4_B2C(sbi, i);
 	while (i < EXT4_CLUSTERS_PER_GROUP(sb)) {
 		if (!mb_test_bit(i, bitmap)) {
@@ -2929,8 +2929,9 @@ ext4_mb_regular_allocator(struct ext4_allocation_context *ac)
 				ext4_mb_simple_scan_group(ac, &e4b);
 			else {
 				bool is_stripe_aligned = sbi->s_stripe &&
+					sbi->s_stripe >= sbi->s_cluster_ratio &&
 					!(ac->ac_g_ex.fe_len %
-					  EXT4_B2C(sbi, sbi->s_stripe));
+					  EXT4_NUM_B2C(sbi, sbi->s_stripe));
 
 				if ((cr == CR_GOAL_LEN_FAST ||
 				     cr == CR_BEST_AVAIL_LEN) &&
@@ -3707,7 +3708,7 @@ int ext4_mb_init(struct super_block *sb)
 	 */
 	if (sbi->s_stripe > 1) {
 		sbi->s_mb_group_prealloc = roundup(
-			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
+			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
 	}
 
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
-- 
2.43.5


