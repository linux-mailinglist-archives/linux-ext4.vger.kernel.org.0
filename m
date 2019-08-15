Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5D8E860
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Aug 2019 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731179AbfHOJfo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Aug 2019 05:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:59004 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730212AbfHOJfo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Aug 2019 05:35:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 8196DB12E;
        Thu, 15 Aug 2019 09:35:42 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 172DE1E4200; Thu, 15 Aug 2019 11:35:42 +0200 (CEST)
Date:   Thu, 15 Aug 2019 11:35:42 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH v4] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <20190815093542.GA14313@quack2.suse.cz>
References: <20190815081631.19437-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190815081631.19437-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 15-08-19 16:16:31, zhangyi (F) wrote:
> Remount process will release system zone which was allocated before if
> "noblock_validity" is specified. If we mount an ext4 file system to two
> mountpoints with default mount options, and then remount one of them
> with "noblock_validity", it may trigger a use after free problem when
> someone accessing the other one.
> 
>  # mount /dev/sda foo
>  # mount /dev/sda bar
> 
> User access mountpoint "foo"   |   Remount mountpoint "bar"
>                                |
> ext4_map_blocks()              |   ext4_remount()
> check_block_validity()         |   ext4_setup_system_zone()
> ext4_data_block_valid()        |   ext4_release_system_zone()
>                                |   free system_blks rb nodes
> access system_blks rb nodes    |
> trigger use after free         |
> 
> This problem can also be reproduced by one mountpint, At the same time,
> add_system_zone() can get called during remount as well so there can be
> racing ext4_data_block_valid() reading the rbtree at the same time.
> 
> This patch add RCU to protect system zone from releasing or building
> when doing a remount which inverse current "noblock_validity" mount
> option. It assign the rbtree after the whole tree was complete and
> do actual freeing after rcu grace period, avoid any intermediate state.
> 
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> ---
> Changes since v3:
>  - add comments before ext4_setup_system_zone() and
>    ext4_release_system_zone() to explain why we need to serializes update
>    sbi->system_blks pointer.
>  - Fix block validity checking logic changes in v3.

Thanks for the patch! The patch looks good. Just some language fixes in the
new comments below.  You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

> +/*
> + * Build system zone rbtree which is used for block validity checking.
> + *
> + * Note that system_blks pointer should be serializes updated at remount
> + * time even under sb->s_umount semaphore protection, due to it can be
> + * racing with ext4_data_block_valid() reading the system_blks rbtree at
> + * the same time.

I'd rephrase this paragraph a bit to be easier to understand:

The update of system_blks pointer in this function is protected by
sb->s_umount semaphore. However we have to be careful as we can be racing
with ext4_data_block_valid() calls reading system_blks rbtree protected
only by RCU. That's why we first build the rbtree and then swap it in place.

> -/* Called when the filesystem is unmounted */
> +/*
> + * Called when the filesystem is unmounted or when remounting it with
> + * noblock_validity specified.
> + *
> + * Note that system_blks pointer should be serializes updated and do
> + * the actual freeing after the RCU grace period at remount time even
> + * under sb->s_umount semaphore protection, due to it can be racing with
> + * ext4_data_block_valid() reading the system_blks rbtree at the same
> + * time.
> + */

Similarly here I'd phrase the last paragraph as:

The update of system_blks pointer in this function is protected by
sb->s_umount semaphore. However we have to be careful as we can be racing
with ext4_data_block_valid() calls reading system_blks rbtree protected
only by RCU. So we first clear the system_blks pointer and then free the
rbtree only after RCU grace period expires.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
