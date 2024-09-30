Return-Path: <linux-ext4+bounces-4383-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF75989D81
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 11:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A2AC1C21F16
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Sep 2024 09:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898C170A22;
	Mon, 30 Sep 2024 09:00:45 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63EC2FE33;
	Mon, 30 Sep 2024 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686845; cv=none; b=PN6YrPms19zrU1rVoCd7QEDgONuiVm4gfBP6SskWHB+OMBiUiNS3KW4We0uNGlw3d2yzbUTaXP5Oe6AzRVpKI4w4ltTDxB4+AiYctQcmG/0mf943GY+rz0KBB2tF6aHqM9KxwqsJJx0QAeHcpIcvxlaPRL27iJPhewQLLO+0J8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686845; c=relaxed/simple;
	bh=HO+P8Flt/ewYD4N75KI72j298jEuexJbVH/p+lQ+3fk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAeYZvuIM79WZCLJlmn7iZ+pyxDYWqZommxAID0V/m/yEYVE4EAuyQP9NVsM7Z0jXm/1Kl2ETgUBW97/tQXWk7KAFl2ERErjxjsaUldAeakQSuTxRLx3Slc97dBJnWKtzT3d+1A4Cev5Ci7nT27P4+Ja+FsCks0T2Y91XTmbTUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U6ArIS011865;
	Mon, 30 Sep 2024 02:00:14 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41xhakhkup-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 30 Sep 2024 02:00:13 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 02:00:13 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 02:00:10 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+96ee12698391289383dd@syzkaller.appspotmail.com>
CC: <jack@suse.com>, <jlbec@evilplan.org>, <joseph.qi@linux.alibaba.com>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mark@fasheh.com>, <ocfs2-devel@lists.linux.dev>,
        <syzkaller-bugs@googlegroups.com>, <tytso@mit.edu>
Subject: Re: [ext4?] [ocfs2?] WARNING in jbd2_journal_update_sb_log_tail
Date: Mon, 30 Sep 2024 17:00:09 +0800
Message-ID: <20240930090009.174420-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <66f98a80.050a0220.6bad9.0021.GAE@google.com>
References: <66f98a80.050a0220.6bad9.0021.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=YOLNygGx c=1 sm=1 tr=0 ts=66fa689d cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=f1uxmiMR-l0qOoKR0IgA:9 a=fVKOHcENdpsA:10
X-Proofpoint-GUID: Od2NVnKJ6JabaWOuGtqvZ81pZMEa2bLi
X-Proofpoint-ORIG-GUID: Od2NVnKJ6JabaWOuGtqvZ81pZMEa2bLi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_08,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=776 clxscore=1011 suspectscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.21.0-2408220000 definitions=main-2409300064

The s_sequence value of journal superblock loaded from disk is 4294967295,
is it too large?

#syz test

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 97f487c3d8fc..563c4af533ac 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1397,6 +1397,12 @@ static int journal_check_superblock(journal_t *journal)
 		}
 	}
 
+	if (sb->s_sequence == U32_MAX) {
+		pr_err("JBD2: Load a too big s_sequence: %u, %s\n", 
+			sb->s_sequence, __func__);
+		return err;
+	}
+
 	return 0;
 }
 

