Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC62E7DE4B0
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Nov 2023 17:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjKAQi1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Nov 2023 12:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjKAQi0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Nov 2023 12:38:26 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8BFD;
        Wed,  1 Nov 2023 09:38:23 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FwpPm018971;
        Wed, 1 Nov 2023 16:38:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=bqzZF6Y8RSQ9fIQ5rXf87/CsDE5jJQpEoTdC3OaGO0U=;
 b=SWKbuU+Jv6OgQZKFCJUtuCMnZCxj8dgHwwBA6MeC0Quq/AG/n2F7JPw3/zHqxEe3xrOE
 YE/mZ/zBb6p4ZNLI0f8g4ovRSzIy5l5+jZpplhE82Y6+vPNA0l2QoiydNmf8gWbjc7sI
 vyVqPgpFSbmy28YkRS+kTaXIn7G8FfuwBLjDkaRTkKQkiQxjQOVyhYnrqDRdmD726fTg
 jeQCIbIfE+kIT6GQurZatwqlH6b5Th1AN/JKmQMRh9YeK8Lts6ILA2lT+J7pOWF6Dp7H
 y/5qAXZ5fphTNhskD4keGvMULWRFkPfitdeePUzmQwi/mvSl6JsgBBTjilYhKyr3k0Dk eQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk418wn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:19 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3A1GTdZs011672;
        Wed, 1 Nov 2023 16:38:18 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u3sk418w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:18 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1FhToB020321;
        Wed, 1 Nov 2023 16:38:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3u1d0yrxmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Nov 2023 16:38:17 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3A1GcFk638404746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 16:38:16 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D340B20043;
        Wed,  1 Nov 2023 16:38:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F80220040;
        Wed,  1 Nov 2023 16:38:14 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.9.163])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  1 Nov 2023 16:38:14 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v2 0/2] Document handing of unwritten bh in ext4_block_zero_page_range()
Date:   Wed,  1 Nov 2023 22:08:09 +0530
Message-Id: <cover.1698856309.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: suN64p_AwKzoTaWsCCF2QtP4gC8wGVXV
X-Proofpoint-GUID: Xi_vsV5XsktoosfggeVP1s2DI3yTzQu-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-01_15,2023-11-01_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2311010131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

** Changes v1 -> v2 **

* Instead of exiting early in ext4_block_zero_page_range() for unwrit
  bhs like in v1, lets let the current logic be as it is and instead
  document the handing of unwritten buffer heads to make the intent
  clear

v1:
https://lore.kernel.org/linux-ext4/20231019165546.norapdphdyx7g3ob@quack3/T/#mbd0ab69d55487493edbd465b3882051e5bc2365d

** Original Cover Letter **

As per discussion with Jan here [1], this patchset intends to exit early
from __ext4_block_zero_page_range() incase the block we are about to
zero (partially) is unwritten and unmapped, since such a block doesn't
require zeroing.

Further, also make sure that calls to ext4_zero_partial_blocks()
truncate the page cache completely beforehand, so that they don't rely
on ext4_zero_partial_block() -> __ext4_block_zero_page_range() to zero
out non block aligned edges of pagecache.

Reviews and comments are appreciated!

Regards,
ojaswin

[1]
https://lore.kernel.org/linux-ext4/20230914141920.lw2nlpzhcxwuz2y6@quack3/

Ojaswin Mujoo (2):
  ext4: treat end of range as exclusive in ext4_zero_range()
  ext4: Clarify handling of unwritten bh in
    __ext4_block_zero_page_range()

 fs/ext4/extents.c | 6 ++++--
 fs/ext4/inode.c   | 6 ++++++
 2 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.39.3

