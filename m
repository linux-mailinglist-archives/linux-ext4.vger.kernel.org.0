Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D802B8A9D
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Nov 2020 05:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgKSEZT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Nov 2020 23:25:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:7934 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgKSEZT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 Nov 2020 23:25:19 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Cc6656llwz6v2R;
        Thu, 19 Nov 2020 12:25:01 +0800 (CST)
Received: from [10.174.179.106] (10.174.179.106) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.487.0; Thu, 19 Nov 2020 12:25:08 +0800
Subject: Re: [Bug report] journal data mode trigger panic in
 jbd2_journal_commit_transaction
To:     Mauricio Oliveira <mauricio.oliveira@canonical.com>
CC:     "Theodore Y . Ts'o" <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.cz>, <linux-ext4@vger.kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>, Hou Tao <houtao1@huawei.com>,
        <zhangxiaoxu5@huawei.com>, Ye Bin <yebin10@huawei.com>,
        <hejie3@huawei.com>
References: <68b9650e-bef2-69e2-ab5e-8aaddaf46cfe@huawei.com>
 <CAO9xwp12E1wjErfX-Ef6+OKnme_ENOx22Hh=44g9cLn7aBr3-w@mail.gmail.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <c4c16548-1f37-a63e-de38-de5812bcc97e@huawei.com>
Date:   Thu, 19 Nov 2020 12:25:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAO9xwp12E1wjErfX-Ef6+OKnme_ENOx22Hh=44g9cLn7aBr3-w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.106]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2020/11/16 21:50, Mauricio Oliveira 写道:
> Hi Kun,
> 
> On Sat, Nov 14, 2020 at 5:18 AM yangerkun <yangerkun@huawei.com> wrote:
>> While using ext4 with data=journal(3.10 kernel), we meet a problem that
>> we think may never happend...
> [...]
> 
> Could you please confirm you mean 5.10-rc* kernel instead of 3.10?
> (It seems so as you mention a recent commit below.)  Thanks!
> 
>> For now, what I have seen that can dirty buffer directly is
>> ext4_page_mkwrite(64a9f1449950 ("ext4: data=journal: fixes for
>> ext4_page_mkwrite()")), and runing ext4_punch_hole with keep_size
>> /ext4_page_mkwrite parallel can trigger above warning easily.
> [...]
> 
> 

Hi,

Sorry for the long delay reply... And thanks a lot for your advise! The 
bug trigger with a very low probability. So won't trigger with 5.10 can 
not prove no bug exist in 5.10.

Google a lot and notice that someone before has report the same bug[1]. 
'3b136499e906 ("ext4: fix data corruption in data=journal mode")' seems 
fix the problem. I will try to understand this, and give a analysis 
about how to reproduce it!

Thanks,
Kun.
