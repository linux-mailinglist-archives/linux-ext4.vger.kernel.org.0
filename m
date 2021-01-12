Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989442F2E54
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Jan 2021 12:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbhALLrt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 12 Jan 2021 06:47:49 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:45828 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730958AbhALLrs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 12 Jan 2021 06:47:48 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=xiaoguang.wang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0ULWk8Hc_1610452025;
Received: from 30.225.32.185(mailfrom:xiaoguang.wang@linux.alibaba.com fp:SMTPD_---0ULWk8Hc_1610452025)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 12 Jan 2021 19:47:06 +0800
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
From:   Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Subject: code questions about ext4_inode_datasync_dirty()
Cc:     joseph qi <joseph.qi@linux.alibaba.com>
Message-ID: <c95ac3d6-5e9c-b706-28f7-3bbe4b75964b@linux.alibaba.com>
Date:   Tue, 12 Jan 2021 19:45:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

hi,

I use io_uring to evaluate ext4 randread performance(direct io), observed
obvious overhead in jbd2_transaction_committed():
Samples: 124K of event 'cycles:ppp', Event count (approx.): 80630088951
Overhead  Command          Shared Object      Symbol
    7.02%  io_uring-sq-per  [kernel.kallsyms]  [k] jbd2_transaction_committed

The codes:
	/*
	 * Writes that span EOF might trigger an I/O size update on completion,
	 * so consider them to be dirty for the purpose of O_DSYNC, even if
	 * there is no other metadata changes being made or are pending.
	 */
	iomap->flags = 0;
	if (ext4_inode_datasync_dirty(inode) ||
	    offset + length > i_size_read(inode))
		iomap->flags |= IOMAP_F_DIRTY;

ext4_inode_datasync_dirty() calls jbd2_transaction_committed(). Sorry, I don't spend
much time to learn iomap codes yet, just ask a quick question here. Do we need to call
ext4_inode_datasync_dirty() for a read operation?

If we must call ext4_inode_datasync_dirty() for a read operation, can we improve
jbd2_transaction_committed() a bit, for example, have a quick check between
inode->i_datasync_tid and j_commit_sequence, if inode->i_datasync_tid is less than
or equal to j_commit_sequence, we also don't call jbd2_transaction_committed()?

Regards,
Xiaoguang Wang
