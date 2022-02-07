Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E0C4AB8C5
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Feb 2022 11:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbiBGKd6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Feb 2022 05:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355431AbiBGKSg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Feb 2022 05:18:36 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD01C043188;
        Mon,  7 Feb 2022 02:18:31 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2177CVSc017264;
        Mon, 7 Feb 2022 08:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cHdBGum3ViKORuq1lsnz9xMyPvBGrxWN8z1Btb2lq4A=;
 b=kxsuJql3QhlcVEghccC7RYtyjSajLT4f1T01wvbDjagYJopC0sEkW9pyzsYJ8k6DR79n
 KTu639EUa6iDz/LzdPz4lUU6yR2TsFo+dQkB5LB0YMIH0mIFhao1sNanCnIGW9ktOgqZ
 y55iJSFiVzFcPpgz2PhsTomlSdSZaZnZUiXNja94XS7p+8DfeRWnpcNtb9gUVSyXcNGx
 pihJ/GV8nAUAt06o4Mx6RW5sLJd3uXuD1P4FjHJ85xZkBpQd7J+0cNuvwCoH4Ri+E4oo
 U8/ajyCnLbvhnEwoTw5bzdfkhjjEZ5b8JEVv8JPIUf7jEwTYAeeACLLIO6HMELpFECRR +Q== 
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e236edp2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 08:26:18 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2178E3IU014418;
        Mon, 7 Feb 2022 08:26:16 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3e1gv918sn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Feb 2022 08:26:16 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2178QAZq40370484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Feb 2022 08:26:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BD244A404D;
        Mon,  7 Feb 2022 08:26:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 349DDA4053;
        Mon,  7 Feb 2022 08:26:07 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.26.84])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Feb 2022 08:26:06 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Cc:     Ojaswin Mujoo <ojaswin@linux.ibm.com>, riteshh@linux.ibm.com
Subject: [PATCH 0/2] tests/ext4: Ensure resizes with sparse_super2 are handled correctly
Date:   Mon,  7 Feb 2022 13:55:32 +0530
Message-Id: <cover.1644217569.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cct_J2zfpV8jyUrNlZEIR73lUJLXeKec
X-Proofpoint-GUID: cct_J2zfpV8jyUrNlZEIR73lUJLXeKec
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-07_03,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 mlxlogscore=635 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202070053
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

Patch 1: Fix the src/ext4_resize.c script to return accurate error codes.
Patch 2: Add the ext4 test for checking resize functionality

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b1489186cc8391e0c1e342f9fbc3eedf6b944c61

Ojaswin Mujoo (2):
  src/ext4_resize.c: Refactor code and ensure accurate errno is returned
  ext4: Test to ensure resize with sparse_super2 is handled correctly

 src/ext4_resize.c  |  46 +++++++++++++-------
 tests/ext4/056     | 102 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   2 +
 3 files changed, 136 insertions(+), 14 deletions(-)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out

-- 
2.27.0

