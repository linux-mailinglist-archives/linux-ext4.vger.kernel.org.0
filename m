Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D7069F51D
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Feb 2023 14:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231426AbjBVNMU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Feb 2023 08:12:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbjBVNMT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Feb 2023 08:12:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E212438B65
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 05:12:17 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g8so6225206lfj.2
        for <linux-ext4@vger.kernel.org>; Wed, 22 Feb 2023 05:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=93lv5W1gOoz/d8xm0kpxyYjh8rSfangydTFO3ZDvwQ8=;
        b=KfGrW9ZCFW/jZTV93li2ItPTn62M5TJhXwUjb3A6jCiRI1ZnHsbOqOEHHvESSSoMkc
         bnxl4DdZM3ti+KGqA/dz4bAnZiAOwBIsFpgCgX21XrVM91pmpNI+2eEkaoRvPfbKKRhH
         +pVqFkRleRf2Rxsx3bqpRwVft6RfPWcVCOsT4tUmC+7liM8LrbiXelfn+yvJ52IUtRqa
         OrdZgl7hK1c6x88S7GiUuP6IfEjLND+fR/2P5h681PH8QnpHNfGOkg4TQV7R11yORh5s
         XLst83TJYtNZIQ/rEcphgtdqroJL+y+vOGSIEmKxl/37cp7nPYmi6/BXkqrS5JGXtJE+
         gSCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=93lv5W1gOoz/d8xm0kpxyYjh8rSfangydTFO3ZDvwQ8=;
        b=sNfrApIZksv31WgnkC5xxR2YN7/AEQPbdi/ztO6csICH5XGN9W+JcPRmiAR1aEddLc
         TX1ay5uT6s1sltt8PopVbiCU7XBkTMNRtQSf5KZoVDRSRo1cRuParUkfwpjFIYGv3Aw/
         cRtnenI3M+UKNlIUxJiJx6dvU5oek4cdhF0E1O5DSdJxvNtrBopv9YKuXiSdfd0rNCfb
         cVpK0fvZQw+yc1ppAbUprJR7ag84nIi0eIF9C35f/C+FEgLFO8gStiuugayn/r4RJJ2L
         7t+w5vA5/eHXQEQ5WqN3cjIagwAXak+aVzSYTVml7hbtMm8yJcB4LcY0mrBEj9FUlfXN
         jYdg==
X-Gm-Message-State: AO0yUKWxLvDKijEDvNjEydNcyP2RRrpjnTTQ2s5OI6C9ibrO/kB/+bgW
        f2zp9pLssLJL1oG11pSchmU+GA==
X-Google-Smtp-Source: AK7set84+e2PcW1obnF3Ej8m1/3ZaCWaHf858/nT6me+MgLDDLj5K2dxclBsS5BbmJvKzq1WxSHkPg==
X-Received: by 2002:ac2:5312:0:b0:4b5:5ddc:da32 with SMTP id c18-20020ac25312000000b004b55ddcda32mr2598925lfh.56.1677071536155;
        Wed, 22 Feb 2023 05:12:16 -0800 (PST)
Received: from ta1.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id y25-20020a2e7d19000000b0029335c12997sm564383ljc.58.2023.02.22.05.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 05:12:15 -0800 (PST)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, darrick.wong@oracle.com, djwong@kernel.org,
        adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/3] ext4: fsmap: Improve key validation
Date:   Wed, 22 Feb 2023 13:12:08 +0000
Message-Id: <20230222131211.3898066-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the bug reported at:
https://syzkaller.appspot.com/bug?id=79d5768e9bfe362911ac1a5057a36fc6b5c30002

Darrick J. Wong proposed a similar patch to address the same bug at:
https://lore.kernel.org/linux-ext4/3e125c64-da56-2a2b-1a20-fdcc5a0d3014@linaro.org/

I think my version of the patch is better. It clearly indicates that
lower out of bounds requests are ignored. The high key should be greater
than the first data block for the ext4_getfsmap_datadev() handler,
otherwise there's no data to return, thus we exit early and ignore the
request. Darrick indirectly implied the same thing, but missed the case
where the high_key->fmr_phisical is equal to the first data block.

After the fix you'll find another patch that consolidates the validation
of the user provided data. Instead of having the checks scattered among
the fsmap representations, gather the code in a single method and do the
checks directly on the data received from user.
Similar patch can be done for xfs fsmap, but I'll wait for some
feedback first.

Tested the changes with kvm-xfstests: ext4/{027, 028, 029}, all passed,
output below.

Cheers,
ta

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc8-xfstests-00003-gc34cc283e325 #13 SMP PREEMPT_DYNAMIC Wed Feb 22 12:35:39 UTC 2023 x86_64
CMDLINE:   ext4/027
CPUS:      2
MEM:       1975.3

ext4/4k: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/1k: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/ext3: 1 tests, 2 seconds
  ext4/027     Pass     1s
ext4/encrypt: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/nojournal: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/ext3conv: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/adv: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/dioread_nolock: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/data_journal: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/bigalloc: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/bigalloc_1k: 1 tests, 1 seconds
  ext4/027     Pass     0s
Totals: 11 tests, 0 skipped, 0 failures, 0 errors, 6s

