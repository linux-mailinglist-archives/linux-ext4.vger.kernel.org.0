Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4243AC983
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233800AbhFRLMg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:12:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233543AbhFRLMf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:12:35 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3nNc019791;
        Fri, 18 Jun 2021 07:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=aHXSEeipvdqcaWVoz84Nmladvcs+yX1bx/EmIf2tUdw=;
 b=DmzcKjnGX0Fy8uqkHUwuMFolJd76eOquzou0tVLnGpvREP25CrBN0q6Pd9PPxoLv38eP
 TdZXT/2L2uI9h40Z25wSuFZDGvT5hfAzt4Eu1BGkaReAP4Sy04It7Ko+vnNUhiuAFJLN
 VOTSMP1//OAVQNClsXn0YuF0uBGtWQwVi+W91JGhszjSvvgbR/0RnyM8ryt3BMfmO5Vn
 VrfAoWbVBK9Q/BbhzqMR6LcLHp2Ba1Mjp+/zLVcBG/18oSNhiE1ZdIpWiNQW83HrmZqF
 Mf9n0/fS3QqIIF0OUu0bYLUtEYP1ZqvlX94weyeCi7YglEmZaZZ7TluVsx66kvdsWutO Xg== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 398s44japu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:10:24 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB99GR012034;
        Fri, 18 Jun 2021 11:10:22 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8u8xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IBAK1x28836282
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:10:20 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B912AE051;
        Fri, 18 Jun 2021 11:10:20 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16848AE04D;
        Fri, 18 Jun 2021 11:10:20 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:19 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 8/9] runtests.sh: Fix when SCRATCH_DEV_POOL is passed
Date:   Fri, 18 Jun 2021 16:39:59 +0530
Message-Id: <5eab116f5daa4cf36adde6e5175a88ee1df60e7c.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: zRQh6_O9VgICE7V0GFeLYJOe1thtL2jT
X-Proofpoint-GUID: zRQh6_O9VgICE7V0GFeLYJOe1thtL2jT
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 mlxlogscore=852 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

btrfs may need more than 1 disk which mostly needs to be passed via
SCRATCH_DEV_POOL. In such case we should not set SCRATCH_DEV [1].

[1]: https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/README#n55

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/files/root/runtests.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kvm-xfstests/test-appliance/files/root/runtests.sh b/kvm-xfstests/test-appliance/files/root/runtests.sh
index 6cbda62..bfc5b24 100755
--- a/kvm-xfstests/test-appliance/files/root/runtests.sh
+++ b/kvm-xfstests/test-appliance/files/root/runtests.sh
@@ -288,6 +288,12 @@ do
 		export LOGWRITES_DEV=$LG_SCR_DEV
 	    fi
 	fi
+
+	# This is required in case of BTRFS uses SCRATCH_DEV_POOL
+	if [[ -n $SCRATCH_DEV_POOL ]]; then
+		unset SCRATCH_DEV
+	fi
+
 	case "$TEST_DEV" in
 	    */ovl|9p*) ;;
 	    *:/*) ;;
-- 
2.31.1

