Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5359DB83
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 04:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfH0CGQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 22:06:16 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:39784 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbfH0CGQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 22:06:16 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0TaZ5Pn4_1566871552;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TaZ5Pn4_1566871552)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 27 Aug 2019 10:05:52 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
        Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Dave Chinner <david@fromorbit.com>
Subject: [PATCH 0/3] Revert parallel dio reads
Date:   Tue, 27 Aug 2019 10:05:49 +0800
Message-Id: <1566871552-60946-1-git-send-email-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This patch set is trying to revert parallel dio reads feature at present
since it causes significant performance regression in mixed random
read/write scenario.

Joseph Qi (3):
  Revert "ext4: remove EXT4_STATE_DIOREAD_LOCK flag"
  Revert "ext4: fix off-by-one error when writing back pages before dio
    read"
  Revert "ext4: Allow parallel DIO reads"

 fs/ext4/ext4.h        | 17 +++++++++++++++++
 fs/ext4/extents.c     | 19 ++++++++++++++-----
 fs/ext4/inode.c       | 47 +++++++++++++++++++++++++++++++----------------
 fs/ext4/ioctl.c       |  4 ++++
 fs/ext4/move_extent.c |  4 ++++
 fs/ext4/super.c       | 12 +++++++-----
 6 files changed, 77 insertions(+), 26 deletions(-)

-- 
1.8.3.1

