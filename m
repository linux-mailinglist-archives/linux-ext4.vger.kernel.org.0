Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94D072DC17
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jun 2023 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235447AbjFMINN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jun 2023 04:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjFMINM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jun 2023 04:13:12 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745C126
        for <linux-ext4@vger.kernel.org>; Tue, 13 Jun 2023 01:13:10 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QgLpR4KjHzqTFk;
        Tue, 13 Jun 2023 16:10:39 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 16:13:07 +0800
Subject: Re: [PATCH v3 4/6] jbd2: Fix wrongly judgement for buffer head
 removing while doing checkpoint
To:     Theodore Ts'o <tytso@mit.edu>, Zhang Yi <yi.zhang@huaweicloud.com>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yi.zhang@huawei.com>, <yukuai3@huawei.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
 <20230606135928.434610-5-yi.zhang@huaweicloud.com>
 <20230613043120.GB1584772@mit.edu>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <20002902-39c5-914b-75b0-5a21b5cee25c@huawei.com>
Date:   Tue, 13 Jun 2023 16:13:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230613043120.GB1584772@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ÔÚ 2023/6/13 12:31, Theodore Ts'o Ð´µÀ:
> There is something about this patch which is causing test runs to hang
> when running "gce-xfstests -c ext4/adv -C 10 generic/475" at least
> 60-70% of the time.
> 
> When I took a closer look, the problem seems to be e2fsck is hanging
> after a SEGV when running e2fsck -nf on the block device.  This then
> causes the check script to hang, until the test appliance's safety
> timer triggers and forces a shutdown of the test VM and aborts the
> test run.
> 
> The cause of the hang is clearly an e2fsprogs bug --- no matter how
> corrupted the file system is, e2fsck should never crash or hang.  So
> something is clearly going wrong with e2fsck:
> 
>      ...
>      Symlink /p1/dc/d14/dee/l154 (inode #2898) is invalid.
>      Clear? no
> 
>      Entry 'l154' in /p1/dc/d14/dee (2753) has an incorrect filetype (was 7, should be 0).
>      Fix? no
> 
>      corrupted size vs. prev_size
>      Signal (6) SIGABRT si_code=SI_TKILL
> 
>      (Note: "corrutped size vs prev_size" is issued by glibc when
>      malloc's internal data structures have been corrupted.  So
>      there is definitely something going very wrong with e2fsck.)
>      
> That being said, if I run the same test on the parent commit (patch
> 3/6, jbd2: remove journal_clean_one_cp_list()), e2fsck does *not* hang
> or crash, and the regression tests complete.  So this patch is
> changing the behavior of the kernel in terms of the file system that
> is left behind after a large number of injected I/O errors.
> 
> My plan therefore is to drop patches 4/6 through 6/6 of this patch
> series.  This will allow at least the "long standing metadata
> corruption issue that happens from to time" to be addressed, and it
> will give us time study what's going on here in more detail.  I've
> captured the compressed file system image which is causing e2fsck
> (version 1.47.0) to corrupt malloc's data structure, and I'll try see
> what using Address Sanitizer or valgrind show about what's going on.
> 

Hi Ted, I tried to run './check generic/475' many rounds(1.47.0, 
5-Feb-2023), and I cannot reproduce the problem with this patch. Could 
you send me a compressed image which can trigger the problem with 'fsck 
-fn'?

I agree to make clear the problem first before applying this patch.

> Looking at the patch, it looks pretty innocuous, and I don't
> understand how this could be making a significant enough difference
> that it's causing e2fsck, which had previously been working fine, to
> now start tossing its cookies.  If you could double check the patch
> and see you see anything that I might have missed in my code review,
> I'd really appreciate it.
> 
> Thanks,
> 
> 					- Ted
> 
> .
> 

