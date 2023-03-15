Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A682D6BAF1B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 12:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjCOLVU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 Mar 2023 07:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231785AbjCOLUk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 15 Mar 2023 07:20:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D25166D0
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id h3so19028343lja.12
        for <linux-ext4@vger.kernel.org>; Wed, 15 Mar 2023 04:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678879215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TcZe62watmsrNWNr+0xVUg5ns1bQCkpf6JEkAYSSRnQ=;
        b=jEKOTpXWBgetyvBOTcq07ZVms4OzGIZaIeNU2rzx3ydcLvu2cG2uT8OiNwi0RkzH8+
         EbireJXYYekGTGE6kq9tgYaysO5S1wmAxwgSDQ04ZQn5ISAyDtDAA04i5/tP+QUBXIgM
         qvSMLreKOTUGBxRji8i97cXAAHLnPRGzOE7OItuRWtJ76sMyRsxiwYqmwMkpgjyy1gIt
         QEh3yk98BEGhnU+9/YTx7GinRxV/xtC5NthxpnRFV1Urj0N97PtXyBCfFl/lWocXD+Dn
         lfHVlRFUxoZtpLJUvzX5MvDBXUCHocr+0jcWRlAyDtqKu8bs+8EGJlkouRIltgjL549q
         o8HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678879215;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TcZe62watmsrNWNr+0xVUg5ns1bQCkpf6JEkAYSSRnQ=;
        b=kNiZ8gUP62Q2OTTczJS4ONglSIcCos/JSseW8dfM4FsAYzvVKCpYcTk13eglT4ULFn
         /1kray71c3cvALePkAR5MMeYhV11QN8fWJvjV9C1EGFPgVFUKnlleSYadjFL/bVTPbph
         SdIFStzyYDCEj+QBCsvk99IdBvltYV0tES/gF/6O1EBSIypYs0ewqVS/WenMP2ag/48B
         GWbwjED5d5Z08fHvQcpBtyonyNpgEpxsGaBSK1BwOL+gN8YcBKn+0B+5hddmDEMZP21C
         q4uTHMfX4Ui/vKsAAYoVXDGemNc1vman0HVYx/OGudT5JD0SLl7Gggo19NmVoGrEgXyo
         W+Qg==
X-Gm-Message-State: AO0yUKV0irzopUWcC+bykDvyuPvWEJ5LS/72rQT1pP1ZkcLEPpnwSmCK
        qpWR798xXalwot2ZChPd2m/3Pw==
X-Google-Smtp-Source: AK7set/3CUMDDiss89unCTHeA53FeidCS8ibgSCy1cIYfEWTq4ghTouy+BTRT2HTVXVun1FA5IgMoA==
X-Received: by 2002:a05:651c:2220:b0:295:9829:47b0 with SMTP id y32-20020a05651c222000b00295982947b0mr955554ljq.49.1678879215485;
        Wed, 15 Mar 2023 04:20:15 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id k2-20020a2e92c2000000b00295da33c42dsm817410ljh.15.2023.03.15.04.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 04:20:14 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        djwong@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        leejones@google.com, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/5] ext4: fsmap: Consolidate fsmap_head checks
Date:   Wed, 15 Mar 2023 11:20:06 +0000
Message-Id: <20230315112011.927091-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

The sanity checks on user provided data were scattered, some fields
were checked directly after copying the data from user, but others were
checked on the ext4 internal fsmap representation, see patch 3/5.
Consolidate the logic around fsmap sanity checks.

No functional change in the code. Tested with the ext4 fsmap xfstests
027, 028, 029. All passed, see the summary reports below.

Cheers,
ta

v2:
- ext4: fsmap: Consolidate fsmap_head checks
  - split patch for easier review
  - rewrite commit message
  - new patches {1, 2, 4}/5
v1:
https://lore.kernel.org/linux-ext4/20230222131211.3898066-1-tudor.ambarus@linaro.org/

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc5-xfstests-00005-gf59f84395275 #16 SMP PREEMPT_DYNAMIC Wed Mar 15 11:06:14 UTC 2023 x86_64
CMDLINE:   ext4/027
CPUS:      2
MEM:       1975.31

ext4/4k: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/1k: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/ext3: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/encrypt: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/nojournal: 1 tests, 0 seconds
  ext4/027     Pass     0s
ext4/ext3conv: 1 tests, 1 seconds
  ext4/027     Pass     0s
ext4/adv: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/dioread_nolock: 1 tests, 1 seconds
  ext4/027     Pass     1s
ext4/data_journal: 1 tests, 0 seconds
  ext4/027     Pass     0s
ext4/bigalloc: 1 tests, 0 seconds
  ext4/027     Pass     0s
ext4/bigalloc_1k: 1 tests, 1 seconds
  ext4/027     Pass     0s
Totals: 11 tests, 0 skipped, 0 failures, 0 errors, 4s

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
[   59.850894] ACPI: PM: Preparing to enter system sleep state S5
[   59.855495] reboot: Power down

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc5-xfstests-00005-gf59f84395275 #16 SMP PREEMPT_DYNAMIC Wed Mar 15 11:06:14 UTC 2023 x86_64
CMDLINE:   ext4/028
CPUS:      2
MEM:       1975.31

ext4/4k: 1 tests, 5 seconds
  ext4/028     Pass     5s
ext4/1k: 1 tests, 2 seconds
  ext4/028     Pass     2s
ext4/ext3: 1 tests, 1 skipped, 1 seconds
  ext4/028     Skipped  0s
ext4/encrypt: 0 tests, 0 seconds
ext4/nojournal: 1 tests, 4 seconds
  ext4/028     Pass     4s
ext4/ext3conv: 1 tests, 4 seconds
  ext4/028     Pass     4s
ext4/adv: 1 tests, 4 seconds
  ext4/028     Pass     4s
ext4/dioread_nolock: 1 tests, 1 seconds
  ext4/028     Pass     0s
ext4/data_journal: 1 tests, 1 seconds
  ext4/028     Pass     0s
ext4/bigalloc: 1 tests, 5 seconds
  ext4/028     Pass     5s
ext4/bigalloc_1k: 1 tests, 2 seconds
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
[   79.583715] ACPI: PM: Preparing to enter system sleep state S5
[   79.588092] reboot: Power down

-------------------- Summary report
KERNEL:    kernel 6.2.0-rc5-xfstests-00005-gf59f84395275 #16 SMP PREEMPT_DYNAMIC Wed Mar 15 11:06:14 UTC 2023 x86_64
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
[    8.712254] reboot: Power down

Tudor Ambarus (5):
  ext4: ioctl: Add missing linux/string.h header
  ext4: fsmap: Check fmh_iflags value directly on the user copied data
  ext4: fsmap: Consolidate fsmap_head checks
  ext4: fsmap: Do the validation checks on constified fsmap data
  ext4: fsmap: Remove duplicated initialization

 fs/ext4/fsmap.c | 52 ++++++++++++++++++++++++++++++++++---------------
 fs/ext4/fsmap.h |  3 +++
 fs/ext4/ioctl.c | 18 ++++-------------
 3 files changed, 43 insertions(+), 30 deletions(-)

-- 
2.40.0.rc1.284.g88254d51c5-goog

