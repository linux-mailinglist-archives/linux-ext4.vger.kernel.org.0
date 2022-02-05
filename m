Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0660C4AA96C
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Feb 2022 15:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380122AbiBEO3V (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Feb 2022 09:29:21 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355500AbiBEO3T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Feb 2022 09:29:19 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21583TgV002439;
        Sat, 5 Feb 2022 14:29:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=EvIJ6Q1EY4tw45dTRGd8+HjE4HztvK3unbqkRLOKWTg=;
 b=dpEovuU42nbvK8SOpfvXmZ3ZNQh6ONhj8TLws4oLQIMKwGhZG/QB3TD2bxwmFqROl5Xz
 vM5VaXdf2qSvWDhrWUuJgK8hBjwG12uG8BN0CRkslW6PeVZS/UKA2udenGk3R90aTWtW
 eXsUxEghGxM+1CQvjuDgbzBGd/vPaMgkRNKW7Q1+3eWTnitvgApiNR5bg2cZtMqAhMEL
 rvFnX/5ttFwcjnlzNlXS8tVY86HmwRhtyw2zHiTwePGbE5vXwGHiQWzntbUqxkJWHslo
 mPfiW5k9k0RXY5AnqFD+zWd15hWnlZBg1FmFbxNADlzVeNlgoDRoUWMGlv5LLTD38o0z 6Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1ekuhsjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:19 +0000
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215EFWP0009297;
        Sat, 5 Feb 2022 14:29:19 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1ekuhsjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:18 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215ERalN032508;
        Sat, 5 Feb 2022 14:29:16 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma04ams.nl.ibm.com with ESMTP id 3e1gv8j7u7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:29:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EJGXE49480110
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:19:16 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AFFC2AE053;
        Sat,  5 Feb 2022 14:29:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EAE8AE04D;
        Sat,  5 Feb 2022 14:29:13 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat,  5 Feb 2022 14:29:12 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     linux-ext4@vger.kernel.org,
        Ritesh Harjani <ritesh.harjani@gmail.com>
Subject: [PATCHv1 2/4] common/punch: Add block_size argument to _filter_fiemap_**
Date:   Sat,  5 Feb 2022 19:58:52 +0530
Message-Id: <6db398df705564ba2776d2eb15a7ceec1b236d3b.1644070604.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644070604.git.riteshh@linux.ibm.com>
References: <cover.1644070604.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SrAHkeWkpE5wFPqidE43kdjQBa_5SfN9
X-Proofpoint-ORIG-GUID: GEuguBBkNyhroD_3qks_KzejtmJVA5t4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ritesh Harjani <ritesh.harjani@gmail.com>

Add block_size paramter to _filter_fiemap_flags() and
_filter_hole_fiemap(). This is used in next patches

Also this fixes some of the end of line whitespace issues while we are
at it.

Signed-off-by: Ritesh Harjani <ritesh.harjani@gmail.com>
---
 common/punch | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/common/punch b/common/punch
index b6b8a0b9..f99e21ad 100644
--- a/common/punch
+++ b/common/punch
@@ -109,6 +109,7 @@ _filter_fiemap()
 
 _filter_fiemap_flags()
 {
+	block_size=$1
 	$AWK_PROG '
 		$3 ~ /hole/ {
 			print $1, $2, $3;
@@ -135,23 +136,24 @@ _filter_fiemap_flags()
 			}
 			print $1, $2, flag_str
 		}' |
-	_coalesce_extents
+	_coalesce_extents $block_size
 }
 
-# Filters fiemap output to only print the 
+# Filters fiemap output to only print the
 # file offset column and whether or not
 # it is an extent or a hole
 _filter_hole_fiemap()
 {
+	block_size=$1
 	$AWK_PROG '
 		$3 ~ /hole/ {
-			print $1, $2, $3; 
+			print $1, $2, $3;
 			next;
-		}   
+		}
 		$5 ~ /0x[[:xdigit:]]+/ {
 			print $1, $2, "extent";
 		}' |
-	_coalesce_extents
+	_coalesce_extents $block_size
 }
 
 #     10000 Unwritten preallocated extent
-- 
2.31.1

