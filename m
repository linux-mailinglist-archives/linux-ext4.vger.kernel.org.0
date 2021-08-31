Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CF3FC311
	for <lists+linux-ext4@lfdr.de>; Tue, 31 Aug 2021 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238711AbhHaHC5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 31 Aug 2021 03:02:57 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8802 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbhHaHC4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 31 Aug 2021 03:02:56 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GzJ4t47shzYpYB;
        Tue, 31 Aug 2021 15:01:18 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Tue, 31 Aug 2021 15:01:59 +0800
Subject: Re: [PATCH v4 6/6] ext4: prevent getting empty inode buffer
To:     Theodore Ts'o <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <adilger.kernel@dilger.ca>,
        <jack@suse.cz>, <yukuai3@huawei.com>
References: <20210826130412.3921207-1-yi.zhang@huawei.com>
 <20210826130412.3921207-7-yi.zhang@huawei.com> <YS2brqdSIO8mQs3U@mit.edu>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <e9c96dad-f7d8-aa01-e56f-13d487c3d590@huawei.com>
Date:   Tue, 31 Aug 2021 15:01:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <YS2brqdSIO8mQs3U@mit.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/8/31 11:02, Theodore Ts'o wrote:
> On Thu, Aug 26, 2021 at 09:04:12PM +0800, Zhang Yi wrote:
>>
>> So this patch initialize the inode buffer by filling the in-mem inode
>> contents if we skip read I/O, ensure that the buffer is really uptodate.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 22 ++++++++++++++++------
>>  1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 3c36e701e30e..8b37f55b04ad 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4446,8 +4446,8 @@ static int ext4_fill_raw_inode(struct inode *inode, struct ext4_inode *raw_inode
>>   * inode.
>>   */
>>  static int __ext4_get_inode_loc(struct super_block *sb, unsigned long ino,
>> -				struct ext4_iloc *iloc, int in_mem,
>> -				ext4_fsblk_t *ret_block)
>> +				struct inode *inode, struct ext4_iloc *iloc,
>> +				int in_mem, ext4_fsblk_t *ret_block)
> 
> 
> In this patch you've added a new argument 'inode'.  However, if in_mem
> is true, and inode is NULL, the kernel will crash with a null pointer
> dereference.  Furthermore, whenever in_mem is false, the callers pass
> in NULL for inode.
> 
> Given that, perhaps we should just drop the in_mem argument, and then
> instead of
> 
> 	if (in_mem) {
> 
> we do:
> 
> 	if (inode && !ext4_test_inode_state(inode, EXT4_STATE_XATTR) {
> 
> with the comments adjusted accordingly?
> 
> I think it will make the code a bit simpler and readable.
> 
> What do you think?
> 

Yes，although I have already prevent passing 'in_mem' is true but 'inode' is
NULL in ext4_get_inode_loc(), using two arguments show the inode in-mem case
is not safe. I will remove the 'in_mem' parameter.

Thanks,
Yi.
