Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02BA778782
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Aug 2023 08:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjHKGga (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Aug 2023 02:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjHKGg3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Aug 2023 02:36:29 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239D61FED
        for <linux-ext4@vger.kernel.org>; Thu, 10 Aug 2023 23:36:28 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RMYwR3kxPz4f3nbp
        for <linux-ext4@vger.kernel.org>; Fri, 11 Aug 2023 14:36:23 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgA3x6na1tVkKEbDAQ--.35746S4;
        Fri, 11 Aug 2023 14:36:20 +0800 (CST)
From:   Zhang Yi <yi.zhang@huaweicloud.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        yi.zhang@huawei.com, yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [PATCH v3 00/12] ext4,jbd2: cleanup journal load and initialization process
Date:   Fri, 11 Aug 2023 14:35:58 +0800
Message-Id: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.34.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgA3x6na1tVkKEbDAQ--.35746S4
X-Coremail-Antispam: 1UD129KBjvJXoW7tF47urWxWr48JrWktFW5Jrb_yoW8ur45pF
        43Ka4furWUCryxAF4IqF4rJFWrW34IkFW7GrnrCwn7Aw4rZrnrtr4kKF1rJFyUGFW5u3W7
        GF4UGanrKw1Fk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
        6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

v2->v3:
 - Fix the potential overflow on journal space check in patch 7.
 - Rename ext4_get_journal_dev() to ext4_get_journal_blkdev() in patch 11.
v1->v2:
 - Fix the changelog in patch 1 and 2.
 - Simplify the comments for local functions in patch 6.
 - Remove the incorrect zero fast_commit blocks check in patch 7.
 - Fix a UAF problem in patch 11.

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
 fs/jbd2/journal.c  | 466 +++++++++++++++++++++------------------------
 fs/ocfs2/journal.c |   8 +-
 3 files changed, 300 insertions(+), 328 deletions(-)

-- 
2.34.3

