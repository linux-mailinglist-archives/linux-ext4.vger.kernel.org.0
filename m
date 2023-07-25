Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A3F76117F
	for <lists+linux-ext4@lfdr.de>; Tue, 25 Jul 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjGYKwA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 25 Jul 2023 06:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233792AbjGYKvM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 25 Jul 2023 06:51:12 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2829F2723;
        Tue, 25 Jul 2023 03:50:45 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4R9DMd2zBcz4f3p0M;
        Tue, 25 Jul 2023 18:50:37 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quj+qL9kl7XQOg--.17520S2;
        Tue, 25 Jul 2023 18:50:39 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, ritesh.list@gmail.com,
        ojaswin@linux.ibm.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shikemeng@huaweicloud.com
Subject: [PATCH v2 00/10] A few fixes and cleanups to mballoc
Date:   Wed, 26 Jul 2023 02:50:56 +0800
Message-Id: <20230725185106.2147273-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quj+qL9kl7XQOg--.17520S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF4xAr1xAw18Kr1xXFy7ZFb_yoW8Jw4xpr
        ZxGry3t34fKr17JFZxAayFq3WrWws7Ar47XF1a934kGry7Cr92v3ZrKF18ZFyUAFWDGFn8
        Xr9xZF45Ga17CaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvF14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
        0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
        wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
        x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
        64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r
        1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
        YI8I648v4I1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
        xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
        MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
        0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AK
        xVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
        TRNgAwUUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

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

