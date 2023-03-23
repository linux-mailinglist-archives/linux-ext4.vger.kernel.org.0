Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595A26C6181
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 09:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbjCWIUO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 04:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjCWIUN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 04:20:13 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CFF2FCDA
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 01:20:11 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Phyqc1306zbcN6;
        Thu, 23 Mar 2023 16:17:00 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 16:20:06 +0800
Subject: Re: [PATCH v5 0/3] ext4, jbd2: journal cycled record transactions
 between each mount
To:     Andreas Dilger <adilger@dilger.ca>,
        Zhang Yi <yi.zhang@huaweicloud.com>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        <yukuai3@huawei.com>
References: <20230322013353.1843306-1-yi.zhang@huaweicloud.com>
 <06F8DFC9-26F5-475F-9428-06FED2CA01AA@dilger.ca>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <62be1bf9-293a-7833-d13d-e7dee7d04742@huawei.com>
Date:   Thu, 23 Mar 2023 16:20:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <06F8DFC9-26F5-475F-9428-06FED2CA01AA@dilger.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.34]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/3/23 5:34, Andreas Dilger wrote:
> On Mar 21, 2023, at 7:33 PM, Zhang Yi <yi.zhang@huaweicloud.com> wrote:
>> This patch set add a new journal option 'JBD2_CYCLE_RECORD' and always
>> enable on ext4. It saves journal head for a clean unmounted file system
>> in the journal super block, which could let us record journal
>> transactions between each mount continuously. It could help us to do
>> journal backtrack and find root cause from a corrupted filesystem.
>> Current filesystem's corruption analysis is difficult and less useful
>> information, especially on the real products. It is useful to some
>> extent, especially for the cases of doing fuzzy tests and deploy in some
>> shout-runing products.
> 
> Another interesting side benefit of this change is that it gets a step
> closer to the "lazy ext4" (log-structured optimization) that had been
> described some time ago at FAST:
> 
> https://lwn.net/Articles/720226/
> https://www.usenix.org/system/files/conference/fast17/fast17-aghayev.pdf
> https://lists.openwall.net/linux-ext4/2017/04/11/1
> 
> Essentially, free space in the filesystem (or a large external device)
> could be used as a continuous journal, and metadata would only rarely
> be checkpointed to the actual filesystem.  If the "journal" is close to
> wrapping to the start, either the meta/data is checkpointed (if it is
> no longer actively used or can make a large write), or re-journaled to
> the end of the journal.  At remount time, the full journal is read into
> memory (discarding old copies of blocks) and this is used to identify
> the current metadata rather than reading from the filesystem itself.
> 
> This would allow e.g. very efficient flash caching of metadata (and also
> journaled data for small writes) for an HDD (or QLC) device.
> 

This is interesting, but current change looks like is just one small step.
It's been almost 6 years after the last talk I can found[1]. Is there
anyone still working on it?

[1] https://lore.kernel.org/linux-ext4/6B0F0C59-6930-41B3-8EE4-EA5BEECEB9F9@dilger.ca/

Thanks,
Yi.
