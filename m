Return-Path: <linux-ext4+bounces-455-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3093F8146B7
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 12:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7765B2345B
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Dec 2023 11:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2081E24B30;
	Fri, 15 Dec 2023 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TUEugtr0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18820249F2;
	Fri, 15 Dec 2023 11:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFANg6M025951;
	Fri, 15 Dec 2023 11:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=eJx4Y4RaaHrqfjWnJcJuQnA/D4VZLkqigBXCP76igKI=;
 b=TUEugtr0ijv5GXCGi37b6y9Yxd1CdNQKd01/mk/+2MX9GLZQyhjPIJK6Hx/tqTDA+UVp
 MJWqZhHsd7jZbZDTrbllGHw+gSNlxvsFN0J3lbjFfycYHRYKIuAK35xsYv9A5NBZkK9O
 w70psMHM9cCbhz8rwaIopqH1jWQE+wmLmnYxbVylU8g7/y+B5Pmw9Wyd9JuDw/ol8z5/
 k4YyGQCQzNVI4N7puAVmJMCtqpU+aq4nZqKichf+5X5YvmVSYC/nHZ+7ljXSbyvXQT+l
 mu9VfnVyMJ1e74O1qgc0Zwdjzey9XcdSEUjeu7rd6hmMYY1YG18sNj/hc7Ra//vjwk+6 eg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0n0j99m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:23 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3BFBKKfk009366;
	Fri, 15 Dec 2023 11:20:22 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3v0n0j99kq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:22 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BFBGN6l012599;
	Fri, 15 Dec 2023 11:20:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw3jpfkhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Dec 2023 11:20:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BFBKJKr42074408
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Dec 2023 11:20:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8F4620049;
	Fri, 15 Dec 2023 11:20:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B593720040;
	Fri, 15 Dec 2023 11:20:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.77.136])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Dec 2023 11:20:06 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, glandvador@yahoo.com, bugzilla@eyal.emu.id.au
Subject: [PATCH 0/1] Fix for recent bugzilla reports related to long halts during block allocation
Date: Fri, 15 Dec 2023 16:49:49 +0530
Message-Id: <cover.1702455010.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KvCVVePiPt1Odt_IQy5qFSOm81yZFcD3
X-Proofpoint-ORIG-GUID: tct1xqpz0feQXHNGWANpOTPAxiPsgoBv
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-15_06,2023-12-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 clxscore=1011 mlxscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=999 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312150073

This patch intends to fix the recent bugzilla [1] report where the
kworker flush thread seemed to be taking 100% CPU utilizationa and was
slowing down the whole system. The backtrace indicated that we were
stuck in mballoc allocation path. The issue was only seen kernel 6.5+
and when ext4 was mounted with -o stripe (or stripe option was
implicitly added due us mkfs flags used).

Although I was not able to fully replicate this issue, from the perf
probe logs collected I have a possible root cause which I have explained
in the patch commit message. 

Now, the one thing I'm still skeptical about is why this was only seen
in kernel 6.5+. We added a new mballoc criteria in kernel 6.5 but I was
not able to find a satisfactory explanation as to why that would have
any effect here. Furter, the issue still persisted when I asked one of
the reporters to disable the it using sysfs file and rerun the test.
Maybe there are some more factors at play? 

Anyways, I would appreciate if the people experiencing this issue can
help test this patch and see if it fixes the regression.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217965

Regards,
ojaswin

Ojaswin Mujoo (1):
  ext4: fallback to complex scan if aligned scan doesn't work

 fs/ext4/mballoc.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
2.39.3


