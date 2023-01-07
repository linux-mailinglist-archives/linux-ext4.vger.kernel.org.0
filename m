Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889AB660B85
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Jan 2023 02:38:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjAGBh7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Jan 2023 20:37:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjAGBh6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Jan 2023 20:37:58 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE927D9FD;
        Fri,  6 Jan 2023 17:37:56 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NpjQJ3kRbzqTtp;
        Sat,  7 Jan 2023 09:33:12 +0800 (CST)
Received: from [10.174.177.174] (10.174.177.174) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Sat, 7 Jan 2023 09:37:54 +0800
Message-ID: <eb59bd16-d97a-836b-691d-0d72106eccde@huawei.com>
Date:   Sat, 7 Jan 2023 09:37:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 1/2] ext4: fail ext4_iget if special inode unallocated
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <ritesh.list@gmail.com>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <yukuai3@huawei.com>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>
References: <20230106104706.2410740-1-libaokun1@huawei.com>
 <20230106104706.2410740-2-libaokun1@huawei.com>
 <20230106142846.rzkflbdedv2oyrro@quack3>
Content-Language: en-US
From:   Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20230106142846.rzkflbdedv2oyrro@quack3>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.174]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2023/1/6 22:28, Jan Kara wrote:
> On Fri 06-01-23 18:47:05, Baokun Li wrote:
>> In ext4_fill_super(), EXT4_ORPHAN_FS flag is cleared after
>> ext4_orphan_cleanup() is executed. Therefore, when __ext4_iget() is
>> called to get an inode whose i_nlink is 0 when the flag exists, no error
>> is returned. If the inode is a special inode, a null pointer dereference
>> may occur. If the value of i_nlink is 0 for any inodes (except boot loader
>> inodes) got by using the EXT4_IGET_SPECIAL flag, the current file system
>> is corrupted. Therefore, make the ext4_iget() function return an error if
>> it gets such an abnormal special inode.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=199179
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216541
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216539
>> Reported-by: Luís Henriques <lhenriques@suse.de>
>> Suggested-by: Theodore Ts'o <tytso@mit.edu>
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Thanks for the patch! A few comments below.
>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index 9d9f414f99fe..3f7cfa91ba89 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -4872,13 +4872,6 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>   		goto bad_inode;
>>   	raw_inode = ext4_raw_inode(&iloc);
>>   
>> -	if ((ino == EXT4_ROOT_INO) && (raw_inode->i_links_count == 0)) {
>> -		ext4_error_inode(inode, function, line, 0,
>> -				 "iget: root inode unallocated");
>> -		ret = -EFSCORRUPTED;
>> -		goto bad_inode;
>> -	}
>> -
>>   	if ((flags & EXT4_IGET_HANDLE) &&
>>   	    (raw_inode->i_links_count == 0) && (raw_inode->i_mode == 0)) {
>>   		ret = -ESTALE;
>> @@ -4951,10 +4944,13 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
>>   	 * NeilBrown 1999oct15
>>   	 */
>>   	if (inode->i_nlink == 0) {
>> -		if ((inode->i_mode == 0 ||
>> +		if ((inode->i_mode == 0 || (flags & EXT4_IGET_SPECIAL) ||
> 					   ^ extra parenthesis here  ^
Indeed, I'll remove the extra parenthesis.
>>   		     !(EXT4_SB(inode->i_sb)->s_mount_state & EXT4_ORPHAN_FS)) &&
>>   		    ino != EXT4_BOOT_LOADER_INO) {
>>   			/* this inode is deleted */
>> +			if (flags & EXT4_IGET_SPECIAL)
>> +				ext4_error_inode(inode, function, line, 0,
>> +						 "iget: special inode unallocated");
> I think it would be better to return -EFSCORRUPTED and not -ESTALE in this
> case.
Totally agree! For special inode, -EFSCORRUPTED is more reasonable.
>>   			ret = -ESTALE;
>>   			goto bad_inode;
>>   		}
> Otherwise the patch looks good to me.
>
> 									Honza
>
Thank you very much for your review！
I will send a patch V2 with the changes suggested by you.

-- 
With Best Regards,
Baokun Li
.
