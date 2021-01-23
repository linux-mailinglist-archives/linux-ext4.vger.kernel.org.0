Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 169663014EF
	for <lists+linux-ext4@lfdr.de>; Sat, 23 Jan 2021 13:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726637AbhAWMCO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 23 Jan 2021 07:02:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbhAWMCN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 23 Jan 2021 07:02:13 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C85DC06174A;
        Sat, 23 Jan 2021 04:01:33 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id w14so5557216pfi.2;
        Sat, 23 Jan 2021 04:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=xF36MGLCsxggSjMA46WhSwB7+yR8lPhJZ7ontH36Elw=;
        b=Ka0jclfRVsjyUo+y1gk+OLNt9D4t5tfTc3fZiQBG8fPlw70Yro4M+Kh2hw5A6bW/PZ
         o6MFfsXM/YxcjJCn5EVidhUK58rWyTTDbphFm+Z5OxYs6uCtBT12kjmugS5lGsRRx+oJ
         GKO96b0dbKhlFwmEpQECnsIwOZoApYaYBi3bm+RBmHQLezJkKLm+0aGzsESvnK8l+th0
         QU/zjVH6eu866jHsh/Q5jeuHVk89bjL7vbxjpaiEjlrvIjfJJeBFKfwk4VXEA+q0SDmX
         xAozk5YmIoIjP7PtRhoq7I6s7dYoobqxkRaUWZNMAPDELVIT0ylVQFZjJPxrtLyu11hI
         kFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xF36MGLCsxggSjMA46WhSwB7+yR8lPhJZ7ontH36Elw=;
        b=jyJP5jtQTRiCiPo21Rf09ej0pczROQ1kgwwGaY3/uDP0pZRthFACK6eGql8y0BFdso
         XXF6MJ7+fFk6DUUsN0XEt/Ix1PZtNOI4MTP1ZALbaV0DbO75tEPCm79/bzUi96jpAj1C
         d5YZJCOhb9T+2rpjMCaG60g/SmmAU5J9ETqSs/yIvZAnf5r0UKO/69N2VfTIVDxd7EaE
         uRExDsDETga49IzyQwvTg9ed9Aik0NQxm5LdcHVnP7X0B0dYbjpEUgudZausi5tVSu//
         l0DM9dneG5C3sBfZ8otFtyv5rl4jjAR1QW0L4/vlPf73XsGbRhhLlhCYb6m/6YLSUFDB
         b2Tw==
X-Gm-Message-State: AOAM531hR8CoQ8XScOf7WvofaMIByvvV90CvbInapjnolu39NcArSab5
        y1Ws3TytL46EBe3M6LZZYMg=
X-Google-Smtp-Source: ABdhPJzlrv8dMPwFpuqdTLoQy2fa0t3pDjeflodref341ex2xHqxzjm3SpQf5A8ee1l6jfOtg0dugQ==
X-Received: by 2002:a63:4c09:: with SMTP id z9mr582817pga.260.1611403291961;
        Sat, 23 Jan 2021 04:01:31 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id x19sm11854648pfp.207.2021.01.23.04.01.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2021 04:01:30 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] make jbd2 debug switch per device
Date:   Sat, 23 Jan 2021 20:00:42 +0800
Message-Id: <cover.1611402263.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On a multi-disk machine, because jbd2 debugging switch is global, this
confuses the logs of multiple disks. It is not easy to distinguish the
logs of each disk and the amount of generated logs is very large. Maybe
a separate debugging switch for each disk would be better, so that we
can easily distinguish the logs of a certain disk. 

We can enable jbd2 debugging of a device in the following ways:
echo X > /proc/fs/jbd2/sdX/jbd2_debug

But there is a small disadvantage here. Because the debugging switch is
placed in the journal_t object, the log before the object is initialized
will be lost. However, usually this will not have much impact on
debugging.

Chunguang Xu (4):
  jbd2: make jdb2_debug module parameter per device
  jbd2: introduce some new log interfaces
  jbd2: replace jbd_debug with the new log interface
  ext4: replace jbd_debug with the new log interface

 fs/ext4/balloc.c      |   2 +-
 fs/ext4/ext4_jbd2.c   |   3 +-
 fs/ext4/fast_commit.c |  64 +++++++++++++-----------
 fs/ext4/indirect.c    |   4 +-
 fs/ext4/inode.c       |   3 +-
 fs/ext4/namei.c       |  10 ++--
 fs/ext4/super.c       |  16 +++---
 fs/jbd2/checkpoint.c  |   6 +--
 fs/jbd2/commit.c      |  36 ++++++-------
 fs/jbd2/journal.c     | 114 +++++++++++++++++++++++++++++-------------
 fs/jbd2/recovery.c    |  59 +++++++++++-----------
 fs/jbd2/revoke.c      |   8 +--
 fs/jbd2/transaction.c |  35 ++++++-------
 include/linux/jbd2.h  |  66 +++++++++++++++++-------
 14 files changed, 258 insertions(+), 168 deletions(-)

-- 
2.30.0

