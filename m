Return-Path: <linux-ext4+bounces-2655-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B941D8D09AE
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 20:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 737A8281F25
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 18:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48ED015F404;
	Mon, 27 May 2024 18:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Vkj85MON"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2E361FE9;
	Mon, 27 May 2024 18:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716832955; cv=none; b=vDLoIlly27Y122iRE8mRISwmhFcQuQ/xiN3h+kVohFqHsYCEpaQes4HoJ8BiyjtYpURlm/K6+hOFE2VpI1PQWvF4fIjRyCgfFN08nH9Xl0gFFbLJ7KLFNCHvCjox5JcvEMhsH20NH03IVbn/koj3ZMw0RDpvtL4ovjX8vjJaJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716832955; c=relaxed/simple;
	bh=wa1L9VoauTTKHEa6vX1CApzuEJe1DfRB/MC0GiWaPWc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=M9GTDlR49vbNOeTn6JcQqWOGd+qa0ISMaVZ9pccI5LdNSGUjQ6oK9MwgOftqShHKbI+PhiiIAasFJLWoyV7Wi4Rg0WKC/pxTRVfIqMr5QHYnsaEGnbPBNgrkbiv1i+6ulEnIX9dealAeTvuoNpkBzQ/CIApwth+nDMKcpkDsfQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Vkj85MON; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44RAlher030409;
	Mon, 27 May 2024 18:02:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+smRZOrjGfOTzzOqwIb7JZ
	geZcDu6DdS6uzLgh10RxI=; b=Vkj85MONbnI3KwdC9ctoucvC0gMyVzmHy2Ccp7
	6ZATlXZXYj7hpQwIl7jvg9aEnezOSFCVWFCykgXS+tN5K5SPcrOt66cpqCgRzLVp
	+7Rrp3hl4FiEgSeq+fHl1DUCTkzBAO/Whrpn9W1ZeKuZLpPbwEFVHt1C1TkGQQzJ
	nZIlz/OgofJq1/cXzwgCgn7kRXszWmwpNShEqFG4jkZuYC76zkTdnpnCeE+qbQ9G
	odNXeBDSykxEwQkZo+jNAnrh05Dnm8LBaWBI/0O2pXffENtbY9TqdY4LyCoE4MqF
	MgFjd0ENeavY5jRvYYvSkKIOXvzIsGgV6NqGl6Bx1212orTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yb9yj4dh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:02:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44RI2UJM009567
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 May 2024 18:02:30 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 27 May
 2024 11:02:29 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 27 May 2024 11:02:29 -0700
Subject: [PATCH] fs: ext4: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240527-md-fs-ext4-v1-1-07aad5936bb1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALTKVGYC/x3MQQqDMBBA0avIrDtgg1HSq5QuEjPRgZqWGZWAe
 HfTLt/i/wOUhEnh0RwgtLPyJ1fcbw2Ms88TIcdqMK3pWmsGXCImRSprhy5aE3tnXQo91OArlLj
 8Z89XdfBKGMTncf4t3py3govXlQTO8wIB9cznewAAAA==
To: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Z1wj6_RaWP8OBYbPW8270hS66Edy0niW
X-Proofpoint-ORIG-GUID: Z1wj6_RaWP8OBYbPW8270hS66Edy0niW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-27_04,2024-05-27_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 mlxlogscore=882 spamscore=0
 clxscore=1011 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405270148

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/ext4/ext4-inode-test.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/ext4/inode-test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ext4/inode-test.c b/fs/ext4/inode-test.c
index f0c0fd507fbc..749af7ad4e09 100644
--- a/fs/ext4/inode-test.c
+++ b/fs/ext4/inode-test.c
@@ -279,4 +279,5 @@ static struct kunit_suite ext4_inode_test_suite = {
 
 kunit_test_suites(&ext4_inode_test_suite);
 
+MODULE_DESCRIPTION("KUnit test of ext4 inode timestamp decoding");
 MODULE_LICENSE("GPL v2");

---
base-commit: 2bfcfd584ff5ccc8bb7acde19b42570414bf880b
change-id: 20240527-md-fs-ext4-9d52d6959fb6


