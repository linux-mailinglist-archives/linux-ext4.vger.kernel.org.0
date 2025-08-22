Return-Path: <linux-ext4+bounces-9555-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8FB31119
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C35AB6432B
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Aug 2025 08:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6572EBB89;
	Fri, 22 Aug 2025 08:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FZ8afuQx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7454C2E54C7;
	Fri, 22 Aug 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849760; cv=none; b=MXpnLpwwyE2qIHUIX8/kDgeiLsWik5idj3sQpkkD7MFuUPZ0asu1Y1LS9Dpc6EoTTInvSZkICjeYI/zKyQRLRysSYS3KKXStuRPnALYy5MLD+pg5x6zCp9We34Ah2W7zC87tt01xiTiNNnM4m63LXHrp1cjLFeeEZp1g5+gGY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849760; c=relaxed/simple;
	bh=h7wbbamg4JolKV3mimLB8bIlNNmks/rM2pudmV6msgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fveoaE3VOGTvLbMpWILDIEvm5bZeiMo+o+rhK17PYSd6OoNtF4Kz/shdjjbPqCrkjWjRcLgEmk1AN78sx/GTUfesmR0NugPB/PM2rQKoPbEkjLOU+B86m5NH9sgeOKSHW6BZXLz8vBXYCjHjmUOsJ5b/WbbW3g7xgWMq8usgAGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FZ8afuQx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LIXov7012217;
	Fri, 22 Aug 2025 08:02:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zpb085wPGmEPbAst3
	E2KRxlV+xk0WkLGfPuijn8WhgI=; b=FZ8afuQxmlJ6/eBt68nDdc7Yr1/Oju5Xq
	2/0WSaN120Tl8VSBGOa4vQ0mDUvd1S+u+LT+auebq+5KUqVP9RngZPVZcIiS87/i
	OF7BBVjd1ceUTC7Vsbtta3dniD7O5dgjKHmS4EAy2hDAAPDEUV4OfWgWNFv9vO4R
	UlFB/Q4/WDuuZTu0EpUXbeAwttoPpvG40lg4UDlpL1s9k1rAwB6KuLHhMEPFdxYY
	iUyDzm/w8fjwt26SpsQiXvPXe0sWRgHNAfSWfNUxTHJ8qOor68bhx9NSOsD5RQa0
	DPIqB/XClOpwz/wMCi/GBlNA0y2sfa3YW9D9tbJ9P2Dpaw5ow1A/g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnawp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:23 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57M82NWT010015;
	Fri, 22 Aug 2025 08:02:23 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48n38vnawg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57M4KUCm008726;
	Fri, 22 Aug 2025 08:02:22 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48my42cadf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Aug 2025 08:02:22 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57M82KnQ58917324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:02:20 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 219C420040;
	Fri, 22 Aug 2025 08:02:20 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C964D20043;
	Fri, 22 Aug 2025 08:02:17 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.124.210.10])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 Aug 2025 08:02:17 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v5 02/12] common/rc: Add _require_fio_version helper
Date: Fri, 22 Aug 2025 13:32:01 +0530
Message-ID: <955d47b2534d9236adbd2bbd13598bbd1da8fc04.1755849134.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755849134.git.ojaswin@linux.ibm.com>
References: <cover.1755849134.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FQ5llxCM6DH61Rgdbx68JJqk60laNYSh
X-Authority-Analysis: v=2.4 cv=IrhHsL/g c=1 sm=1 tr=0 ts=68a82410 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=0B_TZz9YXGle3_EXArAA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDIyMiBTYWx0ZWRfXxrD64K5fCyeB
 O4tZskCw6In2YscmVoKx7c1Blj1vvn2bymwK+Jfa5hSNrt+tN8XXgYR8OdIEmcgX+RaXUgu56NV
 YaZqDe0v/thsY+VhM8DxtuAjXPD711TYRCjJLv6+YR9nbxoKN1OCBBiYqyIx9f5BABM5/byApzx
 dXxVrdNYC1HuT1p3la0Y/mMWkTNsQsJLtli5VqHTPaVeuJcJdaFTsW7oUiksF3iUJEcI/Zcr34o
 dm+3gdBkXrMfOmkbLvtHbuADHJICEgdliTyU5U0D9FKzMGZjIZNtzlQtRtpk2iont8o+QSE8MJ/
 RPZzA2wrmMKL5OcmGt5ocaofa4Sf2lHZw4QgNqPgbGBqkIQ5vXoUdpwYRsE/7LA4POsTGEQ1iPA
 6rsTsjEfsTZAUrFs39rSvxwKXtAKgw==
X-Proofpoint-ORIG-GUID: bB2KwJJOyyLW5hz9oicfrl2rFA6IoRer
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2508110000
 definitions=main-2508190222

The main motivation of adding this function on top of _require_fio is
that there has been a case in fio where atomic= option was added but
later it was changed to noop since kernel didn't yet have support for
atomic writes. It was then again utilized to do atomic writes in a later
version, once kernel got the support. Due to this there is a point in
fio where _require_fio w/ atomic=1 will succeed even though it would
not be doing atomic writes.

Hence, add an explicit helper to ensure tests to require specific
versions of fio to work past such issues.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/common/rc b/common/rc
index 35a1c835..f45b9a38 100644
--- a/common/rc
+++ b/common/rc
@@ -5997,6 +5997,38 @@ _max() {
 	echo $ret
 }
 
+# Check the required fio version. Examples:
+#   _require_fio_version 3.38 (matches 3.38 only)
+#   _require_fio_version 3.38+ (matches 3.38 and above)
+#   _require_fio_version 3.38- (matches 3.38 and below)
+_require_fio_version() {
+	local req_ver="$1"
+	local fio_ver
+
+	_require_fio
+	_require_math
+
+	fio_ver=$(fio -v | cut -d"-" -f2)
+
+	case "$req_ver" in
+	*+)
+		req_ver=${req_ver%+}
+		test $(_math "$fio_ver >= $req_ver") -eq 1 || \
+			_notrun "need fio >= $req_ver (found $fio_ver)"
+		;;
+	*-)
+		req_ver=${req_ver%-}
+		test $(_math "$fio_ver <= $req_ver") -eq 1 || \
+			_notrun "need fio <= $req_ver (found $fio_ver)"
+		;;
+	*)
+		req_ver=${req_ver%-}
+		test $(_math "$fio_ver == $req_ver") -eq 1 || \
+			_notrun "need fio = $req_ver (found $fio_ver)"
+		;;
+	esac
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.49.0


