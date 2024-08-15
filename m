Return-Path: <linux-ext4+bounces-3728-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9063952787
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 03:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61DFE1F22FAE
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2024 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C8D5680;
	Thu, 15 Aug 2024 01:36:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D6117C9;
	Thu, 15 Aug 2024 01:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723685778; cv=none; b=u/aFE+qII1M0pDSMdZSNKjETyElgWB6oADRm+trbhJH+yqosEtaztTSJpo8ng0DRJTyHJ4NMReFeffqHVY09QxE1pmbWmAYuQrLATaiupXRkRXDPINutUGY5DFac2N7bqh+77ab+WNMD2sPThZ0+WhYmVSHiRDbhQ4H+HPVNvNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723685778; c=relaxed/simple;
	bh=4D6Szzp8yOxn1qdN+JL9HZF4/Od7GnMRQJiljyjspbQ=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=KPS8KD81u07wBMRU11/DEFhD1ANP7GhXDPmWS4E+ViI1Y2d9tcHQznPvM6K84uTAtLnQh41QDrC3Vf1i0py8gpDlw/dSUqxVRvdvIVADoeThUvgAJ/L45HcXpH+KsaIYPBtTRUn4QRaQUf0pDhxWVz4kSImyBiPUpYtGkCWJDLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wknl13t51z4f3js2;
	Thu, 15 Aug 2024 09:35:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 54DB81A018D;
	Thu, 15 Aug 2024 09:36:11 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDHGUyJW71mwcmsBg--.62677S2;
	Thu, 15 Aug 2024 09:36:11 +0800 (CST)
Subject: Re: [PATCH 2/7] ext4: avoid potential buffer_head leak in
 __ext4_new_inode
To: Zhang Yi <yi.zhang@huawei.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
 <20240813120712.2592310-3-shikemeng@huaweicloud.com>
 <0351b3b1-e84a-9e41-a492-743f5bbea910@huawei.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <b089fd73-5c3d-89d7-e947-646b301babb2@huaweicloud.com>
Date: Thu, 15 Aug 2024 09:36:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0351b3b1-e84a-9e41-a492-743f5bbea910@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDHGUyJW71mwcmsBg--.62677S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr4rtw1fur4rJr17Zr1UWrg_yoW8Ar1fpr
	Z3tF1UKFs5Xr9Igryft34FvF1rtan7Ka17JF4Svw1rWFsrKrnaqrWxKFy8WFn8Ars7XF4q
	qFsIkF48Xr129a7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/14/2024 4:48 PM, Zhang Yi wrote:
> On 2024/8/13 20:07, Kemeng Shi wrote:
>> If a group is marked EXT4_GROUP_INFO_IBITMAP_CORRUPT after it's inode
>> bitmap buffer_head was successfully verified, then __ext4_new_inode
>> will get a valid inode_bitmap_bh of a corrupted group from
>> ext4_read_inode_bitmap in which case inode_bitmap_bh misses a release.
>> Hnadle "IS_ERR(inode_bitmap_bh)" and group corruption separately like
>> how ext4_free_inode does to avoid buffer_head leak.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/ialloc.c | 10 +++++++---
>>  1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
>> index ad7f13976dc6..f24a238b6b09 100644
>> --- a/fs/ext4/ialloc.c
>> +++ b/fs/ext4/ialloc.c
>> @@ -1054,9 +1054,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>>  		brelse(inode_bitmap_bh);
>>  		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
>>  		/* Skip groups with suspicious inode tables */
>> -		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
>> -		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
>> -		    IS_ERR(inode_bitmap_bh)) {
>> +		if (IS_ERR(inode_bitmap_bh)) {
>> +			inode_bitmap_bh = NULL;
>> +			goto next_group;
>> +		}
>> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY) &&
>> +		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
>> +			brelse(inode_bitmap_bh);
>>  			inode_bitmap_bh = NULL;
> 
> Wouldn't the inode_bitmap_bh be brelsed in the next loop or the end of this
> function? why not just goto next_group?
Sure, goto next_group directly will be better. Will do it in next version.

Thanks,
Kemeng
> 
> Thanks,
> Yi.
> 
>>  			goto next_group;
>>  		}
>>
> 


