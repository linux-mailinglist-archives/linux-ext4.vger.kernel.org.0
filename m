Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED1A6B74D0
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 11:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCMK5L (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjCMK5I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 06:57:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15814D2A7;
        Mon, 13 Mar 2023 03:57:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AC5BB2218B;
        Mon, 13 Mar 2023 10:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678705025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJOelRtwxw+LNoqfWpG1fvcFYS3q3yKnUAcZznPm3KU=;
        b=mRPlK+n8WZL6heNX2y1fbJFiL7QlzuOe77Kd/RmpJgXzCMfVsPNzAEErsOgph6HjHUdPen
        0t2FuoRcZiKlmAe6Xz6sdDsrgN1nR9vFOl9nMKp43w87uevxGvFVlvJ1sWxrYKsXRBmci9
        IubY0ptvkaUUH7tLOmP50kgQzJNanF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678705025;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tJOelRtwxw+LNoqfWpG1fvcFYS3q3yKnUAcZznPm3KU=;
        b=U/TZDRD25FuPPJ7tpCcEIG6upVcfgTzUG2mG7WfF15VkqI0FyNoOsDcKBFIImiGKr8g0j+
        shcHV16KR4inKeAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E3F113517;
        Mon, 13 Mar 2023 10:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id icKtJoEBD2SYTwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 10:57:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2FCC3A06FD; Mon, 13 Mar 2023 11:57:05 +0100 (CET)
Date:   Mon, 13 Mar 2023 11:57:05 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 3/5] jbd2: switch to check format version in superblock
 directly
Message-ID: <20230313105705.5t2huh3hjgqm2ovf@quack3>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-4-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125206.2867822-4-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-03-23 20:52:04, Zhihao Cheng wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> We should only check and set extented features if journal format version
> is 2, and now we check the in memory copy of the superblock
> 'journal->j_format_version', which relys on the parameter initialization
> sequence, switch to use the h_blocktype in superblock cloud be more
> clear.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/journal.c    | 16 +++++++---------
>  include/linux/jbd2.h | 17 ++++++++++++++---
>  2 files changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index e80c781731f8..b991d5c21d16 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -2059,10 +2059,12 @@ int jbd2_journal_load(journal_t *journal)
>  		return err;
>  
>  	sb = journal->j_superblock;
> -	/* If this is a V2 superblock, then we have to check the
> -	 * features flags on it. */
>  
> -	if (journal->j_format_version >= 2) {
> +	/*
> +	 * If this is a V2 superblock, then we have to check the
> +	 * features flags on it.
> +	 */
> +	if (jbd2_format_support_feature(journal)) {
>  		if ((sb->s_feature_ro_compat &
>  		     ~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
>  		    (sb->s_feature_incompat &
> @@ -2224,7 +2226,7 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
>  	if (journal->j_format_version == 0 &&
>  	    journal_get_superblock(journal) != 0)
>  		return 0;
> -	if (journal->j_format_version == 1)
> +	if (!jbd2_format_support_feature(journal))
>  		return 0;
>  
>  	sb = journal->j_superblock;
> @@ -2254,11 +2256,7 @@ int jbd2_journal_check_available_features(journal_t *journal, unsigned long comp
>  	if (!compat && !ro && !incompat)
>  		return 1;
>  
> -	/* We can support any known requested features iff the
> -	 * superblock is in version 2.  Otherwise we fail to support any
> -	 * extended sb features. */
> -
> -	if (journal->j_format_version != 2)
> +	if (!jbd2_format_support_feature(journal))
>  		return 0;
>  
>  	if ((compat   & JBD2_KNOWN_COMPAT_FEATURES) == compat &&
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index ad7bb6861143..7095c0f17ad0 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -1305,11 +1305,22 @@ struct journal_s
>  		rwsem_release(&j->j_trans_commit_map, _THIS_IP_); \
>  	} while (0)
>  
> +/*
> + * We can support any known requested features iff the
> + * superblock is not in version 1.  Otherwise we fail to support any
> + * extended sb features.
> + */
> +static inline bool jbd2_format_support_feature(journal_t *j)
> +{
> +	return j->j_superblock->s_header.h_blocktype !=
> +					cpu_to_be32(JBD2_SUPERBLOCK_V1);
> +}
> +
>  /* journal feature predicate functions */
>  #define JBD2_FEATURE_COMPAT_FUNCS(name, flagname) \
>  static inline bool jbd2_has_feature_##name(journal_t *j) \
>  { \
> -	return ((j)->j_format_version >= 2 && \
> +	return (jbd2_format_support_feature(j) && \
>  		((j)->j_superblock->s_feature_compat & \
>  		 cpu_to_be32(JBD2_FEATURE_COMPAT_##flagname)) != 0); \
>  } \
> @@ -1327,7 +1338,7 @@ static inline void jbd2_clear_feature_##name(journal_t *j) \
>  #define JBD2_FEATURE_RO_COMPAT_FUNCS(name, flagname) \
>  static inline bool jbd2_has_feature_##name(journal_t *j) \
>  { \
> -	return ((j)->j_format_version >= 2 && \
> +	return (jbd2_format_support_feature(j) && \
>  		((j)->j_superblock->s_feature_ro_compat & \
>  		 cpu_to_be32(JBD2_FEATURE_RO_COMPAT_##flagname)) != 0); \
>  } \
> @@ -1345,7 +1356,7 @@ static inline void jbd2_clear_feature_##name(journal_t *j) \
>  #define JBD2_FEATURE_INCOMPAT_FUNCS(name, flagname) \
>  static inline bool jbd2_has_feature_##name(journal_t *j) \
>  { \
> -	return ((j)->j_format_version >= 2 && \
> +	return (jbd2_format_support_feature(j) && \
>  		((j)->j_superblock->s_feature_incompat & \
>  		 cpu_to_be32(JBD2_FEATURE_INCOMPAT_##flagname)) != 0); \
>  } \
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
