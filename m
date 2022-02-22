Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D14C0073
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Feb 2022 18:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiBVRvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 22 Feb 2022 12:51:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbiBVRva (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 22 Feb 2022 12:51:30 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A9116FDC7;
        Tue, 22 Feb 2022 09:51:04 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MHJu0g027294;
        Tue, 22 Feb 2022 17:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=j2lxBEKXj31SxcbAozEFxIXgEqDLIsmOwAI5PHFvBrQ=;
 b=fvKCKcqs5IFtnrqKI28DD8O2HVNIZfrW2gsV8VOS1OQZ4ntWJsMNjvZuO2o2gMRMo1JO
 AYgcgVRGXr5o828YGBYtRyOQfjncAWUZmPFpqV8nLp3dAhrpDuhvpRUJq6onk1zv7lJh
 1GUTj+9v0yZmYtIeqVorl6uc9CNvt8yWghAKrJH7fUsTUtFl3xVtSsaD5yygFE7P72rH
 1vFyvw/054c9SLO0qsnG70vJG+kK2UAIn29x0RhFUf2qAMK3/dDF5YBky+IhbqjsJVFN
 CzGjxo+hI76d98LInpjwBwjxuuylgJ4ocwihVazB+/LVinoRWvpN1ai1lI4HitGWCMS0 jQ== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3ed1ctp0fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:03 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 21MHlOeF024753;
        Tue, 22 Feb 2022 17:51:02 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3eaqtj4xky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:51:01 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 21MHowjf9765136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Feb 2022 17:50:58 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8ABB0A404D;
        Tue, 22 Feb 2022 17:50:58 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3FDA2A4051;
        Tue, 22 Feb 2022 17:50:57 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.41.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 22 Feb 2022 17:50:56 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     riteshh@linux.ibm.com
Subject: [PATCH v2 0/2] tests/ext4: Ensure resizes with sparse_super2 are handled correctly
Date:   Tue, 22 Feb 2022 23:20:51 +0530
Message-Id: <cover.1645549521.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LVVQGbPP0LaQ4kADcsZwuNRpcgxm10Q_
X-Proofpoint-GUID: LVVQGbPP0LaQ4kADcsZwuNRpcgxm10Q_
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0 mlxlogscore=570
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202220107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As detailed in the patch [1], kernel currently does not support resizes
with sparse_super2 enabled.  Before the above patch, if we used the
EXT4_IOC_RESIZE_FS ioctl directly, wiht sparse_super2 enabled, the
kernel used to still try the resize and ultimatley leave the fs in an
inconsistent state. This also led to corruption and kernel BUGs.

This patchset adds a test for ext4 to ensure that the kernel handles
resizes with sparse_super2 correctly, and returns -EOPNOTSUPP. 

Summary:

  Patch 1: Fix the src/ext4_resize.c script to return accurate error
           codes.
  Patch 2: Add the ext4 test for checking resize functionality

Changes since v1 [2]

  *  In patch 2, don't iterate if the expected errno is returned
  *  Code cleanup and additional comments for clarity (also see extra
     note in patch 2)
  *  No changes in patch 1

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1489186cc8391e0c1e342f9fbc3eedf6b944c61
[2] https://lore.kernel.org/fstests/cover.1644217569.git.ojaswin@linux.ibm.com/ 

Ojaswin Mujoo (2):
  src/ext4_resize.c: Refactor code and ensure accurate errno is returned
  ext4: Test to ensure resize with sparse_super2 is handled correctly

 src/ext4_resize.c  |  46 +++++++++++++------
 tests/ext4/056     | 108 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 3 files changed, 142 insertions(+), 14 deletions(-)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

-- 
2.27.0

