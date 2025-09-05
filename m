Return-Path: <linux-ext4+bounces-9820-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79CB4510A
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 10:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 883B13B48D0
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Sep 2025 08:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488242FFDF6;
	Fri,  5 Sep 2025 08:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c30yvJaK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649E92FF155;
	Fri,  5 Sep 2025 08:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757060106; cv=none; b=BDLuaV+aE+FeHtzS2P49Et1F/85ylPk69C9RXvEPBobxsfaF9M2Y1XmUxvZij8pRzv7o/eqP0ocXzImlWu14+KobU98jBOaV+WuTEBdXmiTiVnkLji7avGeztfN2X1eP1EyWdW8ZHj51VRyC2SoQ4bHQEB2h95xkB8BgSryMuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757060106; c=relaxed/simple;
	bh=sgr8KwWBNyGWO9cWj+BKDb2VmeI4D9Wu6/GLBDGJATg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kzu49HKZsOxrzyO8WblnX3wIyO4HSCmQRIUb/juiNGwQRGh+CTBZJYTuMVhW1fm2HKFQ3EeoICbc/xurs7zntIMc4kHIf2BdNUU0uNJDrJOLPkd8y2si57AS1havewnMkmCGjMjLPZQQKz1Famht8ChSAvId3CbxN9MtPLfGNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c30yvJaK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5855VN6C027521;
	Fri, 5 Sep 2025 08:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=oM48yX/YR59XzOhYZ5orrKwOGTuY8MVIGM9iU6dRC
	Jo=; b=c30yvJaK5+xFWe9CA1PaSJKiuui2Wzh0VFKFfAqseEWE4mnivAOHPD8kH
	+dQa6ltsUCnJY3sgidOA1TyoiTQ4JFNEYSL0AkC9B2FkCEfiV9NeMfHrkuCmgAZc
	XLvjh35/g7lU0p69BGlb0LvCOu9+PnlvWZmgn4sPcIUoJjrCzfOyJnHa/Z93UjO6
	bgUvKa3KeEPaeKX9YTHnskn7jenSgs1WbndwxiDWPdOp5lbMXa96xW5Y2YNEUkXi
	5l5ARALGJ63SNebwcY6iSmo8EsGcbxBhKtXOqHMo/DwSwJbqDdvMTlCsTcMdduWI
	/BheHAPZFbppNdOOV6QrlRJPgqZxg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdq5rj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5858EsZj027670;
	Fri, 5 Sep 2025 08:14:54 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdq5re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5856Ggfg013959;
	Fri, 5 Sep 2025 08:14:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48veb3r8td-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 08:14:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5858EpCe51642784
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 08:14:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FFC82004B;
	Fri,  5 Sep 2025 08:14:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D81B520043;
	Fri,  5 Sep 2025 08:14:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.27.144])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 08:14:48 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>,
        linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH 0/2] Some more misc fsmap fixes
Date: Fri,  5 Sep 2025 13:44:45 +0530
Message-ID: <cover.1757058211.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68ba9bfe cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=C1f-N4PK-TteUKfjugwA:9
 a=zZCYzV9kfG8A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX9jimB3+fWg4k
 mTuf4GVJUecZyqEFhhwnEY62ftjKw2OckQbfhWI4Ka7W0ZNUCee9OXlz3y3Z7bXpV7PrgC3KaoC
 YaNeZPWBnvuUzSzBUHfcU8Ty0jg4G/C7xlGffmaNi2tO+CPt/2rBNU51ptTZ8kADIRtCa7n8+i0
 8R++MainXLi5gMDO+eMRzK1NjmaX7DuEHli139Reo3nyroFlbrNT5jZ1y+vXQuPFxN/DgPxikja
 mHy7wzmbiGCvr7qqr9qGHSs8marqVSdedZXKdxrZvIM0lbj6T5/9e7YIDYQdnGOx5dA8WkdP0cd
 kzkAyAI5PT8rSdk/HLDdu6ETFZaDAsGLGbWuv81MOqTDFV8rCAxGPNkZcaY24T1F6M4gbNrKmEA
 bR8A86IB
X-Proofpoint-GUID: lnED6WZeQ1Fne_uX0dG0LB6ginQHIHXD
X-Proofpoint-ORIG-GUID: dU16aDdiD6otrt6D7y89vbQIdlbBqNO2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_02,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

These 2 patches mostly fixup a couple edge case inconsistent behavior
we were seeing in fsmap. Further, convert fsmap path to use block size
units wherever possible to avoid issues due to block to cluster to block
conversions like [1].

[1] https://lore.kernel.org/linux-ext4/e7472c8535c9c5ec10f425f495366864ea12c9da.1754377641.git.ojaswin@linux.ibm.com/

Tested with some custom edge cases (which I'll see how to consistently
convert to xfstests) as well as generic/365 on 4k, 64k and bigalloc

Ojaswin Mujoo (2):
  ext4: Correctly handle queries for metadata mappings
  fsmap: use blocksize units instead of cluster units

 fs/ext4/fsmap.c   | 56 +++++++++++++++++++++++++++--------------------
 fs/ext4/mballoc.c | 25 ++++++++++++++-------
 2 files changed, 49 insertions(+), 32 deletions(-)

-- 
2.49.0


