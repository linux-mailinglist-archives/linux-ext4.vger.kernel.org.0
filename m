Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 102A747E8B5
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Dec 2021 21:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbhLWUVx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 15:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240669AbhLWUVx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 15:21:53 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB4C061401
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:53 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id v16so5915280pjn.1
        for <linux-ext4@vger.kernel.org>; Thu, 23 Dec 2021 12:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHW20gq3zYEGj4pmrQnn/yEzcBmjNkoaVoXOsYGnrZQ=;
        b=iziRDyFyZUJcpsK9GvJLsNOqIGGSmHp6r2a05E619GRyHZE2o8+JsQ1lliOTGDeRKi
         s8P5pZ4iaGiL6YMtYkmUXfoMbs6nZPjemR2yAT+/JYeQU8wfhpPyBIMIAHnyPFEmyseU
         wb0gS+UqM8l35Q1H3ivXAIuREkckZQLX+AVDDD40qn5jEb0E5Vg4a8nFE12UJo31AV+5
         4D2TPh+cY6pw/fcisnIN9G685b/skAFoQnWC4HVsayI0zbQ31AQoD/CQfvXuCPLNmJ3p
         F5mZoBo/RDPOwVMl7LO/h3A3dpcCmesvYuLLIBtdtCHyE9tYpbsQy5mEXtYl68TdIupQ
         2LQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rHW20gq3zYEGj4pmrQnn/yEzcBmjNkoaVoXOsYGnrZQ=;
        b=AT30YZMbk0/ri2wldZLfc8YuWlIBs0BJKQq5CWRpCz7xws58Sp5RZHBO3bi4yFc0eb
         eY4AEkLKbb2BYCAu5abrzSuzDU5EMeGWTn4jQicNh/+Hojpyz/4F6pX0R/PiCI0ReBF9
         h0aFJI60FPe1nyYlnC0ZiJ7dTQCwvXOfb/69br8CAf96AcnCfhPZv9hda0lQwmVzKm6G
         ld5EjvusbqlbsJgALa642a7XIY2JqtPxSEWMbW7b5hQ4AGPboyf8twEgx1lTFgyEZGei
         eksT07ZakdmN99b1TSvzJ/LM5A+cbLIZkrgpHjHRaRqGIb0tD2bo1xbDAQpzLcitXBBF
         7/ig==
X-Gm-Message-State: AOAM5319lEwEk+5pgYqsH9sGdcUHN2F7mO7HdhX2LjFss1aHAWYPHhHc
        xzA+Lq5qJdyZ61iD0FWxk0h/l86vmPA=
X-Google-Smtp-Source: ABdhPJyxsa/Eg3RMD7jmIKOfHObA/zdraoB41ttghsBqHpX2XvnbC6I0hNArvWSb7DY/QAY4tdHqlg==
X-Received: by 2002:a17:902:7085:b0:148:adf5:f5fe with SMTP id z5-20020a170902708500b00148adf5f5femr3602009plk.85.1640290912441;
        Thu, 23 Dec 2021 12:21:52 -0800 (PST)
Received: from harshads-520.kir.corp.google.com ([2620:15c:17:10:404a:8e2b:a329:bed6])
        by smtp.googlemail.com with ESMTPSA id lx8sm10351074pjb.18.2021.12.23.12.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 12:21:51 -0800 (PST)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
X-Google-Original-From: Harshad Shirwadkar <harshads@google.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshads@google.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [PATCH v2 0/4] ext4 fast commit API cleanup
Date:   Thu, 23 Dec 2021 12:21:36 -0800
Message-Id: <20211223202140.2061101-1-harshads@google.com>
X-Mailer: git-send-email 2.34.1.448.ga2b2bfdf31-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series fixes up fast commit APIs. There are NO on-disk
format changes introduced in this series. The main contribution of the
series is that it drops fast commit specific transaction APIs and
makes fast commits work with journal transaction APIs of JBD2
journalling system. With these changes, a fast commit eligible
transaction is simply enclosed in calls to "jbd2_journal_start()" and
"jbd2_journal_stop()". If the update that is being performed is fast
commit ineligible, one must simply call ext4_fc_mark_ineligible()
after starting a transaction using "jbd2_journal_start()". The last
patch in the series simplifies fast commit stats recording by moving
it to a different function.

I verified that the patch series introduces no regressions in "quick"
and "log" groups when "fast_commit" feature is enabled.

Changes from V1:
---------------

- In the V1 of the patch series, there's performance regression. With
  this patch series, we lock the entire file system from starting any
  new handles during (which ensures consistency at the cost of
  performance). What we ideally want to do is to lock individual
  inodes from starting new updates during a commit. To do so, the V2
  of this patch series retains the infrastructure of inode level
  transactions (ext4_fc_start/stop_update()). In future (not in this
  series), we would build on this infrastructure to lock individual
  inodes and drop the file system level locking during the commit path.

Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

Harshad Shirwadkar (4):
  ext4: use ext4_journal_start/stop for fast commit transactions
  ext4: drop ineligible txn start stop APIs
  ext4: simplify updating of fast commit stats
  ext4: update fast commit TODOs

 fs/ext4/acl.c         |   2 -
 fs/ext4/ext4.h        |   7 +-
 fs/ext4/extents.c     |   9 +-
 fs/ext4/fast_commit.c | 188 ++++++++++++++++--------------------------
 fs/ext4/fast_commit.h |  27 +++---
 fs/ext4/file.c        |   4 -
 fs/ext4/inode.c       |   7 +-
 fs/ext4/ioctl.c       |  13 +--
 fs/ext4/super.c       |   1 -
 fs/jbd2/journal.c     |   2 +
 10 files changed, 96 insertions(+), 164 deletions(-)

-- 
2.34.1.307.g9b7440fafd-goog

