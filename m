Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CF6FB3FC
	for <lists+linux-ext4@lfdr.de>; Mon,  8 May 2023 17:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbjEHPml (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 May 2023 11:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbjEHPmj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 May 2023 11:42:39 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD998A49
        for <linux-ext4@vger.kernel.org>; Mon,  8 May 2023 08:42:37 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4f14f266b72so2975103e87.1
        for <linux-ext4@vger.kernel.org>; Mon, 08 May 2023 08:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683560556; x=1686152556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/k9mXeLq47jt42cr5C/5Uc1LW2DaBuDnesO/cJRWcvM=;
        b=BscybJtUZ9QX8GUfeknwxReMN3x3VDKuIe/SS+YwPMjM3NybAL9ZEQcoIqPzOxXOqE
         g4o4ab0OL53G10jRFbs4Vx9qtxWzO9Y7zbiBHPiYF7ytGSiBZjx8ulgnbHG+1PoOQkjz
         J8+P5m75lab04gxJNZVrZan/tD3wiTK/b+KoIY2vj9UghDI1t1zG1Mr3Wfi9puU/zobv
         0epJpsm1yVJK4WuV19r/aKSEjgQFazC/zuCkO3qdLuGURnKnrufo/T5OZCVVHONAyJZa
         RZxfvicXJ/UubdefaCFT4RcdtLmeRV1/LPSB7/YnsIsYDvpgb+xE618mSwZhsk2QBV2H
         NHOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683560556; x=1686152556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/k9mXeLq47jt42cr5C/5Uc1LW2DaBuDnesO/cJRWcvM=;
        b=cYSex7Y1RTtf/sFvr66/LbzbbBafR0CzZWAzbq2AvKT9YAtGTssHqRsZxbRBzLTpGw
         qefs/PkojFW75S10CsyTCdZ/3Vv7P86JDmrG7FhY3R1tS6AwUeGsgAWwws/966grZ83t
         zqqe8dtawI918Y/UhAZolRPZgvQnZ+Z1A8dbY63l8Aqs8NPgP0+rc1/iinz3V9+CrFhb
         mywhdqAuBsci97iGsfbGu3dgScXDJq9S7xpS4ip81kb6nnoszSHxi+R+Xmap9/sJ6gG6
         ZiNQ5I4URXKKv0muRXKKu73FoWkrJSj3D/MAcLpuLvz5j2AnIWYaZIXTFqPKcXUyHmvq
         onvQ==
X-Gm-Message-State: AC+VfDzh0yLpDcBTWIOOHtk42Qn0qAmcTe80tLWqi45c+X4lAKdQpFrc
        vSh1+61+qPZ/W+uf/SpFIYHjrw==
X-Google-Smtp-Source: ACHHUZ7Qo3PGwyGqRifkVme2GcUiS1DV5DY9Q0J/1o9pRvjyoiN9e8F2ZqjpW2xMy9tCL2YWOme9Sw==
X-Received: by 2002:a2e:a30c:0:b0:2a8:ea22:28a8 with SMTP id l12-20020a2ea30c000000b002a8ea2228a8mr3163016lje.15.1683560555861;
        Mon, 08 May 2023 08:42:35 -0700 (PDT)
Received: from ta1.c.googlers.com.com (61.215.228.35.bc.googleusercontent.com. [35.228.215.61])
        by smtp.gmail.com with ESMTPSA id a21-20020a2e9815000000b002ad9b741959sm17720ljj.76.2023.05.08.08.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 08:42:35 -0700 (PDT)
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     tytso@mit.edu
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, joneslee@google.com,
        Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [RESEND PATCH v2 0/5] ext4: fsmap: Consolidate fsmap_head checks
Date:   Mon,  8 May 2023 15:42:25 +0000
Message-ID: <20230508154230.159654-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.40.1.521.gf1e218fcd8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The sanity checks on user provided data were scattered along three
representations of the keys. This is not only difficult to follow but
also inefficient in case one of the checks returns an error because we
waste CPU cycles by copying data and preparing other local structures
that won't be used in case of errors.
Consolidate the logic around fsmap sanity checks.

No functional change in the code. Tested with the ext4 fsmap xfstests
027, 028, 029. All passed, see the summary reports below.

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
2.40.1.521.gf1e218fcd8-goog

