Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2BDC3AC9ED
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jun 2021 13:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbhFRLdy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 18 Jun 2021 07:33:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18354 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232090AbhFRLdx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 18 Jun 2021 07:33:53 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15IB3qaE108345;
        Fri, 18 Jun 2021 07:31:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Z5pV4U5jcmPzNryHW53l24ZHOhZpaChlG5/QJvukUp0=;
 b=MWcYsLBAeio+C7whojKMHEw3PfP8mq96mc/8BeQ7zQMYlC3HHHIO7q38i47iD9hng0Ju
 dB467/nFOpaJ+ubxo49tlPodZ3fGnBjTnXR1pt2zu89zcq3q2GhSxL2Gklf/QbU1YtXa
 uX7VQROqfeG1W7sbTE4neYeJ/9HOLrMHlgOcaMzkxIcgaHxMUmcP76WtBALhXpxgwC+G
 XxRRMw+/XJeYwVsMV6l/uaFW7pf6ppG6RhqSrKbZZ1qucyqPHO38rK/7TwYrezWiThSW
 U29UK48iBEBVqY6HSTovCQhiDAo+dpHEQ2J8vaVh/LRKIdyXoyIsgDRYmdkNwIQ9mhfq Jg== 
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 398sk7sxt1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 07:31:42 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15IB9SXW010974;
        Fri, 18 Jun 2021 11:10:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 394mj8ht7j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Jun 2021 11:10:23 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15IB9Atb32833926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Jun 2021 11:09:10 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AC3B6AE051;
        Fri, 18 Jun 2021 11:10:21 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 56AABAE045;
        Fri, 18 Jun 2021 11:10:21 +0000 (GMT)
Received: from localhost (unknown [9.85.68.238])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Jun 2021 11:10:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 9/9] xfstests-packages: Add some more packages.
Date:   Fri, 18 Jun 2021 16:40:00 +0530
Message-Id: <553d8fb3aea3ceb46bbc95adf2fd69e7c8045024.1624007533.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624007533.git.riteshh@linux.ibm.com>
References: <cover.1624007533.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CtTL84WbcIdcMQeQr4aF7H7V34-lxaC1
X-Proofpoint-ORIG-GUID: CtTL84WbcIdcMQeQr4aF7H7V34-lxaC1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-18_04:2021-06-18,2021-06-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106180064
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

libnuma-dev is required otherwise fio complaints and failes to start
(seen on ppc64el)
ndctl is required for creating pmem namespaces.
remaining are good to have packages in case if any editing is required
when debugging/accessing shell using telnet.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 kvm-xfstests/test-appliance/xfstests-packages | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kvm-xfstests/test-appliance/xfstests-packages b/kvm-xfstests/test-appliance/xfstests-packages
index 77dc2a8..85ca6a6 100644
--- a/kvm-xfstests/test-appliance/xfstests-packages
+++ b/kvm-xfstests/test-appliance/xfstests-packages
@@ -53,3 +53,7 @@ udftools
 uuid-runtime
 udev
 xz-utils
+libnuma-dev
+ndctl
+git
+vim
--
2.31.1

