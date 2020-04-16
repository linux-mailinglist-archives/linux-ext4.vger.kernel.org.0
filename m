Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2841AC574
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Apr 2020 16:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503185AbgDPOTf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Apr 2020 10:19:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2383 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2442450AbgDPOTY (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 16 Apr 2020 10:19:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 13ACFF3664D218E272C3;
        Thu, 16 Apr 2020 22:19:16 +0800 (CST)
Received: from [127.0.0.1] (10.166.212.218) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Thu, 16 Apr 2020
 22:19:06 +0800
From:   yangerkun <yangerkun@huawei.com>
Subject: [QUESTION] BUG_ON in ext4_mb_simple_scan_group
To:     <tytso@mit.edu>, <jack@suse.cz>, <dmonakhov@gmail.com>,
        <adilger@dilger.ca>, <bob.liu@oracle.com>, <wshilong@ddn.com>,
        "zhangyi (F)" <yi.zhang@huawei.com>
CC:     <linux-ext4@vger.kernel.org>
Message-ID: <9ba13e20-2946-897d-0b81-3ea7b21a4db6@huawei.com>
Date:   Thu, 16 Apr 2020 22:19:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.212.218]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Nowadays, we trigger the a bug that has been reported before[1](trigger 
the bug with read block bitmap error before). After search the patch,
I found some related patch which has not been included in our kernel.

eb5760863fc2 ext4: mark block bitmap corrupted when found instead of BUGON
736dedbb1a7d ext4: mark block bitmap corrupted when found
206f6d552d0c ext4: mark inode bitmap corrupted when found
db79e6d1fb1f ext4: add new ext4_mark_group_bitmap_corrupted() helper
0db9fdeb347c ext4: fix wrong return value in ext4_read_inode_bitmap()

Maybe this patch can fix the problem, but I am a little confused with
the explain from Ted described in the mail:

 > What probably happened is that the page containing actual allocation
 > bitmap was pushed out of memory due to memory pressure.  However, the
 > buddy bitmap was still cached in memory.  That's actually quite
 > possible since the buddy bitmap will often be referenced more
 > frequently than the allocation bitmap (for example, while searching
 > for free space of a specific size, and then having that block group
 > skipped when it's not available).

 > Since there was an I/O error reading the allocation bitmap, the buffer
 > is not valid.  So it's not surprising that the BUG_ON(k >= max) is
 > getting triggered.

(Our machine: x86, 4K page size, 4K block size)

After check the related code, we found that once we get a IO error from 
ext4_wait_block_bitmap, ext4_mb_init_cache will return directly with a 
error number, so the latter ext4_mb_simple_scan_group may never been 
called! So any other scene will trigger this BUG_ON?

Thanks,
Kun.

-----
[1] https://www.spinics.net/lists/linux-ext4/msg60329.html

