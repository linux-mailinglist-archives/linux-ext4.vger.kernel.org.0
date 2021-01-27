Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7924D3055DC
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 09:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhA0Ifl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 03:35:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhA0IXb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 03:23:31 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB30C061573;
        Wed, 27 Jan 2021 00:22:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id h15so620210pli.8;
        Wed, 27 Jan 2021 00:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=r5A4YkHNHqnDPRqviYDqEEnsQ+dE0Ohb2lYumOvQAN0=;
        b=OT3Jd26/ozdaMcSy7EHqgHPXLRt983ztF3aXYZdMqWD7T3NiYQRsSFsuZ1CVvXbxfa
         tXgsteF5pDOguWud3Yj09OS314PCztXADGzMUTX5rCjFS/8AQWw8G+LWp02HmWX1b5BM
         DLq411MfkHR3yw+7I2lIz2jVopN+CMCHEM7M6aO82ncsOLuN/5b98HGec2i0Iqe4x7Hk
         NOqzZxeIoYo1UiKhGjHdc9SdnPnyRP9xT2MHncXZ8+PL3lnwZ15Tm9CaVaReQ68gPSw5
         vKasJSbVthTuoxKmNE3KtfuF8+WHvn82ziMulje+Z0Pz+zQmP6/1VrW8Yp4QoOHXx5ql
         6wYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=r5A4YkHNHqnDPRqviYDqEEnsQ+dE0Ohb2lYumOvQAN0=;
        b=iN5nvoWYG9G6HNxEL6YhBfhNrQHnNCvMQZrIysYMGFLKUcpXq2DPFXwFdErxepqJBs
         4crKBMab4vcpRklf2SkL6YjraIwvUl1liZAv7g9ZD01/ZdTAcuKYZcxXFJddMil7jTdx
         jqHEo3tJ+DeEW6XEwzfMqkhmEgGIMsohPUAGXfttfKg9YdLuRW64LfRQVhfoP8r63oBZ
         OrM/aq2x8Q+DQavhaoFY7iyuFb8DirRJDzHxmRlD5PR3xmEBTgjlCMFe5NY4HLiVUlth
         5TrJ8yHLRtLrnUZhzEEykVAMvUO8GkZcrRJ2nypMXAMqWorOZqEYXucOtZNEw7P9zZGU
         m7kQ==
X-Gm-Message-State: AOAM5303pMaGlmSYAoI00fMK6t/K1ybH1POfdiY2alRL2ez2mY4goVK4
        uRvpEsaPwePufq2LvX6Yo8h66YInHJg=
X-Google-Smtp-Source: ABdhPJx8gt1AiLWwQME0dOppV+vdqseFYg0o4AxmmSIPKBfs46X8yQ82FW8hE2ssnSU1r/ivbLcusw==
X-Received: by 2002:a17:902:6a82:b029:da:fc41:bafe with SMTP id n2-20020a1709026a82b02900dafc41bafemr10421234plk.20.1611735770972;
        Wed, 27 Jan 2021 00:22:50 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id q17sm1499902pfl.143.2021.01.27.00.22.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jan 2021 00:22:50 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v3 0/3] make jbd2 debug switch per device
Date:   Wed, 27 Jan 2021 16:22:03 +0800
Message-Id: <cover.1611733806.git.brookxu@tencent.com>
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

Chunguang Xu (3):
  jbd2: make jdb2_debug module parameter per device
  jbd2: update the arguments of jbd_debug()
  ext4: update the arguments of jbd_debug()

 fs/ext4/balloc.c      |   2 +-
 fs/ext4/ext4_jbd2.c   |   4 +-
 fs/ext4/fast_commit.c |  60 ++++++++++++++-----------
 fs/ext4/indirect.c    |   4 +-
 fs/ext4/inode.c       |   3 +-
 fs/ext4/namei.c       |  10 ++---
 fs/ext4/super.c       |  15 ++++---
 fs/jbd2/checkpoint.c  |   6 +--
 fs/jbd2/commit.c      |  32 ++++++-------
 fs/jbd2/journal.c     | 101 ++++++++++++++++++++++++++++++++----------
 fs/jbd2/recovery.c    |  32 ++++++-------
 fs/jbd2/revoke.c      |   8 ++--
 fs/jbd2/transaction.c |  30 ++++++-------
 include/linux/jbd2.h  |  41 ++++++++++-------
 14 files changed, 209 insertions(+), 139 deletions(-)

-- 
2.30.0

