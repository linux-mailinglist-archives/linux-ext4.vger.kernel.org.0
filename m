Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D89F3A5D2F
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhFNGaz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17954 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232516AbhFNGaw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:52 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E63YB0179176;
        Mon, 14 Jun 2021 02:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=x6NbGgHgj1ossGyOem7RBPDReF0JPijJ2u+vwpE04U8=;
 b=O7RRK2dxh7JA3+gPYOYFKp6zAUfPVVixGnwMS96iV6Dc3OyjzEMI37zH3WAefGhhXW56
 s8+ev43hthWJNTRazFDjQOlJGRzC+ok7Y/h8hJ9Qw7zw7Htmg7qrfWKMLnwhCTJpnsm0
 K9xewsLlWBJ1wGDuZgGiEOCWiR4bOsaGm3OhhTG72Lz8hfc3VKwXbt8OgG4nNotB2Ac4
 IaekDZSOlZeqXwaOcRElxdBijdJ536G92KraUI3VC03WInXAuxOfz3SBlehxmHpFqE+H
 zBH7KuYlyVbZe7vsEbA1fKf3HiSAbCq1irtjKAbyy5OY4Ep/ZL7IBUhQNDeXtRJpJElw pg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395yxg2gfm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:49 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6OGlZ019526;
        Mon, 14 Jun 2021 06:28:48 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 394mj8rr66-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:47 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6SjJD33489218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:28:45 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2A05042047;
        Mon, 14 Jun 2021 06:28:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBD2A4203F;
        Mon, 14 Jun 2021 06:28:44 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:44 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 9/9] common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize
Date:   Mon, 14 Jun 2021 11:58:13 +0530
Message-Id: <f23e6788b958849ec9c1fb7fed0081e58c02a13a.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2lmcz6TvJeQX6-bz6pl5rn7s_Ab7uN8T
X-Proofpoint-GUID: 2lmcz6TvJeQX6-bz6pl5rn7s_Ab7uN8T
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 mlxlogscore=817 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test generic/020 fails for ext4 with 64K blocksize. So increase some overhead
value to reduce the MAX_ATTRS so that it can accomodate for 64K blocksize.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/attr | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/attr b/common/attr
index d3902346..e8661d80 100644
--- a/common/attr
+++ b/common/attr
@@ -260,7 +260,7 @@ xfs|udf|pvfs2|9p|ceph|nfs)
 	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
 	# user.attribute_XXX="value.XXX" is about 32 bytes; leave some overhead
-	let MAX_ATTRS=$BLOCK_SIZE/40
+	let MAX_ATTRS=$BLOCK_SIZE/48
 esac
 
 export MAX_ATTRS
-- 
2.31.1

