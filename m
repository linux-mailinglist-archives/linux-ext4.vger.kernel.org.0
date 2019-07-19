Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1B936E359
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Jul 2019 11:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfGSJW3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 19 Jul 2019 05:22:29 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:45286 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfGSJW2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 19 Jul 2019 05:22:28 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TXH-bb4_1563528144;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0TXH-bb4_1563528144)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Jul 2019 17:22:25 +0800
To:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org,
        Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: [RFC] performance regression with "ext4: Allow parallel DIO reads"
Message-ID: <ab7cf51b-6b52-d151-e22c-6f4400a14589@linux.alibaba.com>
Date:   Fri, 19 Jul 2019 17:22:24 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted & Jan,
I've observed an significant performance regression with the following
commit in my Intel P3600 NVMe SSD.
16c54688592c ext4: Allow parallel DIO reads

From my initial investigation, it may be because of the
inode_lock_shared (down_read) consumes more than inode_lock (down_write)
in mixed random read write workload.

Here is my test result.

ioengine=psync
direct=1
rw=randrw
iodepth=1
numjobs=8
size=20G
runtime=600

w/ parallel dio reads : kernel 5.2.0
w/o parallel dio reads: kernel 5.2.0, then revert the following commits:
  1d39834fba99 ext4: remove EXT4_STATE_DIOREAD_LOCK flag (related)
  e5465795cac4 ext4: fix off-by-one error when writing back pages before dio read (related)
  16c54688592c ext4: Allow parallel DIO reads

bs=4k:
-------------------------------------------------------------------------------------------
w/ parallel dio reads | READ 30898KB/s, 7724, 555.00us   | WRITE 30875KB/s, 7718, 479.70us
-------------------------------------------------------------------------------------------
w/o parallel dio reads| READ 117915KB/s, 29478, 248.18us | WRITE 117854KB/s，29463, 21.91us
-------------------------------------------------------------------------------------------

bs=16k:
-------------------------------------------------------------------------------------------
w/ parallel dio reads | READ 58961KB/s, 3685, 835.28us   | WRITE 58877KB/s, 3679, 1335.98us
-------------------------------------------------------------------------------------------
w/o parallel dio reads| READ 218409KB/s, 13650, 554.46us | WRITE 218257KB/s，13641, 29.22us
-------------------------------------------------------------------------------------------

bs=64k:
-------------------------------------------------------------------------------------------
w/ parallel dio reads | READ 119396KB/s, 1865, 1759.38us | WRITE 119159KB/s, 1861, 2532.26us
-------------------------------------------------------------------------------------------
w/o parallel dio reads| READ 422815KB/s, 6606, 1146.05us | WRITE 421619KB/s, 6587, 60.72us
-------------------------------------------------------------------------------------------

bs=512k:
-------------------------------------------------------------------------------------------
w/ parallel dio reads | READ 392973KB/s, 767, 5046.35us  | WRITE 393165KB/s, 767, 5359.86us
-------------------------------------------------------------------------------------------
w/o parallel dio reads| READ 590266KB/s, 1152, 4312.01us | WRITE 590554KB/s, 1153, 2606.82us
-------------------------------------------------------------------------------------------

bs=1M:
-------------------------------------------------------------------------------------------
w/ parallel dio reads | READ 487779KB/s, 476, 8058.55us  | WRITE 485592KB/s, 474, 8630.51us
-------------------------------------------------------------------------------------------
w/o parallel dio reads| READ 593927KB/s, 580, 7623.63us  | WRITE 591265KB/s, 577, 6163.42us
-------------------------------------------------------------------------------------------

Thanks,
Joseph
