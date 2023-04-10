Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042886DCA28
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Apr 2023 19:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjDJRpt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Apr 2023 13:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDJRps (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Apr 2023 13:45:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8DC171C;
        Mon, 10 Apr 2023 10:45:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B965B610A3;
        Mon, 10 Apr 2023 17:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CC0DC433D2;
        Mon, 10 Apr 2023 17:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681148746;
        bh=Q72b34YBtc7OXzlvOQZ3dPKBZ4tw4gB1Uk02Sk+ZOxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G/G2jOWOmBcqah9uKdDP7U0f+PCmS5RTT9H0cTBuVaFjX7PfIKGfmy0XkQI5BInZr
         3NvcwNYSGElLLQg2L8tvKzVJc5HlMdL3NnvKlgvO3t8XPttosac3Bm377sBBC0ZvJZ
         o6delpRrwT7W7L7Elhd/NpV5+o7b5X3vvtrURuIkbD2E4PeDDi1trJVBc07rH1Ai/e
         FEll0jV9xkFBUMAEcPV7hGvGqNgs2xtVHWApf8KfDBuIKlrpm4EIAuaEEqc93yW+gD
         o2L37UUddeCbp7Cggouqwfgu8oOFCxolY/CPffCF6xVwWzOEd9A6088yKp04+LhoG2
         ZGl3RFt3wH9yg==
Date:   Mon, 10 Apr 2023 10:45:45 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Guoqing Cai <u202112087@hust.edu.cn>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: jbd2: fix an incorrect warn log
Message-ID: <20230410174545.GA360877@frogsfrogsfrogs>
References: <20230410172039.1752440-1-u202112087@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410172039.1752440-1-u202112087@hust.edu.cn>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 11, 2023 at 01:20:38AM +0800, Guoqing Cai wrote:
> In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
> warn log.
> 
> Fix this by changing the goto statement to return statement.
> 
> Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
>  fs/jbd2/journal.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e80c781731f8..555f09ca1d99 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2082,8 +2082,10 @@ int jbd2_journal_load(journal_t *journal)
>  
>  	/* Let the recovery code check whether it needs to recover any
>  	 * data from the journal. */
> -	if (jbd2_journal_recover(journal))
> -		goto recovery_error;
> +	if (jbd2_journal_recover(journal)) {
> +		printk(KERN_WARNING "JBD2: recovery failed\n");
> +		return -EIO;
> +	}
>  
>  	if (journal->j_failed_commit) {
>  		printk(KERN_ERR "JBD2: journal transaction %u on %s "
> @@ -2101,14 +2103,10 @@ int jbd2_journal_load(journal_t *journal)
>  	 * reinitialise the dynamic contents of the superblock in memory
>  	 * and reset them on disk. */
>  	if (journal_reset(journal))
> -		goto recovery_error;
> +		return -EIO;

Why wouldn't you warn about the journal reset failing here?

--D

>  
>  	journal->j_flags |= JBD2_LOADED;
>  	return 0;
> -
> -recovery_error:
> -	printk(KERN_WARNING "JBD2: recovery failed\n");
> -	return -EIO;
>  }
>  
>  /**
> -- 
> 2.40.0
> 
