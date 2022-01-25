Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9516749AC2D
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jan 2022 07:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236896AbiAYGM3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jan 2022 01:12:29 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238834AbiAYGCb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 25 Jan 2022 01:02:31 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20P4lQrm001512;
        Tue, 25 Jan 2022 06:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=5p8Wp2r2xAze9kpL5AFF4CamRzAPWdC2kdc2nmOiCnQ=;
 b=HICX7BuJk2omG6xwdVNyX47LLvKITYV4Ma2DkBpT1F0mOayURAjQSz0Uw2uG9t8y8/UA
 Q0LSTi1LV/gfVJLqHYcKYssoFRI9Zuon+vf9neyV+uGkitt2TdTGkrM1iYX3AmAtsF5N
 1RQta/Zo8CtWOFI2VswQFc7DUp6kIZZecTDg5q05cogAfwE2UTKSzQEUWCDpUeJ1w1Zf
 rdVZv9B9LGnBWvjuzvKRLIx2z6w/9luhcHWpf4V7SPHEacWj78lWhEfcQO7yUgrXZqys
 Ixpg9iQeko4oAD6dEE7pQ3PIVqr2mVWu/x/0+zwHv4Bs6N8DBMAS6cy+aveuKbuWPhCO yw== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dtag7197c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 06:02:14 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20P5xj5U032149;
        Tue, 25 Jan 2022 06:02:12 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3dr9j92h63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jan 2022 06:02:12 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20P62ASq43647338
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 06:02:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B7E6A4055;
        Tue, 25 Jan 2022 06:02:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97291A4040;
        Tue, 25 Jan 2022 06:02:09 +0000 (GMT)
Received: from localhost (unknown [9.43.18.116])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 25 Jan 2022 06:02:09 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>, linux-ext4@vger.kernel.org
Cc:     Zhang Yi <yi.zhang@huawei.com>, tytso@mit.edu,
        Jan Kara <jack@suse.cz>, chenlong <chenlongcl.chen@huawei.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 1/1] ext4/054: Remove auto and quick group
Date:   Tue, 25 Jan 2022 11:32:02 +0530
Message-Id: <1e04c57094d871869997220fc5539dfe2ffa1884.1643089143.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643089143.git.riteshh@linux.ibm.com>
References: <cover.1643089143.git.riteshh@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TFrCSFaUSRdfl4WrvakNaFc-V0i2ry_P
X-Proofpoint-GUID: TFrCSFaUSRdfl4WrvakNaFc-V0i2ry_P
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-25_01,2022-01-24_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 mlxlogscore=994 bulkscore=0 adultscore=0
 clxscore=1015 phishscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201250040
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

It seems this test creates a crafted corrupted image by modifying ext4
extent block structure of an inode to test some ext4 extent consistency
fixes done at [1].
This IMO, should not be in auto and quick group, since it could cause BUG_ON()
and happens only with some crafted corrupted image (or with fault injection
testing with errors=continue mount option).

[1]: https://lore.kernel.org/all/20210908120850.4012324-1-yi.zhang@huawei.com/
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 tests/ext4/054 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/054 b/tests/ext4/054
index 9a11719f..21fa4e0a 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -12,7 +12,7 @@
 #    ext4_valid_extent_entries())

 . ./common/preamble
-_begin_fstest auto quick dangerous_fuzzers
+_begin_fstest dangerous_fuzzers

 # Import common functions
 . ./common/filter
--
2.31.1

