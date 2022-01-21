Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76175495A5E
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Jan 2022 08:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378849AbiAUHML (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Jan 2022 02:12:11 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:59418 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348854AbiAUHMI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 21 Jan 2022 02:12:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V2PmKif_1642749125;
Received: from localhost(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0V2PmKif_1642749125)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 21 Jan 2022 15:12:06 +0800
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
To:     akpm@linux-foundation.org, tytso@mit.edu, adilger.kernel@dilger.ca
Cc:     gautham.ananthakrishna@oracle.com, ocfs2-devel@oss.oracle.com,
        linux-ext4@vger.kernel.org
Subject: [PATCH 0/2] ocfs2: fix a deadlock case 
Date:   Fri, 21 Jan 2022 15:12:03 +0800
Message-Id: <20220121071205.100648-1-joseph.qi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is trying to fix a deadlock case in ocfs2.
We firstly export jbd2 symbols jbd2_journal_[grab|put]_journal_head as
preparation and later use them in ocfs2 insread of
jbd_[lock|unlock]_bh_journal_head to fix the deadlock.

Joseph Qi (2):
  jbd2: export jbd2_journal_[grab|put]_journal_head
  ocfs2: fix a deadlock when commit trans

 fs/jbd2/journal.c   |  2 ++
 fs/ocfs2/suballoc.c | 25 +++++++++++--------------
 2 files changed, 13 insertions(+), 14 deletions(-)

-- 
2.19.1.6.gb485710b

