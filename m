Return-Path: <linux-ext4+bounces-9925-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C7EB53A09
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DCC51CC5E84
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Sep 2025 17:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED9936209C;
	Thu, 11 Sep 2025 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="i/sI+mtq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF3636207B;
	Thu, 11 Sep 2025 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757610844; cv=none; b=CpkWuoODA/UD2G3+aIaUpGiRDES10/YTaEi2m7QmANFce2qZzuYNrEqDdtSiXLr40dtTZYWE6Z0YW3kk/erwP4+AKnjfYfrOo4TCnDiovQR17ff/+4S/QnkSsGH1a3+aRKAvjwBo7tl1VfO7GmITsn7723VY2A/B2KrmaxvUDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757610844; c=relaxed/simple;
	bh=w+HAnnjKd3GJVEihEy0k9c5/uycjCPovrRjLi95YrnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/LUvCjfkjm5VJQ05r3OD4+RxwopENVL9kVbb9VU13nJv6rIKT8OQ6LEuk1/P9uVE0ZXXLfz7SiIXmRxgBNo+hx8wvZNbapz69XngQV6YfbWJOqql9xUlwZR7xk+KU9l2xvv7DxNMzS24SiCT7Zb3bp4cvr6p/r1+N3wdpa70BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=i/sI+mtq; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BB05Qj009190;
	Thu, 11 Sep 2025 17:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4w8BDwO1ZUf0Evazr
	ueiJY6KTF9inKx36aKsZrlnj8c=; b=i/sI+mtq9aLN6XcA5Pe9u69DZccSTGKcs
	d5g+cLjl1xEuRhBy3Ft26oTxeKpHaZdRlUTFsVAit5Q8jEL70SmTK/a6hOjGR1cH
	UdJznYw1RJKyMzjNKMU97ggNRpnKD0ALOZ+LJ9s05vo3dlSzS08J8HfyprTP5kxV
	Uy25Al636aY65fI6wyE207vdAlh85kFfAE4ccZ9zISyn7niLq+10zB9mkLI9aaPT
	Zoi8+d2FE7VKAzBDydf5PCZZks/FyNAcohNhVDQB2e8X4JWImwkI48/oMmDNrHVY
	qFc13CQjYAOonvtyK1/JyQyDpnGXUjblFRk0/tjU51fBxuwOiBTNg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgfc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58BH8sXN024933;
	Thu, 11 Sep 2025 17:13:54 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490acrdgf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGgkkO011435;
	Thu, 11 Sep 2025 17:13:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9uq52m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Sep 2025 17:13:53 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58BHDpVu53149964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:13:52 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D7AC820063;
	Thu, 11 Sep 2025 17:13:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 727CC2004F;
	Thu, 11 Sep 2025 17:13:48 +0000 (GMT)
Received: from li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com (unknown [9.39.17.37])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Sep 2025 17:13:48 +0000 (GMT)
From: Ojaswin Mujoo <ojaswin@linux.ibm.com>
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: Ritesh Harjani <ritesh.list@gmail.com>, djwong@kernel.org,
        john.g.garry@oracle.com, tytso@mit.edu, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [PATCH v6 01/12] common/rc: Add _min() and _max() helpers
Date: Thu, 11 Sep 2025 22:43:32 +0530
Message-ID: <9475f8da726b894dd152b54b1416823181052c2a.1757610403.git.ojaswin@linux.ibm.com>
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
X-Proofpoint-GUID: XeNOgZgpvvw0Ue7ocIDcr884w84A20b3
X-Authority-Analysis: v=2.4 cv=Mp1S63ae c=1 sm=1 tr=0 ts=68c30353 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=wDx1mg2EYdB0JXDzLs4A:9
X-Proofpoint-ORIG-GUID: DkDTP1kNrScJXzhjjB6Pi-JU_pVfvOeN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAwMCBTYWx0ZWRfX43miWC2CRvZ5
 ezGke3OYi6qAgjk1cpwebThQsAPGkRAoLe00VK8649ehFHby9qft+Epd0glqQQdN5a8OP3BiQDA
 OiGdyhErfJFFLWhvZ39ipzMo8okwLGg0Z5x1M+6TGf0WVpfpzkSW6Wt/VCCFBIUKvsufUPPV8jD
 gF/L8YLytxMoSyvfZjCVYt+fHopCFDTjoLHpX8ojqkBK1RAMbkrdilWcSoFBKHZtxhYpZoX1Y6O
 9HjTvKwA0K2JkTxzaDyKnCEjygdwwVKpuv9K4WXtWyHvceRjEE5qAMc4Z9vfqoSrcbFN88jWYrx
 tuJKD1FgBwSqdK0o9CbbZVMC7FXKGKuNT+irP2zztlBx5jxg/gBgczXchcY3EnbHAVpEQNqZoRr
 bMc5Cofr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060000

Many programs open code these functionalities so add it as a generic helper
in common/rc

Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 common/rc | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/common/rc b/common/rc
index 81587dad..28fbbcbb 100644
--- a/common/rc
+++ b/common/rc
@@ -5978,6 +5978,28 @@ _require_inplace_writes()
 	fi
 }
 
+_min() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg < $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
+_max() {
+	local ret
+
+	for arg in "$@"; do
+		if [ -z "$ret" ] || (( $arg > $ret )); then
+			ret="$arg"
+		fi
+	done
+	echo $ret
+}
+
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.49.0


