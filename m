Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1953C7302
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 17:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbhGMPUh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 11:20:37 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:43098 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236901AbhGMPUh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Jul 2021 11:20:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7DD03201E1;
        Tue, 13 Jul 2021 15:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626189466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OugUYcdbWnmFO4L1Bq0cZ+t/zX082NeKg/Jqt9gM3HI=;
        b=BbPfczroi+1NStZhS62Qc+056En5C1K2D22KCqfP/svvqE1RlJB50KdbCwglozgPnQLjDZ
        nM7Xx4E24h2jLXn0hwUmpQaKsgWjk16RQJm5AQpFj7KwS3w5kr1zWDl9HzvOA1Fw8UWg6j
        Y/CnwswB1mwcAnHqnLV/i9kzbwHJ/LA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626189466;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OugUYcdbWnmFO4L1Bq0cZ+t/zX082NeKg/Jqt9gM3HI=;
        b=WkvwvDvqMX5fv0Ynqygn7wR49OYryBnnBGLJ/oagJo63bPPvoAvUBkYh2+/qBc6+KYnOAb
        02fec9ZzN+6WEdDw==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 70CA5A3B9D;
        Tue, 13 Jul 2021 15:17:46 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1F13B1E0BBE; Tue, 13 Jul 2021 17:17:46 +0200 (CEST)
Date:   Tue, 13 Jul 2021 17:17:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guoqing Jiang <jgq516@gmail.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH] ext4: remove conflict comment from __ext4_forget
Message-ID: <20210713151746.GD24271@quack2.suse.cz>
References: <20210623085846.1059647-1-jgq516@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623085846.1059647-1-jgq516@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 23-06-21 16:58:46, Guoqing Jiang wrote:
> From: Guoqing Jiang <jiangguoqing@kylinos.cn>
> 
> We do a bforget and return for no journal case, so let's remove this
> conflict comment.
> 
> Signed-off-by: Guoqing Jiang <jiangguoqing@kylinos.cn>

Looks good. I agree the comment seems stale. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Not sure if my understanding is correct, so this is RFC.
> 
> Thanks,
> Guoqing
> 
>  fs/ext4/ext4_jbd2.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
> index be799040a415..6e224b19eae7 100644
> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -244,9 +244,6 @@ int __ext4_journal_get_write_access(const char *where, unsigned int line,
>   * "bh" may be NULL: a metadata block may have been freed from memory
>   * but there may still be a record of it in the journal, and that record
>   * still needs to be revoked.
> - *
> - * If the handle isn't valid we're not journaling, but we still need to
> - * call into ext4_journal_revoke() to put the buffer head.
>   */
>  int __ext4_forget(const char *where, unsigned int line, handle_t *handle,
>  		  int is_metadata, struct inode *inode,
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
