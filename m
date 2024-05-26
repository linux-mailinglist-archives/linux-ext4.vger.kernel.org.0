Return-Path: <linux-ext4+bounces-2647-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EDE8CF58D
	for <lists+linux-ext4@lfdr.de>; Sun, 26 May 2024 20:54:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86C331F21185
	for <lists+linux-ext4@lfdr.de>; Sun, 26 May 2024 18:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9443F56477;
	Sun, 26 May 2024 18:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cf3uTnZ4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA6E1A2C21;
	Sun, 26 May 2024 18:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716749640; cv=none; b=jaxaoDdtEWgOsvDz0IROK9fLwuv0uhw7BJnr5WIeHW9qGK+swBzffbnmZ89b38UxL8ojHv2JglZoYyQ6osUJfuBUm0yxxomb48YofqmlL45UhyETdoO0ZZkZLP+hQZSaEOEu/qWqewW2M0JT3HxmDW6er+tTHXHOST+SRy0iQak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716749640; c=relaxed/simple;
	bh=kuITH6P9GTetzXAVCMxT/omhG2Ghm9hRi7nGRq8Vp18=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=unSZAY0sTXg1yAfS5OuRh6rVpneCvlX0eezRQVhPcfKwyfQzKMw3GASNucUzYE1WZu0ButAPvZU+M4HpvVPofzlEMmxWockHvxY5kmSeUBgLm3qkg2N00Tz2GAyTZGBRPGPQaQ+bkiOWhyHgEixHG+MfBAGb+nQPdpgdSk4dOAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cf3uTnZ4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44QIkUPb013226;
	Sun, 26 May 2024 18:53:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0IDPTEJDMuYERr/mRMDeMm
	t/ibxc81efqZqaZ9uJiAo=; b=cf3uTnZ4D6FCK/4xdTIkHRAuO+1GIVNHIEzJS8
	pDkiXJYbioYZXZtIXqPfu51kCK3kYvWThhyOOES71knmoCZRQTLToqRy4NL7wBtl
	fZ1kj/MR4G8OcykewMkq6PrhCXFXBIfwaHeZHJzUSsBZBwLeLcr0nWU7DRcy+GlH
	ziK43U26yGLjinWp1B1z4WdbRA83ozHBNadluVA8ySJY2G0TjlPtRjxZ/yeVI25q
	PNrpAm4lGR6CpBiwSH5PrAcO32EPWF3ssg+H99PHo1IkQ74XFzxlEjBqT37YVsfV
	AcZFLQUlcWoKLWWqqtQlighWyouNZqe9qaWieoZ3UOk4pLeg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2h21vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 May 2024 18:53:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44QIrpg7027750
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 May 2024 18:53:51 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sun, 26 May
 2024 11:53:50 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sun, 26 May 2024 11:53:49 -0700
Subject: [PATCH] jbd2: add missing MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240526-md-fs-jbd2-v1-1-7bba6665327d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIADyFU2YC/x3MQQrCQAyF4auUrA2Mg63iVcRFMpPaiB3LpEql9
 O5Glx+8969gUlUMzs0KVd5q+iyO/a6BNFC5CWp2QwzxENrY4ZixN7xzjsg5UOKujUc+gR+mKr0
 u/9jl6mYyQa5U0vBLPLS8FhzJZqk4fXwK2/YFpcaqz4EAAAA=
To: Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p9U7thaAjs4NCVA11ig1iD9WK0ceEpJj
X-Proofpoint-ORIG-GUID: p9U7thaAjs4NCVA11ig1iD9WK0ceEpJj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-26_09,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=926 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405260158

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/jbd2/jbd2.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/jbd2/journal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 03c4b9214f56..0d2825c131cc 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -3181,6 +3181,7 @@ static void __exit journal_exit(void)
 	jbd2_journal_destroy_caches();
 }
 
+MODULE_DESCRIPTION("Generic filesystem journal-writing module");
 MODULE_LICENSE("GPL");
 module_init(journal_init);
 module_exit(journal_exit);

---
base-commit: 416ff45264d50a983c3c0b99f0da6ee59f9acd68
change-id: 20240526-md-fs-jbd2-bd0acb6527b8


