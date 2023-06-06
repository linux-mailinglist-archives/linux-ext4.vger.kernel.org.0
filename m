Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16FE723A6C
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 09:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjFFHvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 03:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237362AbjFFHu3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 03:50:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C22109
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 00:46:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 762542199E;
        Tue,  6 Jun 2023 07:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686037598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjii8hmsK/zfv+bhzEyIymIb21MRzy3WYUbD1DWRFbY=;
        b=1PEXr9rUn9gTRk75UXojKbJ9a6yfdIBFhDvS2erkwnXDVdZugeSKfXEO5yuwDnruieehPI
        UzIY673aE29KLuR/9/quP7bDWFm8COCZSKGXPN7VKQWL0fOvMMGjxHwKNt/7SUHG5XNJ05
        oxtlO3Ubr3ldTSletuhefw5+SehVUGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686037598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sjii8hmsK/zfv+bhzEyIymIb21MRzy3WYUbD1DWRFbY=;
        b=bR/PcwCW2ml/HW/GKRjd2cEK4caRFI/wtpok7lqTPZdCLX9ITiEFA1VvQegj0rKxMh/SMD
        nLx52bUKRqirLuAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6742A13519;
        Tue,  6 Jun 2023 07:46:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UaAjGV7kfmSgFwAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 07:46:38 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E1F04A0754; Tue,  6 Jun 2023 09:46:37 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:46:37 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 3/6] jbd2: remove journal_clean_one_cp_list()
Message-ID: <20230606074637.6purq76gaae366t3@quack3>
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
 <20230606061447.1125036-4-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606061447.1125036-4-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-06-23 14:14:44, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
> the same, so merge them into journal_shrink_one_cp_list(), remove the
> nr_to_scan parameter, always scan and try to free the whole checkpoint
> list.
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Just one nit below:

> @@ -398,15 +358,14 @@ static int journal_clean_one_cp_list(struct journal_head *jh, bool destroy)
>   * Called with j_list_lock held.
>   */
>  static unsigned long journal_shrink_one_cp_list(struct journal_head *jh,
> -						unsigned long *nr_to_scan,
> -						bool *released)
> +						bool destroy, bool *released)
>  {
>  	struct journal_head *last_jh;
>  	struct journal_head *next_jh = jh;
>  	unsigned long nr_freed = 0;
>  	int ret;

When changing this function, I think it will be more robust calling
convention to unconditionally set *released = false at the beginning of
this function. Then we can remove the initialization from
__jbd2_journal_clean_checkpoint_list().

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
