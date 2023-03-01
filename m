Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891BF6A6BC5
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Mar 2023 12:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjCALf4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Mar 2023 06:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCALfz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Mar 2023 06:35:55 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0165FE5;
        Wed,  1 Mar 2023 03:35:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4PRXH92f8Vz4f3knR;
        Wed,  1 Mar 2023 19:35:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyGVOP9jOXabEA--.39702S4;
        Wed, 01 Mar 2023 19:35:51 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>
Subject: [PATCH v4 0/2] fix error flag covered by journal recovery
Date:   Wed,  1 Mar 2023 19:59:07 +0800
Message-Id: <20230301115909.184772-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyGVOP9jOXabEA--.39702S4
X-Coremail-Antispam: 1UD129KBjvJXoW7WF47CFW8CF4DtFW7JrWfuFg_yoW8AF45pa
        95ur98KrWvvF1IyFykJay7t3yDX3sxAFWrWF4Duw1Iyw15Gr1av3s7tF4a9FWUKr1Sgayj
        qF18J34rKayDKFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgCb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Diff v4 Vs v3:
After journal replay recover 'es->s_state' error flag like recover error
info.

Diff v3 Vs v2:
Only fix fs error flag lost when previous journal errno is not record
in disk. As this may lead to drop orphan list, however fs not record
error flag, then fsck will not repair deeply.

Diff v2 vs v1:
Move call 'j_replay_prepare_callback' and 'j_replay_end_callback' from
ext4_load_journal() to jbd2_journal_recover().

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

Ye Bin (2):
  ext4: commit super block if fs record error when journal record
    without error
  ext4: make sure fs error flag setted before clear journal error

 fs/ext4/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.31.1

