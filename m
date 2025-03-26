Return-Path: <linux-ext4+bounces-6983-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DE3A712B5
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 09:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A481E188B5BC
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 08:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E315B1A3171;
	Wed, 26 Mar 2025 08:33:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D65A1862BB;
	Wed, 26 Mar 2025 08:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742978026; cv=none; b=AkqL7zxDMYbTlRIcNlouQmGTKTWRgc3dfqYzjqCW7LK28HAWLTbKSixtNOaXnTqcuTUoGrO4v31T7jes7mc/uGYgNtFB6i7PgKziE42eG670tIv80HloNUpX7dZFSJexzy1tHqXWsIshqm34aG1jxDDLF0IZnxCeqKVvN80eGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742978026; c=relaxed/simple;
	bh=gLs0leCVkNIX3Zf6y1RbhLpxV1WSU3KeeY4emgMgbOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S8kaoOgpl5pKFDE/ZB62Bc275c2CyDYH5d0lv1VG2GL2Ah1Seoj1V4K3kMJgfBKdvXPCU27VkM4HlyPAkDGL0EbeUaTwrrhtJ6yRQVFp2ukiF/JlyyQ2ppbuKrPoiAhG04w5tF1X3panDVT+l3K2ZDT8I386IQmJCPMSJFLR6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZN0RT2XLmz4f3lV7;
	Wed, 26 Mar 2025 16:33:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BEE371A0D7B;
	Wed, 26 Mar 2025 16:33:33 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBXu1_cu+NnVQRwHg--.61258S3;
	Wed, 26 Mar 2025 16:33:33 +0800 (CST)
Message-ID: <68b490b1-2c48-46e4-aa8a-a74f3547e063@huaweicloud.com>
Date: Wed, 26 Mar 2025 16:33:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org,
 Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>,
 linux-kernel@vger.kernel.org, Yang Erkun <yangerkun@huawei.com>,
 Theodore Ts'o <tytso@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
 <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
 <be35b86c-1e64-4593-8f68-fbd1f6b61eef@huawei.com>
 <Z-OhNOVEcQNkYc18@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z-OhNOVEcQNkYc18@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBXu1_cu+NnVQRwHg--.61258S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAF47JFW7XF4ktw4xWrykXwb_yoWrKr4xpr
	y8AF1UWryUur10kr1xtr4UXryjq3W7tw4UWr1DCFy8Jrs8tryaqr48XF1j9F1UGr48G3Wj
	qr1UJ347uw1UtrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/3/26 14:39, Ojaswin Mujoo wrote:
> On Wed, Mar 26, 2025 at 12:01:45PM +0800, Zhang Yi wrote:
>> On 2025/3/26 10:16, Baokun Li wrote:
>>> On 2025/3/26 1:57, Ojaswin Mujoo wrote:
>>>> On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
>>>>> On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
>>>>>>> So this is something we need to do if the journal is actived, and if
>>>>>>> it's active, then sbi->s_journal will be non-NULL, and so we can just
>>>>>>> check to see if inode == sbi->s_journal instead.  This will simplify
>>>>>> I believe you mean inode == sbi->s_journal->j_inode here right?
>>>>> Yes, that's what I meant; sorry for the not catching this before I
>>>>> sent my reply.
>>>>>
>>>>> Cheers,
>>>>>
>>>>>                     - Ted
>>>> Hi Ted, Baokun,
>>>>
>>>> I got some time to revisit this. Seems like checking against
>>>> s_journal->j_inode is not enough. This is because both
>>>> ext4_check_blockref() and check_block_validity() can be called even
>>>> before journal->j_inode is set:
>>>>
>>>> ext4_open_inode_journal
>>>>    ext4_get_journal_inode
>>>>       __ext4_iget
>>>>           ext4_ind_check_inode
>>>>               ext4_check_blockref  /* j_inode not set */
>>>>
>>>>    journal = jbd2_journal_init_inode
>>>>       bmap
>>>>           ext4_bmap
>>>>              iomap_bmap
>>>>                ext4_iomap_begin
>>>>                    ext4_map_blocks
>>>>                        check_block_validity
>>>>
>>>>    journal->j_inode = inode
>>>>
>>>>
>>>> Now, I think in this case the best solution might be to use the extra
>>>> field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
>>>> sufficiently early.
>>>>
>>>> Thoughts?
>>>
>>> Because system zone setup happens after the journal are loaded, I think we
>>> can skip the check if the journal haven't been loaded yet, like this:
>>>
>>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>>> index d04d8a7f12e7..38dc72ff7e78 100644
>>> --- a/fs/ext4/inode.c
>>> +++ b/fs/ext4/inode.c
>>> @@ -383,9 +383,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
>>>                                 unsigned int line,
>>>                                 struct ext4_map_blocks *map)
>>>  {
>>> +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
>>> +
>>>         if (ext4_has_feature_journal(inode->i_sb) &&
>>> -           (inode->i_ino ==
>>> - le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
>>> +           (!journal || inode == journal->j_inode))
>>>                 return 0;
>>>         if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>>>                 ext4_error_inode(inode, func, line, map->m_pblk,
>>>
>>> If any part of the journal area overlaps with the system zone, we'll catch
>>> it when we add the journal area to the system zone later.
>>>
>>>
>>
>> Since the creation of the system zone relies on the journal being
>> loaded, I think there is no risk in proceeding to call
>> ext4_inode_block_valid() to perform a basic block range check for
>> the journal inode, or even better.
>>
>> Thanks,
>> Yi.
> 
> Got it Yi, makes sense to me. So I believe you are suggesting something
> like:
> 
> @@ -384,9 +384,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
>                                 unsigned int line,
>                                 struct ext4_map_blocks *map)
>  {
> +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +
>         if (ext4_has_feature_journal(inode->i_sb) &&

We are going to check ->s_journal, so I suppose we could drop this
feature check as well. Others looks good to me.

> -           (inode->i_ino ==
> -            le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> +           (journal && journal->j_inode == inode))
>                 return 0;
>         if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>                 ext4_error_inode(inode, func, line, map->m_pblk,
> 
>>
> 
> So that even if it is a journal inode we can go ahead and perform some basic checks
> as the system zone rbtree will anyways be NULL at this point. From a cursory look,
> it seems that __ext4_iget(..., journal_inode) -> ext4_ext_check_inode() already relies
> on the fact that system zone is NULL, so we should be okay here as well.

Yeah, that's right. :)

Cheers,
Yi.

> 
> If this looks good, I'll send a v2 with the suggested changes.
> 
> Thanks,
> ojaswin


