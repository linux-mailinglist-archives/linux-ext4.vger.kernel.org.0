Return-Path: <linux-ext4+bounces-6980-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF85A70EDF
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 03:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8589840361
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Mar 2025 02:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD39113C9A3;
	Wed, 26 Mar 2025 02:16:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF90F2904;
	Wed, 26 Mar 2025 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742955416; cv=none; b=jZO+P46Ljf5UquYqT2Hir/F6JZ6rluf4qsZF2L/TxA6XYRn/9M+TBOsz22bm+1DMlzi0/ym1MzU1wyPCpBZ4Xw1IaUUUxHdUIfrgnXsu4Nn5aUWMvuG9MT0EG1irsUf8kzW2Y+CfSLckKOq8pQHv6XXm3zYNauNrSuXWDA4nOow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742955416; c=relaxed/simple;
	bh=0pFQ2xu7zxHQ8FHvgjU1qjsyx/mC4SibL8xajPm2Q0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HffyLM+jFhYEBVmVc3GckGheoDcg7Jm7c90EB4jIeVLyCDL3EA2lmjXgWy9pvi/C5YjEwff2jF7T2fDIdI5EC9t91SIw84AlxpaQtvf4X/+sMkneVewpze8hwEfDP6VieWeaJ+PMp8+pr8M5aOyy1LLG7bqYiP9/tkajNiEH0k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZMr4q67V8z1d108;
	Wed, 26 Mar 2025 10:16:27 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id F398B1400F4;
	Wed, 26 Mar 2025 10:16:49 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 26 Mar
 2025 10:16:49 +0800
Message-ID: <8b76667a-a331-4bf5-bb6a-8db9319d84da@huawei.com>
Date: Wed, 26 Mar 2025 10:16:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: cache es->s_journal_inum in ext4_sb_info
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Theodore Ts'o <tytso@mit.edu>
CC: <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>, Ritesh Harjani
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>, Yang Erkun
	<yangerkun@huawei.com>
References: <d1a9328a41029f6210a1924b192a59afcd3c5cee.1741952406.git.ojaswin@linux.ibm.com>
 <20250316014128.GA787758@mit.edu>
 <Z9kq744Q1zbbxOKH@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <20250319023129.GF787758@mit.edu>
 <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <Z-Lunpbeh176mwRu@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/3/26 1:57, Ojaswin Mujoo wrote:
> On Tue, Mar 18, 2025 at 10:31:29PM -0400, Theodore Ts'o wrote:
>> On Tue, Mar 18, 2025 at 01:42:31PM +0530, Ojaswin Mujoo wrote:
>>>> So this is something we need to do if the journal is actived, and if
>>>> it's active, then sbi->s_journal will be non-NULL, and so we can just
>>>> check to see if inode == sbi->s_journal instead.  This will simplify
>>> I believe you mean inode == sbi->s_journal->j_inode here right?
>> Yes, that's what I meant; sorry for the not catching this before I
>> sent my reply.
>>
>> Cheers,
>>
>> 					- Ted
> Hi Ted, Baokun,
>
> I got some time to revisit this. Seems like checking against
> s_journal->j_inode is not enough. This is because both
> ext4_check_blockref() and check_block_validity() can be called even
> before journal->j_inode is set:
>
> ext4_open_inode_journal
>    ext4_get_journal_inode
> 	  __ext4_iget
> 		  ext4_ind_check_inode
> 			  ext4_check_blockref  /* j_inode not set */
>
>    journal = jbd2_journal_init_inode
> 	  bmap
> 		  ext4_bmap
> 			 iomap_bmap
> 			   ext4_iomap_begin
> 				   ext4_map_blocks
> 					   check_block_validity
>
>    journal->j_inode = inode
>
>
> Now, I think in this case the best solution might be to use the extra
> field like we do in this patch but set  EXT4_SB(sb)->s_journal_ino
> sufficiently early.
>
> Thoughts?

Because system zone setup happens after the journal are loaded, I think we
can skip the check if the journal haven't been loaded yet, like this:

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d04d8a7f12e7..38dc72ff7e78 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -383,9 +383,10 @@ static int __check_block_validity(struct inode 
*inode, const char *func,
                                 unsigned int line,
                                 struct ext4_map_blocks *map)
  {
+       journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+
         if (ext4_has_feature_journal(inode->i_sb) &&
-           (inode->i_ino ==
- le32_to_cpu(EXT4_SB(inode->i_sb)->s_es->s_journal_inum)))
+           (!journal || inode == journal->j_inode))
                 return 0;
         if (!ext4_inode_block_valid(inode, map->m_pblk, map->m_len)) {
                 ext4_error_inode(inode, func, line, map->m_pblk,

If any part of the journal area overlaps with the system zone, we'll catch
it when we add the journal area to the system zone later.


Cheers,
Baokun


