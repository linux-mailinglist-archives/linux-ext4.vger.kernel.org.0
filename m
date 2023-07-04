Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABDF7472FD
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Jul 2023 15:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjGDNoF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Jul 2023 09:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbjGDNoE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Jul 2023 09:44:04 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085DCEE
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 06:44:04 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QwPCM2k2cz4f3lfW
        for <linux-ext4@vger.kernel.org>; Tue,  4 Jul 2023 21:43:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
        by APP4 (Coremail) with SMTP id gCh0CgD3rLASIqRk9WjENA--.31120S4;
        Tue, 04 Jul 2023 21:43:56 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: [PATCH 00/12] ext4,jbd2: cleanup journal load and initialization process
Date:   Tue,  4 Jul 2023 21:42:21 +0800
Message-Id: <20230704134233.110812-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD3rLASIqRk9WjENA--.31120S4
X-Coremail-Antispam: 1UD129KBjvJXoW7CF1xGw1xtF4fKr4kZr1DWrg_yoW8Ary3pF
        43Ga4furWUC34xAa1IqF4xGFWfWw1Ikay7Grn7Crn7Aw4rZFnrtr48Jr1rJFyUCFW8ua12
        gF4UGanxGw10k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l42xK82IYc2Ij64vI
        r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
        xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
        cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
        AvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbE_M3UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Hello,

This patch set cleanup the journal load and initialization process
(discussed and suggested by Ted in [1]). Firstly, move reading of the
journal superblock from jbd2_journal_load() and jbd2_journal_wipe()
early to journal_init_common(), and completely drop the kludgy call of
journal_get_superblock() in jbd2_journal_check_used_features(). Then
cleanup the ext4_get_journal() and ext4_get_dev_journal(), making their
initialization process and error handling process more clear, and return
proper errno if some bad happens. Finally rename those two functions to
jbd2_open_{dev,inode}_journal. This patch set has passed
'kvm-xfstests -g auto'.

[1] https://lore.kernel.org/linux-ext4/20230617185057.GA343628@mit.edu/

Thanks,
Yi.

Zhang Yi (12):
  jbd2: move load_superblock() dependent functions
  jbd2: move load_superblock() into journal_init_common()
  jbd2: don't load superblock in jbd2_journal_check_used_features()
  jbd2: checking valid features early in journal_get_superblock()
  jbd2: open code jbd2_verify_csum_type() helper
  jbd2: cleanup load_superblock()
  jbd2: add fast_commit space check
  jbd2: cleanup journal_init_common()
  jbd2: drop useless error tag in jbd2_journal_wipe()
  jbd2: jbd2_journal_init_{dev,inode} return proper error return value
  ext4: cleanup ext4_get_dev_journal() and ext4_get_journal()
  ext4: ext4_get_{dev}_journal return proper error value

 fs/ext4/super.c    | 154 ++++++++-------
 fs/jbd2/journal.c  | 474 ++++++++++++++++++++++-----------------------
 fs/ocfs2/journal.c |   8 +-
 3 files changed, 308 insertions(+), 328 deletions(-)

-- 
2.39.2

