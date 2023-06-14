Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B568772F951
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Jun 2023 11:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243903AbjFNJfh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Jun 2023 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244173AbjFNJfH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Jun 2023 05:35:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3D2126;
        Wed, 14 Jun 2023 02:34:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5AEB91FDD4;
        Wed, 14 Jun 2023 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686735293; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Raq4wSbTtPkjnLNJhAyMZD8KD5DkYkXU3htNdimdemQ=;
        b=fSSCHKJRZ+Zq6h96vVBCGSq4ySljHcaC1mq9va9R3RsN0nM8806ZD9f3zWgSiqjvOuLQ1e
        2uHg6k6nYRo+psxt5NMVR5wYAuYHvmDyWXGXwVSGCP0acuOVH2gJ/GJguCzCNHHcukvYEC
        sTTkb7F94nZkOqH25H5ynvq9WzNw1mo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686735293;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Raq4wSbTtPkjnLNJhAyMZD8KD5DkYkXU3htNdimdemQ=;
        b=9vIuJbd51oRCuVxW0JAIvLpvwO2GnmPJokXbRP3x3LXtJTF7QjK71zm4vgWYEiX8tt51pI
        WEEZbzipzMJIv0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 492F61391E;
        Wed, 14 Jun 2023 09:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id k7zXEb2JiWRTXgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Jun 2023 09:34:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CE94EA0755; Wed, 14 Jun 2023 11:34:52 +0200 (CEST)
Date:   Wed, 14 Jun 2023 11:34:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: Re: [PATCH -next] jbd2: remove unused function '__cp_buffer_busy'
Message-ID: <20230614093452.j47ntd4slhvra2yr@quack3>
References: <20230614004443.56937-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614004443.56937-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 14-06-23 08:44:43, Yang Li wrote:
> The code calling function '__cp_buffer_busy' has been removed, so the
> function should also be removed.
> silence the warning:
> fs/jbd2/checkpoint.c:48:20: warning: unused function '__cp_buffer_busy'
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5518
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Ted is now debugging other issues possibly caused by the patch series
making this function unused (CCing its author). If we need to respin to the
series, we might as well just fold this fixup into it. But otherwise the
patch is obviously good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/checkpoint.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
> index 9ec91017a7f3..ba4ae74c7167 100644
> --- a/fs/jbd2/checkpoint.c
> +++ b/fs/jbd2/checkpoint.c
> @@ -40,18 +40,6 @@ static inline void __buffer_unlink(struct journal_head *jh)
>  	}
>  }
>  
> -/*
> - * Check a checkpoint buffer could be release or not.
> - *
> - * Requires j_list_lock
> - */
> -static inline bool __cp_buffer_busy(struct journal_head *jh)
> -{
> -	struct buffer_head *bh = jh2bh(jh);
> -
> -	return (jh->b_transaction || buffer_locked(bh) || buffer_dirty(bh));
> -}
> -
>  /*
>   * __jbd2_log_wait_for_space: wait until there is space in the journal.
>   *
> -- 
> 2.20.1.7.g153144c
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
