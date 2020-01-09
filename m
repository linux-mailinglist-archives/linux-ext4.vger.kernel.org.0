Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF67D1356BB
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Jan 2020 11:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbgAIKTl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Jan 2020 05:19:41 -0500
Received: from mx2.suse.de ([195.135.220.15]:48872 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729118AbgAIKTj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 9 Jan 2020 05:19:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 472DF69D77;
        Thu,  9 Jan 2020 10:19:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 822C01E0798; Thu,  9 Jan 2020 11:19:30 +0100 (CET)
Date:   Thu, 9 Jan 2020 11:19:30 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unnecessary selections from EXT3_FS
Message-ID: <20200109101930.GD27035@quack2.suse.cz>
References: <20191226153920.4466-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226153920.4466-1-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 26-12-19 09:39:20, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Since EXT3_FS already selects EXT4_FS, there's no reason for it to
> redundantly select all the selections of EXT4_FS -- notwithstanding the
> comments that claim otherwise.
> 
> Remove these redundant selections to avoid confusion.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Interesting. I was always thinking that 'select' is not recursive - at
least that's how I was interpretting the note in kconfig-language.rs:

  Note:
        select should be used with care. select will force
        a symbol to a value without visiting the dependencies.
        By abusing select you are able to select a symbol FOO even
        if FOO depends on BAR that is not set.
        In general use select only for non-visible symbols
        (no prompts anywhere) and for symbols with no dependencies.
        That will limit the usefulness but on the other hand avoid
        the illegal configurations all over.

But when experimenting with it now, I agree that these additional selects
don't seem to be needed in ext3 config. So probably the paragraph just
references to the fact that 'depends on' dependencies are not checked for
'select'. All in all this is a long way to say:

Reviewed-by: Jan Kara <jack@suse.cz>

:)
								Honza

> ---
>  fs/ext4/Kconfig | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
> index ef42ab040905..5841fd8aa706 100644
> --- a/fs/ext4/Kconfig
> +++ b/fs/ext4/Kconfig
> @@ -4,12 +4,7 @@
>  # kernels after the removal of ext3 driver.
>  config EXT3_FS
>  	tristate "The Extended 3 (ext3) filesystem"
> -	# These must match EXT4_FS selects...
>  	select EXT4_FS
> -	select JBD2
> -	select CRC16
> -	select CRYPTO
> -	select CRYPTO_CRC32C
>  	help
>  	  This config option is here only for backward compatibility. ext3
>  	  filesystem is now handled by the ext4 driver.
> @@ -33,7 +28,6 @@ config EXT3_FS_SECURITY
>  
>  config EXT4_FS
>  	tristate "The Extended 4 (ext4) filesystem"
> -	# Please update EXT3_FS selects when changing these
>  	select JBD2
>  	select CRC16
>  	select CRYPTO
> -- 
> 2.24.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
