Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7AB3D0846
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbhGUEsT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:48:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232514AbhGUErt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:49 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L53aE9142235;
        Wed, 21 Jul 2021 01:28:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MIGzUg9JFo2imBKW37FbdzMtksUozX5A4YinXYWXsSg=;
 b=X5G1VUZ3lq3oPFxFBqKB5K/4JC82accIuGA2fJmKqkFFS82UwI40DFVfSIAiFeDKJ0/c
 Xn7X1zSq7gskO5Cs80o3v9uGWRndBXtBsv6cnBxMfNupa3EaJW21sAyY6FQitiF5qBpx
 ICtFjnXyLPKqHulKoEMhRH8F5CVpoZzuHMymVD+OzF9mwsOguDbhYrFqTol3I4Gu0Tab
 wVijfsCudUWSw5r/qVYulavssQjerlhliwvh4IwmtvMxrEYmhxGXEOjEP6jDapAfAome
 ZRkunqxVTPQSoMnYz5rw0ehsFfS2ySkCk8ShOxN2p6LlfVw1z5cGx3FNoNWho5nZK+Sw 4A== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xan7bgmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:23 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5CvHC015122;
        Wed, 21 Jul 2021 05:28:22 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04ams.nl.ibm.com with ESMTP id 39upu89p3d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:22 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5SJXZ33554818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:19 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 97C4DAE053;
        Wed, 21 Jul 2021 05:28:19 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 38352AE04D;
        Wed, 21 Jul 2021 05:28:19 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:19 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 9/9] common/attr: Reduce MAX_ATTRS to leave some overhead for 64K blocksize
Date:   Wed, 21 Jul 2021 10:58:02 +0530
Message-Id: <1109c811f550f918b8ea8bbe49323f32653b488f.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: kl6FvUNOrJnZcLyfwBmFo09GcJNl4VN2
X-Proofpoint-GUID: kl6FvUNOrJnZcLyfwBmFo09GcJNl4VN2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Test generic/020 fails for ext4 with 64K blocksize.
This adds changes in common/attr for MAX_ATTRS calculations for
ext2|ext3|ext4 along with comments explaining the calculations.

Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/attr | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/common/attr b/common/attr
index d3902346..35682d7c 100644
--- a/common/attr
+++ b/common/attr
@@ -256,6 +256,45 @@ case "$FSTYP" in
 xfs|udf|pvfs2|9p|ceph|nfs)
 	MAX_ATTRS=1000
 	;;
+ext2|ext3|ext4)
+	# For 4k blocksizes, most of the attributes have an attr_name of
+	# "attribute_NN" which is 12, and "value_NN" which is 8.
+	# But for larger block sizes, we start having extended attributes of the
+	# form "attribute_NNN" or "attribute_NNNN", and "value_NNN" and
+	# "value_NNNN", which causes the round(len(..), 4) to jump up by 4
+	# bytes.  So round_up(len(attr_name, 4)) becomes 16 instead of 12, and
+	# round_up(len(value, 4)) becomes 12 instead of 8.
+	#
+	# For 64K blocksize the calculation becomes
+	# 	max_attrs = (block_size - 32) / (16 + 12 + 16)
+	# or
+	# 	max_attrs = (block_size - 32) / 44
+	#
+	# For 4K blocksize:-
+	# 	max_attrs = (block_size - 32) / (16 + 8 + 12)
+	# or
+	# 	max_attrs = (block_size - 32) / 36
+	#
+	# Note (for 4K bs) above are exact calculations for attrs of type
+	# attribute_NN with values of type value_NN.
+	# With above calculations, for 4k blocksize max_attrs becomes 112.
+	# This means we can have few attrs of type attribute_NNN with values of
+	# type value_NNN. To avoid/handle this we need to add extra 4 bytes of
+	# headroom.
+	#
+	# So for 4K, the calculations becomes:-
+	# 	max_attrs = (block_size - 32) / (16 + 8 + 12 + 4)
+	# or
+	# 	max_attrs = (block_size - 32) / 40
+	#
+	# Assume max ~1 block of attrs
+	BLOCK_SIZE=`_get_block_size $TEST_DIR`
+	if [ $BLOCK_SIZE -le 4096 ]; then
+		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 8 + 12 + 4)))
+	else
+		let MAX_ATTRS=$((($BLOCK_SIZE - 32) / (16 + 12 + 16 )))
+	fi
+	;;
 *)
 	# Assume max ~1 block of attrs
 	BLOCK_SIZE=`_get_block_size $TEST_DIR`
-- 
2.31.1

