Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6A6EBF1
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 23:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbfD2VLn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Apr 2019 17:11:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:47820 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726154AbfD2VLm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Apr 2019 17:11:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0D337AEF8;
        Mon, 29 Apr 2019 21:11:41 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BB45E1E3BEC; Mon, 29 Apr 2019 23:11:39 +0200 (CEST)
Date:   Mon, 29 Apr 2019 23:11:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     Debabrata Banerjee <dbanerje@akamai.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, Dmitry Monakhov <dmonakhov@openvz.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: bad mount opts in no journal mode
Message-ID: <20190429211139.GC1424@quack2.suse.cz>
References: <20190429173158.1463-1-dbanerje@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190429173158.1463-1-dbanerje@akamai.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 29-04-19 13:31:58, Debabrata Banerjee wrote:
> Fixes:
> commit 1e381f60dad9 ("ext4: do not allow journal_opts for fs w/o journal")
> 
> Instead of removing EXT4_MOUNT_JOURNAL_CHECKSUM from s_def_mount_opt as
> I assume was intended, all other options were blown away leading to
> _ext4_show_options() output being incorrect.
> 
> Signed-off-by: Debabrata Banerjee <dbanerje@akamai.com>

Thanks! You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 6ed4eb81e674..5cdf1d88b5c3 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4238,7 +4238,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
>  				 "data=, fs mounted w/o journal");
>  			goto failed_mount_wq;
>  		}
> -		sbi->s_def_mount_opt &= EXT4_MOUNT_JOURNAL_CHECKSUM;
> +		sbi->s_def_mount_opt &= ~EXT4_MOUNT_JOURNAL_CHECKSUM;
>  		clear_opt(sb, JOURNAL_CHECKSUM);
>  		clear_opt(sb, DATA_FLAGS);
>  		sbi->s_journal = NULL;
> -- 
> 2.21.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
