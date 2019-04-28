Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7274E176
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfD2Ljv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Apr 2019 07:39:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:47594 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727872AbfD2Ljv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Apr 2019 07:39:51 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F930AE84;
        Mon, 29 Apr 2019 11:39:50 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 87F711E3BFD; Sun, 28 Apr 2019 22:21:54 +0200 (CEST)
Date:   Sun, 28 Apr 2019 22:21:54 +0200
From:   Jan Kara <jack@suse.cz>
To:     Debabrata Banerjee <dbanerje@akamai.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: bad mount opts in no journal mode
Message-ID: <20190428202154.GE7441@quack2>
References: <20190411214917.1899-1-dbanerje@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190411214917.1899-1-dbanerje@akamai.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-04-19 17:49:17, Debabrata Banerjee wrote:
> Fixes:
> commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")
> 
> Instead of removing EXT4_MOUNT_JOURNAL_CHECKSUM from s_def_mount_opt as
> I assume was intended, all other options were blown away leading to
> _ext4_show_options() output being incorrect. I don't see why this or
> other journal related flags should be removed from s_def_mount_opt
> regardless, it is only used for comparison to display opts, and we
> already made sure they couldn't be set.
> 
> Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>

So I agree that the clearing is wrong. But I don't agree with just deleting
the line. We could have JOURNAL_CHECKSUM in s_def_mount_opt in nojournal
mode and in such case we don't want to show in /proc/mounts
nojournal_checksum as a mount option. So the line should be really fixed
to:

	sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;

								Honza

> ---
>  fs/ext4/super.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6ed4eb81e674..63eef29666e0 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4238,7 +4238,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  				 "data=, fs mounted w/o journal");
>  			goto failed_mount_wq;
>  		}
> -		sbi->s_def_mount_opt &= EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
>  		clear_opt(sb, DATA_FLAGS);
>  		sbi->s_journal = NULL;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
