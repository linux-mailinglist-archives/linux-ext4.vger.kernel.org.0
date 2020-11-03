Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4802A47B4
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 15:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgKCOPE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 09:15:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:56422 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgKCONc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Nov 2020 09:13:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A456ABF4;
        Tue,  3 Nov 2020 14:13:31 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5DDA61E12FB; Tue,  3 Nov 2020 15:13:31 +0100 (CET)
Date:   Tue, 3 Nov 2020 15:13:31 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [PATCH 02/10] ext4: mark fc ineligible if inode gets evictied
 due to mem pressure
Message-ID: <20201103141331.GF3440@quack2.suse.cz>
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-3-harshadshirwadkar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201031200518.4178786-3-harshadshirwadkar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 31-10-20 13:05:10, Harshad Shirwadkar wrote:
> If inode gets evicted due to memory pressure, we have to remove it
> from the fast commit list. However, that inode may have uncommitted
> changes that fast commits will lose. So, just fall back to full
> commits in this case. Also, rename the fast commit ineligiblity reason
> from "EXT4_FC_REASON_MEM" to "EXT4_FC_REASON_MEM_CRUNCH" for better
> expression.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

...

> diff --git a/fs/ext4/fast_commit.h b/fs/ext4/fast_commit.h
> index 06907d485989..cde86747faf8 100644
> --- a/fs/ext4/fast_commit.h
> +++ b/fs/ext4/fast_commit.h
> @@ -100,7 +100,7 @@ enum {
>  	EXT4_FC_REASON_XATTR = 0,
>  	EXT4_FC_REASON_CROSS_RENAME,
>  	EXT4_FC_REASON_JOURNAL_FLAG_CHANGE,
> -	EXT4_FC_REASON_MEM,
> +	EXT4_FC_REASON_MEM_CRUNCH,

Well MEM_CRUNCH doesn't really sound more understandable to me :). I'd
rather call it MEM_RECLAIM or ENOMEM or something like that...

> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index b96a18679a27..52ff71236290 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -327,6 +327,7 @@ void ext4_evict_inode(struct inode *inode)
>  	ext4_xattr_inode_array_free(ea_inode_array);
>  	return;
>  no_delete:
> +	ext4_fc_mark_ineligible(inode->i_sb, EXT4_FC_REASON_MEM_CRUNCH);
>  	ext4_clear_inode(inode);	/* We must guarantee clearing of inode... */
>  }

This will make fs ineligible on every inode reclaim. Even if the inode was
clean, not part of any FC. I guess this is too aggressive...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
