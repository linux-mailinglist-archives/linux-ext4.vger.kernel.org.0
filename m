Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 334C59CB92
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Aug 2019 10:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbfHZIbq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Aug 2019 04:31:46 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:58852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726747AbfHZIbq (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 26 Aug 2019 04:31:46 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D0093D5AD12F44246E56;
        Mon, 26 Aug 2019 16:31:44 +0800 (CST)
Received: from [127.0.0.1] (10.177.244.145) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Mon, 26 Aug 2019
 16:31:42 +0800
Subject: Re: [PATCH v5] ext4: fix potential use after free in system zone via
 remount with noblock_validity
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
References: <1565869639-105420-1-git-send-email-yi.zhang@huawei.com>
 <20190825034000.GE5163@mit.edu> <20190826025612.GB4918@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <jack@suse.cz>,
        <adilger.kernel@dilger.ca>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <33767946-1e6f-5165-94b3-46e2da15172f@huawei.com>
Date:   Mon, 26 Aug 2019 16:31:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20190826025612.GB4918@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.177.244.145]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/8/26 10:56, Theodore Y. Ts'o Wrote:
> I added a missing rcu_read_lock() to prevent a suspicious RCU
> warning when CONFIG_PROVE_RCU is enabled:
> 
> diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
> index 003dc1dc2da3..f7bc914a74df 100644
> --- a/fs/ext4/block_validity.c
> +++ b/fs/ext4/block_validity.c
> @@ -330,11 +330,13 @@ void ext4_release_system_zone(struct super_block *sb)
>  {
>  	struct ext4_system_blocks *system_blks;
>  
> +	rcu_read_lock();
>  	system_blks = rcu_dereference(EXT4_SB(sb)->system_blks);
>  	rcu_assign_pointer(EXT4_SB(sb)->system_blks, NULL);
>  
>  	if (system_blks)
>  		call_rcu(&system_blks->rcu, ext4_destroy_system_zone);
> +	rcu_read_unlock();
>  }
>  
>  int ext4_data_block_valid(struct ext4_sb_info *sbi, ext4_fsblk_t start_blk,
> 

Hi Ted，
Sorry about missing this warning, I think switch to use:
  system_blks = rcu_dereference_raw(EXT4_SB(sb)->system_blks);
or
  system_blks = rcu_dereference_protected(EXT4_SB(sb)->system_blks, true);
is enough to fix this waring, am I missing something?

Thanks,
Yi.

