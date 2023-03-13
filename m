Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47C36B74B2
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 11:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCMKxB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 06:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjCMKw7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 06:52:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DEE1FFB;
        Mon, 13 Mar 2023 03:52:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B77A51FE06;
        Mon, 13 Mar 2023 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678704774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVAI5Ct7jxbvSwYzv8w9i0QFOpgp79+efnjwErE4+EY=;
        b=PeDTfl4ge4wJzfZHT5AJdwBI0FkhIniYl3r9GkkIcXmDUyy/ufuvjeM4lPoQdNgyKJ97a3
        62agyEWy/qGsyyBAKX0C2QHsjtrbWSQAvgMmSsLIuT811k9OW6mWBK4JL2wxcfXZ1yM0Cj
        ybHVSL31LBRglntrDw6IyQjKdLq2qis=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678704774;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SVAI5Ct7jxbvSwYzv8w9i0QFOpgp79+efnjwErE4+EY=;
        b=nl0BwOS50ztuaYEfJTbTPcIaJNP0waVYF0I1t+g5uqnmA/Vgg6D6qNFvhIWQkDBA2qhrHL
        FyEu7FZ8DtFBPXAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E8CA13582;
        Mon, 13 Mar 2023 10:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FC2yJoYAD2QsTQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 13 Mar 2023 10:52:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 25F06A06FD; Mon, 13 Mar 2023 11:52:54 +0100 (CET)
Date:   Mon, 13 Mar 2023 11:52:54 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH 2/5] jbd2: remove unused feature macros
Message-ID: <20230313105254.czim7srj6ivcxhzy@quack3>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
 <20230310125206.2867822-3-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310125206.2867822-3-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 10-03-23 20:52:03, Zhihao Cheng wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> JBD2_HAS_[IN|RO_]COMPAT_FEATURE macros are no longer used, just remove
> them.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
> ---
>  include/linux/jbd2.h | 11 -----------
>  1 file changed, 11 deletions(-)

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 5962072a4b19..ad7bb6861143 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -274,17 +274,6 @@ typedef struct journal_superblock_s
>  /* 0x0400 */
>  } journal_superblock_t;
>  
> -/* Use the jbd2_{has,set,clear}_feature_* helpers; these will be removed */
> -#define JBD2_HAS_COMPAT_FEATURE(j,mask)					\
> -	((j)->j_format_version >= 2 &&					\
> -	 ((j)->j_superblock->s_feature_compat & cpu_to_be32((mask))))
> -#define JBD2_HAS_RO_COMPAT_FEATURE(j,mask)				\
> -	((j)->j_format_version >= 2 &&					\
> -	 ((j)->j_superblock->s_feature_ro_compat & cpu_to_be32((mask))))
> -#define JBD2_HAS_INCOMPAT_FEATURE(j,mask)				\
> -	((j)->j_format_version >= 2 &&					\
> -	 ((j)->j_superblock->s_feature_incompat & cpu_to_be32((mask))))
> -
>  #define JBD2_FEATURE_COMPAT_CHECKSUM		0x00000001
>  
>  #define JBD2_FEATURE_INCOMPAT_REVOKE		0x00000001
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
