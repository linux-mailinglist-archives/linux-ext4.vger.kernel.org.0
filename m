Return-Path: <linux-ext4+bounces-9926-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDD7B53A0E
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763FCA081AA
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F53629BC;
	Thu, 11 Sep 2025 17:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TtNh+pnX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4CE36207B;
	Thu, 11 Sep 2025 17:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610849; cv=none; b=TrpD+X9YuOEIXSEx7eRDBSRyLyzyLXcC78tg88jYF7/kbifZ2rWSn3k/IiFIfwIqYTdtJwdP4FG2MCqgBGpqZ7TdFQZtwLYe7Q0EnM63cId43sjUduc8Bmo27L9Gk2A+fjdQJ3E35llDID6N6lndDH2X1wJSgSFYcg6jh60AZ5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610849; c=relaxed/simple;
	bh=W5XD++tnY8d0E4SXC6W9CchT17TpiD9tJGLiVrNOR6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pk1KpPAlpgYEYr1JLK4Pl2vKPvtUXrsylpt1IhqH1QQATdkJC4OdFDz2c4nBn6U7fDiegBxl3dGpaDgkZGYpoZZ28UAE6dzaMeQmcu+EgSRUq4GchaXKtOf5tvHWY1oU3JWL7NBDrUjmv6Ewkg2xyVh9BKLnJJkCQhJCuqiigeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TtNh+pnX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BG6U9q008043;
	Thu, 11 Sep 2025 17:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rNdvYmkqmpP8HC0yG
	I10lE8tHceC+TYn9c1ZHNzN2dY=; b=TtNh+pnXuiiVzAMgK2xusLcp93Ud2GwC3
	fqzabSOQ317y4ppWvlr4Tgycrp1jauEWd5rpV6IYHEPHDDAvdgNs1KDzj7UohfbU
	tw4dqTJ8z8Rak70NBqwW3Qo2b1yiVLCcUj1xO+4MQmdlphGnZTtqzsC86JVecFt0
	4MWDR6q43rTX5LhiYv81yrE7knb9VPkrwiz6tknq49+oVPODjbvcPecI+PGRx8G4
	wwoMpNA5WvRpjzpLhcBsKK+65hPDXpMGXiHD3dcwH72OqnfuI0W2TZ+htLOLfqT/
	Kz2WY+d5yINlVmgLfaLF7FrT/5yLR3utlLr0Hgp1vHbh1MOOuWMdA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketu17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:59 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BH6fsS029908;
	Thu, 11 Sep 2025 17:13:58 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490uketu14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BH3c1p007929;
	Thu, 11 Sep 2025 17:13:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109pxvw0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:57 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHDtR250397690
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:13:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1DCF2004E;
	Thu, 11 Sep 2025 17:13:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8684420043;
	Thu, 11 Sep 2025 17:13:52 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:13:52 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 02/12] common/rc: Add fio atomic write helpers
Date: Thu, 11 Sep 2025 22:43:33 +0530
Message-ID: <c940c2d672d963cc7775df082e9ce6894905f92d.1757610403.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1757610403.git.ojaswin@linux.ibm.com>
References: <cover.1757610403.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDE5NSBTYWx0ZWRfX3LlXug2v7ngr
 h0J1i8hMku8O1H6kBy/dY6BppfQLr+yuum0eG8V2RZIbfoAxJCsMP0Ror3oqhG3QQofQPrKxcOD
 112GTDVyZ0in36EMrU/qXKb8BGlaQlVQrQ11CVeFbNnCukYt42k1ijvYKcGpeibmu0PgzNKzaXw
 7BBtrOwERUs7jFXKwNXXjW/1uC86ieOQjp3gx78zI7wyFmh75Ww958qSlZJ2uUm04KMGlrdn45A
 Ej9iaf5jwLXFimbSKe/lh/LuqsLQbepmB3Won4Zp1hYdYpv4RMFzvAxMfczs3juZYXoY5woAfPj
 zX3os7vCq+7zJ3PbEJyKxlxdOEjgI2xNbiqEy/XMCZLw/E1X3WOeUGllkHWBUSkp5453ZlOlt/q
 4rbhxb2C
X-Proofpoint-ORIG-GUID: DnVKLSROxWaAh090llgYuxDbJ5pgLaRs
X-Proofpoint-GUID: bMW8BhXSre6hCQzO1jBsUNMDaRyDSAQt
X-Authority-Analysis: v=2.4 cv=StCQ6OO0 c=1 sm=1 tr=0 ts=68c30357 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=nFHpeJSrNhMDmVjzN9sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060195

The main motivation of adding this function on top of _require_fio is
that there has been a case in fio where atomic= option was added but
later it was changed to noop since kernel didn't yet have support for
atomic writes. It was then again utilized to do atomic writes in a later
version, once kernel got the support. Due to this there is a point in
fio where _require_fio w/ atomic=1 will succeed even though it would
not be doing atomic writes.

Hence, add an internal helper __require_fio_version to require specific
versions of fio to work past such issues. Further, add the high level
_require_fio_atomic_writes helper which tests can use to ensure fio
has the right version for atomic writes.

Reviewed-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/common/rc b/common/rc
index 28fbbcbb..8a023b9d 100644
--- a/common/rc
+++ b/common/rc
@@ -6000,6 +6000,49 @@ _max() {
 	echo $ret
 }
 
+# Due to reasons explained in fio commit 40f1fc11d, fio version between
+# v3.33 and v3.38 have atomic= feature but it is a no-op and doesn't do
+# RWF_ATOMIC write. Hence, use this helper to ensure fio has the
+# required support. Currently, the simplest way we have is to ensure
+# the version.
+_require_fio_atomic_writes() {
+	__require_fio_version "3.38+"
+}
+
+# Check the required fio version. Examples:
+#   __require_fio_version 3.38 (matches 3.38 only)
+#   __require_fio_version 3.38+ (matches 3.38 and above)
+#   __require_fio_version 3.38- (matches 3.38 and below)
+#
+# Internal helper, avoid using directly in tests.
+__require_fio_version() {
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


