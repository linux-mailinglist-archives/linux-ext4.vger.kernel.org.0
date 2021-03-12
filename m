Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49957338363
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Mar 2021 03:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbhCLCCf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Mar 2021 21:02:35 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13909 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhCLCCG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Mar 2021 21:02:06 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4DxTYB6qrpzkXvk;
        Fri, 12 Mar 2021 10:00:30 +0800 (CST)
Received: from [10.174.176.202] (10.174.176.202) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Fri, 12 Mar 2021 10:01:50 +0800
Subject: Re: [PATCH v1 1/2] ext4: find old entry again if failed to rename
 whiteout
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <yangerkun@huawei.com>
References: <20210303131703.330415-1-yi.zhang@huawei.com>
 <YEo6k8kg3zF7avId@mit.edu>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <a81cf4d6-a934-9031-7e9d-f5a91647d210@huawei.com>
Date:   Fri, 12 Mar 2021 10:01:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YEo6k8kg3zF7avId@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/3/11 23:43, Theodore Ts'o wrote:
> On Wed, Mar 03, 2021 at 09:17:02PM +0800, zhangyi (F) wrote:
>> If we failed to add new entry on rename whiteout, we cannot reset the
>> old->de entry directly, because the old->de could have moved from under
>> us during make indexed dir. So find the old entry again before reset is
>> needed, otherwise it may corrupt the filesystem as below.
>>
>>   /dev/sda: Entry '00000001' in ??? (12) has deleted/unused inode 15. CLEARED.
>>   /dev/sda: Unattached inode 75
>>   /dev/sda: UNEXPECTED INCONSISTENCY; RUN fsck MANUALLY.
>>
>>   ....
>>
>> +	/*
>> +	 * old->de could have moved from under us during make indexed dir,
>> +	 * so the old->de may no longer valid and need to find it again
>> +	 * before reset old inode info.
>> +	 */
>> +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
>> +	if (IS_ERR(old.bh))
>> +		retval = PTR_ERR(old.bh);
>> +	if (!old.bh)
>> +		retval = -ENOENT;
>> +	if (retval) {
>> +		ext4_std_error(old.dir->i_sb, retval);
> 
> 
> So if the directory entry may have been deleted out from under us, an
> ENOENT failure might happen under normal circumstances, shouldn't it?
> > In that case, ext4_std_error() will declare that the file system is
> inconsistent, potentially resulting in the file system to be remounted
> read-only, or causing the system to panic.  So calling
> ext4_std_error() needs to be done carefully.
> 
> Are we sure that calling ext4_std_error() is the right thing to do in
> the case where ext4_find_entry() returns ENOENT?
> 

Hi, Ted

In this error path of whiteout rename, we want to restore the old inode
number and old name back to the old entry, it's just a rollback operation.
The old entry will stay where it was in common cases, but it can be moved
from the first block to the leaf block during make indexed dir for one
special case, but it cannot be deleted in theory. So if we cannot find it
again, there must some bad thing happen and the filesystem may probably
inconsistency. So I calling ext4_std_error() here，or am I missing something？

Thanks,
Yi.
