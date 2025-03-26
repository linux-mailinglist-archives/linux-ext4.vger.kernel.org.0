Return-Path: <linux-ext4+bounces-6984-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02507A713AA
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 10:26:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 472CC7A529B
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 09:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542651A8407;
	Wed, 26 Mar 2025 09:26:33 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E716D1A5B94;
	Wed, 26 Mar 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742981193; cv=none; b=h9h5qDI64oAPS8rlB5ExUGaNsrexKHTu41XamEBrLRarpefwmRtXTWwS5hxlIkDiPvPsE/qZMGe/8K61K0FBkjTWD7JMJgKHUtTu4DN70dUuae8WKaFYhVTdyDXfiGoyvnQ3Emon3aO+zU+Mzbs7OFTQLT3497AFtOHtJfidWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742981193; c=relaxed/simple;
	bh=OShkHehVDg+e+LIWRvGLORZgZlOEwCHLY+rss4wN84Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bz+FNoD5dlq0DZOw4+kGHjESD2Kb80X5EYrYKTRb7vfxqEUssxWutEDBDhmbC88wO7cAGQ+dFlDwTgvsEPFbEn8YlX6GAoisnaS90D4kXHo2kQ7F7Nsg8ZgkFQ6hmOdO08bitXYcuNLcSjYHquM3pY2OBLyOQVNvgZunWhgo6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZN1WT5nT3z2RVRr;
	Wed, 26 Mar 2025 17:21:41 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 289431A016C;
	Wed, 26 Mar 2025 17:26:21 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Mar
 2025 17:26:20 +0800
Message-ID: <74139de7-4194-46b9-aeea-702bdd5b432a@huawei.com>
Date: Wed, 26 Mar 2025 17:26:19 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Zhang Yi <yi.zhang@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>, Theodore Ts'o <tytso@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
 <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
 <be35b86c-1e64-4593-8f68-fbd1f6b61eef@huawei.com>
 <Z-OhNOVEcQNkYc18@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <68b490b1-2c48-46e4-aa8a-a74f3547e063@huaweicloud.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <68b490b1-2c48-46e4-aa8a-a74f3547e063@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/26 16:33, Zhang Yi wrote:
> On 2025/3/26 14:39, Ojaswin Mujoo wrote:
>> On Wed, Mar 26, 2025 at 12:01:45PM +0800, Zhang Yi wrote:
>>> On 2025/3/26 10:16, Baokun Li wrote:
>>>> On 2025/3/26 1:57, Ojaswin Mujoo wrote:
>>>>> On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
>>>>>> On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
>>>>>>>> So this is something we need to do if the journal is actived, and if
>>>>>>>> it's active, then sbi->s_journal will be non-NULL, and so we can just
>>>>>>>> check to see if inode == sbi->s_journal instead.  This will simplify
>>>>>>> I believe you mean inode == sbi->s_journal->j_inode here right?
>>>>>> Yes, that's what I meant; sorry for the not catching this before I
>>>>>> sent my reply.
>>>>>>
>>>>>> Cheers,
>>>>>>
>>>>>>                      - Ted
>>>>> Hi Ted, Baokun,
>>>>>
>>>>> I got some time to revisit this. Seems like checking against
>>>>> s_journal->j_inode is not enough. This is because both
>>>>> ext4_check_blockref() and check_block_validity() can be called even
>>>>> before journal->j_inode is set:
>>>>>
>>>>> ext4_open_inode_journal
>>>>>     ext4_get_journal_inode
>>>>>        __ext4_iget
>>>>>            ext4_ind_check_inode
>>>>>                ext4_check_blockref  /* j_inode not set */
>>>>>
>>>>>     journal = jbd2_journal_init_inode
>>>>>        bmap
>>>>>            ext4_bmap
>>>>>               iomap_bmap
>>>>>                 ext4_iomap_begin
>>>>>                     ext4_map_blocks
>>>>>                         check_block_validity
>>>>>
>>>>>     journal->j_inode = inode
>>>>>
>>>>>
>>>>> Now, I think in this case the best solution might be to use the extra
>>>>> field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
>>>>> sufficiently early.
>>>>>
>>>>> Thoughts?
>>>> Because system zone setup happens after the journal are loaded, I think we
>>>> can skip the check if the journal haven't been loaded yet, like this:
>>>>
>>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>>> index d04d8a7f12e7..38dc72ff7e78 100644
>>>> --- a/fs/ext4/inode.c
>>>> +++ b/fs/ext4/inode.c
>>>> @@ -383,9 +383,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
>>>>                                  unsigned int line,
>>>>                                  struct ext4_map_blocks *map)
>>>>   {
>>>> +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>>>> +
>>>>          if (ext4_has_feature_journal(inode->i_sb) &&
>>>> -           (inode->i_ino ==
>>>> - le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
>>>> +           (!journal || inode == journal->j_inode))
>>>>                  return 0;
>>>>          if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>>>>                  ext4_error_inode(inode, func, line, map->m_pblk,
>>>>
>>>> If any part of the journal area overlaps with the system zone, we'll catch
>>>> it when we add the journal area to the system zone later.
>>>>
>>>>
>>> Since the creation of the system zone relies on the journal being
>>> loaded, I think there is no risk in proceeding to call
>>> ext4_inode_block_valid() to perform a basic block range check for
>>> the journal inode, or even better.
Indeed, performing some basic anomaly checks in advance can prevent
journal replay from worsening the situation in abnormal cases. Moreover,
since s_journal is NULL at this point, we won't schedule s_sb_upd_work
even if the check fails, which is safe.
>>>
>>> Thanks,
>>> Yi.
>> Got it Yi, makes sense to me. So I believe you are suggesting something
>> like:
>>
>> @@ -384,9 +384,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
>>                                  unsigned int line,
>>                                  struct ext4_map_blocks *map)
>>   {
>> +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>> +
>>          if (ext4_has_feature_journal(inode->i_sb) &&
> We are going to check ->s_journal, so I suppose we could drop this
> feature check as well. Others looks good to me.
Seconded.
>
>> -           (inode->i_ino ==
>> -            le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
>> +           (journal && journal->j_inode == inode))
>>                  return 0;
>>          if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>>                  ext4_error_inode(inode, func, line, map->m_pblk,
>>
>> So that even if it is a journal inode we can go ahead and perform some basic checks
>> as the system zone rbtree will anyways be NULL at this point. From a cursory look,
>> it seems that __ext4_iget(..., journal_inode) -> ext4_ext_check_inode() already relies
>> on the fact that system zone is NULL, so we should be okay here as well.
> Yeah, that's right. :)
>
> Cheers,
> Yi.
>
>> If this looks good, I'll send a v2 with the suggested changes.
>>
>> Thanks,
>> ojaswin

Please mention in the commit message that we're now doing some basic
checks on the journal area.


Cheers,
Baokun


