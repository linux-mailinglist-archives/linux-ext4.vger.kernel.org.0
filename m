Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40372B524
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Jun 2023 03:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229455AbjFLBiV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 21:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjFLBiV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 21:38:21 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9374E8;
        Sun, 11 Jun 2023 18:38:19 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QfZ4d43m2zLqTw;
        Mon, 12 Jun 2023 09:35:13 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemm600013.china.huawei.com (7.193.23.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 09:38:17 +0800
Subject: Re: [PATCH v3 0/6] ext4: Fix stale buffer loading from last failed
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
 <f67f0b5c-d02b-7a72-e723-a10336739249@huawei.com>
 <20230611044228.GD1436857@mit.edu>
From:   Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <3d10044b-0ed2-a61e-5d87-e26837ceb815@huawei.com>
Date:   Mon, 12 Jun 2023 09:38:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20230611044228.GD1436857@mit.edu>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.46]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

ÔÚ 2023/6/11 12:42, Theodore Ts'o Ð´µÀ:
> On Fri, Jun 09, 2023 at 04:04:47PM +0800, Zhihao Cheng wrote:
>>
>> Hi Ted, will this patchset be merged in next window?
> 
> It's currently in the dev branch.  I haven't set the ack out for it
> yet because I'm still seeing some test failures, including some test
> hangs in my regression tests.  There are a number of patches series
> submission that I'm currently working through, so we'll have to see
> what the "guilty" patch set might be, and whether there is an obvious
> fix for it or not.  (I've found one such problem that was missed by
> code review[1], and unfortunately, there is at least one more issue
> that I'm currently trying to pin down.)
> 
> [1] https://lore.kernel.org/r/20230610190319.GB1436857@mit.edu
> 
> Cheers,
> 
> 					- Ted
> 
> .
> 

Thanks for reminding. now I'm sure this patchset is tracked. Please 
follow your process.
