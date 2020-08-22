Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E574224E65F
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 10:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgHVIWn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 04:22:43 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10254 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbgHVIWm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Aug 2020 04:22:42 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 10A266D5D679CDE46B1F;
        Sat, 22 Aug 2020 16:22:38 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 16:22:31 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: [PATCH 0/2] Fix race between do_invalidatepage and init_page_buffers
Date:   Sat, 22 Aug 2020 16:22:16 +0800
Message-ID: <20200822082218.2228697-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Ye Bin (2):
  ext4: Add comment to BUFFER_FLAGS_DISCARD for search code
  jbd2: Fix race between do_invalidatepage and init_page_buffers

 fs/buffer.c                 | 12 +++++++++++-
 fs/jbd2/journal.c           |  7 +++++++
 include/linux/buffer_head.h |  2 ++
 3 files changed, 20 insertions(+), 1 deletion(-)

-- 
2.25.4

