Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D34C9CB7A
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 10:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729585AbfHZIYd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 04:24:33 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5213 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727798AbfHZIYc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 04:24:32 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AD1C04BAE3479113E447;
        Mon, 26 Aug 2019 16:24:28 +0800 (CST)
Received: from [127.0.0.1] (10.74.221.148) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 16:24:20 +0800
Subject: Re: [PATCH] ext4: change the type of ext4 cache stats to
 percpu_counter to improve performance
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Yang Guo <guoyang2@huawei.com>,
        "Andreas Dilger" <adilger.kernel@dilger.ca>
References: <1566528454-13725-1-git-send-email-zhangshaokun@hisilicon.com>
 <20190825032524.GD5163@mit.edu> <20190825172803.GA9505@sol.localdomain>
 <20190826004744.GA27472@mit.edu>
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
Message-ID: <f0495aa7-8f21-e938-9617-07ac8741acb7@hisilicon.com>
Date:   Mon, 26 Aug 2019 16:24:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.1
MIME-Version: 1.0
In-Reply-To: <20190826004744.GA27472@mit.edu>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.221.148]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

On 2019/8/26 8:47, Theodore Y. Ts'o wrote:
> On Sun, Aug 25, 2019 at 10:28:03AM -0700, Eric Biggers wrote:
>> This patch is causing the following.  Probably because there's no calls to
>> percpu_counter_destroy() for the new counters?
> 
> Yeah, I noticed this from my test runs last night as well.  It looks
> like original patch was never tested with CONFIG_HOTPLUG_CPU.
> 

Sorry that We may miss it completely, we shall double check it and
make the proper patch carefully.

> The other problem with this patch is that it initializes
> es_stats_cache_hits and es_stats_cache_miesses too late.  They will
> get used when the journal inode is loaded.  This is mostly harmless,

I have checked it again, @es_stats_cache_hits and @es_stats_cache_miesses
have been initialized before the journal inode is loaded, Maybe I miss
something else?

egrep "ext4_es_register_shrinker|ext4_load_journal" fs/ext4/super.c
4260:   if (ext4_es_register_shrinker(sbi))
4302:           err = ext4_load_journal(sb, es, journal_devnum);

Thanks,
Shaokun

> but it's also wrong.
> 
> I've dropped this patch from the ext4 git tree.
> 
>      	     	  	     	      - Ted
> 
> .
> 

