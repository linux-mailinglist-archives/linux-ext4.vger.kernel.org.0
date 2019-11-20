Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FE104460
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 20:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfKTTdB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 14:33:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47882 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbfKTTdB (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Nov 2019 14:33:01 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJIx8B046781;
        Wed, 20 Nov 2019 19:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=45f10fGewTN5DTha0eLm9c7XATMXfTvr1aQpOy/Cv4c=;
 b=ZzQj9IiAhU7x+cbMe/OQ6PvS65+P0jsAfdjkBuRykNvlb2Thepk8hJ4eOxeoKWWpEAAX
 Jc786zK6vx5cjpY7XSZ9SF8A37tvIPy0P6+xWLN5jXqv8l5hLKRk2DccZKEcfvAJmK84
 4ppL/k+3xHJ0/9cnFmf1se3kGKctyffLpV++MkbG+XtJYcKNJlnoWTQqv/HIGHcd2A8Y
 y/rmChmo0f9tkBbuTAM+SYxSUQ2cIsl96JIjB8hgNugP9bAP0X0MGfRzTbY2z7V1JhR6
 NzfoH7TkFS0cgwKmbQxwq4PDxZ9YQrHGQv22Ikec1DVdJoCyMK0hr7T991SG9PomCR7v /w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2wa8htyr0g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:32:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id xAKJIfWo069172;
        Wed, 20 Nov 2019 19:32:57 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2wd46wyaeg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 19:32:57 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id xAKJWu6Q009172;
        Wed, 20 Nov 2019 19:32:56 GMT
Received: from localhost (/10.159.246.236)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Nov 2019 11:32:56 -0800
Date:   Wed, 20 Nov 2019 11:32:55 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4 <linux-ext4@vger.kernel.org>,
        eric.saint.etienne@oracle.com
Subject: [PATCH] tune2fs: prohibit toggling uninit_bg on live filesystems
Message-ID: <20191120193255.GF6213@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-1911200160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9447 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-1911200160
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

An internal customer followed an erroneous AskUbuntu article[1] to try to
change the UUID of a live ext4 filesystem.  The article claims that you
can work around tune2fs' "cannot change UUID on live fs" error by
disabling uninit_bg, changing the UUID, and re-enabling the feature.

This led to metadata corruption because tune2fs' journal descriptor
rewrite races with regular filesystem writes.  Therefore, prevent
administrators from turning on or off uninit_bg on a mounted fs.

[1] https://askubuntu.com/questions/132079/how-do-i-change-uuid-of-a-disk-to-whatever-i-want/195839#459097

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 misc/tune2fs.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 8368a733..150dc916 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -1312,6 +1312,12 @@ static int update_feature_set(ext2_filsys fs, char *features)
 
 	if (FEATURE_ON(E2P_FEATURE_RO_INCOMPAT,
 		       EXT4_FEATURE_RO_COMPAT_GDT_CSUM)) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("Cannot enable uninit_bg on a mounted "
+				"filesystem!\n"), stderr);
+			exit(1);
+		}
+
 		/* Do not enable uninit_bg when metadata_csum enabled */
 		if (ext2fs_has_feature_metadata_csum(fs->super))
 			ext2fs_clear_feature_gdt_csum(fs->super);
@@ -1321,6 +1327,12 @@ static int update_feature_set(ext2_filsys fs, char *features)
 
 	if (FEATURE_OFF(E2P_FEATURE_RO_INCOMPAT,
 			EXT4_FEATURE_RO_COMPAT_GDT_CSUM)) {
+		if (mount_flags & EXT2_MF_MOUNTED) {
+			fputs(_("Cannot disable uninit_bg on a mounted "
+				"filesystem!\n"), stderr);
+			exit(1);
+		}
+
 		err = disable_uninit_bg(fs,
 				EXT4_FEATURE_RO_COMPAT_GDT_CSUM);
 		if (err)
