Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD16B75A1
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 12:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjCMLOl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 07:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCMLOI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 07:14:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D122E16899;
        Mon, 13 Mar 2023 04:13:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AAB091FD86;
        Mon, 13 Mar 2023 11:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678705995; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHUoWvRz6Ewls362jVkfMYuQ5sniuEbNJGYK+IU7EvY=;
        b=InfbJbAG+bcfRt5zaOGQJPqpzU90fF2DCrC3KimksCRN18s1fEX3Eqht5mOa0Zj2puYzos
        oe7UJz7qMG22vG+ENy+6SKGlnEgHVrGQ50nJAI7Nuei7FuJ1WnKyuquYKMpJ9LyZutqFbQ
        2pLm8trMvfwmQd1Th/MQZoA/udWhTis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678705995;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vHUoWvRz6Ewls362jVkfMYuQ5sniuEbNJGYK+IU7EvY=;
        b=SQyqPXJ9rovPnzHfoymuA3ZNpfQNkQurBiPE3/dnNBR2YEsgVJ1rddACUqexVZgCdi/iN5
        vSuNwWriLhiTN3Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C9DD13517;
        Mon, 13 Mar 2023 11:13:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8tI6JksFD2QNWQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 11:13:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 3E49CA06FD; Mon, 13 Mar 2023 12:13:15 +0100 (CET)
Date:   Mon, 13 Mar 2023 12:13:15 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 5/5] jbd2: remove j_format_version
Message-ID: <20230313111315.hw32swlzb3bfxk3y@quack3>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-6-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125206.2867822-6-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-03-23 20:52:06, Zhihao Cheng wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> journal->j_format_version is no longer used, remove it.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c    | 9 ---------
>  include/linux/jbd2.h | 5 -----
>  2 files changed, 14 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index cd94d068b4e6..fbada835b6b7 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -1997,15 +1997,6 @@ static int load_superblock(journal_t *journal)
>  
>  	sb = journal->j_superblock;
>  
> -	switch (be32_to_cpu(sb->s_header.h_blocktype)) {
> -	case JBD2_SUPERBLOCK_V1:
> -		journal->j_format_version = 1;
> -		break;
> -	case JBD2_SUPERBLOCK_V2:
> -		journal->j_format_version = 2;
> -		break;
> -	}
> -
>  	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
>  	journal->j_tail = be32_to_cpu(sb->s_start);
>  	journal->j_first = be32_to_cpu(sb->s_first);
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 7095c0f17ad0..b7c79f68f7ca 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -792,11 +792,6 @@ struct journal_s
>  	 */
>  	journal_superblock_t	*j_superblock;
>  
> -	/**
> -	 * @j_format_version: Version of the superblock format.
> -	 */
> -	int			j_format_version;
> -
>  	/**
>  	 * @j_state_lock: Protect the various scalars in the journal.
>  	 */
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
