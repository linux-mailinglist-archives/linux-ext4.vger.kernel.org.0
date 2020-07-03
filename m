Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE3921395B
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Jul 2020 13:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgGCLc3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Jul 2020 07:32:29 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17065 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbgGCLc3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Jul 2020 07:32:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593775938; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=mbm5z/rDXPXxJTE0XFrU2xvgIZ/YrKHwl6XJJUrqi8f+l15KAanfGhDCkxPGpdayjTyDw0yR1HYy8s5/HBMw+EMOZXh6gSRTDQ2Kj4oReeJGLjqHYMgq/5u2YJe9gV6PiHiVf+Y2lsM/s50xRQL0s4zRx4RbsE5QdDRvhCRYi1o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1593775938; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=4ddpW60DKz6/ueqd9yvS2dT5cEW4j2jLPwjwCX/zDPc=; 
        b=VkZrE/TwKasxqp0/Ec//z786pYPQtVPur6EHwyObv8F+qbIPJ/rOL4sEqL98/crI2jHfIOlLUMOcZ3pZqP2oXDpG5cqfPMLrkkMU6EkwidMhcoKaWH7QkNaCvZQrKmGdKHZzwhaXmzVDC4rLkHXt1zvEggXFXTTWlY/1C7t2oCk=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1593775938;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=4ddpW60DKz6/ueqd9yvS2dT5cEW4j2jLPwjwCX/zDPc=;
        b=axdH9rljFCPdnzH4czlFWI2at3iEKm2ncnczM9LQOLwctmKpEsn0Qa3JiFU/umVp
        NgxpCLU/7EXy530ueWlXTd1ZT57xAbJ2PXyWZCIz/M87y2wmTi5yzYFiFvg+EQPczRS
        1DGb2IuMIb9BUjQRK9CJZiS34h/5CPr9xV/QcPX4=
Received: from [10.0.0.14] (113.116.49.35 [113.116.49.35]) by mx.zoho.com.cn
        with SMTPS id 1593775935767839.0081122735146; Fri, 3 Jul 2020 19:32:15 +0800 (CST)
Subject: Re: [PATCH] ext2: delete incorrect comment for
 ext2_blks_to_allocate()
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
References: <20200702095636.29246-1-cgxu519@mykernel.net>
 <20200703102019.GC4355@quack2.suse.cz>
From:   cgxu <cgxu519@mykernel.net>
Message-ID: <619147f3-89f5-3e8c-ff12-0f2115ae6d73@mykernel.net>
Date:   Fri, 3 Jul 2020 19:32:15 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200703102019.GC4355@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 7/3/20 6:20 PM, Jan Kara wrote:
> On Thu 02-07-20 17:56:36, Chengguang Xu wrote:
>> ext2_blks_to_allocate() only counts direct blocks need to be allocated,
>> return value does not include indirect blocks.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>>   fs/ext2/inode.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
>> index c8b371c82b4f..4df849e694dd 100644
>> --- a/fs/ext2/inode.c
>> +++ b/fs/ext2/inode.c
>> @@ -355,9 +355,6 @@ static inline ext2_fsblk_t ext2_find_goal(struct inode *inode, long block,
>>    *	@k: number of blocks need for indirect blocks
>>    *	@blks: number of data blocks to be mapped.
>>    *	@blocks_to_boundary:  the offset in the indirect block
>> - *
>> - *	return the total number of blocks to be allocate, including the
>> - *	direct and indirect blocks.
> 
> You're right the comment is wrong but instead of deleting it, I'd rather
> fix it like: "Return the number of direct blocks to allocate."
> 

That's fine, I can resend it with another comment fix together.

Thanks,
cgxu
