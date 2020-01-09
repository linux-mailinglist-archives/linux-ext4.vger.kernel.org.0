Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCD741356C8
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 11:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgAIKXQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 05:23:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:49852 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728944AbgAIKXQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 05:23:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA56F69DC5;
        Thu,  9 Jan 2020 10:22:55 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 6DDCC1E0798; Thu,  9 Jan 2020 11:22:54 +0100 (CET)
Date:   Thu, 9 Jan 2020 11:22:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     zhengbin <zhengbin13@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: use true,false for bool variable
Message-ID: <20200109102254.GE27035@quack2.suse.cz>
References: <1577241959-138695-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577241959-138695-1-git-send-email-zhengbin13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 25-12-19 10:45:59, zhengbin wrote:
> Fixes coccicheck warning:
> 
> fs/ext4/extents.c:5271:6-12: WARNING: Assignment of 0/1 to bool variable
> fs/ext4/extents.c:5287:4-10: WARNING: Assignment of 0/1 to bool variable
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: zhengbin <zhengbin13@huawei.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 0e8708b..d8611be 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5268,7 +5268,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  {
>  	int depth, err = 0;
>  	struct ext4_extent *ex_start, *ex_last;
> -	bool update = 0;
> +	bool update = false;
>  	depth = path->p_depth;
> 
>  	while (depth >= 0) {
> @@ -5284,7 +5284,7 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>  				goto out;
> 
>  			if (ex_start == EXT_FIRST_EXTENT(path[depth].p_hdr))
> -				update = 1;
> +				update = true;
> 
>  			while (ex_start <= ex_last) {
>  				if (SHIFT == SHIFT_LEFT) {
> --
> 2.7.4
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
