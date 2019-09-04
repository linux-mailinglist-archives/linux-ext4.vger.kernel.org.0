Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED1AA7CB2
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Sep 2019 09:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbfIDHXf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Sep 2019 03:23:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:34176 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728209AbfIDHXf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Sep 2019 03:23:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AF44BB6B9;
        Wed,  4 Sep 2019 07:23:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 4783E1E37A2; Wed,  4 Sep 2019 09:23:33 +0200 (CEST)
Date:   Wed, 4 Sep 2019 09:23:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext2: Delete an unnecessary check before brelse()
Message-ID: <20190904072333.GB8225@quack2.suse.cz>
References: <51dea296-2207-ebc0-bac3-13f3e5c3b235@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51dea296-2207-ebc0-bac3-13f3e5c3b235@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 03-09-19 14:44:08, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 3 Sep 2019 14:40:18 +0200
> 
> The brelse() function tests whether its argument is NULL
> and then returns immediately.
> Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Thanks. Added to my tree.

								Honza

> ---
>  fs/ext2/super.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index baa36c6fb71e..30c630d73f0f 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -162,8 +162,7 @@ static void ext2_put_super (struct super_block * sb)
>  	}
>  	db_count = sbi->s_gdb_count;
>  	for (i = 0; i < db_count; i++)
> -		if (sbi->s_group_desc[i])
> -			brelse (sbi->s_group_desc[i]);
> +		brelse(sbi->s_group_desc[i]);
>  	kfree(sbi->s_group_desc);
>  	kfree(sbi->s_debts);
>  	percpu_counter_destroy(&sbi->s_freeblocks_counter);
> --
> 2.23.0
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
