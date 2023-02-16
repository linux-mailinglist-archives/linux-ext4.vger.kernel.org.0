Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48157699B53
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Feb 2023 18:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBPRcD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Feb 2023 12:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjBPRcC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Feb 2023 12:32:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964824C3F8;
        Thu, 16 Feb 2023 09:32:01 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 50C2B1FD72;
        Thu, 16 Feb 2023 17:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1676568720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeQ3nBB0cL6wjlWjtrXmuxY4fLv7GzDfT+Q1ruNna0M=;
        b=14OgZUHNAp55oh/Bkc4waG0fLhTjFEeCNMMNzedSdICMTyoi3riMK3AHlk8AmX305aqV2m
        X0dNB7oaSx5POvV0tdEfMQtmGAS/RJwiZF+mej1ZO/nuSJpSTNqS21l+v7NqcW3IxOdqyb
        6qWY8iEr0UezkIxsPbZPPBMevpYRVVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1676568720;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PeQ3nBB0cL6wjlWjtrXmuxY4fLv7GzDfT+Q1ruNna0M=;
        b=BQ/nAieL84f17iv9roPUJm2KQxPJi/JykEMBpExXGJYjlKj4cyQo63ycA5mHpTTcYf+iEc
        kNhbRD7ecDwDU/AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2852413438;
        Thu, 16 Feb 2023 17:32:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +XDUCZBo7mNKRgAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 16 Feb 2023 17:32:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8145CA06E1; Thu, 16 Feb 2023 18:31:59 +0100 (CET)
Date:   Thu, 16 Feb 2023 18:31:59 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin@huaweicloud.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>
Subject: Re: [PATCH v3 1/2] ext4: commit super block if fs record error when
 journal record without error
Message-ID: <20230216173159.zkj4qd2nmj2yjpkr@quack3>
References: <20230214022905.765088-1-yebin@huaweicloud.com>
 <20230214022905.765088-2-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214022905.765088-2-yebin@huaweicloud.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 14-02-23 10:29:04, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> Now, 'es->s_state' maybe covered by recover journal. And journal errno
> maybe not recorded in journal sb as IO error. ext4_update_super() only
> update error information when 'sbi->s_add_error_count' large than zero.
> Then 'EXT4_ERROR_FS' flag maybe lost.
> To solve above issue commit error information after recover journal.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/ext4/super.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index dc3907dff13a..b94754ba8556 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5932,6 +5932,18 @@ static int ext4_load_journal(struct super_block *sb,
>  		goto err_out;
>  	}
>  
> +	if (unlikely(es->s_error_count && !jbd2_journal_errno(journal) &&
> +		     !(le16_to_cpu(es->s_state) & EXT4_ERROR_FS))) {
> +		EXT4_SB(sb)->s_mount_state |= EXT4_ERROR_FS;
> +		es->s_state |= cpu_to_le16(EXT4_ERROR_FS);
> +		err = ext4_commit_super(sb);
> +		if (err) {
> +			ext4_msg(sb, KERN_ERR,
> +				 "Failed to commit error information, please repair fs force!");
> +			goto err_out;
> +		}
> +	}
> +

Hum, I'm not sure I follow here. If journal replay has overwritten the
superblock (and thus the stored error info), then I'd expect
es->s_error_count got overwritten (possibly to 0) as well. And this is
actually relatively realistic scenario with errors=remount-ro behavior when
the first fs error happens.

What I intended in my original suggestion was to save es->s_error_count,
es->s_state & EXT4_ERROR_FS, es->s_first_error_*, es->s_last_error_* before
doing journal replay in ext4_load_journal() and then after journal replay
merge this info back to the superblock - if EXT4_ERROR_FS was set, set it
now as well, take max of old and new s_error_count, set s_first_error_* if
it is now unset, set s_last_error_* if stored timestamp is newer than
current timestamp.

Or am I overengineering it now? :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
