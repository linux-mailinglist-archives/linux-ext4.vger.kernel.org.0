Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFAD1F10FF
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 03:20:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgFHBUH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 21:20:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:50534 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727972AbgFHBUH (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 7 Jun 2020 21:20:07 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BF881C31F3ECCA726673
        for <linux-ext4@vger.kernel.org>; Mon,  8 Jun 2020 09:20:03 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.198) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Jun 2020
 09:20:00 +0800
Subject: Re: [PATCH v2 2/2] ext2: ext2_find_entry() return -ENOENT if no entry
 found
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>
References: <20200603063514.3904811-1-yi.zhang@huawei.com>
 <20200603063514.3904811-2-yi.zhang@huawei.com>
 <20200605151100.GD13248@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <13a18e5f-faea-f8b6-1072-8e911975ddc2@huawei.com>
Date:   Mon, 8 Jun 2020 09:20:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200605151100.GD13248@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.198]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2020/6/5 23:11, Jan Kara wrote:
> On Wed 03-06-20 14:35:14, zhangyi (F) wrote:
>> Almost all callers of ext2_find_entry() transform NULL return value to
>> -ENOENT, so just let ext2_find_entry() retuen -ENOENT instead of NULL
>> if no valid entry found, and also switch to check the return value of
>> ext2_inode_by_name() in ext2_lookup() and ext2_get_parent().
>>
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
>> Suggested-by: Jan Kara <jack@suse.cz>
> 
> Thanks for the patch. Just one small nit below.
> 
>> @@ -419,11 +419,16 @@ int ext2_inode_by_name(struct inode *dir, const struct qstr *child, ino_t *ino)
>>  	struct page *page;
>>  	
>>  	de = ext2_find_entry(dir, child, &page);
>> -	if (IS_ERR_OR_NULL(de))
>> +	if (IS_ERR(de))
>>  		return PTR_ERR(de);
>>  
>> -	*ino = le32_to_cpu(de->inode);
>>  	ext2_put_page(page);
>> +	if (!de->inode) {
> 
> ext2_find_entry() will not ever return de with de->inode == 0 because
> ext2_match() never returns true for such entries. So I'd just remove this
> condition...
> 
Indeed, I missed this point, will do.

Thanks,
Yi.

