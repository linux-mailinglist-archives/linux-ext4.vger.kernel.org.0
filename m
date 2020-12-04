Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36BE2CEC6A
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Dec 2020 11:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgLDKoo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Dec 2020 05:44:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728879AbgLDKoo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Dec 2020 05:44:44 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4AX9PD178189;
        Fri, 4 Dec 2020 05:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=pCRKxrdEPudlZWE0SFUYXt4kmE1sWCkFQWdVSSas4qE=;
 b=afEC/XsbC8Dg4Gjcq6q4jer9ljRY489Bht1DmrOb2DjyIBy//+o0LStQ6h8QN7hywWiI
 IVINCnnUDuDt0jyJUroc3TircBP1oimPGmDMwZ0mYEo0WYCW09meB3WdzO3cv8q4TxpP
 tWrge/00Q6xLnWXv+b26+wjToMn+sgZ6XT2Byi0m0s9C7FT2K326VcaEv2lesZQaL+l3
 oGrCdPcZuyGyufJa83TJbY19rD3qXYm6JB7VQm7S8lw4c7rOSVvYg0AI1iyRYrhZOI5P
 C9JtlnY5LAxDvwb4gwJqHlvnOtVbfCJ16pR5rhAoUE5J1madL/b0k+FnUQPKTWIJKqo8 Yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 357jbgj97d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 05:44:01 -0500
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B4AWdeL002743;
        Fri, 4 Dec 2020 10:43:59 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3573v9rq0b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Dec 2020 10:43:59 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B4Ahvvb11534742
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Dec 2020 10:43:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A2EB2A4040;
        Fri,  4 Dec 2020 10:43:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3B443A4051;
        Fri,  4 Dec 2020 10:43:56 +0000 (GMT)
Received: from riteshh-domain.ibmuc.com (unknown [9.199.46.245])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  4 Dec 2020 10:43:56 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, linux-ext4@vger.kernel.org, anju@linux.vnet.ibm.com,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 0/2] Section handling patch and huge sparse file generic/618
Date:   Fri,  4 Dec 2020 16:13:52 +0530
Message-Id: <cover.1607078368.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_03:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 mlxlogscore=649 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040063
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Patch-1 was suggested from Eryu. This does fixes the multiple section handling
issue which was discussed here [1]. Hence sending it for review and
inclusion in fstests.

Patch-2 - addressed the review comments from [2] w.r.t. ext4 MKFS_OPTIONS
for bs < 4k.

[1]: https://patchwork.kernel.org/project/fstests/cover/cover.1604000570.git.riteshh@linux.ibm.com/
[2]: https://patchwork.kernel.org/patch/11864921


Eryu Guan (1):
  check: source common/rc again if TEST_DEV was recreated

Ritesh Harjani (1):
  generic: Add test to check for mounting a huge sparse dm device

 check                 |  4 +++
 common/rc             | 10 +++++++
 tests/generic/618     | 70 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/618.out |  3 ++
 tests/generic/group   |  1 +
 5 files changed, 88 insertions(+)
 create mode 100755 tests/generic/618
 create mode 100644 tests/generic/618.out

--
2.26.2

