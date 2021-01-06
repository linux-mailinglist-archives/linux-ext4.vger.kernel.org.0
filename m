Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C1B2EB7A3
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Jan 2021 02:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbhAFBdb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Jan 2021 20:33:31 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:51964 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725817AbhAFBd3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Jan 2021 20:33:29 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210106013246epoutp0364eec19a1aad8c4f9729b09c40326ad8~XgJR0xuOS1964419644epoutp037
        for <linux-ext4@vger.kernel.org>; Wed,  6 Jan 2021 01:32:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210106013246epoutp0364eec19a1aad8c4f9729b09c40326ad8~XgJR0xuOS1964419644epoutp037
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609896766;
        bh=wu5lRWGWZPfTtvp4R+y7TNZs4ntWTmDe3ujGAklWk4A=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=uPzAlbcvXC0ELMVJRdY9tVw87rf7gOTL6K67UrtWZ5X40WFrp2IFTNZGxlXziU3cF
         9vG9XmRv3aNIIpupECeXjDNYx8LBxw7T3ZY2p3hSSbC92w6g+rDuVVV0A/TV/EsYSZ
         ipd8nVbdKTDXNHwAumA8wBFpXrBm2mZ4gxkk+uI4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210106013246epcas2p36a2a7a3dc0ab01d6a3e4774672938a1d~XgJRFi6ms3159331593epcas2p3X;
        Wed,  6 Jan 2021 01:32:46 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.191]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4D9X186hzmz4x9QF; Wed,  6 Jan
        2021 01:32:44 +0000 (GMT)
X-AuditID: b6c32a47-b97ff7000000148e-8f-5ff5133a25b1
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        97.DC.05262.A3315FF5; Wed,  6 Jan 2021 10:32:42 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] ext4: Remove expensive flush on fast commit
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
Date:   Wed, 06 Jan 2021 10:32:42 +0900
X-CMS-MailID: 20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmha6V8Nd4g4lfdSy+fulgsVjZ2MJk
        MXPeHTaLy7vmsFm09vxkd2D1aNlc7rFz1l12j6YzR5k9Pm+SC2CJyrHJSE1MSS1SSM1Lzk/J
        zEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAVqrpFCWmFMKFApILC5W0rezKcov
        LUlVyMgvLrFVSi1IySkwNCzQK07MLS7NS9dLzs+1MjQwMDIFqkzIyWhsmshasJ2vonltbQPj
        L+4uRk4OCQETif6GvYxdjFwcQgI7GCW+T//H1MXIwcErICjxd4cwSI2wgI3Equ5PjCC2kICS
        xPqLs9gh4noStx6uAYuzCehITD9xnx1kjojAbEaJKxcXs4PMYRaok/h0lwViF6/EjPanULa0
        xPblWxkhbA2JH8t6mSFsUYmbq9+yw9jvj82HqhGRaL13FqpGUOLBz91QcUmJY7s/MEHY9RJb
        7/wC+0VCoIdR4vDOW6wQCX2Jax0bwRbzCvhKLPo+HcxmEVCV6J1wCKrGRWLzwRdgQ5kF5CW2
        v53DDHG/psT6XfogpoSAssSRWywQFXwSHYf/ssO8tWPeE6gT1CTW/VzPBFEuI3FrHtSVHhJ9
        m/ezQ0IwUOLDrIesExgVZiHCeRaStbMQ1i5gZF7FKJZaUJybnlpsVGCMHLObGMHpT8t9B+OM
        tx/0DjEycTAeYpTgYFYS4bU49iVeiDclsbIqtSg/vqg0J7X4EKMp0MMTmaVEk/OBCTivJN7Q
        1MjMzMDS1MLUzMhCSZy32OBBvJBAemJJanZqakFqEUwfEwenVAOT8rvpCfEM26smJx6vVxW4
        vdNo3tOrJlbaPtYzhOYdyErI+mSsqfFmGucXpX9a841SdFccm82YmPot8WPXlvWplZ9r6992
        VsRIdLl3Zs6rFSr3zZgv13OFJf9PeMe6XS+2Ct5SdXunFBHAcLoyX36qWvBLoQNrJ2y6JJS4
        5fD7N0W5q39rWW2v2nST/6i37BHdl7On+W6ZcGj1lAKNr7tvGkbZymcfci1hclWVVduyJfGl
        wOYLnjxWX1OvJQXk3TTtD35wze/qbTvFGWzqqVPbFO+ei2rsjrm0fLad1K1nzS+dn+vuf+mt
        cjqgc127IWvQjM6apzpLKv+wr1bqMeo+mXJo8d680y+rvdOW8VUqsRRnJBpqMRcVJwIAjyWA
        pggEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4
References: <CGME20210106013242epcms2p5b6b4ed8ca86f29456fdf56aa580e74b4@epcms2p5>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In the fast commit, it adds REQ_FUA and REQ_PREFLUSH on each fast commit
block when barrier is enabled. However, in recovery phase, ext4 compares
CRC value in the tail. So it is sufficient adds REQ_FUA and REQ_PREFLUSH
on the block that has tail.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/ext4/fast_commit.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4fcc21c25e79..e66507be334c 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -604,13 +604,13 @@ void ext4_fc_track_range(handle_t *handle, struct inode *inode, ext4_lblk_t star
 	trace_ext4_fc_track_range(inode, start, end, ret);
 }
 
-static void ext4_fc_submit_bh(struct super_block *sb)
+static void ext4_fc_submit_bh(struct super_block *sb, bool is_tail)
 {
 	int write_flags = REQ_SYNC;
 	struct buffer_head *bh = EXT4_SB(sb)->s_fc_bh;
 
-	/* TODO: REQ_FUA | REQ_PREFLUSH is unnecessarily expensive. */
-	if (test_opt(sb, BARRIER))
+	/* Add REQ_FUA | REQ_PREFLUSH only its tail */
+	if (test_opt(sb, BARRIER) && is_tail)
 		write_flags |= REQ_FUA | REQ_PREFLUSH;
 	lock_buffer(bh);
 	set_buffer_dirty(bh);
@@ -684,7 +684,7 @@ static u8 *ext4_fc_reserve_space(struct super_block *sb, int len, u32 *crc)
 		*crc = ext4_chksum(sbi, *crc, tl, sizeof(*tl));
 	if (pad_len > 0)
 		ext4_fc_memzero(sb, tl + 1, pad_len, crc);
-	ext4_fc_submit_bh(sb);
+	ext4_fc_submit_bh(sb, false);
 
 	ret = jbd2_fc_get_buf(EXT4_SB(sb)->s_journal, &bh);
 	if (ret)
@@ -741,7 +741,7 @@ static int ext4_fc_write_tail(struct super_block *sb, u32 crc)
 	tail.fc_crc = cpu_to_le32(crc);
 	ext4_fc_memcpy(sb, dst, &tail.fc_crc, sizeof(tail.fc_crc), NULL);
 
-	ext4_fc_submit_bh(sb);
+	ext4_fc_submit_bh(sb, true);
 
 	return 0;
 }
-- 
2.25.1

