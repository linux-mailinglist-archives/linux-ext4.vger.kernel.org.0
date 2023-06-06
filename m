Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F59723AE3
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jun 2023 10:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjFFICa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jun 2023 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjFFICF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jun 2023 04:02:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EAD19A8
        for <linux-ext4@vger.kernel.org>; Tue,  6 Jun 2023 00:59:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 77A801FD6C;
        Tue,  6 Jun 2023 07:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686038387; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7QocHAeNupt2yfSlCCiT1kcKEGTLlJpepX09+qPGXU=;
        b=BLzAzfBvtspXmE/khn/0a5yrhHpJR1+nNzaRYIo8FsyxQtmBGSrohv+Go3cdvgl9U34ZUA
        oJ+aSl+Ry1oIBSYy17y5Tde0CB4Ip6zUIhXj3JoUApygIeYwH/QoHxfMMrU/NdympAQH4y
        A7cV+ESY4wfYq2Y0qqLGdrE4pyNXJ4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686038387;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7QocHAeNupt2yfSlCCiT1kcKEGTLlJpepX09+qPGXU=;
        b=DeBpFB5mRhqBDDEO0tLbvEYMY16DZDQfv+rz97rNVwSWhtVbjGxOMx3H33S4zjQY+qsfi8
        X26cyBh+AJU4fRAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6871D13519;
        Tue,  6 Jun 2023 07:59:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id W4BzGXPnfmQWIAAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 06 Jun 2023 07:59:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F120EA0754; Tue,  6 Jun 2023 09:59:46 +0200 (CEST)
Date:   Tue, 6 Jun 2023 09:59:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH v2 5/6] jbd2: fix a race when checking checkpoint buffer
 busy
Message-ID: <20230606075946.dj3ldknkoehr4agp@quack3>
References: <20230606061447.1125036-1-yi.zhang@huaweicloud.com>
 <20230606061447.1125036-6-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606061447.1125036-6-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 06-06-23 14:14:46, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> Before removing checkpoint buffer from the t_checkpoint_list, we have to
> check both BH_Dirty and BH_Lock bits together to distinguish buffers
> have not been or were being written back. But __cp_buffer_busy() checks
> them separately, it first check lock state and then check dirty, the
> window between these two checks could be raced by writing back
> procedure, which locks buffer and clears buffer dirty before I/O
> completes. So it cannot guarantee checkpointing buffers been written
> back to disk if some error happens later. Finally, it may clean
> checkpoint transactions and lead to inconsistent filesystem.
> 
> jbd2_journal_forget() and __journal_try_to_free_buffer() also have the
> same problem (journal_unmap_buffer() escape from this issue since it's
> running under the buffer lock), so fix them through introducing a new
> helper to try holding the buffer lock and remove really clean buffer.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217490
> Cc: stable@vger.kernel.org
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

Just a type correction below:

> @@ -615,6 +619,34 @@ int __jbd2_journal_remove_checkpoint(struct journal_head *jh)
>  	return 1;
>  }
>  
> +/*
> + * Check the checkpoint buffer and try to remove it from the checkpoint
> + * list if it's clean. Returns -EBUSY if it is not clean, returns 1 if
> + * it frees the transaction, 0 otherwise.
> + *
> + * This function is called with j_list_lock held.
> + */
> +int jbd2_journal_try_remove_checkpoint(struct journal_head *jh)
> +{
> +	struct buffer_head *bh = jh2bh(jh);
> +
> +	if (!trylock_buffer(bh))
> +		return -EBUSY;
> +	if (buffer_dirty(bh)) {
> +		unlock_buffer(bh);
> +		return -EBUSY;
> +	}
> +	unlock_buffer(bh);
> +
> +	/*
> +	 * Buffer is clean and the IO has finished (we hold the buffer
							^^^ held

> +	 * lock) so the checkpoint is done. We can safely remove the
> +	 * buffer from this transaction.
> +	 */
> +	JBUFFER_TRACE(jh, "remove from checkpoint list");
> +	return __jbd2_journal_remove_checkpoint(jh);
> +}

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
