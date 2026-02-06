Return-Path: <linux-ext4+bounces-13591-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKkEOkIQhmk1JgQAu9opvQ
	(envelope-from <linux-ext4+bounces-13591-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 17:01:06 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F91FFF9E
	for <lists+linux-ext4@lfdr.de>; Fri, 06 Feb 2026 17:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ACA1A3045002
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Feb 2026 15:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E992E4257;
	Fri,  6 Feb 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kg1XPIaV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6423B2DF155
	for <linux-ext4@vger.kernel.org>; Fri,  6 Feb 2026 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770393509; cv=none; b=ndeXhOgh2UBuOTet0MS+uGkBCbSmgt0xUHi/I1Np0yVAe8FXLLeTgoaTZh8pby5kFz64XGc0gfiPC07CKnvLV1xm6vEWKU2iXRqw0p1X3eaVv6JEsW3Lql1K9KJpmZXqruhCdJYj3D7hdxKY13XrKYAeEBVy2rewDxJK8CvI31g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770393509; c=relaxed/simple;
	bh=mZf9Okkmj16KuTWC7/0CYg5ffRIe1tNA9e39gzOf/FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iS2k6psUP84oqcASpmw8VuX9Zvo2Oi9BrdDE4UzzkuqKi6Kn3vRjaG++Fg5zUV/b8ZBOn1jJFZTSdEaYMGTBb/F0wTOgq097H7TYKZ4llzgU18lr9d+Nnc1NhpDNLX32SopQr9Vp+GZFJaf7kxXZWu60Fa4z+D7/3HoKiQ89h10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kg1XPIaV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 616CU9lB017074;
	Fri, 6 Feb 2026 15:58:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=3tYtZ/VXThJYkD+r4U7cMEd6TTPE8aZI7I/dtOoRP
	ek=; b=kg1XPIaVV7Y+wkzzNO1lD2K7Lkx0+ezes6lFpJUuuXVgmRagOglRxLGiC
	qUOjLXqkL1AlVRoCsQkx2SVOwsr/7i3N/uR6wOBk5DQ/p/YLDQeAHi60vnIfzOpu
	4xpUgbO9Ktqih1qBEY7pz9uUJlzgSqLxpcAHhEUL7BHrtB19DWR7E07HWpRJTSuU
	0lfpO1+XlTx0094bkQxAv4G8MuFFRIIdFpNf3dJsD/BaaS2iLlG7LyFZDqqj7+uj
	zDR3s2WmvDkloZHVZ/PPzEwmKvj7iHwp7KSMWzo1w5BodAHbfms4I0IiH6S4pmx8
	hpCLlM4vIorQjtyoHNmWnsW6ELDiw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c185h95as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:58:26 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 616FOgv4015775;
	Fri, 6 Feb 2026 15:58:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c4gsgy361-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 15:58:25 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 616FwN6P51642634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Feb 2026 15:58:23 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B4B12004E;
	Fri,  6 Feb 2026 15:58:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74AEF20043;
	Fri,  6 Feb 2026 15:58:22 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.218.3])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Feb 2026 15:58:22 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] ext4: Minor fix for ext4_split_extent_zeroout()
Date: Fri,  6 Feb 2026 21:28:21 +0530
Message-ID: <20260206155821.2869356-1-ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=UdxciaSN c=1 sm=1 tr=0 ts=69860fa2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8
 a=g8sj6wszTY4gYSZuickA:9 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: Kt4nkeMXiamCFtNTuZBEQWl9BQ1Bj2fa
X-Proofpoint-ORIG-GUID: Kt4nkeMXiamCFtNTuZBEQWl9BQ1Bj2fa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDExNSBTYWx0ZWRfX3/CQn4ukN49V
 63FnRIYU8kGfLBkxC5dA9BkTDcq6/jQhpcYrI9aHRkIK8Uzk43yidIjkAMuaOF20BDUl7drtO+c
 CvU0AiXg6kjJ94zUfJxmrPVCdXwOr3LSVtf4FvisKVb4r/zJR7jT/1nCjaZJ03F//CyrBevbZ+J
 fkD5GZ3/qgSo3S9GnN1Mo1UTodEEkG/IA/praeQzoDOYNITDJCigxyf4gQ9yRvjQd/A4KG/arKC
 St4r4ibxTodu06yFYcHxGH8lcBTgfJACxfB9tZbfI9wFidRWqRhiyaFZ5wBYiwd27tYMlLeJV3A
 MruGq7r/OHT4fWbOsP9G/gC6u8gABP1d2qdJ5dkm1Y9KNVA6D2ADCZ0/JSu9EbARC0DNs111l2z
 aVYFTTqoOZ0yOjk/HznbkgYlnGRUrPTvbN+fQV1A107/pHq6EXlRShKzQX27y4GC+WA+8zfDzV5
 OZhEA30GUcNdv4NBfHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602060115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13591-lists,linux-ext4=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ojaswin@linux.ibm.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 48F91FFF9E
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


