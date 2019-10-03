Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D57A1C9ED9
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Oct 2019 14:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbfJCMvW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 08:51:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44184 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJCMvV (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 08:51:21 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id B36B84FCC9
        for <linux-ext4@vger.kernel.org>; Thu,  3 Oct 2019 12:51:21 +0000 (UTC)
Received: from work (unknown [10.40.205.162])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F89F608A5
        for <linux-ext4@vger.kernel.org>; Thu,  3 Oct 2019 12:51:21 +0000 (UTC)
Date:   Thu, 3 Oct 2019 14:51:17 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 1/2] mke2fs: Warn if page size != blocksize when ecnrypt
 is enabled
Message-ID: <20191003125117.75gmubgqgcp3xo3k@work>
References: <20190821131813.9456-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821131813.9456-1-lczerner@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 03 Oct 2019 12:51:21 +0000 (UTC)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

ping

On Wed, Aug 21, 2019 at 03:18:12PM +0200, Lukas Czerner wrote:
> With encrypt feature enabled the file system block size must match
> system page size. Currently mke2fs will not complain at all when we try
> to create a file system that does not satisfy this requirement for the
> system. Add a warning for this case.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> ---
>  misc/mke2fs.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/misc/mke2fs.c b/misc/mke2fs.c
> index d7cf257e..aa9590d8 100644
> --- a/misc/mke2fs.c
> +++ b/misc/mke2fs.c
> @@ -2468,6 +2468,26 @@ profile_error:
>  		      exit (1);
>  	}
>  
> +	/*
> +	 * Encrypt feature requires blocksize to be the same as page size,
> +	 * otherwise file system won't mount
> +	 */
> +	if (ext2fs_has_feature_encrypt(&fs_param) &&
> +	   (blocksize != sys_page_size)) {
> +		if (!force) {
> +			com_err(program_name, 0,
> +				_("Encrypt feature is enabled, but block size "
> +				  "(%dB) does not match system page size "
> +				  "(%dB)"),
> +				blocksize, sys_page_size);
> +			proceed_question(proceed_delay);
> +		}
> +		fprintf(stderr,_("Warning: Encrypt feature enabled, but block "
> +				 "size (%dB) does not match system page size "
> +				 "(%dB), forced to continue\n"),
> +			blocksize, sys_page_size);
> +	}
> +
>  	/* Don't allow user to set both metadata_csum and uninit_bg bits. */
>  	if (ext2fs_has_feature_metadata_csum(&fs_param) &&
>  	    ext2fs_has_feature_gdt_csum(&fs_param))
> -- 
> 2.21.0
> 
