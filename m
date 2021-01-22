Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF542FFCF3
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jan 2021 07:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhAVGos (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jan 2021 01:44:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbhAVGor (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jan 2021 01:44:47 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120CBC06174A;
        Thu, 21 Jan 2021 22:44:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id s15so2653370plr.9;
        Thu, 21 Jan 2021 22:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bPJihy/Jk8wcSahUjMVfP8dARrotEDLArOJhgiyk4Z8=;
        b=QdrO7UDx1V0rGwhZVr3LEkQyrRl8QmBFYCxvboGLXQoP0KwZ2pjtEkBCvoduFtdZAO
         0dgGXXMa8zMvhHkXLTjiY2+JIrY9GrNWXW8WDuNE/q3jbQT/vl2CLm1SyXTUB70YP1xi
         VYMnSXMX85vZmdjE56Um9EQu1F2x+fy9PJEjyujGJxiO0nX/5iUazWnuUKwu0pT0BAGT
         esmPYMOMrwWGygTykWzmw2lMnUUQ3Ztrj79nNHO6kVHCEpcTXIGJF+gls29kUN3s7soK
         lv5OiUDiNcpiWeehVYkxS0Q/pi4fyJUM579Yi/n0wEfbyCh1LhmzJmrg7j3lLnKRp5qS
         qgSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bPJihy/Jk8wcSahUjMVfP8dARrotEDLArOJhgiyk4Z8=;
        b=bxkft8B+xP0JuVSpZRcG/ihCrtelECrCHlDI29lCaClfRGb1ro6B6QNCddc9W9g+ju
         rMpDNxR0IbJjEUm2HFAWqmwCcT87wuFt9PXhPpL/xOYq5xswnbqkw8rcP/wba8Sjncba
         MPJrgfKxHTT6rIXvYsXMIualHqArKu4xvQ5+XRMJkAeo18hYsq1E9/9/D2o7ErkifrSq
         bzvEn1gjeT//dY/0zL4Tu/9sjv/ytCFNJkP2pT9+zT5x3wcZlJJ/AxtjmS3p3IoDoScX
         nH1p/D9jZXotxf93prCoywnCILL7tp0nCJTcctY/DKxoOKZU/BJeOsmcdRVylr8tQfeS
         1mRQ==
X-Gm-Message-State: AOAM532A+a52TyS0s12wbAvItAH7W2LZqYW2IzpwSGp7HBWQbgx0pkna
        ujTetL4BEDKTGE3AVlySXsQ=
X-Google-Smtp-Source: ABdhPJxBtld8jqUG1nibgfU28cRuU7sqMJCr8ieDoXM2zbNHkd5oWB5LENe7pNgr0jBNf4qOdYa1fw==
X-Received: by 2002:a17:90a:b28f:: with SMTP id c15mr3531735pjr.79.1611297846543;
        Thu, 21 Jan 2021 22:44:06 -0800 (PST)
Received: from VM-0-6-centos.localdomain ([119.28.90.140])
        by smtp.gmail.com with ESMTPSA id t22sm8319641pgm.18.2021.01.21.22.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2021 22:44:06 -0800 (PST)
From:   Chunguang Xu <brookxu.cn@gmail.com>
X-Google-Original-From: Chunguang Xu <brookxu@tencent.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/4] make jbd2 debug switch per device
Date:   Fri, 22 Jan 2021 14:43:18 +0800
Message-Id: <cover.1611287342.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On a multi-disk machine, because jbd2 debugging switch is global, this
confuses the logs of multiple disks. It is not easy to distinguish the
logs of each disk and the amount of generated logs is very large. Or a
separate debugging switch for each disk would be better, so that you
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
 fs/ext4/fast_commit.c |  64 ++++++++++++----------
 fs/ext4/indirect.c    |   4 +-
 fs/ext4/inode.c       |   3 +-
 fs/ext4/namei.c       |  10 ++--
 fs/ext4/super.c       |  16 +++---
 fs/jbd2/checkpoint.c  |   6 +--
 fs/jbd2/commit.c      |  36 ++++++-------
 fs/jbd2/journal.c     | 122 +++++++++++++++++++++++++++---------------
 fs/jbd2/recovery.c    |  59 ++++++++++----------
 fs/jbd2/revoke.c      |   8 +--
 fs/jbd2/transaction.c |  35 ++++++------
 include/linux/jbd2.h  |  65 ++++++++++++++++------
 14 files changed, 257 insertions(+), 176 deletions(-)

-- 
2.30.0

