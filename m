Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067558D1DE
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 13:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfHNLOL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 07:14:11 -0400
Received: from mx2.suse.de ([195.135.220.15]:35574 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726265AbfHNLOL (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 14 Aug 2019 07:14:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F260DACEC;
        Wed, 14 Aug 2019 11:14:09 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ED2691E4200; Wed, 14 Aug 2019 13:14:08 +0200 (CEST)
Date:   Wed, 14 Aug 2019 13:14:08 +0200
From:   Jan Kara <jack@suse.cz>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz,
        adilger.kernel@dilger.ca
Subject: Re: [PATCH v3] ext4: fix potential use after free in system zone via
 remount with noblock_validity
Message-ID: <20190814111408.GC26273@quack2.suse.cz>
References: <1565701547-146508-1-git-send-email-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565701547-146508-1-git-send-email-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 13-08-19 21:05:47, zhangyi (F) wrote:
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
> Changes since v2:
>  - Remove seqlock, and assign the whole rbtree when finished assembling.
>  - Fix the sparse warning.

Thanks for the patch! It looks great to me. Just one nit below and with
that applied feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

>  int ext4_setup_system_zone(struct super_block *sb)
...
>  /* Called when the filesystem is unmounted */
>  void ext4_release_system_zone(struct super_block *sb)

Can you perhaps add a comment before ext4_setup_system_zone() and
ext4_release_system_zone() explaining that these two functions are called
under sb->s_umount semaphore protection which also serializes updates of
sb->system_blks pointer? Thanks!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
