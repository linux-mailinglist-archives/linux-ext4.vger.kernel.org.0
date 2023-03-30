Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6385E6CF95A
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Mar 2023 04:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjC3C5I (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Mar 2023 22:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjC3C5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Mar 2023 22:57:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F75259
        for <linux-ext4@vger.kernel.org>; Wed, 29 Mar 2023 19:57:02 -0700 (PDT)
Received: from dggpeml500016.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Pn7LN69K8zKwtC;
        Thu, 30 Mar 2023 10:54:36 +0800 (CST)
Received: from [10.174.176.102] (10.174.176.102) by
 dggpeml500016.china.huawei.com (7.185.36.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 10:57:00 +0800
Message-ID: <9d3ad717-e3c2-69c8-4ef0-3f5f24c4ae1c@huawei.com>
Date:   Thu, 30 Mar 2023 10:56:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 0/2] Add some msg for io error
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <linfeilong@huawei.com>,
        <louhongxiang@huawei.com>, <liuzhiqiang26@huawei.com>
References: <20230325065652.2111384-1-zhanchengbin1@huawei.com>
 <20230326143128.GA436186@mit.edu>
From:   zhanchengbin <zhanchengbin1@huawei.com>
In-Reply-To: <20230326143128.GA436186@mit.edu>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.102]
X-ClientProxiedBy: dggpeml500014.china.huawei.com (7.185.36.63) To
 dggpeml500016.china.huawei.com (7.185.36.70)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2023/3/26 22:31, Theodore Ts'o wrote:
> On Sat, Mar 25, 2023 at 02:56:50PM +0800, zhanchengbin wrote:
>> If there is an EIO during the process of fsck, the user can be notified of it.
> 
> Can you identify a code path where the user is *not* getting notified
> while e2fsck is running without this patch series?
> 
> The unix_io.c module calls fsync() through unix_flush() only.  When
> unix_write_byte() calls flush_cached blocks(), if the read or write
> system call fails, the error will be returned to the caller of
> flush_cached_byte(), and the unix_write_byte() will return the error
> back to the caller (in this case, e2fsck).
> 

io_channel_flush and io_channel_write_byte do have return values, but
they may not necessarily be checked at their calling points. As in the
following path:

e2fsck_run_ext3_journal
  ext2fs_flush // Ignore errors.
   ext2fs_flush2
    io_channel_flush
  ext2fs_mmp_stop // Ignore errors.
   ext2fs_mmp_write
    io_channel_flush

ext2fs_flush // Many calls ignore errors.
  ext2fs_flush2
   write_primary_superblock
    io_channel_write_byte

Thanks,
  - bin.

> So in both cases, e2fsck checks the error return from ext2fs_flush()
> (which is the only place where write_byte gets called) and
> io_channel->flush(), and so the user will get some kind of error
> report already.
> 
> The error message might not identify exactly what I/O failed, but the
> "Error sync" message that this commit series provides is not going to
> be much better.
> 
> 						- Ted
> 
> .
> 
