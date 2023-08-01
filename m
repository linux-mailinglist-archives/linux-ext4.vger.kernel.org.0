Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FCE76A924
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Aug 2023 08:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjHAGb6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Aug 2023 02:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbjHAGbx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Aug 2023 02:31:53 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E9F114;
        Mon, 31 Jul 2023 23:31:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RFQHh5X9sz4f3lXm;
        Tue,  1 Aug 2023 14:31:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgDnjOrQpshkMcvqPA--.21719S2;
        Tue, 01 Aug 2023 14:31:46 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v3 00/10] A few fixes and cleanups to mballoc
Date:   Tue,  1 Aug 2023 22:31:54 +0800
Message-Id: <20230801143204.2284343-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgDnjOrQpshkMcvqPA--.21719S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xAr1xAw18Kr1xXFy7ZFb_yoW8Xw13pr
        ZxGry3K34ftr17JFZxCa1Fq3WrWws7Ar1UXF1ag34kAry7CrykZ3ZrKF18ZFyUAFWDGF15
        XrnxZF48C3WUC37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvY14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7
        xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
        FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
        0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
        x2IErcIFxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
        0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
        IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
        AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0p
        RQo7tUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        MAY_BE_FORGED,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

v2->v3:
-Correct comment of patch 10 on top of [1]. Remove the RVB from patch
10 as it changed.
-Collect RVG from Ritesh to Patch 1.
v1->v2:
Collect review-by from Ritesh and do improve as Ritesh suggested:
-Keep checks inside unlikely() in patch 1
-Add missed fixes tags in patch 1, 2 and 10
-Fix typo, fix conflic and kill one more return in patch 5
 
Hi all, this series contains some random fixes and cleanups to mballoc
which include correct grp validation, fix data overflow and so on.
More details can be found in respective patches.
Besides, 'kvm-xfstest smoke' runs successfully without error.

Thanks!

[1] https://lore.kernel.org/linux-ext4/20230630085927.140137-1-ojaswin@linux.ibm.com/

Kemeng Shi (10):
  ext4: correct grp validation in ext4_mb_good_group
  ext4: avoid potential data overflow in next_linear_group
  ext4: return found group directly in
    ext4_mb_choose_next_group_p2_aligned
  ext4: use is_power_of_2 helper in ext4_mb_regular_allocator
  ext4: remove unnecessary return for void function
  ext4: replace the traditional ternary conditional operator with with
    max()/min()
  ext4: remove unused ext4_{set}/{clear}_bit_atomic
  ext4: return found group directly in
    ext4_mb_choose_next_group_goal_fast
  ext4: return found group directly in
    ext4_mb_choose_next_group_best_avail
  ext4: correct some stale comment of criteria

 fs/ext4/ext4.h    |  2 --
 fs/ext4/mballoc.c | 89 ++++++++++++++++++-----------------------------
 2 files changed, 33 insertions(+), 58 deletions(-)

-- 
2.30.0

