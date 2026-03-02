Return-Path: <linux-ext4+bounces-14324-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECMXH26ipWngCwAAu9opvQ
	(envelope-from <linux-ext4+bounces-14324-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:45:02 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7797F1DB192
	for <lists+linux-ext4@lfdr.de>; Mon, 02 Mar 2026 15:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CF8308FC45
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2026 14:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0143FFACC;
	Mon,  2 Mar 2026 14:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GSb3ARcX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9813E430BB2
	for <linux-ext4@vger.kernel.org>; Mon,  2 Mar 2026 14:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462304; cv=none; b=gPadgos0shVeY7f7FQ2NRcfYk0AIbV7eU5Czqxt1zz2Mpk0dMKZVdOw5aQ/WW1JTrVwrnQg1oP5NhsI5nmOLY/ufzLXOS2X5Hneb0IivqAPeYqVbukUATdcOgRo5zwhraTv11u/F/9w7jxNgT77uzN7qBlXAqAscYGmByfxh4Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462304; c=relaxed/simple;
	bh=6UBYh9rHFv+hFEcKmS0wZQ+VZW4NAVb4JuvnHHNx7rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V4V8U1qD1+l34Gt1/D+fQZ9fg7lBJOwPQA96e+MYggnZUhq9TGjnlQMQZOuF0Irst3zZFFrRNGhxhvqTe4+HA6FICMZnS143uGxjutf/0XKiQIf8jqIM3S94HocS0Y+FjVGo28rVy6kn6aI8AvhgBsGu29rBtSJuWVOPj1dSsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GSb3ARcX; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EDw5A2397074;
	Mon, 2 Mar 2026 14:38:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=01bc5mqI8hoWqRYzuRrzfTkvrD7g8yllV15ni+4Q1
	a0=; b=GSb3ARcXxF+B0OnHM45Y562oMXmYHiTmGURFDZrxd3zx19dAX3hXOvtzA
	UkieX4l0SDnX9cQvrcpuuRDsjlK2g5BH2TTCMY7DaIKYLMm1eFeVfXZO5BYNqG0i
	NQEBndKs6xWcM7PxZEn9/v6Ac1UNW8zBMJZcNfPfO2RBCiJ7PzKqy/4Y31jbJ5eP
	QOHc4ogYY2jPY8Ik+R3jHqDJ0lAaqnnG1dTrqNgnyORHTSs/PJo8blC73gfLhmmO
	lLguu0xXZjW0blZAZ+qFPxP8+fMlpVNG1JSYpnL1zWKu1/HEoe59RaKkyynwUOUL
	8gDMhAHi7QHRdhjZ6izP8gglbro4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cksrhy2k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:38:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622Ccxgc003275;
	Mon, 2 Mar 2026 14:38:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmb2xxmpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 14:38:17 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622EcDu656688996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 14:38:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB88720043;
	Mon,  2 Mar 2026 14:38:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80DFC20040;
	Mon,  2 Mar 2026 14:38:12 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.211.209])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 14:38:12 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2] ext4: Minor fix for ext4_split_extent_zeroout()
Date: Mon,  2 Mar 2026 20:08:11 +0530
Message-ID: <20260302143811.605174-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Rp/I7SmK c=1 sm=1 tr=0 ts=69a5a0da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=Oa9wtnAbrLbwD9IejVoA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDExOSBTYWx0ZWRfX7qp3F08sEhaG
 v5Wh7VB6DSzy3tV6TL7IWI5fvSDfmL1bMQVQtoQ+kYZxffX7ortLNoddf7NPvU9iWz/HAErMMEg
 iNkMWKEx/9WTxWHzQIKAESFyf2GCCmHyWsM/RAjocTJcarvHeo/NHaDMWrJCY/7etG5wVf4EAFx
 VgQn5gjH6Hj4oDuWFeBg5iJWexBELxQHEdPsjIYXUF35cacfRPlJiaCBe1YkezAjSJzO4ui/Uvp
 4g7W+uzx1fKQWWCUMjHl1NVZqNgzSUxKiUaJNzYci7H6VDrBtWFMNbzQqy2z0rQ/dduiRa7UgkD
 0n53ODtK18cNVSpIpjwvCR+wQPbKOjs5Q+tprZWh8cBCUeebBqzWcbxpz56OR/+vMdQMLhRk46G
 XRjOmr3EHnRdkYc6AqjT5ABPY+tpqpBYQK8Q2h869YyrPOPfMpZrHED4P58zdjfnQiVBVSE764n
 /9tS8OnJxIyM8ob8NLg==
X-Proofpoint-GUID: o5p1y-FvulEiru48s7MxrS0mPfVjD42Y
X-Proofpoint-ORIG-GUID: CYGQR8IavGERPGeFFpEbw-tauTfyW6Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0
 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020119
X-Rspamd-Queue-Id: 7797F1DB192
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-14324-lists,linux-ext4=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.ibm.com:mid,linaro.org:email];
	TAGGED_RCPT(0.00)[linux-ext4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Action: no action

We missed storing the error which triggerd smatch warning:

	fs/ext4/extents.c:3369 ext4_split_extent_zeroout()
	warn: duplicate zero check 'err' (previous on line 3363)

fs/ext4/extents.c
    3361
    3362         err = ext4_ext_get_access(handle, inode, path + depth);
    3363         if (err)
    3364                 return err;
    3365
    3366         ext4_ext_mark_initialized(ex);
    3367
    3368         ext4_ext_dirty(handle, inode, path + depth);
--> 3369         if (err)
    3370                 return err;
    3371
    3372         return 0;
    3373 }

Fix it by correctly storing the err value from ext4_ext_dirty().

Link: https://lore.kernel.org/all/aYXvVgPnKltX79KE@stanley.mountain/
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Fixes: a985e07c26455 ("ext4: refactor zeroout path and handle all cases")
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 3630b27e4fd7..5579e0e68c0f 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3365,7 +3365,7 @@ static int ext4_split_extent_zeroout(handle_t *handle, struct inode *inode,
 
 	ext4_ext_mark_initialized(ex);
 
-	ext4_ext_dirty(handle, inode, path + depth);
+	err = ext4_ext_dirty(handle, inode, path + depth);
 	if (err)
 		return err;
 
-- 
2.52.0


