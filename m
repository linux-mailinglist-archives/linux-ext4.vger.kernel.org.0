Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 477C58D02F
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfHNKBp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 06:01:45 -0400
Received: from mgw-01.mpynet.fi ([82.197.21.90]:50874 "EHLO mgw-01.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfHNKBp (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Aug 2019 06:01:45 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Aug 2019 06:01:44 EDT
Received: from pps.filterd (mgw-01.mpynet.fi [127.0.0.1])
        by mgw-01.mpynet.fi (8.16.0.27/8.16.0.27) with SMTP id x7E9nfqK090644;
        Wed, 14 Aug 2019 12:54:09 +0300
Received: from ex13.tuxera.com (ex13.tuxera.com [178.16.184.72])
        by mgw-01.mpynet.fi with ESMTP id 2ucfarg20m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 12:54:09 +0300
Received: from localhost (194.100.106.190) by tuxera-exch.ad.tuxera.com
 (10.20.48.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 14 Aug
 2019 12:54:08 +0300
Date:   Wed, 14 Aug 2019 12:54:08 +0300
From:   Rakesh Pandit <rakesh@tuxera.com>
To:     <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] ext4: fix warning inside ext4_convert_unwritten_extents_endio
Message-ID: <20190814095406.GA38531@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
User-Agent: Mutt/1.7.1 (2016-10-04)
X-Originating-IP: [194.100.106.190]
X-ClientProxiedBy: tuxera-exch.ad.tuxera.com (10.20.48.11) To
 tuxera-exch.ad.tuxera.com (10.20.48.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=936
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908140100
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Really enable warning when CONFIG_EXT4_DEBUG is set and fix missing
first argument.  This was introduced in commit ff95ec22cd7f ("ext4:
add warning to ext4_convert_unwritten_extents_endio") and splitting
extents inside endio would trigger it.

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 fs/ext4/extents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 92266a2da7d6..f203bf989a4c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -3813,8 +3813,8 @@ static int ext4_convert_unwritten_extents_endio(handle_t *handle,
 	 * illegal.
 	 */
 	if (ee_block != map->m_lblk || ee_len > map->m_len) {
-#ifdef EXT4_DEBUG
-		ext4_warning("Inode (%ld) finished: extent logical block %llu,"
+#ifdef CONFIG_EXT4_DEBUG
+		ext4_warning(inode->i_sb, "Inode (%ld) finished: extent logical block %llu,"
 			     " len %u; IO logical block %llu, len %u",
 			     inode->i_ino, (unsigned long long)ee_block, ee_len,
 			     (unsigned long long)map->m_lblk, map->m_len);
-- 
2.17.1

