Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F46E9DD46
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Aug 2019 07:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729249AbfH0Fq5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Aug 2019 01:46:57 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729137AbfH0Fq5 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 27 Aug 2019 01:46:57 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9AE8DE6BE64AB22EFF1E;
        Tue, 27 Aug 2019 13:46:54 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Tue, 27 Aug 2019
 13:46:48 +0800
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yang Guo <guoyang2@huawei.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190825032524.GD5163@mit.edu> <20190825172803.GA9505@sol.localdomain>
 <20190826004744.GA27472@mit.edu>
 <f0495aa7-8f21-e938-9617-07ac8741acb7@hisilicon.com>
 <20190826155728.GE4918@mit.edu>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <31888086-9ad8-6442-cbf6-c777cbc4947c@hisilicon.com>
Date:   Tue, 27 Aug 2019 13:46:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190826155728.GE4918@mit.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,

On 2019/8/26 23:57, Theodore Y. Ts'o wrote:
> On Mon, Aug 26, 2019 at 04:24:20PM +0800, Shaokun Zhang wrote:
>>> The other problem with this patch is that it initializes
>>> es_stats_cache_hits and es_stats_cache_miesses too late.  They will
>>> get used when the journal inode is loaded.  This is mostly harmless,
>>
>> I have checked it again, @es_stats_cache_hits and @es_stats_cache_miesses
>> have been initialized before the journal inode is loaded, Maybe I miss
>> something else?
> 
> No, sorry, that was my mistake.  I misread things when I was looking
> over your patch last night.
> 
> Please resubmit your patch once you've fixed things up and tested it.
> 

Sure, will do it soon.

> I would recommend that you at least try running your patch using the
> kvm-xfstests's smoke test[1] before submitting them.  It will save you
> and me time.
> 

Ok, thanks your guidance.

Shaokun,

> [1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
> 
> Thanks,
> 
> 					- Ted
> 					
> 
> .
> 

