Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD31687FD5
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Feb 2023 15:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjBBOWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Feb 2023 09:22:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjBBOWi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Feb 2023 09:22:38 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCE11B564
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 06:22:35 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P71Fx60MSz4f3jZJ
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 22:22:29 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP4 (Coremail) with SMTP id gCh0CgCnD7Mgx9tjTJV+Cw--.129S4;
        Thu, 02 Feb 2023 22:22:30 +0800 (CST)
From:   Zhang Yi <yi.zhang@huawei.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        harshadshirwadkar@gmail.com, yi.zhang@huawei.com,
        yi.zhang@huaweicloud.com, yukuai3@huawei.com
Subject: [RFC PATCH v2 0/2] ext4, jbd2: journal cycled record transactions between each mounts
Date:   Thu,  2 Feb 2023 22:22:22 +0800
Message-Id: <20230202142224.3679549-1-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCnD7Mgx9tjTJV+Cw--.129S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uw4xXF17ZFyftF43tF4fZrb_yoW8JFWfpF
        93tw15Wr1kZFyxA3Za9ay7JrWYyws5CFy7WFy3Wa4rKa98JryIqws7tr13CFyYyrWI9a1U
        Gr1UJr4DKw12k37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0aVACjI8F5VA0II8E6IAqYI8I648v4I1l
        42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2Kf
        nxnUUI43ZEXa7IUbmhF7UUUUU==
Sender: yi.zhang@huaweicloud.com
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huaweicloud.com>

v1->v2:
 - Fix the format type warning.
 - Add more check of journal_cycle_record mount options in remount.

Hello, This patch set introduce a new mount option names
journal_cycle_record, it save journal head for a clean unmounted file
system, let ext4 continue/cycled record new journal transactions after
previous mount or recovered transactions for unclean file system. It
could give us more info when analysing a corrupted file system image
and locate kernel consistency bugs more conveniently.

This is just the kernel part and have already passed throuth xfstests in
auto mode (it depends on one prefix patch[1]). I will continue the
e2fsprogs' part if nobody strong dislike that. Any comments are welcome.

[1] https://lore.kernel.org/linux-ext4/20230130111138.76tp6pij3yhh4brh@quack3/T/#m96a1cffd567bdd844233b3115a6635391ed0b45b

Thanks,
Yi.


Zhang Yi (2):
  jbd2: cycled record log on clean journal logging area
  ext4: add journal cycled recording support

 fs/ext4/ext4.h       |  2 ++
 fs/ext4/super.c      | 18 ++++++++++++++++++
 fs/jbd2/journal.c    | 18 ++++++++++++++++--
 fs/jbd2/recovery.c   | 22 +++++++++++++++++-----
 include/linux/jbd2.h |  9 +++++++--
 5 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.31.1

