Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDEFA792450
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Sep 2023 17:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjIEP6p (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Sep 2023 11:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354364AbjIELBR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Sep 2023 07:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71381AB;
        Tue,  5 Sep 2023 04:01:13 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 385Ad8lr009106;
        Tue, 5 Sep 2023 11:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=9toUWMnBTPzr30H7hB+mEnlmhwveyOLT5sLs6DzuLeo=;
 b=T+UhntOhkUzkiYjpA8VSB699dd+/A36IfnRgrXS8qbXQOdEO3u5jXIgrI5YcEDQ8DVNC
 5kazg3qlfXyRjU/WcyWp/lobqb7o0wL5Mv4CAhYqGaNkLyjSq20bzn+mScZG6M4Vhep+
 38eFcRFSr30XMEnPwytxJrdPcOZ3Sd2UL0DJ+gWYdfEGfyRYlYkup0Lf9YgS7nl9JbEb
 vL6dTMOde2BmVOpldBHaG0kAugvp373GEQiVALRxBWNC8aClI2CZQUTFMSz++0ScUQdm
 jAh487VUtkmjqOH3UaklK7raPubef5YTrTpcNPGvXXCLfIEP4ZAISsTMcqyMat+h2PMJ ag== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sx0aqvh3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 11:01:09 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38596Psw001615;
        Tue, 5 Sep 2023 11:01:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svfcsjbn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Sep 2023 11:01:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 385B163s23265792
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 5 Sep 2023 11:01:06 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A96F20040;
        Tue,  5 Sep 2023 11:01:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41FD720043;
        Tue,  5 Sep 2023 11:01:05 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  5 Sep 2023 11:01:05 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [RFC 0/1] ext4: Replace linear search with array of lists in CR_GOAL_LEN_SLOW
Date:   Tue,  5 Sep 2023 16:31:03 +0530
Message-Id: <cover.1693911548.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: L--kFvG2LdAobeduF2Rmo56y8h3q0heM
X-Proofpoint-ORIG-GUID: L--kFvG2LdAobeduF2Rmo56y8h3q0heM
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-05_08,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309050094
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello all!

This patch changes the linear searching in CR_GOAL_LEN_SLOW to use an array of
lists based on the order of requested length. The list array itself holds one
list for each possible order of free blocks in a block group.

While running some performance tests on my setup, I noticed that although the
groups we were considering before finding a good group in CR_GOAL_LEN_SLOW did
improve however there was not much improvement (or regression) in performance
as such, which I believe could be partly because my test disk was not
big enough to highlight the issues of linear traversal in
CR_GOAL_LEN_SLOW.  Unfortunately, I currently don't have a disk that
might be big enough for this however I think theoretically we should see
improvement when we have a very large disk and most of the BGs are near
full. Suggestions on alternate ways to test this or help in getting some
performance numbers is welcome.

That being said, I do believe that other than performance, having such a design
in CR_GOAL_LEN_SLOW is beneficial because:

1. We'll be able to select a BG whose free block order matches our goal length
and hence we won't be filling up bigger holes for small requests. This can
improve fragmentation in the longer run.

2. We'll have more control in what block groups we want to allocate from,
making CR_GOAL_LEN_SLOW more flexible. For example, the ongoing discussions
around introducing new types of BGs marked w/ IOPS flag [1]  which we only want
to use for metadata allocation. With the current design of linear search, we'll
have to check for this flag everytime and skip the BG if we have a data
allocation.  However, with the proposed design, we can easily set up our
freelist to ignore IOPS BGs, which is much more inline with how that patch
handles other criterias.

Now, with this patch, we'll no longer look for BGs linearly and hence this has a
chance of increasing the spread of allocation however I think that shouldn't be
a problem since we still have the MB_DEFAULT_LINEAR_LIMIT for rotational devices
combined with Jan's (merged) patchset that fixed several issues related to
allocation spread [2].

This seems to pass quick xfstests and several iterations for the generic/269
test that stresses the mballoc code. However, there's still some todos in the
patchset eg more testing, refactoring code, bug hunting etc. I wanted to
get the RFC out to check what the community feels about this and for any
suggestions and ideas.

Thanks!

[1] https://lore.kernel.org/linux-ext4/OS3P286MB056789DF4EBAA7363A4346B5AF06A@OS3P286MB0567.JPNP286.PROD.OUTLOOK.COM/
[2] https://lore.kernel.org/all/20220908091301.147-1-jack@suse.cz/

Ojaswin Mujoo (1):
  ext4: Replace linear search with array of lists in CR_GOAL_LEN_SLOW

 fs/ext4/ext4.h    |  25 +++++++--
 fs/ext4/mballoc.c | 134 ++++++++++++++++++++++++++++++++++++++++++++--
 fs/ext4/mballoc.h |   5 ++
 3 files changed, 156 insertions(+), 8 deletions(-)

-- 
2.31.1

