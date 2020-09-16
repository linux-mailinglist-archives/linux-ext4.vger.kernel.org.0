Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62F426CA22
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Sep 2020 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbgIPTrn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Sep 2020 15:47:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728094AbgIPTpU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Sep 2020 15:45:20 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 172C0ACE6C333B8D70A6;
        Wed, 16 Sep 2020 19:37:52 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 16 Sep 2020
 19:37:45 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <riteshh@linux.ibm.com>, <jack@suse.cz>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH v5 0/2] Fix dead loop in ext4_mb_new_blocks
Date:   Wed, 16 Sep 2020 19:38:57 +0800
Message-ID: <20200916113859.1556397-1-yebin10@huawei.com>
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

Jan Kara (1):
  ext4: Discard preallocations before releasing group lock

Ye Bin (1):
  ext4: Fix dead loop in ext4_mb_new_blocks

 fs/ext4/mballoc.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

-- 
2.25.4

