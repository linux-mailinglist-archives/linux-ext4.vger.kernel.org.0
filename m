Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB137B3452
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Sep 2023 16:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjI2OLA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 29 Sep 2023 10:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjI2OLA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 29 Sep 2023 10:11:00 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF41D1A8;
        Fri, 29 Sep 2023 07:10:58 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38TDePMj013370;
        Fri, 29 Sep 2023 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=UlyjKVqSNheBUUaPtMe4WybDN6izUixlaSlH1n/sPCQ=;
 b=VZplf/e64Nsg8SHaL3YsPJkNjF4y1x+E9Qe2Ny5PkEUDUk5rVuBvfYuc4iQPkn8lnLuc
 ewmBS3sNXf9yIgBI4BqoB8obOblsF3cOkwL53XBok3ecAsl8FgvqOI1J3BGmkdHaeqjq
 jMBWkNtQM6SPzo4E0AgueWk7KMaDgk+lxlZtvI9i1jZIJLbCyMNYY/jHWWbB8SZLfxMi
 D4viDd55bPEjxlrFrwkeX7Au5+Xftq3jDM2F9XrF3qH+JESsRqrIhxe6ezGcuhAcWtVH
 p7NWoEejh4P5BHr3BkXv+avK8NRu7tG61m48c8C59W1kFAnOng8og8ZImsAbGc1vyUT3 Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxgpb873-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:53 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38TDf9K9017705;
        Fri, 29 Sep 2023 14:10:53 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tdxgpb85r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:53 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38TE34TW008399;
        Fri, 29 Sep 2023 14:10:51 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3taabtdfx6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 14:10:51 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38TEAof621562034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Sep 2023 14:10:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0620120043;
        Fri, 29 Sep 2023 14:10:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F6CB20040;
        Fri, 29 Sep 2023 14:10:48 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.84.228])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 29 Sep 2023 14:10:48 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH 0/3] Optimize __ext4_block_zero_page_range() for unwritten buffers
Date:   Fri, 29 Sep 2023 19:40:42 +0530
Message-Id: <cover.1695987265.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: n2iZnCLwg90Oo1SuT_ZbK4-AmGAFNeRk
X-Proofpoint-ORIG-GUID: 3pvBxqYj0MDNNakloeEavPHid3IGJ9a4
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 mlxlogscore=721 bulkscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290120
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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

Ojaswin Mujoo (3):
  ext4: treat end of range as exclusive in ext4_zero_range()
  ext4: truncate complete range in pagecache before calling
    ext4_zero_partial_blocks()
  ext4: Skip unwritten buffers in __ext4_block_zero_page_range()

 fs/ext4/extents.c | 20 +++++++++++++-------
 fs/ext4/inode.c   |  7 +++++--
 2 files changed, 18 insertions(+), 9 deletions(-)

-- 
2.39.3

