Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B76D232318
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Jul 2020 19:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgG2RFJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jul 2020 13:05:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:46806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgG2RFI (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 29 Jul 2020 13:05:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C19A6B61F;
        Wed, 29 Jul 2020 17:05:18 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id BFFA71E12C7; Wed, 29 Jul 2020 19:05:06 +0200 (CEST)
Date:   Wed, 29 Jul 2020 19:05:06 +0200
From:   Jan Kara <jack@suse.cz>
To:     kyoungho koo <rnrudgh@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix comment typo "the the".
Message-ID: <20200729170506.GD16052@quack2.suse.cz>
References: <20200424171620.GA11943@koo-Z370-HD3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424171620.GA11943@koo-Z370-HD3>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 25-04-20 02:16:24, kyoungho koo wrote:
> I have found double typed comments "the the". So i modified it to
> one "the"
> 
> Signed-off-by: kyoungho koo <rnrudgh@gmail.com>

Ted, this seems to have fallen through the cracks...

								Honza

> ---
>  fs/ext4/inline.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index f35e289e17aa..bb8d7cb7bdec 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -276,7 +276,7 @@ static int ext4_create_inline_data(handle_t *handle,
>  		len = 0;
>  	}
>  
> -	/* Insert the the xttr entry. */
> +	/* Insert the xttr entry. */
>  	i.value = value;
>  	i.value_len = len;
>  
> -- 
> 2.17.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
