Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F809645924
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Dec 2022 12:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiLGLj7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Dec 2022 06:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiLGLj7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Dec 2022 06:39:59 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4632122BD4;
        Wed,  7 Dec 2022 03:39:57 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NRwKj2HC1zmWQV;
        Wed,  7 Dec 2022 19:39:05 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Dec 2022 19:39:54 +0800
Subject: Re: [PATCH v2 2/6] ext4: add primary check extended attribute inode
 in ext4_xattr_check_entries()
To:     Jan Kara <jack@suse.cz>, Ye Bin <yebin@huaweicloud.com>
References: <20221207074043.1286731-1-yebin@huaweicloud.com>
 <20221207074043.1286731-3-yebin@huaweicloud.com>
 <20221207111437.birh6zujw4wauvhu@quack3>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   "yebin (H)" <yebin10@huawei.com>
Message-ID: <63907B8A.9030800@huawei.com>
Date:   Wed, 7 Dec 2022 19:39:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <20221207111437.birh6zujw4wauvhu@quack3>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On 2022/12/7 19:14, Jan Kara wrote:
> On Wed 07-12-22 15:40:39, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> Add primary check for extended attribute inode, only do hash check when read
>> ea_inode's data in ext4_xattr_inode_get().
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ...
>
>> +static inline int ext4_xattr_check_extra_inode(struct inode *inode,
>> +					       struct ext4_xattr_entry *entry)
>> +{
>> +	int err;
>> +	struct inode *ea_inode;
>> +
>> +	err = ext4_xattr_inode_iget(inode, le32_to_cpu(entry->e_value_inum),
>> +				    le32_to_cpu(entry->e_hash), &ea_inode);
>> +	if (err)
>> +		return err;
>> +
>> +	if (i_size_read(ea_inode) != le32_to_cpu(entry->e_value_size)) {
>> +		ext4_warning_inode(ea_inode,
>> +                           "ea_inode file size=%llu entry size=%u",
>> +                           i_size_read(ea_inode),
>> +			   le32_to_cpu(entry->e_value_size));
>> +		err = -EFSCORRUPTED;
>> +	}
>> +	iput(ea_inode);
>> +
>> +	return err;
>> +}
>> +
>>   static int
>> -ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
>> -			 void *value_start)
>> +ext4_xattr_check_entries(struct inode *inode, struct ext4_xattr_entry *entry,
>> +			 void *end, void *value_start)
>>   {
>>   	struct ext4_xattr_entry *e = entry;
>>   
>> @@ -221,6 +247,10 @@ ext4_xattr_check_entries(struct ext4_xattr_entry *entry, void *end,
>>   			    size > end - value ||
>>   			    EXT4_XATTR_SIZE(size) > end - value)
>>   				return -EFSCORRUPTED;
>> +		} else if (entry->e_value_inum) {
>> +			int err = ext4_xattr_check_extra_inode(inode, entry);
>> +			if (err)
>> +				return err;
>>   		}
>>   		entry = EXT4_XATTR_NEXT(entry);
>>   	}
> So I was thinking about this. It is nice to have the inode references
> checked but OTOH this is rather expensive for a filesystem with EA inodes -
> we have to lookup and possibly load EA inodes from the disk although they
> won't be needed for anything else than the check. Also as you have noticed
> we do check whether i_size and xattr size as recorded in xattr entry match
> in ext4_xattr_inode_iget() which gets called once we need to do anything
> with the EA inode.
>
> Also I've checked and we do call ext4_xattr_check_block() and
> xattr_check_inode() in ext4_expand_extra_isize_ea() so Ted's suspicion that
> the problem comes from not checking the xattr entries before moving them
> from the inode was not correct.
>
> So to summarize, I don't think this and the following patch is actually
> needed and brings benefit that would outweight the performance cost.
>
> 								Honza

Yes, I agree with you.
In ext4_ xattr_ check_ Entries () simply verifies the length of the 
extended attribute with
ea_inode. If the previous patch is not merged, EXT4_ XATTR_ SIZE_ MAX is 
much larger
than the actual constraint value. Data verification can only be 
postponed until the ea_inode
is read.
So your suggestion is to modify EXT4_ XATTR_ SIZE_ MAX Or defer data 
verification until
the ea_inode is read?


