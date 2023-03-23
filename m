Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3734E6C6426
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 10:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbjCWJzg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Mar 2023 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjCWJzJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 05:55:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D6A35EE3;
        Thu, 23 Mar 2023 02:53:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 31E065C253;
        Thu, 23 Mar 2023 09:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679565228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDlGr14ZVvQg1Nj6sP7mL6XAaiIugwM/EnaIl8Ce8Bs=;
        b=vqHmF5Ytl9nJ/0BSI1GNg58lvmUqekplnYMCmLIS7GpetvrsOvjvpvsJkA6+cCzwkOFTTZ
        /wL0I0+d9cXOJ/LzoMY6zI6xWZPcmq1dFddhPXljMDX2SuFvtlkrEzhcnlbVDg/0YqvmtG
        N1DouTqk9qc51uNg+ovSsQJ99HHEdDA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679565228;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vDlGr14ZVvQg1Nj6sP7mL6XAaiIugwM/EnaIl8Ce8Bs=;
        b=74iHc4MZnIzKnYRZuvqQaO3S94VEbcG2MHgzha/Y8y5WKksbl4j6Y+aPe+37ZZtaK3Obty
        tXQyGI17fRMzXaDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18414132C2;
        Thu, 23 Mar 2023 09:53:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id lDTlBawhHGQ+VgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 23 Mar 2023 09:53:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 085E7A071C; Thu, 23 Mar 2023 10:53:47 +0100 (CET)
Date:   Thu, 23 Mar 2023 10:53:46 +0100
From:   Jan Kara <jack@suse.cz>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/3] jbd2: Avoid printing out the boundary
Message-ID: <20230323095346.ibpv25xjjf6rozpv@quack3>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
 <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322141206.56347-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 22-03-23 16:12:04, Andy Shevchenko wrote:
> Theoretically possible that "%pg" will take all room for the j_devname
> and hence the "-%lu" will go out the boundary due to unconditional
> sprintf() in use. To make this code more robust, replace two sequential
> s*printf():s by a single call and then replace forbidden character.
> It's possible to do this way, because '/' won't ever be in the result
> of "-%lu".
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 8ae419152ff6..00c0aa4a3a91 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1515,9 +1515,8 @@ journal_t *jbd2_journal_init_inode(struct inode *inode)
>  
>  	journal->j_inode = inode;
>  	snprintf(journal->j_devname, sizeof(journal->j_devname),
> -		 "%pg", journal->j_dev);
> -	p = strreplace(journal->j_devname, '/', '!');
> -	sprintf(p, "-%lu", journal->j_inode->i_ino);
> +		 "%pg-%lu", journal->j_dev, journal->j_inode->i_ino);
> +	strreplace(journal->j_devname, '/', '!');
>  	jbd2_stats_proc_init(journal);
>  
>  	return journal;
> -- 
> 2.40.0.1.gaa8946217a0b
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
