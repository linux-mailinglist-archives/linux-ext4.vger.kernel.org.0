Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 323262E7DA1
	for <lists+linux-ext4@lfdr.de>; Thu, 31 Dec 2020 02:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgLaBxA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Dec 2020 20:53:00 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:37714 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgLaBw7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Dec 2020 20:52:59 -0500
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201231015216epoutp04846ff4863270dfb5f5bde44b165223ef~Vqil0z8vO3172131721epoutp04c
        for <linux-ext4@vger.kernel.org>; Thu, 31 Dec 2020 01:52:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201231015216epoutp04846ff4863270dfb5f5bde44b165223ef~Vqil0z8vO3172131721epoutp04c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609379536;
        bh=Pavx+2KlD0fJy/GmKeiLRdvuDhlWzwyoD9M4eFpU3s0=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=I7AAeVKp4y01CXzFXdqRnq+kN5C2xSh5d8YWeR8OezrJaCOlLEuCkgtyQvuy7iO2l
         SmNIV0oMfJqwEK9LmhHDbSYhBveadlfIIffJgz8I3Ih1O49sD7Uc6h7Rdqq73xyaWc
         SKktl+EHVtQ/val1gp8kgPnDe7fv4c0J1RsJJ2Gg=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20201231015216epcas2p11548875a00616ea24a0616c08e915fd5~Vqilk0bcI2957129571epcas2p1P;
        Thu, 31 Dec 2020 01:52:16 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4D5rkR2F7Fz4x9Q0; Thu, 31 Dec
        2020 01:52:15 +0000 (GMT)
X-AuditID: b6c32a48-50fff7000000cd1f-a1-5fed2ecd9a28
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        D3.44.52511.DCE2DEF5; Thu, 31 Dec 2020 10:52:13 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] ext4: Change list_for_each to list_for_each_entry
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
Date:   Thu, 31 Dec 2020 10:52:13 +0900
X-CMS-MailID: 20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFKsWRmVeSWpSXmKPExsWy7bCmhe5ZvbfxBse2CVh8/dLBYjFz3h02
        i8u75rBZtPb8ZHdg8WjZXO7RdOYos8fnTXIBzFE5NhmpiSmpRQqpecn5KZl56bZK3sHxzvGm
        ZgaGuoaWFuZKCnmJuam2Si4+AbpumTlAy5QUyhJzSoFCAYnFxUr6djZF+aUlqQoZ+cUltkqp
        BSk5BYaGBXrFibnFpXnpesn5uVaGBgZGpkCVCTkZ567tZS64xF2x9N5yxgbGz5xdjJwcEgIm
        Env2vGcDsYUEdjBKPGwN6GLk4OAVEJT4u0MYJCws4CQx5/06FogSJYn1F2exQ8T1JG49XMMI
        YrMJ6EhMP3EfLC4iECPR9GAnWJxZoE5iy4KdbBCreCVmtD9lgbClJbYv38oIYWtI/FjWywxh
        i0rcXP2WHcZ+f2w+VI2IROu9s1A1ghIPfu6GiktKHNv9gQnCrpfYeucXUJwLyO5hlDi88xYr
        REJf4lrHRhaIv3wlXr8Bm88ioCpx99NpqHtcJN7ee8UKcbO8xPa3c5hBypkFNCXW79IHMSUE
        lCWO3GKBqOCT6Dj8lx3mqx3znkBdoCax7ud6JohyGYlb86CO9JB40trJDgnAQInVzffYJjAq
        zEIE8ywka2chrF3AyLyKUSy1oDg3PbXYqMAEOWI3MYITnZbHDsbZbz/oHWJk4mA8xCjBwawk
        wpuQ8CpeiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBqTavJN7Q1MjMzMDS1MLUzMhCSZy3
        yOBBvJBAemJJanZqakFqEUwfEwenVANTy5diBYnD/TEroiYlvvGU9l+ZcMF6yp7IL02FU1Tv
        dUnO2X1gxVUOF3aJnHdROlO7Vbwsnz44HH9I7FzPSkPhjUc9z68U3N53I0aR9/NLZs2/rjyn
        Nm7oFa3Yp1h44Q4b74OP/ZtjmtODHnIHbhOT92f+++Amp2Pqn67FZ2YuWn3sy5wPSnZznDxs
        eCo7te0c95w7W3XH8d2ljefrO3L5/9XNazaLXLVxidPkDXJPFpSl3bDqfRwUfPWsp+bho9dU
        nmpFzv3nl5Pgq1I7UTorbPq8EwEXXK90Wt+7IvFZQcqiM3P5n2tma0qEN8XsmdUyod5qUpy5
        pOn6xh8Cojc2RvSWHD7d8DFiR4rSaTtXJZbijERDLeai4kQANYXnNP0DAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51
References: <CGME20201231015213epcms2p5ef76aa6b26ab74e045a86f6a13b31d51@epcms2p5>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

list_for_each + list_entry can be changed to list_for_each_entry
It reduces number of variables and lines.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/ext4/fast_commit.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 5b6bb3ef0f33..dc58471971db 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -915,13 +915,11 @@ static int ext4_fc_submit_inode_data_all(journal_t *journal)
 	struct super_block *sb = (struct super_block *)(journal->j_private);
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	struct ext4_inode_info *ei;
-	struct list_head *pos;
 	int ret = 0;
 
 	spin_lock(&sbi->s_fc_lock);
 	ext4_set_mount_flag(sb, EXT4_MF_FC_COMMITTING);
-	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
-		ei = list_entry(pos, struct ext4_inode_info, i_fc_list);
+	list_for_each_entry(ei, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		ext4_set_inode_state(&ei->vfs_inode, EXT4_STATE_FC_COMMITTING);
 		while (atomic_read(&ei->i_fc_updates)) {
 			DEFINE_WAIT(wait);
@@ -1099,8 +1097,7 @@ static int ext4_fc_perform_commit(journal_t *journal)
 		goto out;
 	}
 
-	list_for_each(pos, &sbi->s_fc_q[FC_Q_MAIN]) {
-		iter = list_entry(pos, struct ext4_inode_info, i_fc_list);
+	list_for_each_entry(iter, &sbi->s_fc_q[FC_Q_MAIN], i_fc_list) {
 		inode = &iter->vfs_inode;
 		if (!ext4_test_inode_state(inode, EXT4_STATE_FC_COMMITTING))
 			continue;
-- 
2.25.1

