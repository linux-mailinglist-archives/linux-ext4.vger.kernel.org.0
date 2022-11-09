Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650CA6228AF
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Nov 2022 11:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiKIKkh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Nov 2022 05:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiKIKkg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Nov 2022 05:40:36 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18911BEB6
        for <linux-ext4@vger.kernel.org>; Wed,  9 Nov 2022 02:40:34 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N6hGr2Y8PzpWK0;
        Wed,  9 Nov 2022 18:36:52 +0800 (CST)
Received: from dggpeml500016.china.huawei.com (7.185.36.70) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 18:40:32 +0800
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 9 Nov 2022 18:40:32 +0800
Message-ID: <30ac384e-a015-259a-3efc-1c9f3ee1dabb@huawei.com>
Date:   Wed, 9 Nov 2022 18:40:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, linfeilong <linfeilong@huawei.com>,
        <liuzhiqiang26@huawei.com>
From:   zhanchengbin <zhanchengbin1@huawei.com>
Subject: [bug report] e2fsck: The process is deadlocked
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500012.china.huawei.com (7.185.36.15) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Tytso,
The process is deadlocked, and an I/O error occurs when logs
are replayed. Because in the I/O error handling function, I/O
is sent again and catch the mutexlock.
stack:
(gdb) bt
#0  0x0000ffffa740bc34 in ?? () from /usr/lib64/libc.so.6
#1  0x0000ffffa7412024 in pthread_mutex_lock () from /usr/lib64/libc.so.6
#2  0x0000ffffa7654e54 in mutex_lock (kind=CACHE_MTX, 
data=0xaaaaf5c98f30) at unix_io.c:151
#3  unix_write_blk64 (channel=0xaaaaf5c98e60, block=2, count=4, 
buf=0xaaaaf5c9d170) at unix_io.c:1092
#4  0x0000ffffa762e610 in ext2fs_flush2 (flags=0, fs=0xaaaaf5c98cc0) at 
closefs.c:401
#5  ext2fs_flush2 (fs=0xaaaaf5c98cc0, flags=0) at closefs.c:279
#6  0x0000ffffa762eb14 in ext2fs_close2 (fs=fs@entry=0xaaaaf5c98cc0, 
flags=flags@entry=0) at closefs.c:510
#7  0x0000ffffa762eba4 in ext2fs_close_free 
(fs_ptr=fs_ptr@entry=0xffffc8cbab30) at closefs.c:472
#8  0x0000aaaadcc39bd8 in preenhalt (ctx=ctx@entry=0xaaaaf5c98460) at 
util.c:365
#9  0x0000aaaadcc3bc5c in e2fsck_handle_write_error (channel=<optimized 
out>, block=262152, count=<optimized out>, data=<optimized out>, 
size=<optimized out>, actual=<optimized out>, error=5)
     at ehandler.c:114
#10 0x0000ffffa7655044 in reuse_cache (block=262206, 
cache=0xaaaaf5c98f80, data=0xaaaaf5c98f30, channel=0xaaaaf5c98e60) at 
unix_io.c:583
#11 unix_write_blk64 (channel=0xaaaaf5c98e60, block=262206, 
count=<optimized out>, buf=<optimized out>) at unix_io.c:1097
#12 0x0000aaaadcc3702c in ll_rw_block (rw=rw@entry=1, 
op_flags=op_flags@entry=0, nr=<optimized out>, nr@entry=1, 
bhp=0xffffc8cbac60, bhp@entry=0xffffc8cbac58) at journal.c:184
#13 0x0000aaaadcc375e8 in brelse (bh=<optimized out>, 
bh@entry=0xaaaaf5cac4a0) at journal.c:217
#14 0x0000aaaadcc3ebe0 in do_one_pass 
(journal=journal@entry=0xaaaaf5c9f590, info=info@entry=0xffffc8cbad60, 
pass=pass@entry=PASS_REPLAY) at recovery.c:693
#15 0x0000aaaadcc3ee74 in jbd2_journal_recover (journal=0xaaaaf5c9f590) 
at recovery.c:310
#16 0x0000aaaadcc386a8 in recover_ext3_journal (ctx=0xaaaaf5c98460) at 
journal.c:1653
#17 e2fsck_run_ext3_journal (ctx=0xaaaaf5c98460) at journal.c:1706
#18 0x0000aaaadcc207e0 in main (argc=<optimized out>, argv=<optimized 
out>) at unix.c:1791
