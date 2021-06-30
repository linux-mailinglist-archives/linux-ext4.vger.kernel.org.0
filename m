Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 668E43B8138
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 13:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhF3LYY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 07:24:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:34662 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhF3LYX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 07:24:23 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 47BB51FE6F;
        Wed, 30 Jun 2021 11:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1625052114; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXEAk0/YVoDTZj0zNXyG5NFhb3NO4Aa1DyfJDSHF32g=;
        b=TNJJqDhpKGop/7ub1h6hjG0lYLEF0p0Nnbl166gPaNtCMULoXtoUdLV9eWg4OwPCfWaWlr
        yw98OkrbI2ZNyKZ9MhdRJ30bzdr8/gIi2sCHSSpk6fsy7yfTU1yb4pKjnJIbfCB5qh3dtg
        b4RpeUl0GHlQhVv0sh5ESCAg9Ftsyo4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1625052114;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CXEAk0/YVoDTZj0zNXyG5NFhb3NO4Aa1DyfJDSHF32g=;
        b=mYp76Bkioc4E/dBmb8Zx6V+9hofU6h0x74gRRzZf/aYPdXiX1e7Z+AVP4GVgY5t3QO2TMS
        kQqmXgnmvOGIWcAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 0842EA3B85;
        Wed, 30 Jun 2021 11:21:53 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id CB57A1F2CC3; Wed, 30 Jun 2021 13:21:53 +0200 (CEST)
Date:   Wed, 30 Jun 2021 13:21:53 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH] jbd2: fix jbd2_journal_[un]register_shrinker undefined
 error
Message-ID: <20210630112153.GA27701@quack2.suse.cz>
References: <20210630083638.140218-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210630083638.140218-1-yi.zhang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 30-06-21 16:36:38, Zhang Yi wrote:
> Export jbd2_journal_unregister_shrinker() and
> jbd2_journal_register_shrinker() to fix below error:
> 
>  ERROR: modpost: "jbd2_journal_unregister_shrinker" undefined!
>  ERROR: modpost: "jbd2_journal_register_shrinker" undefined!
> 
> Fixes: 4ba3fcdde7e3 ("jbd2,ext4: add a shrinker to release checkpointed buffers")
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Yeah, I didn't notice this either. The fix looks good. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 7c52feb6f753..152880c298ca 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2122,6 +2122,7 @@ int jbd2_journal_register_shrinker(journal_t *journal)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL(jbd2_journal_register_shrinker);
>  
>  /**
>   * jbd2_journal_unregister_shrinker()
> @@ -2134,6 +2135,7 @@ void jbd2_journal_unregister_shrinker(journal_t *journal)
>  	percpu_counter_destroy(&journal->j_jh_shrink_count);
>  	unregister_shrinker(&journal->j_shrinker);
>  }
> +EXPORT_SYMBOL(jbd2_journal_unregister_shrinker);
>  
>  /**
>   * jbd2_journal_destroy() - Release a journal_t structure.
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
