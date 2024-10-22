Return-Path: <linux-ext4+bounces-4719-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 323929AB6B4
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 21:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B22A0B22748
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76B01CB32F;
	Tue, 22 Oct 2024 19:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g0vlsWgE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE6145A1C;
	Tue, 22 Oct 2024 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625195; cv=none; b=UxxBD9dhySzl8AxPgH4G4UqJjCjSm9bAaQmRXORy3NMCoVntPBlXblc8Vh7d+dIg1XydKOV7R5KbExPxaSWMp4BGSkIchBiD6ZEugiSzaF2e1AVuon1XXPK79S1rY28wvRWM8rehJkDZXHjmilPzXZzmaW97L/7tXE2i5zRG/MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625195; c=relaxed/simple;
	bh=stx+7oLa9nBdY/Enc3ui3V6PquphbwxALSrzOx2srNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cC4lk815IQ0sO5P8CzjIAXP4F+cH60g+aM7sYhxxgUNblZfeHeBEswoZPX4e5WEQsFPNY0Va0sRqdpFO6LAHO1Zeoqta/CvpKbmEKAf9joj8Mr4ofVoYgAltxla0d0G9rEGpqP3m5E0DvR6rTeyauLATlxQYF9SawZlG97MILpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g0vlsWgE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MFdPr0029590;
	Tue, 22 Oct 2024 19:26:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oe+F52Hh4QiFlU14NUyD0ZvXtHpYtXLMGgdP6TmAZ
	GI=; b=g0vlsWgE8LA5QQ4Ka4gKrEO2NnccCreNHID6PR9lrb0BVSUzXpPXXRQ+A
	2NzDuLErf6BI5GOeSTHh1yztdObscNUm4aJKpXEmHhr2axoLzR91ciX9fzqp2vOv
	R6M2PXF+BXk7nd+ks2iYY0TDT+NZWh6eoiZlvlYDu0dMCZ63pvMK+bdf1J9m+xFN
	lsiVpksYZtS4fPI3yxiW17p4jN0bjlrW8XPvLg3PVVTwv3Goo6fhlCRP82THj1RO
	rh9PSWyBmGRYjn0JlooGzlp2lUBAYF0bRPU9R/95EKtQnyQ/7xhcwFdtRmxE+1q6
	qTg8n07OAI8vN6IoV8vVigbcg7i9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eufrby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49MJQSfr027803;
	Tue, 22 Oct 2024 19:26:28 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42c5eufrbw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49MHDEwm028870;
	Tue, 22 Oct 2024 19:26:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cqfxmw93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 19:26:28 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49MJQQBO41943418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 19:26:26 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 321832004B;
	Tue, 22 Oct 2024 19:26:26 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BBD7920040;
	Tue, 22 Oct 2024 19:26:24 +0000 (GMT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com.com (unknown [9.39.26.25])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Oct 2024 19:26:24 +0000 (GMT)
From: Nirjhar Roy <nirjhar@linux.ibm.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        ritesh.list@gmail.com, ojaswin@linux.ibm.com, djwong@kernel.org,
        zlang@kernel.org
Subject: [PATCH 0/2] generic: Addition of new tests for extsize hints
Date: Wed, 23 Oct 2024 00:56:18 +0530
Message-ID: <cover.1729624806.git.nirjhar@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PbEtUK6SzgFgmlg5dIQXu9qt7IA62StC
X-Proofpoint-ORIG-GUID: gTeYafYQILr_gI7EDpcqSJh5JTGVFrp6
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 mlxlogscore=754 mlxscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410220125

This test is basically to check the functionality of setting extsize
hints for xfs filesystem through an ioctl. It covers various scenarios 
like setting and then getting extsize hints for various types of files 
like an empty file, non-empty file (with delayed allocation and allocated
extents). This test set also tests one of scenarios where setting extsize
hints on files with delayed allocated (incorrectly) succeeds and there is 
an ongoing patch series[1] that fixes it.

Currently this test only runs in xfs but there is an patch series[2] in review 
that adds support for the extsize hints for ext4 as well.

I have tested it on ppc64le (with page size 64k) and x86_64 (with page size 4k).
The block sizes I have tested with are 2k, 4k, 8k, 16k, 64k with extsize being 
twice of the block size. I had to enable CONFIG_TRANSPARENT_HUGEPAGE 
to enable block size greater than 4k on x86_64.

[1] https://lore.kernel.org/all/20241015094509.678082-1-ojaswin@linux.ibm.com/
[2] https://lore.kernel.org/linux-ext4/cover.1726034272.git.ojaswin@linux.ibm.com/

Nirjhar Roy (2):
  common/xfs,xfs/207: Adding a common helper function to check xflag
    bits on a given file
  generic: Addition of new tests for extsize hints

 common/xfs            |   9 +++
 tests/generic/365     | 156 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/365.out |  26 +++++++
 tests/xfs/207         |  14 +---
 4 files changed, 194 insertions(+), 11 deletions(-)
 create mode 100755 tests/generic/365
 create mode 100644 tests/generic/365.out

-- 
2.43.5


