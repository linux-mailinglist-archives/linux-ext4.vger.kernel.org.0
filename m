Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0396489A4F
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 14:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiAJNpB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 08:45:01 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:35948 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiAJNos (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jan 2022 08:44:48 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 85742210E2;
        Mon, 10 Jan 2022 13:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641822285; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Es/vszyVq/0VASvIbhasfzhr23C3SCe8HYi55zTaJVU=;
        b=WBzun96dSjBdmxU7VNJVw8gRHYuto4uKj9FkQrMgAP64I64pLM1VXqwh/SgfwKUMs/HO4b
        Q2tQFZ114xb1pgwoP5swVt0grhJ2XxxxOSxmCdQA9UCG8Km6wACVXsu/ZIG62mTX850Gkd
        m8xzg27TYZTXHUQY0jEP4N/tdcWji08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641822285;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Es/vszyVq/0VASvIbhasfzhr23C3SCe8HYi55zTaJVU=;
        b=oVjVE/WCjrhzuVAVCCbt/2MPJuYtUbthUeNGUSRaOr0tvYKdM1InI28nE3hK/wFqQTkC41
        5pWjpDlAIwYrfWCQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 76A86A3B81;
        Mon, 10 Jan 2022 13:44:45 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0AA1FA05B4; Mon, 10 Jan 2022 14:44:45 +0100 (CET)
Date:   Mon, 10 Jan 2022 14:44:45 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     jack@suse.com, tytso@mit.edu, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next -v2] ext4: Fix jbd2_journal_shrink_scan() and
 jbd2_journal_shrink_count() kernel-doc comment
Message-ID: <20220110134445.gzknemajl32rrryh@quack3.lan>
References: <20220110132841.34531-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110132841.34531-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 10-01-22 21:28:41, Yang Li wrote:
> Add the description of @shrink and @sc in jbd2_journal_shrink_scan() and
> jbd2_journal_shrink_count() kernel-doc comment to remove warnings found
> by running scripts/kernel-doc, which is caused by using 'make W=1'.
> fs/jbd2/journal.c:1296: warning: Function parameter or member 'shrink'
> not described in 'jbd2_journal_shrink_scan'
> fs/jbd2/journal.c:1296: warning: Function parameter or member 'sc' not
> described in 'jbd2_journal_shrink_scan'
> fs/jbd2/journal.c:1320: warning: Function parameter or member 'shrink'
> not described in 'jbd2_journal_shrink_count'
> fs/jbd2/journal.c:1320: warning: Function parameter or member 'sc' not
> described in 'jbd2_journal_shrink_count'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index f13d548e4a7f..ad32fd92d251 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1287,6 +1287,8 @@ static int jbd2_min_tag_size(void)
>  
>  /**
>   * jbd2_journal_shrink_scan()
> + * @shrink: shrinker to work on
> + * @sc: reclaim request to process
>   *
>   * Scan the checkpointed buffer on the checkpoint list and release the
>   * journal_head.
> @@ -1312,6 +1314,8 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>  
>  /**
>   * jbd2_journal_shrink_count()
> + * @shrink: shrinker to work on
> + * @sc: reclaim request to process
>   *
>   * Count the number of checkpoint buffers on the checkpoint list.
>   */
> -- 
> 2.20.1.7.g153144c
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
