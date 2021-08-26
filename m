Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390D03F7FA5
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Aug 2021 03:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbhHZBHb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 21:07:31 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:15216 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhHZBHa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 21:07:30 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gw4RP3B9Rz19Vch;
        Thu, 26 Aug 2021 09:06:09 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 26 Aug 2021 09:06:38 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 26 Aug 2021 09:06:37 +0800
Subject: Re: [QUESTION] question for commit 2d01ddc86606 ("ext4: save error
 info to sb through journal if available")
To:     Jan Kara <jack@suse.cz>
CC:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <05ff3a17-6559-9317-a382-f0a02fa59926@huawei.com>
 <20210825102518.GA14620@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <61524dfc-ddd3-0bf2-2ef6-278e024fd6bd@huawei.com>
Date:   Thu, 26 Aug 2021 09:06:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210825102518.GA14620@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/8/25 18:25, Jan Kara 写道:
> 
> Hello Kun!
> 
> On Wed 25-08-21 10:13:03, yangerkun wrote:
>> There is a question about 2d01ddc86606 ("ext4: save error info to sb through
>> journal if available"). This commit describe that we can have checksum
>> failure with follow case:
>>
>> 1. ext4_handle_error will call ext4_commit_super which write directly to the
>> superblock
>> 2. At the same time, jounalled update of the superblock is ongoing
>>
>> However, after commit 05c2c00f3769 ("ext4: protect superblock modifications
>> with a buffer lock"), all the update for superblock and the csum will be
>> protected with buffer lock. It seems we won't get a csum error after that
>> commit and the journal logic in flush_stashed_error_work seems useless.
>>
>> Maybe there is something missing... Can you help to explain more for that...
> 
> You are correct that after commit 05c2c00f3769 the checksum will be
> correct. However there are also other problems that 2d01ddc86606 addresses
> and that are mentioned in the commit description like "writing inconsistent
> information". The fundamental problem is that you cannot mix journalled and
> non-journalled updates to any block. Because e.g. the unjournalled update
> could store to disk information that was changed only as part of the
> currently running transaction and if the machine crashes before the
> transaction commits, we have too new information in the block and thus
> inconsistent filesystem. Or in the other direction, journal replay can
> overwrite unjournalled modifications to the superblock if we crash at the
> right moment.

Got it! Thanks for your explain!

> 
> 								Honza
> 
