Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D343B1B70FC
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Apr 2020 11:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgDXJeG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Apr 2020 05:34:06 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:47858 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726628AbgDXJeG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 24 Apr 2020 05:34:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TwVqLjy_1587720843;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0TwVqLjy_1587720843)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 24 Apr 2020 17:34:04 +0800
From:   Jeffle Xu <jefflexu@linux.alibaba.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, joseph.qi@linux.alibaba.com,
        Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: [PATCH RFC 0/2] fsx: make fsx perceptive to cluster size
Date:   Fri, 24 Apr 2020 17:33:48 +0800
Message-Id: <1587720830-11955-1-git-send-email-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Offset and size should be aligned with cluster_size when inserting or
collapsing range on ext4 with 'bigalloc' enabled. Currently fsx only
align offset/size with block size.

In fact I have no idea which is the best way to fix this isue. On one hand,
fsx should be general and has no knowledge of the underlying filesystem.
Besides the cluster size seems to be stored on ext4_super_block and there's
no easy way to get it. But on the oter hand, quite many tests call fsx
directly, e.g., generic/127, rather than the generic routine run_fsx()
defined in common/rc.


Jeffle Xu (2):
  xfstests: fsx: add support for cluster size
  xfstests: common/rc: add cluster size support for ext4

 common/rc |  9 +++++++++
 ltp/fsx.c | 20 ++++++++++++++------
 2 files changed, 23 insertions(+), 6 deletions(-)

-- 
1.8.3.1

