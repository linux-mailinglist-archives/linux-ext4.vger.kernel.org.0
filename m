Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C230C3A5D25
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhFNGal (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232045AbhFNGal (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E64oUJ184515;
        Mon, 14 Jun 2021 02:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=usoL2QdZOsOz7ZeVheaPtGwaIp1iB/ikPyu3PaCoQtw=;
 b=KVyU4NB4aklY76GLIpoWIvfdJlmj/lWnD0WhJemVnvKpwrENv2yygIYwf2M8XGda1H/k
 Jxt/Opz+/cZKGnwfDrl62yz1TL3X5j4O0PlCQbiq4pT+7EzG07kirWK9hkPF2KjQbSmk
 AoxsMhwjkenUM7Pk1/yvjNVDi4N0QgkoiYpQn5lD9fBMwbzDLTEiCtrgqLXySmdMUR7+
 kfmi5KIPwCKMuXHcdtXpLYPumuIZKNSGP8o9D7k8qFjP5neZUbGt0GRuBmHKUVMxm0H5
 vD1WRarUirxg0Glkc3D2DxMUzBejjCpMtDNt+1Kai7Dxqt/U2qG5P8vnKHxcFypcx1ov YA== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3961b60the-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:39 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6MENj002021;
        Mon, 14 Jun 2021 06:28:37 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 394m6hrrbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:37 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6SXL131981826
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:34 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C383B42045;
        Mon, 14 Jun 2021 06:28:33 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C29E42047;
        Mon, 14 Jun 2021 06:28:33 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/9] 64K blocksize related fixes
Date:   Mon, 14 Jun 2021 11:58:04 +0530
Message-Id: <cover.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: G6uKqA3kGoiruFsTuR_uvBrOfcsDtGWk
X-Proofpoint-ORIG-GUID: G6uKqA3kGoiruFsTuR_uvBrOfcsDtGWk
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Below are the list of fixes mostly centered around 64K blocksize (on PPC64)
and with ext4 filesystem. Tested this with both 64K & 4K blocksize on Power
with (ext4/ext3/ext2/xfs/btrfs).

Ritesh Harjani (9):
  ext4/003: Fix this test on 64K platform for dax config
  ext4/027: Correct the right code of block and inode bitmap
  ext4/306: Add -b blocksize parameter too to avoid failure with DAX config
  ext4/022: exclude this test for dax config on 64KB pagesize platform
  generic/031: Fix the test case for 64k blocksize config
  gitignore: Add 031.out file to .gitignore
  generic/620: Remove -b blocksize option for ext4
  common/attr: Cleanup end of line whitespaces issues
  common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize

 .gitignore                                 |  1 +
 common/attr                                | 20 ++++++------
 tests/ext4/003                             |  3 +-
 tests/ext4/022                             |  7 ++--
 tests/ext4/027                             |  4 +--
 tests/ext4/306                             |  5 ++-
 tests/generic/031                          | 37 ++++++++++++++++++----
 tests/generic/031.out.64k                  | 19 +++++++++++
 tests/generic/{031.out => 031.out.default} |  0
 tests/generic/620                          |  7 ++++
 10 files changed, 80 insertions(+), 23 deletions(-)
 create mode 100644 tests/generic/031.out.64k
 rename tests/generic/{031.out => 031.out.default} (100%)

--
2.31.1

