Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0EF12808C2
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Oct 2020 22:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgJAUuD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Oct 2020 16:50:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39114 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726581AbgJAUuD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Oct 2020 16:50:03 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 091Knhfs024467
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Oct 2020 16:49:44 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AC13342003C; Thu,  1 Oct 2020 16:49:43 -0400 (EDT)
Date:   Thu, 1 Oct 2020 16:49:43 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/4] e2fsck: use the right conversion specifier in
 e2fsck_allocate_memory()
Message-ID: <20201001204943.GP23474@mit.edu>
References: <20200605081442.13428-1-lczerner@redhat.com>
 <20200605081442.13428-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605081442.13428-3-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, I had fixed this in one place, but the fix under the #ifdef
DEBUG_ALLOCATE_MEMORY needed, so that part has been applied.

		      	      	 - Ted
				 



On Fri, Jun 05, 2020 at 10:14:41AM +0200, Lukas Czerner wrote:
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  e2fsck/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/e2fsck/util.c b/e2fsck/util.c
> index 88e0ea8a..79916928 100644
> --- a/e2fsck/util.c
> +++ b/e2fsck/util.c
> @@ -123,10 +123,10 @@ void *e2fsck_allocate_memory(e2fsck_t ctx, unsigned long size,
>  	char buf[256];
>  
>  #ifdef DEBUG_ALLOCATE_MEMORY
> -	printf("Allocating %u bytes for %s...\n", size, description);
> +	printf("Allocating %lu bytes for %s...\n", size, description);
>  #endif
>  	if (ext2fs_get_memzero(size, &ret)) {
> -		sprintf(buf, "Can't allocate %u bytes for %s\n",
> +		sprintf(buf, "Can't allocate %lu bytes for %s\n",
>  			size, description);
>  		fatal_error(ctx, buf);
>  	}
> -- 
> 2.21.3
> 
