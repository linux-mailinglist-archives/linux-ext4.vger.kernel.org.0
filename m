Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374EA741F07
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Jun 2023 06:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjF2EAX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Jun 2023 00:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjF2D7z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 28 Jun 2023 23:59:55 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD19A2D4A;
        Wed, 28 Jun 2023 20:59:51 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Qs4Tb15wDz4f3kpf;
        Thu, 29 Jun 2023 11:59:47 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.124.27])
        by APP2 (Coremail) with SMTP id Syh0CgC3quiwAZ1kw6DMMg--.26995S2;
        Thu, 29 Jun 2023 11:59:46 +0800 (CST)
From:   Kemeng Shi <shikemeng@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/13] fixes and cleanups to ext4 resize
Date:   Thu, 29 Jun 2023 20:00:31 +0800
Message-Id: <20230629120044.1261968-1-shikemeng@huaweicloud.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3quiwAZ1kw6DMMg--.26995S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGr18Zw48JFy8GF18Cr43trb_yoWrGw18pa
        1Sgw13Kr95Xw13Cw47t3sxWF95Xws7GF4UWr13G3Z7KF1UZw18WF9xWan5AFW5KFWrZ3W0
        q3s7Xrs8WF18ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
        8lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_
        tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r
        xl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv
        0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z2
        80aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j-6pPUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series contains some random cleanups and a few fixes to correct gdb
backup copy, fix buffer_head leak and so on. More details can be found
in respective log messages.
I run kvm-xfstest with config "ext4/all" and "-g auto" together with
mballoc patchset I sent before.

-------------------- Summary report
KERNEL:    kernel 6.4.0-rc5-xfstests-g90158dd3c06b #23 SMP PREEMPT_DYNAMIC
Wed Jun 28 17:19:32 CST 2023 x86_64
CPUS:      2
MEM:       1975.36

ext4/4k: 531 tests, 31 skipped, 3421 seconds
ext4/1k: 527 tests, 33 skipped, 4638 seconds
ext4/ext3: 523 tests, 119 skipped, 3289 seconds
ext4/encrypt: 509 tests, 3 failures, 138 skipped, 2163 seconds
  Failures: generic/681 generic/682 generic/691
ext4/nojournal: 526 tests, 5 failures, 98 skipped, 3469 seconds
  Failures: ext4/301 ext4/304 generic/455 generic/459 generic/581
ext4/ext3conv: 528 tests, 31 skipped, 3877 seconds
ext4/adv: 528 tests, 4 failures, 38 skipped, 4170 seconds
  Failures: generic/475 generic/477
  Flaky: generic/455: 80% (4/5)   generic/482: 80% (4/5)
ext4/dioread_nolock: 529 tests, 31 skipped, 3825 seconds
ext4/data_journal: 527 tests, 3 failures, 99 skipped, 3307 seconds
  Failures: generic/455 generic/484
  Flaky: generic/068: 40% (2/5)
ext4/bigalloc_4k: 503 tests, 35 skipped, 3286 seconds
ext4/bigalloc_1k: 503 tests, 1 failures, 43 skipped, 4421 seconds
  Failures: shared/298
Totals: 5798 tests, 696 skipped, 75 failures, 0 errors, 39645s

FSTESTVER: blktests 676d42c (Thu, 2 Mar 2023 15:25:44 +0900)
FSTESTVER: e2fsprogs archive/debian/1.47.0-1 (Mon, 6 Feb 2023 22:36:16 -0500)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5-6-g5d6f7c4 (Mon, 30 Jan 2023 23:22:45 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-53-gd90b7d5 (Tue, 6 Dec 2022 12:59:03 +0100)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v6.1.1 (Fri, 13 Jan 2023 19:06:37 +0100)
FSTESTVER: xfstests v2023.02.26-8-g821ef488 (Thu, 2 Mar 2023 10:23:51 -0500)
FSTESTVER: xfstests-bld 35650073 (Mon, 6 Mar 2023 20:48:08 -0500)
FSTESTVER: zz_build-distro bullseye
FSTESTCFG: ext4/all
FSTESTSET: -g auto
FSTESTOPT: aex

There more failures compared with "good" report in reply from Ted [1] as
following:
ext4/nojournal: generic/459 generic/581
ext4/adv: Flaky: generic/455: 80% (4/5)   generic/482: 80% (4/5)
ext4/data_journal: Flaky: generic/068: 40% (2/5)
It seems still a "good" test run according to rules listed in [1].
Please let me know if more tests to run. Thanks!

[1] https://lore.kernel.org/linux-ext4/db478a24-39f5-3cef-8814-89406ce4d2ca@huawei.com/T/#ma9de3f355f0300291d32fe1f0b32c5660c9bd191

Kemeng Shi (13):
  ext4: correct offset of gdb backup in non meta_bg group to
    update_backups
  ext4: add missed brelse in update_backups
  ext4: correct return value of ext4_convert_meta_bg
  ext4: remove gdb backup copy for meta bg in
    setup_new_flex_group_blocks
  ext4: fix typo in setup_new_flex_group_blocks
  ext4: remove redundant check of count
  ext4: remove commented code in reserve_backup_gdb
  ext4: calculate free_clusters_count in cluster unit in
    verify_group_input
  ext4: remove EXT4FS_DEBUG defination in resize.c
  ext4: use saved local variable sbi instead of EXT4_SB(sb)
  ext4: correct gdblock calculation in add_new_gdb_meta_bg to support
    non first group
  ext4: remove unnecessary check for avoiding multiple update_backups in
    ext4_flex_group_add
  ext4: remove unnecessary initialization of count2 in
    set_flexbg_block_bitmap

 fs/ext4/resize.c | 81 +++++++++++++++++++-----------------------------
 1 file changed, 32 insertions(+), 49 deletions(-)

-- 
2.30.0

