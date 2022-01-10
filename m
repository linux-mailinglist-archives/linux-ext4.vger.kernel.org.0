Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C39489771
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Jan 2022 12:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244741AbiAJLa1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Jan 2022 06:30:27 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:44730 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244749AbiAJL3O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Jan 2022 06:29:14 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 77AF01F393;
        Mon, 10 Jan 2022 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1641814153; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4Y9waJZt1lwkwMGC5NX1ZOU/0fHRLCabIgyT9MAeO8=;
        b=EKT0/1FDJljjONvWJxpAmvQK9C0s3pjm0A2W6cv+J4FEYqron/F7ebV1PoL8BIByOIndEI
        lT6o7ubZdPGiZg9gEBSUDdyrUIHW+JgjGwOegnyKLfPd2moy2WJXesRsDjz603jb2rRNru
        +g3s+9HUVMLwYe838uqZJdbgf4rX2Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1641814153;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P4Y9waJZt1lwkwMGC5NX1ZOU/0fHRLCabIgyT9MAeO8=;
        b=KmQ3XY3RCeHLNzphjU60e6qM+S6vM+MeODiNLfokn62/VCZWcjC9vrQnC/j0YYDqvQ3vTp
        nMe25VHqj1n6l3BQ==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6366FA3B87;
        Mon, 10 Jan 2022 11:29:13 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 22C66A045E; Mon, 10 Jan 2022 12:29:13 +0100 (CET)
Date:   Mon, 10 Jan 2022 12:29:13 +0100
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] ext4: Fix jbd2_journal_shrink_scan() and
 jbd2_journal_shrink_count() kernel-doc comment
Message-ID: <20220110112913.uzf3qhxf5tppc2ej@quack3.lan>
References: <20220110030229.19864-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110030229.19864-1-yang.lee@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 10-01-22 11:02:29, Yang Li wrote:
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

Thanks for the fix! Just one comment below:

>  /**
>   * jbd2_journal_shrink_scan()
> + * @shrink: A callback you can register to apply pressure to ageable caches.
> + * @sc: pass information from page reclaim to the shrinkers.
>   *
>   * Scan the checkpointed buffer on the checkpoint list and release the
>   * journal_head.
> @@ -1312,6 +1314,8 @@ static unsigned long jbd2_journal_shrink_scan(struct shrinker *shrink,
>  
>  /**
>   * jbd2_journal_shrink_count()
> + * @shrink: A callback you can register to apply pressure to ageable caches.
> + * @sc: pass information from page reclaim to the shrinkers.
>   *
>   * Count the number of checkpoint buffers on the checkpoint list.
>   */

I think the comments are unnecessarily verbose and not really helping much.
Maybe just something like:

 * @shrink: shrinker to work on
 * @sc: reclaim request to process

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
