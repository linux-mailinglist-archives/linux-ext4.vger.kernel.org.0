Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 476B5368AFC
	for <lists+linux-ext4@lfdr.de>; Fri, 23 Apr 2021 04:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236688AbhDWCS5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Apr 2021 22:18:57 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17028 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236041AbhDWCS4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Apr 2021 22:18:56 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FRHtr4FhkzPtX3;
        Fri, 23 Apr 2021 10:15:16 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.216) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.498.0; Fri, 23 Apr 2021
 10:18:10 +0800
Subject: Re: [PATCH] e2fsprogs: Try again to solve unreliable io case
To:     Theodore Ts'o <tytso@mit.edu>, Haotian Li <lihaotian9@huawei.com>
CC:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "harshad shirwadkar," <harshadshirwadkar@gmail.com>,
        linfeilong <linfeilong@huawei.com>
References: <d4fd737d-4280-1aee-32ae-36b303e6644d@huawei.com>
 <YH7/D1h5r9WB1TNq@mit.edu>
From:   Zhiqiang Liu <liuzhiqiang26@huawei.com>
Message-ID: <c1eb6441-9081-530c-63d8-1987048b2011@huawei.com>
Date:   Fri, 23 Apr 2021 10:18:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <YH7/D1h5r9WB1TNq@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.216]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/4/21 0:19, Theodore Ts'o wrote:
> On Tue, Apr 20, 2021 at 03:18:05PM +0800, Haotian Li wrote:
>> If some I/O error occured during e2fsck, for example the
>> fibre channel connections are flasky, the e2fsck may exit.
>> Try again in these I/O error cases may help e2fsck
>> successfully execute and fix the disk correctly.
> 
> Why not fix this by retrying in the device driver instead?  If the
> Fibre Channel is that flaky, then it's going to be a problem when the
> file system is mounted, so it would seem to me that fixing this in the
> kernel makes a lot more sense.
> 
>     	   	       	    - Ted
>
Thanks for your reply.
Actually, we have met the problem in ipsan situation.
When exec 'fsck -a <remote-device>', short-term fluctuations or
abnormalities may occur on the network. Despite the driver has
do the best effort, some IO errors may occur. So add retrying in
e2fsprogs can further improve the reliability of the repair
process.

Regards
Zhiqiang Liu
> .
> 

