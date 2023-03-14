Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50C26B9770
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Mar 2023 15:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjCNOMU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjCNOMD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 10:12:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E549A769E
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 07:11:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Pbb6P4pLYz4f3pCL
        for <linux-ext4@vger.kernel.org>; Tue, 14 Mar 2023 22:11:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgD3X7NygBBkPBlyFQ--.57348S8;
        Tue, 14 Mar 2023 22:11:11 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH 4/4] ext4.5: document the journal_cycle_record mount options
Date:   Tue, 14 Mar 2023 22:10:58 +0800
Message-Id: <20230314141058.3267404-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230314141058.3267404-1-yi.zhang@huaweicloud.com>
References: <20230314141058.3267404-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3X7NygBBkPBlyFQ--.57348S8
X-Coremail-Antispam: 1UD129KBjvdXoWrtr1DWF4kWFy8CF1fCw47XFb_yoWDJwb_Ca
        s2qF45Gw4fJ34xtFs8uF47ZrW5Cw4UAF1F9FnayasYg3sFvFWrJ3Wqkr1vyr4DWFZ8Jr13
        Jw4xt3sakr17ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbTkFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2
        IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28E
        F7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr
        1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
        v20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
        F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxK
        x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
        0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 misc/ext4.5.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/misc/ext4.5.in b/misc/ext4.5.in
index c835a344..45392d1b 100644
--- a/misc/ext4.5.in
+++ b/misc/ext4.5.in
@@ -574,6 +574,12 @@ Commit block can be written to disk without waiting for descriptor blocks. If
 enabled older kernels cannot mount the device.
 This will enable 'journal_checksum' internally.
 .TP
+.B journal_cycle_record
+The journal continue to record transactions in a new mount behind the previous
+mount, instead of always record from the start of the logging area. This will
+alow logdump code in debugfs to dump continuous transactions between each
+mount.
+.TP
 .BR barrier=0 " / " barrier=1 " / " barrier " / " nobarrier
 These mount options have the same effect as in ext3.  The mount options
 "barrier" and "nobarrier" are added for consistency with other ext4 mount
-- 
2.31.1

