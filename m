Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D1A216143
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jul 2020 00:04:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgGFWEW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 6 Jul 2020 18:04:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgGFWEW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 6 Jul 2020 18:04:22 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57AC920674;
        Mon,  6 Jul 2020 22:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594073062;
        bh=Tpqj0vEGh0Y4BJob+fzM4aQgx7atUZnSrUcJ8xYrJM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkkqhoX50pjFSabpN36EUot1qekoaqkvgn/3xVwtk43vN+as8LgTaPJxwAsro1iJG
         diCDonUDKIrgpyW/3vKnHjk/8/ohqqJV1U7zb9XxwZh0EQg69mb3sa+5yWjW0ar9wP
         YdffYOUQzPv7kSJE+Ia7rQCx9E2nIHvyvj87CXOY=
Date:   Mon, 6 Jul 2020 15:04:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Florian Schmaus <flo@geekplace.eu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/3] e4crypt: refactor set_policy a little
Message-ID: <20200706220420.GB827691@gmail.com>
References: <20200706194727.12979-1-flo@geekplace.eu>
 <20200706194727.12979-2-flo@geekplace.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706194727.12979-2-flo@geekplace.eu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 06, 2020 at 09:47:26PM +0200, Florian Schmaus wrote:
> Remove the superfluous 'salt' variable and simply use the functions
> parameter instead.
> 
> Signed-off-by: Florian Schmaus <flo@geekplace.eu>
> ---
>  misc/e4crypt.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/misc/e4crypt.c b/misc/e4crypt.c
> index c82c6f8f..23980073 100644
> --- a/misc/e4crypt.c
> +++ b/misc/e4crypt.c
> @@ -344,10 +344,9 @@ static void parse_salt(char *salt_str, int flags)
>  	add_salt(salt_buf, salt_len);
>  }
>  
> -static void set_policy(struct salt *set_salt, int pad,
> +static void set_policy(struct salt *salt, int pad,
>  		       int argc, char *argv[], int path_start_index)
>  {
> -	struct salt *salt;
>  	struct ext4_encryption_policy policy;
>  	uuid_t	uu;
>  	int fd;
> @@ -366,9 +365,7 @@ static void set_policy(struct salt *set_salt, int pad,
>  			perror(argv[x]);
>  			exit(1);
>  		}
> -		if (set_salt)
> -			salt = set_salt;
> -		else {
> +		if (!salt) {
>  			if (ioctl(fd, EXT4_IOC_GET_ENCRYPTION_PWSALT,
>  				  &uu) < 0) {
>  				perror("EXT4_IOC_GET_ENCRYPTION_PWSALT");

This is wrong.  If no salt was explicitly specified, then the salt returned by
EXT4_IOC_GET_ENCRYPTION_PWSALT for the directory should be used.  There can be
multiple directories being processed.  Your patch changes the behavior so that
the default salt of the first directory is also used for all later directories.

- Eric
