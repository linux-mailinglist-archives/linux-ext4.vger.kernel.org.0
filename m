Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA7E823062C
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jul 2020 11:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgG1JKg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Jul 2020 05:10:36 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8837 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727970AbgG1JKf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Jul 2020 05:10:35 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 22F452697912E371BFAF;
        Tue, 28 Jul 2020 17:10:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.38) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 28 Jul 2020
 17:10:28 +0800
Subject: Re: [PATCH 3/6] ext4: Check journal inode extents more carefully
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, Lukas Czerner <lczerner@redhat.com>
References: <20200727114429.1478-1-jack@suse.cz>
 <20200727114429.1478-4-jack@suse.cz>
From:   luomeng <luomeng12@huawei.com>
Message-ID: <ec26732c-d219-8219-e7d6-63dab7aee03d@huawei.com>
Date:   Tue, 28 Jul 2020 17:10:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200727114429.1478-4-jack@suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.38]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2020/7/27 19:44, Jan Kara Ð´µÀ:
> -int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> +int ext4_inode_block_valid(struct inode *inode, ext4_fsblk_t start_blk,
>   			  unsigned int count)
>   {
>   	struct ext4_system_blocks *system_blks;
> @@ -344,8 +346,8 @@ int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
>   	 */
>   	rcu_read_lock();
>   	system_blks = rcu_dereference(sbi->system_blks);
Because of a change in the function parameters£¬there is no 'sbi' 
declared. So there will be a compile error:

   fs/ext4/block_validity.c: In function ¡®ext4_inode_block_valid¡¯:
   fs/ext4/block_validity.c:345:32: error: ¡®sbi¡¯ undeclared (first use 
        in this function)
   system_blks = rcu_dereference(sbi->system_blks);
> -	ret = ext4_data_block_valid_rcu(sbi, system_blks, start_blk,
> -					count);
> +	ret = ext4_data_block_valid_rcu(EXT4_SB(inode->i_sb), system_blks,
> +					start_blk, count, inode->i_ino);
>   	rcu_read_unlock();
>   	return ret;
>   }

