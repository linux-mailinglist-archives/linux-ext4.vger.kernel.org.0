Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 250FC4BF7E
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Jun 2019 19:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfFSRWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Jun 2019 13:22:22 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39953 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729659AbfFSRWV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 19 Jun 2019 13:22:21 -0400
Received: by mail-io1-f68.google.com with SMTP id n5so293867ioc.7
        for <linux-ext4@vger.kernel.org>; Wed, 19 Jun 2019 10:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4I5Ty62o91Pugxcg1FTgTnvgf8oL/T0SugxfMdF360=;
        b=gb4iGaYnPJYNqGfAxkP3X1NyZrCyL5DKEUxf/+boDKefd2UjG+qdworr0YK1ObtumN
         6uLmt1ytGOjQmAyYXv5eWn2+e/wwvBH4V0YZ02cusIrDbo9JldyQ2tukswmk+W03TQCZ
         3fJ2x8pKx2vhpksYet+kdD7iF28u6Vzn2HBLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4I5Ty62o91Pugxcg1FTgTnvgf8oL/T0SugxfMdF360=;
        b=Z3hvsENXUx8jyDDuoaq2PmvryOqY0YnHEvQhCYxv2oSrllztEhXMrMGlhVuuUBR6Um
         MBZHIndS9qfhMQq/3GGLvKX3zDRkVBgdWFIcqAI9yF9eFYpcaNZ2nZrW1EjdXT3irNvm
         Ne3GvjE7mbjlToFCFqyc5QglyD2jajTf451ImELBL3WZaxzK3Ib5Lco8G1uC3VDt1Xd6
         YdojPwpi7Q11cdNFSP5aQl6EyTJ+Bqt0n6IvSImtM+Yh1QC0TFS/5DqECnzOIcAxUDtG
         zc18QbHy5soURHEiOXIwJ6f7oUwVIMYgqblVOy7y6zqPXfQsioDv0w2WwxD82VZmHPde
         kmEw==
X-Gm-Message-State: APjAAAWCBwwUsk4BS7eb8mV5AwF798M2CzdhNBCtaG+dk1KgUw0QjUy1
        l7MjMztiktLBnWHQypzWqgSCmg==
X-Google-Smtp-Source: APXvYqweh9cE0ZdyorzDcYNOiMgH/757F101nec4Tfciidd/HUUM94okf25BnwroKGtoHIwyBfvbEQ==
X-Received: by 2002:a02:ce37:: with SMTP id v23mr11907871jar.2.1560964940961;
        Wed, 19 Jun 2019 10:22:20 -0700 (PDT)
Received: from localhost ([2620:15c:183:200:855f:8919:84a7:4794])
        by smtp.gmail.com with ESMTPSA id z26sm16377581ioi.85.2019.06.19.10.22.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 10:22:20 -0700 (PDT)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>, "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>
Subject: [PATCH 0/3] Add dirty range scoping to jbd2
Date:   Wed, 19 Jun 2019 11:21:53 -0600
Message-Id: <20190619172156.105508-1-zwisler@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch series fixes the issue I described here:

https://www.spinics.net/lists/linux-block/msg38274.html

Essentially the issue is that journal_finish_inode_data_buffers() operates
on the entire address space of each of the inodes associated with a given
journal entry.  This means that if we have an inode where we are constantly
appending dirty pages we can end up waiting for an indefinite amount of
time in journal_finish_inode_data_buffers().

This series improves this situation in ext4 by scoping each of the inode
dirty ranges associated with a given transaction.  Other users of jbd2
which don't (yet?) take advantage of this scoping (ocfs2) will continue to
have the old behavior.

Ross Zwisler (3):
  mm: add filemap_fdatawait_range_keep_errors()
  jbd2: introduce jbd2_inode dirty range scoping
  ext4: use jbd2_inode dirty range scoping

 fs/ext4/ext4_jbd2.h   | 12 +++++------
 fs/ext4/inode.c       | 13 +++++++++---
 fs/ext4/move_extent.c |  3 ++-
 fs/jbd2/commit.c      | 26 +++++++++++++++++------
 fs/jbd2/journal.c     |  2 ++
 fs/jbd2/transaction.c | 49 ++++++++++++++++++++++++-------------------
 include/linux/fs.h    |  2 ++
 include/linux/jbd2.h  | 22 +++++++++++++++++++
 mm/filemap.c          | 22 +++++++++++++++++++
 9 files changed, 114 insertions(+), 37 deletions(-)

-- 
2.22.0.410.gd8fdbe21b5-goog

