Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 912613D0842
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jul 2021 07:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbhGUEsD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jul 2021 00:48:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232334AbhGUErn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 21 Jul 2021 00:47:43 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L54PcT112181;
        Wed, 21 Jul 2021 01:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=h0xH88DU7nHUfD5D/YtLPlvXL9cnO/piE/hv+MV2RwQ=;
 b=Qob7cQbtm8Mv9ZGPBhW8QNG3nPzqzwKQhLXbGGwccE8sbERapwIagkKl918RfmaM/V0n
 nydPmxWR/t0zSSQRGQfT/MJ/FEAZyat/ytuju5ehIuPVNsbS0GdUaY20p70JTr6qK04a
 LUVfQpo3LG2iJvz2ZaQ3ynzLFDPJCTqgf+sUR7kGs/PUkb7bO/IM3AW/kYvGOyNlz0mx
 rPQzaPg2mjLwRPrger72o2cAyZZmJCHgJGsMfxJSmEYDv1kHXb5DzCMNYOGuJUgLcudG
 XLQY/h9QX8pCvAjJYQ38yk1B4m41sz9FSgPE2c5O+nRkiMLrrHT2NC8o3cmttAPC63eD yg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39xbaraqv5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 01:28:19 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16L5DjYk018835;
        Wed, 21 Jul 2021 05:28:17 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma03ams.nl.ibm.com with ESMTP id 39upu89nv3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jul 2021 05:28:16 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16L5PnXd17498524
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 05:25:49 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80BB9AE055;
        Wed, 21 Jul 2021 05:28:14 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21FEBAE045;
        Wed, 21 Jul 2021 05:28:14 +0000 (GMT)
Received: from localhost (unknown [9.85.82.121])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 21 Jul 2021 05:28:13 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv2 6/9] common/rc: Add _mkfs_dev_blocksized functionality
Date:   Wed, 21 Jul 2021 10:57:59 +0530
Message-Id: <0cc5f31ca1e4ef56367d041b86e7dcb78e1e033e.1626844259.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1626844259.git.riteshh@linux.ibm.com>
References: <cover.1626844259.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: oH0hOxGOaHPETxLRD2KUNa3sIHtk5awD
X-Proofpoint-GUID: oH0hOxGOaHPETxLRD2KUNa3sIHtk5awD
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-21_02:2021-07-21,2021-07-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=879 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210025
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This adds _mkfs_dev_blocksized functionality.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 common/rc | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/common/rc b/common/rc
index d4b1f21f..b5fe5c71 100644
--- a/common/rc
+++ b/common/rc
@@ -722,6 +722,53 @@ _mkfs_dev()
     rm -f $tmp.mkfserr $tmp.mkfsstd
 }
 
+_set_mkfs_options_blocksized()
+{
+	local blocksize=$1
+	local re='^[0-9]+$'
+
+	if ! [[ $blocksize =~ $re ]]; then
+		_notrun "error _set_mkfs_options_blocksized: blocksize \"$blocksize\" not an integer"
+	fi
+
+	case $FSTYP in
+	btrfs)
+		test -f /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "Subpage sectorsize support is not found in $FSTYP"
+
+		grep -wq $blocksize /sys/fs/btrfs/features/supported_sectorsizes || \
+		_notrun "$FSTYP does not support sectorsize=$blocksize yet"
+
+		MKFS_OPTIONS=" --sectorsize=$blocksize"
+		;;
+	xfs)
+		MKFS_OPTIONS=" -b size=$blocksize"
+		;;
+	ext2|ext3|ext4)
+		MKFS_OPTIONS=" -b $blocksize"
+		;;
+	gfs2)
+		MKFS_OPTIONS=" -O -b $blocksize"
+		;;
+	ocfs2)
+		MKFS_OPTIONS=" -b $blocksize -C $blocksize"
+		;;
+	bcachefs)
+		MKFS_OPTIONS=" --block_size=$blocksize"
+		;;
+	*)
+		# do nothing for other FS.
+		;;
+	esac
+}
+
+_mkfs_dev_blocksized()
+{
+	_set_mkfs_options_blocksized $1
+	shift
+	_mkfs_dev $*
+}
+
 # remove all files in $SCRATCH_MNT, useful when testing on NFS/CIFS
 _scratch_cleanup_files()
 {
-- 
2.31.1

