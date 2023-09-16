Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5B7A2F4B
	for <lists+linux-ext4@lfdr.de>; Sat, 16 Sep 2023 12:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238371AbjIPKnO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 16 Sep 2023 06:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjIPKmp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 16 Sep 2023 06:42:45 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E7C7;
        Sat, 16 Sep 2023 03:42:40 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38GAd7iI030767;
        Sat, 16 Sep 2023 10:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Sg89+tXih0SrhpwCy/YeRQLuBMFVPIf1pS98QJWGnvQ=;
 b=GfkrsQu7DG3jjE1f7a/rxebuv0n4jEgBwg64s5V6lryL6bzPcIWFbFlF0wUvyYAui5I+
 F8NgyOTZXz323DaAa4ecfB5psCI7hSESSryay6q1ygjEmygkafjaiOGYGy67Ccjw6DXx
 E25fZjIUTmTK+hSAVFoEGUi17J9wQfOIU0Ad57PGldLZphQ6vwuqteLMfX153j+YPD0L
 ENJ+eUB1fLhIIbLMVZcAxWZT13s6ZGlfEkUOv1MkQQGHblCYVCc0I3NemNKGH/0t79dE
 ejbo77hKN3T4be1WtEoKBMeTSAF/tp+qFuGfSa/Hj8rGGAOh2hqAnSR73qSUrkhWbg8j 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t58b1adpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 10:42:30 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38GAfjiW006090;
        Sat, 16 Sep 2023 10:42:30 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t58b1adp5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 10:42:30 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38GADbQ8011974;
        Sat, 16 Sep 2023 10:42:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3t15r3167e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 16 Sep 2023 10:42:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38GAgRCV61473028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Sep 2023 10:42:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD83520040;
        Sat, 16 Sep 2023 10:42:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B69ED2004B;
        Sat, 16 Sep 2023 10:42:21 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.102.18])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 16 Sep 2023 10:42:21 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/1] ext4: Fix stale data exposure caused with dioread_nolock 
Date:   Sat, 16 Sep 2023 16:12:12 +0530
Message-Id: <cover.1694860198.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: bxDIf8gA5RbLCJEhZV0n3_ZI_t1k7YgW
X-Proofpoint-GUID: HTIv-RnJgcLpx4F4qYdE6vB4aPtXW703
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-15_20,2023-09-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 bulkscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0
 mlxlogscore=825 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309160091
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

** Changes in v2 ** 

- Moved the logic to mark buffer as new in ext4_get_block_unwritten, as
  it is actually specific to this function, rather than _ext4_get_block
  which is a more generic function called from codepaths that dont need
  this logic

- Tested with -g rw,quick as well as custom replication test (present in
  commit message). No issues with ps == bs as well as sub page size
  scenarios.

- TODO: Add logic in ext4_block_zero_page_range() to ignore zeroing if
  the buffer is unwritten. This needs some review of the involved code paths 
  hence sending the fix to stale data first right now and will get to
  this in a new patch.

- v1:
  https://lore.kernel.org/linux-ext4/cover.1693909504.git.ojaswin@linux.ibm.com/

** Original Cover **

The detailed report on the issues faced and the root cause can be found
in the commit message. I've intentionally added all the details to
commit message so that it can be tracked in the future, let me know if
its too long and I can try stripping some info.

For this particular fix, I've tested these patches with xfstests -g
quick with:

- 64k block size, 64k pagesize 
- 4k blocksize 64k pagesize
- both with and without nodelalloc 

and I don't see any regressions. I'll plan to run more tests on this and
report back if I notice anything. Suggestions or ideas are welcome.

Regards,
ojaswin

Ojaswin Mujoo (1):
  ext4: Mark buffer new if it is unwritten to avoid stale data exposure

 fs/ext4/inode.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

-- 
2.39.3

