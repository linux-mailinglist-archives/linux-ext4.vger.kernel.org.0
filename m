Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB76512A5A0
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Dec 2019 03:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfLYCiv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Dec 2019 21:38:51 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8179 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726317AbfLYCiu (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 24 Dec 2019 21:38:50 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 058CDE93C6CC6CD10B3A;
        Wed, 25 Dec 2019 10:38:46 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 10:38:38 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH] ext4: use true,false for bool variable
Date:   Wed, 25 Dec 2019 10:45:59 +0800
Message-ID: <1577241959-138695-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes coccicheck warning:

fs/ext4/extents.c:5271:6-12: WARNING: Assignment of 0/1 to bool variable
fs/ext4/extents.c:5287:4-10: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/ext4/extents.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 0e8708b..d8611be 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5268,7 +5268,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 {
 	int depth, err = 0;
 	struct ext4_extent *ex_start, *ex_last;
-	bool update = 0;
+	bool update = false;
 	depth = path->p_depth;

 	while (depth >= 0) {
@@ -5284,7 +5284,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
 				goto out;

 			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr))
-				update = 1;
+				update = true;

 			while (ex_start <= ex_last) {
 				if (SHIFT == SHIFT_LEFT) {
--
2.7.4

