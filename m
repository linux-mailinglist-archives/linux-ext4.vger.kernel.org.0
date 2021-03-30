Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B5FA34EBEE
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Mar 2021 17:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhC3PQI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 30 Mar 2021 11:16:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:42512 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhC3PPf (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 30 Mar 2021 11:15:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 16EE9AC1A;
        Tue, 30 Mar 2021 15:15:34 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3A5361E4353; Tue, 30 Mar 2021 17:15:33 +0200 (CEST)
Date:   Tue, 30 Mar 2021 17:15:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Mauricio Faria de Oliveira <mfo@canonical.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "zhangyi (F)" <yi.zhang@huawei.com>,
        Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Hui Su <sh_def@163.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] jbd2: avoid -Wempty-body warnings
Message-ID: <20210330151533.GA10067@quack2.suse.cz>
References: <20210322102152.95684-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322102152.95684-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 22-03-21 11:21:38, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Building with 'make W=1' shows a harmless -Wempty-body warning:
> 
> fs/jbd2/recovery.c: In function 'fc_do_one_pass':
> fs/jbd2/recovery.c:267:75: error: suggest braces around empty body in an 'if' statement [-Werror=empty-body]
>   267 |                 jbd_debug(3, "Fast commit replay failed, err = %d\n", err);
>       |                                                                           ^
> 
> Change the empty dprintk() macros to no_printk(), which avoids this
> warning and adds format string checking.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/jbd2.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 99d3cd051ac3..232e6285536a 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -61,7 +61,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
>  #define jbd_debug(n, fmt, a...) \
>  	__jbd2_debug((n), __FILE__, __func__, __LINE__, (fmt), ##a)
>  #else
> -#define jbd_debug(n, fmt, a...)    /**/
> +#define jbd_debug(n, fmt, a...)  no_printk(fmt, ##a)
>  #endif
>  
>  extern void *jbd2_alloc(size_t size, gfp_t flags);
> -- 
> 2.29.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
