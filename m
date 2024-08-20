Return-Path: <linux-ext4+bounces-3789-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BC095822F
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 11:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A95E1F246E7
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Aug 2024 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A318C32F;
	Tue, 20 Aug 2024 09:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VHNJzCbM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061D918A6C6;
	Tue, 20 Aug 2024 09:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146052; cv=none; b=qV+NZfMa5yEKZJ25zN6hgzWhznZu1jxDzPwgua0ccLUZzFHTvZiAYjJfmhVYvXQdMFDgrrZwXALmflR/tsGD66Q8apzNYIEAMiTSosIBlAy2spThJAQyclA+5LySCPHR/zcnCKaMT3fzTiwKowUhutB77jOFK4dcsLW4NPjQaa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146052; c=relaxed/simple;
	bh=vlSyjZm3vraF6f4TshQsdmKa+dwgd7TOq3pHvYrwKA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW3H85cnNsyDdhLDEL36iFR6KeqMtzRh5X+O0LtMWeMPtONXraaUDv7SroCOcYEP9ymEAhlvdlY7/CtcXHhIkYv+t7V5XZEz+mKQMyhDkBgpyoOo4p//Eln+JtYid3LzFygp4M3EbyWkBvplvCRwTiJiY9oxPY9zHMVFlW+pCIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VHNJzCbM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47JKwsqs001579;
	Tue, 20 Aug 2024 09:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=eI3hCFcYlVFsE
	7eXCCGw581aBdT62IWfYQMMreIM7I0=; b=VHNJzCbMC83GFBPPtct/a+j8w6lYF
	+ugVF/lv9BD71Fe23jP0II1GD9a6CuQojVgan8+6R5iGWK26ytqDygMBZVETtNpX
	zrobJTbioidID44HvV654L+GkFrzdPx0u02ZilMYEP5kf2yB3xxFGIyx7ZlP3LGn
	m3Ub7qN9C6KS/b6rtAkbEVJmkTlcof7PjqOxjWbew4ol9aqaWvJI0MqzKVEOndmg
	ebsIjlKuTfDnwaRp7b52sFS1hEiRQ4M9tEklK/s2MwADYowhnk/qpRLLpwBm1M/Z
	sLac6lhECt0fdnxK6xFz3rYHB7BBAUC4xl/QohvTU8gbxz/4IH2UstOew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma050nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 47K9RKjZ017885;
	Tue, 20 Aug 2024 09:27:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 412ma050nh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47K80qVh017706;
	Tue, 20 Aug 2024 09:27:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w31v3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 20 Aug 2024 09:27:19 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47K9RGYu56099326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:27:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EBEF32004B;
	Tue, 20 Aug 2024 09:27:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B3AC20040;
	Tue, 20 Aug 2024 09:27:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.124.218.80])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 20 Aug 2024 09:27:14 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Subject: [PATCH v2 2/2] ext4: Convert EXT4_B2C(sbi->s_stripe) users to EXT4_NUM_B2C
Date: Tue, 20 Aug 2024 14:57:08 +0530
Message-ID: <aff746f3dbce54f5ea807928c2286edfd6e9976e.1724145714.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
References: <f9042a87bfe883a3552c8fc561b2aa6f18de4f12.1724145714.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ODbDgItV-Czx4CwFMSFKywveSRSQqgkT
X-Proofpoint-ORIG-GUID: M5WmSbvuXvVuITWVzKWgZUQDwyYqZubz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-19_16,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2408200062

Although we have checks to make sure s_stripe is a multiple of cluster
size, in case we accidentally end up with a scenario where this is not
the case, use EXT4_NUM_B2C() so that we don't end up with unexpected
cases where EXT4_B2C(stripe) becomes 0.

Also make the is_stripe_aligned check in regular_allocator a bit more
robust while we are at it. This should ideally have no functional change
unless we have a bug somewhere causing (stripe % cluster_size != 0)

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9dda9cd68ab2..99d1a8c730e0 100644
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
@@ -3707,7 +3709,7 @@ int ext4_mb_init(struct super_block *sb)
 	 */
 	if (sbi->s_stripe > 1) {
 		sbi->s_mb_group_prealloc = roundup(
-			sbi->s_mb_group_prealloc, EXT4_B2C(sbi, sbi->s_stripe));
+			sbi->s_mb_group_prealloc, EXT4_NUM_B2C(sbi, sbi->s_stripe));
 	}
 
 	sbi->s_locality_groups = alloc_percpu(struct ext4_locality_group);
-- 
2.43.5


