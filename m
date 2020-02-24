Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764C216A57D
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Feb 2020 12:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgBXLtb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Feb 2020 06:49:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:58798 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbgBXLta (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 24 Feb 2020 06:49:30 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A64588F09A17B4D6FF50;
        Mon, 24 Feb 2020 19:31:12 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 24 Feb 2020
 19:31:07 +0800
Subject: Re: [PATCH] ext4/021: make sure the fdatasync subprocess exits
To:     Eryu Guan <guaneryu@gmail.com>
CC:     <fstests@vger.kernel.org>, <linux-ext4@vger.kernel.org>
References: <20200214022001.15563-1-yi.zhang@huawei.com>
 <20200223123411.GA3840@desktop>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <2c2b8a1b-64a3-8fd7-948f-ea7a777e2cf0@huawei.com>
Date:   Mon, 24 Feb 2020 19:31:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200223123411.GA3840@desktop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi,

On 2020/2/23 20:34, Eryu Guan wrote:
> On Fri, Feb 14, 2020 at 10:20:01AM +0800, zhangyi (F) wrote:
>> Now we just kill fdatasync_work process and wait nothing after the
>> test, so a busy unmount failure may appear if the fdatasync syscall
>> doesn't return in time.
>>
>>   umount: /tmp/scratch: target is busy.
>>   mount: /tmp/scratch: /dev/sdb already mounted on /tmp/scratch.
>>   !!! failed to remount /dev/sdb on /tmp/scratch
>>
>> This patch kill and wait the xfs_io fdatasync subprocess to make sure
>> _check_scratch_fs success.
> 
> Yeah, that's a problem.
> 
> I think you could add another "trap" in fdatasync_work, as what
> btrfs/036 does:
> 
> 	trap "wait; exit" SIGTERM
> 
> So xfs_io will be waited by fdatasync_work before exiting.
> 

Thanks for your suggestion, I will do that.

Thanks,
Yi.

