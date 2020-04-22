Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F01B4A04
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Apr 2020 18:14:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgDVQOP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Apr 2020 12:14:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:38074 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgDVQOP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 22 Apr 2020 12:14:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id AC61FAC8F;
        Wed, 22 Apr 2020 16:14:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id F1B1F1E0E56; Wed, 22 Apr 2020 18:14:13 +0200 (CEST)
Date:   Wed, 22 Apr 2020 18:14:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Eric Whitney <enwlinux@gmail.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH 2/2] ext4: translate a few more map flags to strings in
 tracepoints
Message-ID: <20200422161413.GF20756@quack2.suse.cz>
References: <20200415203140.30349-1-enwlinux@gmail.com>
 <20200415203140.30349-3-enwlinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415203140.30349-3-enwlinux@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 15-04-20 16:31:40, Eric Whitney wrote:
> As new ext4_map_blocks() flags have been added, not all have gotten flag
> bit to string translations to make tracepoint output more readable.
> Fix that, and go one step further by adding a translation for the
> EXT4_EX_NOCACHE flag as well.  The EXT4_EX_FORCE_CACHE flag can never
> be set in a tracepoint in the current code, so there's no need to
> bother with a translation for it right now.
> 
> Signed-off-by: Eric Whitney <enwlinux@gmail.com>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/trace/events/ext4.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
> index 40ff8a2fc763..280475c1cecc 100644
> --- a/include/trace/events/ext4.h
> +++ b/include/trace/events/ext4.h
> @@ -45,7 +45,10 @@ struct partial_cluster;
>  	{ EXT4_GET_BLOCKS_CONVERT,		"CONVERT" },		\
>  	{ EXT4_GET_BLOCKS_METADATA_NOFAIL,	"METADATA_NOFAIL" },	\
>  	{ EXT4_GET_BLOCKS_NO_NORMALIZE,		"NO_NORMALIZE" },	\
> -	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" })
> +	{ EXT4_GET_BLOCKS_CONVERT_UNWRITTEN,	"CONVERT_UNWRITTEN" },  \
> +	{ EXT4_GET_BLOCKS_ZERO,			"ZERO" },		\
> +	{ EXT4_GET_BLOCKS_IO_SUBMIT,		"IO_SUBMIT" },		\
> +	{ EXT4_EX_NOCACHE,			"EX_NOCACHE" })
>  
>  /*
>   * __print_flags() requires that all enum values be wrapped in the
> -- 
> 2.11.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
