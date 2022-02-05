Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862CC4AA969
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 15:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380133AbiBEO3L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 09:29:11 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30500 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355500AbiBEO3I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 09:29:08 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215BejPY001920;
        Sat, 5 Feb 2022 14:29:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=cWcsGrwa77SjEU07/El4oV+OaTpJW/7qaW0ddzZqplQ=;
 b=fM69Pql7kA5n9Ajp3n61m+RmV97euexrHbaHwlfFFp8CEd8XiCjTSuUkiOqy8mr6rBbq
 fXiyp/gyhpn9CufJRK14ZxXpuo8H6g8K0h6GzqHShH6tItmPLy1Gls6eI5f3Uqgeucq4
 SqVxKN0Q1mQosW/Gjp2r4gVq9v+n5FQOuW+5CxKXsxQCAe0JTRu/qkC6HcmVDrQ2e2Zm
 xginrz2HfUNJDafrDirNim9dhQO9tcwlisWDWCMp9D+dFC97lc34kwav/O0abuYqKZGL
 aO9H5qEzt5OqPFZdjKXE5sNebAyvUlPBOXD81ZifXA9XNoOAh41i1Wn2zVeX93YPnPmV JA== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j8heysq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:08 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215ERb9f032527;
        Sat, 5 Feb 2022 14:29:06 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv8j7tx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:05 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215ET2F140042796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:29:02 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 705624C050;
        Sat,  5 Feb 2022 14:29:02 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 682114C052;
        Sat,  5 Feb 2022 14:29:00 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:28:59 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 0/4] fstests: ext4: Add fast_commit related tests
Date:   Sat,  5 Feb 2022 19:58:50 +0530
Message-Id: <cover.1644070604.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 1mJyDfEyO9vLK59yI13UzuD9g0wl-2W7
X-Proofpoint-ORIG-GUID: 1mJyDfEyO9vLK59yI13UzuD9g0wl-2W7
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=851 impostorscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series mainly aims at adding some of those test cases for testing
fast_commit. Kernel fix for Patch-1 is still under review [1].

RFC -> PATCHv1:
================
1. Patch-1 mostly remains the same.
2. Added ext4/057 & ext4/058 in the test bucket for fast_commit which are based
   on recent kernel fixes done by Xin Yin.

[RFC]: https://lore.kernel.org/all/b834b83720f61a6aaab11fe20c48b75007be0a46.1643642943.git.riteshh@linux.ibm.com/
[1]: https://lore.kernel.org/all/53596bdf7bd7aed66020db98d903b1653a1dbc7a.1644062450.git.riteshh@linux.ibm.com/

Ritesh Harjani (4):
  ext4/056: Add fast_commit regression test causing data abort exception
  common/punch: Add block_size argument to _filter_fiemap_**
  ext4/057: Add crash test to check unwritten extents tracking with fast_commit
  ext4/058: Add shutdown recovery test with fast_commit

 common/punch       |  12 +++---
 tests/ext4/056     | 101 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/056.out |   3 ++
 tests/ext4/057     |  62 ++++++++++++++++++++++++++++
 tests/ext4/057.out |   6 +++
 tests/ext4/058     |  66 +++++++++++++++++++++++++++++
 tests/ext4/058.out |   7 ++++
 7 files changed, 252 insertions(+), 5 deletions(-)
 create mode 100755 tests/ext4/056
 create mode 100644 tests/ext4/056.out
 create mode 100755 tests/ext4/057
 create mode 100644 tests/ext4/057.out
 create mode 100755 tests/ext4/058
 create mode 100644 tests/ext4/058.out

--
2.31.1

