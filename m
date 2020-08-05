Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49EA23D27D
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 22:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgHEUNZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 16:13:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:54546 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgHEQXn (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E52DDAE25;
        Wed,  5 Aug 2020 15:20:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E71D71E12CB; Wed,  5 Aug 2020 17:20:39 +0200 (CEST)
Date:   Wed, 5 Aug 2020 17:20:39 +0200
From:   Jan Kara <jack@suse.cz>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: ext4: fix spelling typos in ext4_mb_initialize_context
Message-ID: <20200805152039.GF16475@quack2.suse.cz>
References: <883b523c-58ec-7f38-0bb8-cd2ea4393684@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <883b523c-58ec-7f38-0bb8-cd2ea4393684@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-07-20 11:00:44, brookxu wrote:
> Fix spelling typos in ext4_mb_initialize_context.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index c0a331e..6dc2c6c 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -4399,7 +4399,7 @@ static void ext4_mb_group_or_file(struct ext4_allocation_context *ac)
>      ac->ac_g_ex = ac->ac_o_ex;
>      ac->ac_flags = ar->flags;
>  
> -    /* we have to define context: we'll we work with a file or
> +    /* we have to define context: we'll work with a file or
>       * locality group. this is a policy, actually */
>      ext4_mb_group_or_file(ac);
>  
> -- 
> 1.8.3.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
