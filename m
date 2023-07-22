Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50DC75DDB7
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Jul 2023 19:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjGVRP6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Jul 2023 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVRP5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 22 Jul 2023 13:15:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6061E67;
        Sat, 22 Jul 2023 10:15:56 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36MH9nNi022276;
        Sat, 22 Jul 2023 17:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=eXVHnjQ+t0+JDz3/G5CtPgtwlxm1XNAVCmaWksybvr4=;
 b=kgH2kSbpfkSn1mgj3MZVOOwpxiM5AuJVwlg2fNeUi4EAti2F6NXRIv+eT+0HXaoTC0sH
 THBbTeIbklZkyzaflmIlgURa0nb1zsyq/X8xjyyphn+yNEnOupFYcRjHuElBXZ06uVXP
 IlKYgJoG92q056woQ1Yo6lVjZr+zOjDCWEOldDDU76l4JkhOcN2LGSed1HFQxbv/phev
 21SZr3xCVviQpYHuXi092AKB3A8y2dPkZ6J/lO4lB6w3zMJUufkBhtkfGdMjpsH08qTc
 yI05VQ2CtqNi7aRd8ifg17QC+qDsu5HxH197Zop8zqImegXy/v413pxPMlnno53XBzOR pg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0fhfu04j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 17:15:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36MGoWQv007605;
        Sat, 22 Jul 2023 17:15:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3rv80jx19q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 22 Jul 2023 17:15:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36MHFlUm21955290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 22 Jul 2023 17:15:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A4B1A2004E;
        Sat, 22 Jul 2023 17:15:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 432C92004B;
        Sat, 22 Jul 2023 17:15:35 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.0.4])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Sat, 22 Jul 2023 17:15:34 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [PATCH 0/1] ext4: Fix regression in mballoc due to deleted inode PAs in rbtree
Date:   Sat, 22 Jul 2023 22:45:23 +0530
Message-Id: <cover.1690045963.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7W_iCINthKmD23OgZ9LBdzOQUFTeyABX
X-Proofpoint-ORIG-GUID: 7W_iCINthKmD23OgZ9LBdzOQUFTeyABX
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-22_07,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 mlxlogscore=972 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2307220156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

Recently there was a regression found in the mballoc [1] due the existence
of deleted preallocations(PAs) in the per inode preallocation rbtree.
Such deleted PAs can occur because ext4_mb_discard_group_preallocations 
traverses the grp->bb_prealloc_list and marks the PAs as deleted without
taking any inode specific locks like i_data_sem. 

Due to presence of such PAs, we were sometimes missing some of the pa
entries when traversing the per node rbtree in ext4_mb_use_preallocated.
Due to this, in some rare conditions we ended up missing a PA that did
overlap with our original request start. when this happens, we exit 
ext4_mb_use_preallocated and proceed with the allocation. However,
during ext4_mb_normalize_request() we were hitting a bug on as
a PA that could satisfy our request already existed. Since normalize
request was already fixed earlier to account for the deleted PAs we
actually able to catch it there.

This patch aims to fix this regression by using a different appraoch to
traverse the rbtree in ext4_mb_use_preallocated(). More comments can be
found in the commit message.

We've run several overnight runs of xfstests generic/269 as well as
several hours of ltp test on both x86 machines with 4k blocks size and
Power machines with 64k and 4k block size and have yet to hit the
regression. Further we added some debug prints in our testing to make
sure we were correctly handling the conditions that were triggering the
bug ons previously.

[1]
https://lore.kernel.org/linux-ext4/CA+G9fYv2FRpLqBZf34ZinR8bU2_ZRAUOjKAD3+tKRFaEQHtt8Q@mail.gmail.com/

Regards,
ojaswin

Ojaswin Mujoo (1):
  ext4: Fix rbtree traversal bug in ext4_mb_use_preallocated

 fs/ext4/mballoc.c | 158 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 131 insertions(+), 27 deletions(-)

-- 
2.31.1

