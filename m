Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4B72CEC6B
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 11:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbgLDKot (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 05:44:49 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43082 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgLDKot (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 05:44:49 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4AfMYA147786;
        Fri, 4 Dec 2020 05:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=t3lpdktLszahEPOyPi1W7he2+t/pAe+LHzZ8EKQszio=;
 b=fPO21vty1aAn9UWRlGcTGP3D94DABfjjwtuA/JhrAbm7+FzYHYemCnzQV6y3jSy/vJHb
 B/uuL0L7LYhdpkw3v5wr9JBwcH7QeGVkB/LuGqgy2J9xuC+pnZpZb60y8U/iDe9h8yp/
 XckRvQQgGqVEQZsyKmc7WhiPFfmOPu/5rkixKQSPRpDPj4wf9sJ6N9AYJ1jNH/YllQ3k
 yWe9rqNfMqH5+2s/G3cSdpR7Zc8YAg4aTxgslkbcfmdkJsCyIjrMYNCBGUQF9chhhqb2
 noUdF86ZwToe/YoMlAnXqxZZusCSudMPdCWyFe4cpY+uoFsYGYhBIlsJyl+38eEDZJTl ZA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3577431emt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 05:44:05 -0500
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B4AEMAF178196;
        Fri, 4 Dec 2020 05:44:03 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3577431ekx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 05:44:03 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B4AVvov003467;
        Fri, 4 Dec 2020 10:44:02 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 35693xj5q8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 10:44:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B4AhxHb9437788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 10:43:59 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 993F7A404D;
        Fri,  4 Dec 2020 10:43:59 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0CA72A4040;
        Fri,  4 Dec 2020 10:43:58 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.46.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Dec 2020 10:43:57 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-ext4@vger.kernel.org, anju@linux.vnet.ibm.com,
        Eryu Guan <eguan@redhat.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 1/2] check: source common/rc again if TEST_DEV was recreated
Date:   Fri,  4 Dec 2020 16:13:53 +0530
Message-Id: <41edde3b32602dbbad028eec4568875427987cea.1607078368.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1607078368.git.riteshh@linux.ibm.com>
References: <cover.1607078368.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_03:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=950 spamscore=0
 priorityscore=1501 mlxscore=0 suspectscore=1 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040057
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eryu Guan <eguan@redhat.com>

If TEST_DEV is recreated by check, FSTYP derived from TEST_DEV
previously could be changed too and might not reflect the reality.
So source common/rc again with correct FSTYP to get fs-specific
configs, e.g. common/xfs.

For example, using this config-section config file, and run section
ext4 first then xfs, you can see:

our local _scratch_mkfs routine ...
./common/rc: line 825: _scratch_mkfs_xfs: command not found
check: failed to mkfs $SCRATCH_DEV using specified options

local.config:
[default]
RECREATE_TEST_DEV=true
TEST_DEV=/dev/sda5
SCRATCH_DEV=/dev/sda6
TEST_DIR=/mnt/test
SCRATCH_MNT=/mnt/scratch

[ext4]
MKFS_OPTIONS="-b 4096"
FSTYP=ext4

[xfs]
FSTYP=xfs
MKFS_OPTIONS="-f -b size=4k"

Tested-by: Ritesh Harjani <riteshh@linux.ibm.com>
Signed-off-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 check | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/check b/check
index 83f6fc8bdf3e..c6ad1d6c0733 100755
--- a/check
+++ b/check
@@ -630,6 +630,10 @@ function run_section()
 			status=1
 			exit
 		fi
+		# TEST_DEV has been recreated, previous FSTYP derived from
+		# TEST_DEV could be changed, source common/rc again with
+		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
+		. common/rc
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
-- 
2.26.2

