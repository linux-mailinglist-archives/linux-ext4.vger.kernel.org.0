Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE832686552
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Feb 2023 12:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjBALXC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Feb 2023 06:23:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjBALXA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Feb 2023 06:23:00 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66B63C17;
        Wed,  1 Feb 2023 03:22:58 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6KK93K4kz4f3nTP;
        Wed,  1 Feb 2023 19:22:53 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDn4R+NS9pj_j45Cg--.57546S4;
        Wed, 01 Feb 2023 19:22:55 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH 0/5] fix error flag covered by journal recovery
Date:   Wed,  1 Feb 2023 19:46:46 +0800
Message-Id: <20230201114651.4090446-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDn4R+NS9pj_j45Cg--.57546S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KFWruFy8Gr45XFWfZF1kKrg_yoW8WFyUp3
        93u3sxKrWvvFyxtF93Aa1UJ345X34rCFy5WFnruw1xJw1Ykr17X3srtF4rJFWUKrWSqa1j
        qr18J345G3WUKrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

When do fault injection test, got issue as follows:
EXT4-fs (dm-5): warning: mounting fs with errors, running e2fsck is recommended
EXT4-fs (dm-5): Errors on filesystem, clearing orphan list.
EXT4-fs (dm-5): recovery complete
EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro

EXT4-fs (dm-5): recovery complete
EXT4-fs (dm-5): mounted filesystem with ordered data mode. Opts: data_err=abort,errors=remount-ro

Without do file system check, file system is clean when do second mount.
Theoretically, the kernel will not clear fs error flag. In errors=remount-ro
mode the last super block is commit directly. So super block in journal is
not uptodate. When do jounral recovery, the uptodate super block will be
covered by jounral data. If super block submit all failed after recover
journal, then file system error flag is lost. When do "fsck -a" couldn't
repair file system deeply.
To solve above issue we need to do extra handle when do super block journal
recovery.

Ye Bin (5):
  jbd2: introduce callback for recovery journal
  ext4: introudce helper for jounral recover handle
  ext4: fix error flag covered by journal recovery
  ext4: fix super block checksum error
  ext4: make sure fs error flag setted before clear journal error

 fs/ext4/ext4_jbd2.c  | 66 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h  |  2 ++
 fs/ext4/super.c      | 45 ++++++++++++++----------------
 fs/jbd2/recovery.c   | 14 ++++++++++
 include/linux/jbd2.h | 11 ++++++++
 5 files changed, 114 insertions(+), 24 deletions(-)

-- 
2.31.1

