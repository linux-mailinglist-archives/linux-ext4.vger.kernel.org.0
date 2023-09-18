Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995F27A477B
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 12:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIRKq7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 06:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbjIRKqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 06:46:33 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE84912B;
        Mon, 18 Sep 2023 03:46:18 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38IAcoZ7007476;
        Mon, 18 Sep 2023 10:46:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=EnkuqitaEsDx6F2PWuWg4aVXw867xWMsb6IqA+jY56g=;
 b=RACqG/lQ3xfgn2vQZA7tcdBTIIl8HfA56q4Qc2PWcckNGNJMmrGZusmsPNaoR1HLe9kY
 LUtbSQDjX+v+e541vKw6h0PkhMxqnmfUx1e4gKZYiyfRWlvLnameGeMMj/Et5ntuQouX
 RADnWZjXrroFlWhnsx8nvASH2KhtPlMk0Cvob5ysDcce+Ct6Uf2z4LGPHrx2UQ0PcETu
 SzoS6/FFsCt42+o82hd2oEfLRPtixD4sZuph4DMJqfE6jjbAnqRT2NuSoehhRReSLpfj
 hzhiy/gjRK/lKYupdSzglDTozf0AgViniEhDbh7FuUIRb0aSTH+eVEZ4EJZfmntWe9d2 Gw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6m9792k8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:14 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38IAcqkA007605;
        Mon, 18 Sep 2023 10:46:14 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3t6m9792k3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:14 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38I9QMX4005855;
        Mon, 18 Sep 2023 10:46:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3t5q2ya5bw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Sep 2023 10:46:13 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38IAkBEq47382894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Sep 2023 10:46:11 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 47ACB20043;
        Mon, 18 Sep 2023 10:46:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD8DE20040;
        Mon, 18 Sep 2023 10:46:01 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com.com (unknown [9.43.103.37])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 18 Sep 2023 10:46:01 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <ritesh.list@gmail.com>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: [PATCH v3 0/1] ext4: Fix stale data exposure caused with dioread_nolock 
Date:   Mon, 18 Sep 2023 16:15:49 +0530
Message-Id: <cover.1695033645.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CCs8I4O6ifYBtWpGz1_1Pdiv9M5enzT_
X-Proofpoint-ORIG-GUID: RkC-Y-EC35W5EHG2ZHPYlJwp3A05VMEE
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-18_02,2023-09-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0
 mlxlogscore=830 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309180092
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

** Changes in v3 ** 

- Removed accidental "---" separator in commit message.
- Picked up Jan's Reviewed by.
- v2:
  https://lore.kernel.org/linux-ext4/cover.1694860198.git.ojaswin@linux.ibm.com/

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

