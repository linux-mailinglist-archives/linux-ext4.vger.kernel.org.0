Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEB01B4930
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 17:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgDVPxe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 11:53:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:56528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgDVPxd (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 11:53:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5A72DAE6E;
        Wed, 22 Apr 2020 15:53:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6E7DD1E0E56; Wed, 22 Apr 2020 17:53:31 +0200 (CEST)
Date:   Wed, 22 Apr 2020 17:53:31 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH] ext4: increase wait time needed before reuse of deleted
 inode numbers
Message-ID: <20200422155331.GB20756@quack2.suse.cz>
References: <20200414023925.273867-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414023925.273867-1-tytso@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 13-04-20 22:39:25, Theodore Ts'o wrote:
> Current wait times have proven to be too short to protect against inode
> reuses that lead to metadata inconsistencies.
> 
> Now that we will retry the inode allocation if we can't find any
> recently deleted inodes, it's a lot safer to increase the recently
> deleted time from 5 seconds to a minute.
> 
> Google-Bug-Id: 36602237
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ialloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index 9faaf32be5cc..4b8c9a9bdf0c 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -662,7 +662,7 @@ static int find_group_other(struct super_block *sb, struct inode *parent,
>   * block has been written back to disk.  (Yes, these values are
>   * somewhat arbitrary...)
>   */
> -#define RECENTCY_MIN	5
> +#define RECENTCY_MIN	60
>  #define RECENTCY_DIRTY	300
>  
>  static int recently_deleted(struct super_block *sb, ext4_group_t group, int ino)
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
