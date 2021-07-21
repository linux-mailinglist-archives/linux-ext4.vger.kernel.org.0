Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB143D0843
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbhGUEsL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:48:11 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:54004 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232468AbhGUErr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:47 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L5PhS4074824;
        Wed, 21 Jul 2021 01:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=fvM/PnRjCvDKCI6UBB2Ggn5mKmT6PMY9L8YjfIE0Nis=;
 b=Pvx7zDSIi4p/Wsc29ilBMv7RlE5Hhbzxx8QlhXhf2jwAk35JKzLSlJWlyzcXRUSE2CB8
 15xfkt120kUgh5iowz8Iuo+1y5jLcrvC1U77mH3+QBF/5+cD+nc8Sv3KuT3YZNBERgIg
 o048TPKpi/7oKfQGobiG3ajRPtWwMENFU8MtjQ3e9o/FJXo+GyPmT4zKEcmJoTxu9Vft
 DypqrzcI7LV0SdFTdtHYIfMQZZZQ2zeKhQvgCTT9b9JkEgprjYU2RtUNvPtntQBZHoV4
 worO3XbO5lr5vxgYknUSZFTQIi8lR2BKi4++QIXUcNdsCfzVsIi0FRev7FpS1imbAlcv Xw== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39xde4r0yn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:22 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DhhQ015359;
        Wed, 21 Jul 2021 05:28:20 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 39vng71a4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5SIcG16777626
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:28:18 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1350FAE045;
        Wed, 21 Jul 2021 05:28:18 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8980DAE051;
        Wed, 21 Jul 2021 05:28:17 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:17 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 8/9] common/attr: Cleanup end of line whitespaces issues
Date:   Wed, 21 Jul 2021 10:58:01 +0530
Message-Id: <a9607860977613e107f015891411599ffe69cdd4.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S5uGauHQG8QBSO9FfVLSRDstWdJAXgMG
X-Proofpoint-GUID: S5uGauHQG8QBSO9FfVLSRDstWdJAXgMG
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch clears the end of line whitespace issues in this file.
Mostly since many kernel developers also keep this editor config to clear
any end of line whitespaces on file save.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/attr | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/common/attr b/common/attr
index 42ceab92..d3902346 100644
--- a/common/attr
+++ b/common/attr
@@ -59,10 +59,10 @@ _acl_setup_ids()
         j=1
         for(i=1; i<1000000 && j<=3;i++){
           if (! (i in ids)) {
-	     printf "acl%d=%d;", j, i;		 
+	     printf "acl%d=%d;", j, i;
 	     j++
           }
-        }	
+        }
       }'`
 }
 
@@ -101,7 +101,7 @@ _getfacl_filter_id()
 _acl_ls()
 {
     _ls_l -n $* | awk '{ print $1, $3, $4, $NF }' | _acl_filter_id
-} 
+}
 
 # create an ACL with n ACEs in it
 #
@@ -128,7 +128,7 @@ _filter_aces()
 	BEGIN {
 	    FS=":"
 	    while ( getline <tmpfile > 0 ) {
-		idlist[$1] = $3 
+		idlist[$1] = $3
 	    }
 	}
 	/^user/ { if ($2 in idlist) sub($2, idlist[$2]); print; next}
@@ -180,17 +180,17 @@ _require_attrs()
 {
 	local args
 	local nsp
-	
+
 	if [ $# -eq 0 ]; then
 		args="user"
 	else
 	  	args="$*"
 	fi
-	
+
 	[ -n "$ATTR_PROG" ] || _notrun "attr command not found"
 	[ -n "$GETFATTR_PROG" ] || _notrun "getfattr command not found"
 	[ -n "$SETFATTR_PROG" ] || _notrun "setfattr command not found"
-	
+
 	for nsp in $args; do
 		#
 		# Test if chacl is able to write an attribute on the target
@@ -204,14 +204,14 @@ _require_attrs()
 		touch $TEST_DIR/syscalltest
 		$SETFATTR_PROG -n "$nsp.xfstests" -v "attr" $TEST_DIR/syscalltest > $TEST_DIR/syscalltest.out 2>&1
 		cat $TEST_DIR/syscalltest.out >> $seqres.full
-		
+
 		if grep -q 'Function not implemented' $TEST_DIR/syscalltest.out; then
 			_notrun "kernel does not support attrs"
 		fi
 		if grep -q 'Operation not supported' $TEST_DIR/syscalltest.out; then
 			_notrun "attr namespace $nsp not supported by this filesystem type: $FSTYP"
 		fi
-		
+
 		rm -f $TEST_DIR/syscalltest.out
 	done
 }
-- 
2.31.1