FSTESTVER: blktests 4e07b0c (Fri, 15 Jul 2022 14:40:03 +0900)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5 (Sun, 6 Feb 2022 10:59:13 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-43-gd2256ac (Fri, 17 Sep 2021 14:04:16 +0200)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v5.19.0 (Fri, 12 Aug 2022 13:45:01 -0500)
FSTESTVER: xfstests v2022.08.21-8-g289f50f8 (Sun, 21 Aug 2022 15:21:34 -0400)
FSTESTVER: xfstests-bld bb566bcf (Wed, 24 Aug 2022 23:07:24 -0400)
FSTESTVER: zz_build-distro bullseye
FSTESTCFG: all
FSTESTSET: ext4/027
FSTESTOPT: aex
[   59.553199] ACPI: PM: Preparing to enter system sleep state S5
[   59.557660] reboot: Power down

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc8-xfstests-00003-gc34cc283e325 #13 SMP PREEMPT_DYNAMIC Wed Feb 22 12:35:39 UTC 2023 x86_64
CMDLINE:   ext4/028
CPUS:      2
MEM:       1975.31

ext4/4k: 1 tests, 1 seconds
  ext4/028     Pass     1s
ext4/1k: 1 tests, 3 seconds
  ext4/028     Pass     3s
ext4/ext3: 1 tests, 1 skipped, 1 seconds
  ext4/028     Skipped  1s
ext4/encrypt: 0 tests, 0 seconds
ext4/nojournal: 1 tests, 4 seconds
  ext4/028     Pass     4s
ext4/ext3conv: 1 tests, 5 seconds
  ext4/028     Pass     4s
ext4/adv: 1 tests, 4 seconds
  ext4/028     Pass     4s
ext4/dioread_nolock: 1 tests, 1 seconds
  ext4/028     Pass     1s
ext4/data_journal: 1 tests, 1 seconds
  ext4/028     Pass     1s
ext4/bigalloc: 1 tests, 5 seconds
  ext4/028     Pass     5s
ext4/bigalloc_1k: 1 tests, 3 seconds
  ext4/028     Pass     2s
Totals: 10 tests, 1 skipped, 0 failures, 0 errors, 26s

FSTESTVER: blktests 4e07b0c (Fri, 15 Jul 2022 14:40:03 +0900)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5 (Sun, 6 Feb 2022 10:59:13 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-43-gd2256ac (Fri, 17 Sep 2021 14:04:16 +0200)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v5.19.0 (Fri, 12 Aug 2022 13:45:01 -0500)
FSTESTVER: xfstests v2022.08.21-8-g289f50f8 (Sun, 21 Aug 2022 15:21:34 -0400)
FSTESTVER: xfstests-bld bb566bcf (Wed, 24 Aug 2022 23:07:24 -0400)
FSTESTVER: zz_build-distro bullseye
FSTESTCFG: all
FSTESTSET: ext4/028
FSTESTOPT: aex
[   76.557142] EXT4-fs (vdg): unmounting filesystem 3149a29d-9b44-4c17-82a6-c86addd7f1bb.
[   76.592295] ACPI: PM: Preparing to enter system sleep state S5
[   76.597019] reboot: Power down

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc8-xfstests-00003-gc34cc283e325 #13 SMP PREEMPT_DYNAMIC Wed Feb 22 12:35:39 UTC 2023 x86_64
CMDLINE:   -c logdev ext4/029
CPUS:      2
MEM:       1975.31

ext4/logdev: 1 tests, 1 seconds
  ext4/029     Pass     1s
Totals: 1 tests, 0 skipped, 0 failures, 0 errors, 1s

FSTESTVER: blktests 4e07b0c (Fri, 15 Jul 2022 14:40:03 +0900)
FSTESTVER: fio  fio-3.31 (Tue, 9 Aug 2022 14:41:25 -0600)
FSTESTVER: fsverity v1.5 (Sun, 6 Feb 2022 10:59:13 -0800)
FSTESTVER: ima-evm-utils v1.3.2 (Wed, 28 Oct 2020 13:18:08 -0400)
FSTESTVER: nvme-cli v1.16 (Thu, 11 Nov 2021 13:09:06 -0800)
FSTESTVER: quota  v4.05-43-gd2256ac (Fri, 17 Sep 2021 14:04:16 +0200)
FSTESTVER: util-linux v2.38.1 (Thu, 4 Aug 2022 11:06:21 +0200)
FSTESTVER: xfsprogs v5.19.0 (Fri, 12 Aug 2022 13:45:01 -0500)
FSTESTVER: xfstests v2022.08.21-8-g289f50f8 (Sun, 21 Aug 2022 15:21:34 -0400)
FSTESTVER: xfstests-bld bb566bcf (Wed, 24 Aug 2022 23:07:24 -0400)
FSTESTVER: zz_build-distro bullseye
FSTESTCFG: logdev
FSTESTSET: ext4/029
FSTESTOPT: aex
[    8.217384] reboot: Power down

Tudor Ambarus (3):
  ext4: fsmap: Fix crash caused by poor key validation
  ext4: fsmap: Consolidate fsmap_head checks
  ext4: fsmap: Remove duplicated initialization

 fs/ext4/fsmap.c | 56 +++++++++++++++++++++++++++++++++++--------------
 fs/ext4/fsmap.h |  3 +++
 fs/ext4/ioctl.c | 17 +++------------
 3 files changed, 46 insertions(+), 30 deletions(-)

-- 
2.39.2.637.g21b0678d19-goog

