Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1492E3A5D2E
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Jun 2021 08:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232520AbhFNGay (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 14 Jun 2021 02:30:54 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57900 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232512AbhFNGav (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 14 Jun 2021 02:30:51 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15E63gPL016034;
        Mon, 14 Jun 2021 02:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=kBthOWjidHOlZ+s5KNIFqHVBRElK/KDOD1tuQr6UhuM=;
 b=O2pYW/4SEx4ScKI+Aa0ytksUWwsEsD/iBTFkZFrYWuT9QL5Kzo/QyChwZ/tjoOTuMuy6
 A2iebkQaH9NrfJaOowcCtb7dXnbeo6fbT6QGKEatDyrqT8ZhWQ2aO1ZFkRMaf9YFh6FF
 AbStMg2EXTcLAchEN2IMuJjJAuE6R/zoeC5XD8vYBLbxcu0QR1ZOO3zeRzJmn3HbxoNI
 V/s2sRiLywVYKT9X4r49zxfI36EP1sKCxXvZUdze1TsYnWYOsXiK4uK3XO7IG3AgvrwN
 go91uJ5/1qMJUXJVTvjTpeHhG0RifBmpclxZLvbZDEWQbwK15uyT6lXjQJyKlwRy1pzo iw== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 395xnqmaxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 02:28:49 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 15E6P12A032677;
        Mon, 14 Jun 2021 06:28:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04ams.nl.ibm.com with ESMTP id 394mj8rr5n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 14 Jun 2021 06:28:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 15E6Rg2V37159312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 14 Jun 2021 06:27:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E04124203F;
        Mon, 14 Jun 2021 06:28:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87B6142045;
        Mon, 14 Jun 2021 06:28:43 +0000 (GMT)
Received: from localhost (unknown [9.85.68.28])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 14 Jun 2021 06:28:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH 8/9] common/attr: Cleanup end of line whitespaces issues
Date:   Mon, 14 Jun 2021 11:58:12 +0530
Message-Id: <9c2d87969d29f34e0939fa3a524886e343fb96bb.1623651783.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623651783.git.riteshh@linux.ibm.com>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a6AhQAk1CrkxdlMJKJI1NFyM-4AP5Vng
X-Proofpoint-GUID: a6AhQAk1CrkxdlMJKJI1NFyM-4AP5Vng
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-06-13_11:2021-06-11,2021-06-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106140045
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch clears the end of line whitespace issues in this file.
Mostly since many kernel developers also keep this editor config to clear
any end of line whitespaces on file save.

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

