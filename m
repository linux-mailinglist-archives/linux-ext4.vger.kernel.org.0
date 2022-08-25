Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660C35A0F1D
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Aug 2022 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiHYLcV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 25 Aug 2022 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241632AbiHYLcQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Aug 2022 07:32:16 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B33AADCFB;
        Thu, 25 Aug 2022 04:32:12 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MD11z0rY3zlWJs;
        Thu, 25 Aug 2022 19:28:55 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (7.193.23.68) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 19:32:10 +0800
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 25 Aug 2022 19:32:09 +0800
Subject: Re: [PATCH] mm: migrate: buffer_migrate_folio_norefs() fallback
 migrate not uptodate pages
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <akpm@linux-foundation.org>,
        <mgorman@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
References: <20220825080146.2021641-1-chengzhihao1@huawei.com>
 <20220825105704.e46hz6dp6opawsjk@quack3>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <6db0b93a-76d8-e936-c57e-17cb192224f2@huawei.com>
Date:   Thu, 25 Aug 2022 19:32:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20220825105704.e46hz6dp6opawsjk@quack3>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2022/8/25 18:57, Jan Kara Ð´µÀ:
> On Thu 25-08-22 16:01:46, Zhihao Cheng wrote:
>> From: Zhang Yi <yi.zhang@huawei.com>
>>
>> Recently we notice that ext4 filesystem occasionally fail to read
>> metadata from disk and report error message, but the disk and block
>> layer looks fine. After analyse, we lockon commit 88dbcbb3a484
>> ("blkdev: avoid migration stalls for blkdev pages"). It provide a
>> migration method for the bdev, we could move page that has buffers
>> without extra users now, but it will lock the buffers on the page, which
>> breaks a lot of current filesystem's fragile metadata read operations,
>> like ll_rw_block() for common usage and ext4_read_bh_lock() for ext4,
>> these helpers just trylock the buffer and skip submit IO if it lock
>> failed, many callers just wait_on_buffer() and conclude IO error if the
>> buffer is not uptodate after buffer unlocked.
>>
>> This issue could be easily reproduced by add some delay just after
>> buffer_migrate_lock_buffers() in __buffer_migrate_folio() and do
>> fsstress on ext4 filesystem.
>>
>>    EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #73193:
>>    comm fsstress: reading directory lblock 0
>>    EXT4-fs error (device pmem1): __ext4_find_entry:1658: inode #75334:
>>    comm fsstress: reading directory lblock 0
>>
>> Something like ll_rw_block() should be used carefully and seems could
>> only be safely used for the readahead case. So the best way is to fix
>> the read operations in filesystem in the long run, but now let us avoid
>> this issue first. This patch avoid this issue by fallback to migrate
>> pages that are not uotodate like fallback_migrate_folio(), those pages
>> that has buffers may probably do read operation soon.
>>
>> Fixes: 88dbcbb3a484 ("blkdev: avoid migration stalls for blkdev pages")
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> 
> Thanks for the analysis and the fix! As you noted above this is actually a
> bug in the filesystems that they assume that locked buffer means it is
> under IO.  Usually that is the case but there are other places that lock
> the buffer without doing IO. Page migration is one of them, jbd2 machinery
> another one, there may be others.
> 
> So I think this really ought to be fixed in filesystems instead of papering
> over the bug in the migration code. I agree this is more work but we will
> reduce the technical debt, not increase it :). Honestly, ll_rw_block()
> should just die. It is actively dangerous to use. Instead we should have
> one call for readahead of bhs and the rest should be converted to
> submit_bh() or similar calls. There are like 25 callers remaining so it
> won't be even that hard.
> 
> And then we have the same buggy code as in ll_rw_block() copied to
> ext4_bread_batch() (ext4_read_bh_lock() in particular) so that needs to be
> fixed as well...
> 
> 								Honza

You are right, Jan. I totally agree with you. It seems that I shouldn't 
have been lazy.


