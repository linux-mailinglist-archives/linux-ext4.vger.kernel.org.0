Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07C9645473
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 08:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiLGHT6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 02:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLGHT4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 02:19:56 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459EE31DF8;
        Tue,  6 Dec 2022 23:19:55 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NRpZX4fmKz4f3v5m;
        Wed,  7 Dec 2022 15:19:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgBniteWPpBj6qE0Bw--.52253S4;
        Wed, 07 Dec 2022 15:19:51 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v2 0/6] Fix two issue about ext4 extended attribute
Date:   Wed,  7 Dec 2022 15:40:37 +0800
Message-Id: <20221207074043.1286731-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBniteWPpBj6qE0Bw--.52253S4
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy3Jr1UJw48Jw4xZF17GFg_yoWDXrb_AF
        y8JrWrJr4jqa48Wa9Fyr1IyryrKF48Gr1fZF1kCF4Iv347XayDZFWkAr4Uur1UuF4jy3Z8
        u3W7tryxAF9agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbokYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
        Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
        A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
        67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
        z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
        AF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4l
        IxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s
        0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsG
        vfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Diff v2 vs v1:
1.Modify commit message about "ext4: fix WARNING in ext4_expand_extra_isize_ea"
2.Modify the indentation of arguments about "ext4: rename xattr_find_entry()
and __xattr_check_inode()"

This patchset fix two issues:
1. Patch [1]-[4] fix WARNING in ext4_expand_extra_isize_ea.
2. Patch [6] fix inode leak in 'ext4_xattr_inode_create()'.
3. Patch [5] is cleanup.

Ye Bin (6):
  ext4: fix WARNING in ext4_expand_extra_isize_ea
  ext4: add primary check extended attribute inode in
    ext4_xattr_check_entries()
  ext4: remove unnessary size check in ext4_xattr_inode_get()
  ext4: allocate extended attribute value in vmalloc area
  ext4: rename xattr_find_entry() and __xattr_check_inode()
  ext4: fix inode leak in 'ext4_xattr_inode_create()'

 fs/ext4/xattr.c | 91 ++++++++++++++++++++++++++++++++-----------------
 fs/ext4/xattr.h | 11 ++----
 2 files changed, 62 insertions(+), 40 deletions(-)

-- 
2.31.1

