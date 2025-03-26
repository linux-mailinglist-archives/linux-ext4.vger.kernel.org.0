Return-Path: <linux-ext4+bounces-6981-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F10A70FC3
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 05:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9903AC8BB
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 04:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BD913AA5D;
	Wed, 26 Mar 2025 04:01:53 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57BA64A29;
	Wed, 26 Mar 2025 04:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742961713; cv=none; b=Pfo+Uy5kH0x4QIr8Hcn7VNF0OM+EOdiAzDpqujt5T1lSCbY3fZRaiN496pVJh6uiZbjoFZyy2aeiK2se7BrwsH1YpvEfDQsbI+aKBnc2r7CFOiWfYbbe6psr4qyOAjzgzrBjsE/L1m0ZT9YnxlrMiyS7sGo82AkSnelbFAEfHfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742961713; c=relaxed/simple;
	bh=K2vt3ZRLTE4ifwlqZMCuqkJdBq8lXKR2NPQ/BFlY7Do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DeQcWspEIysrtQaqq1wZS96rbNoWt76B4Gb3LCTKeXu1Jmci1js+bxPvVj12H7kohA4NOMaXQvZYmv+QKv3lweQRrPOQonImjUDuz5DbfOv33O2SI818wpwEfTBh5MCx2c9g9Z/gFInVZgqbShGNtOL0aRNhi8J9TIElevcJRMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZMtR517bcz27hP7;
	Wed, 26 Mar 2025 12:02:25 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 740F11800B2;
	Wed, 26 Mar 2025 12:01:47 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 26 Mar 2025 12:01:46 +0800
Message-ID: <be35b86c-1e64-4593-8f68-fbd1f6b61eef@huawei.com>
Date: Wed, 26 Mar 2025 12:01:45 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Baokun Li <libaokun1@huawei.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
CC: <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>, Theodore Ts'o <tytso@mit.edu>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
 <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/3/26 10:16, Baokun Li wrote:
> On 2025/3/26 1:57, Ojaswin Mujoo wrote:
>> On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
>>> On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
>>>>> So this is something we need to do if the journal is actived, and if
>>>>> it's active, then sbi->s_journal will be non-NULL, and so we can just
>>>>> check to see if inode == sbi->s_journal instead.  This will simplify
>>>> I believe you mean inode == sbi->s_journal->j_inode here right?
>>> Yes, that's what I meant; sorry for the not catching this before I
>>> sent my reply.
>>>
>>> Cheers,
>>>
>>>                     - Ted
>> Hi Ted, Baokun,
>>
>> I got some time to revisit this. Seems like checking against
>> s_journal->j_inode is not enough. This is because both
>> ext4_check_blockref() and check_block_validity() can be called even
>> before journal->j_inode is set:
>>
>> ext4_open_inode_journal
>>    ext4_get_journal_inode
>>       __ext4_iget
>>           ext4_ind_check_inode
>>               ext4_check_blockref  /* j_inode not set */
>>
>>    journal = jbd2_journal_init_inode
>>       bmap
>>           ext4_bmap
>>              iomap_bmap
>>                ext4_iomap_begin
>>                    ext4_map_blocks
>>                        check_block_validity
>>
>>    journal->j_inode = inode
>>
>>
>> Now, I think in this case the best solution might be to use the extra
>> field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
>> sufficiently early.
>>
>> Thoughts?
> 
> Because system zone setup happens after the journal are loaded, I think we
> can skip the check if the journal haven't been loaded yet, like this:
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d04d8a7f12e7..38dc72ff7e78 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -383,9 +383,10 @@ static int __check_block_validity(struct inode *inode, const char *func,
>                                 unsigned int line,
>                                 struct ext4_map_blocks *map)
>  {
> +       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
> +
>         if (ext4_has_feature_journal(inode->i_sb) &&
> -           (inode->i_ino ==
> - le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
> +           (!journal || inode == journal->j_inode))
>                 return 0;
>         if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
>                 ext4_error_inode(inode, func, line, map->m_pblk,
> 
> If any part of the journal area overlaps with the system zone, we'll catch
> it when we add the journal area to the system zone later.
> 
> 

Since the creation of the system zone relies on the journal being
loaded, I think there is no risk in proceeding to call
ext4_inode_block_valid() to perform a basic block range check for
the journal inode, or even better.

Thanks,
Yi.


