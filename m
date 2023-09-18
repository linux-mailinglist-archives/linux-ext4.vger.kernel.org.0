Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C75A7A4C68
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Sep 2023 17:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjIRPcl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 18 Sep 2023 11:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbjIRPc3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 18 Sep 2023 11:32:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF88C1A4
        for <linux-ext4@vger.kernel.org>; Mon, 18 Sep 2023 08:30:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E11A021D7D;
        Mon, 18 Sep 2023 14:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695048670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeG7t4jPjVdwTATY9Lqi6Oc/lm1AxloZs65Tey4YBHQ=;
        b=whyWmOm9kzZ3bTqA+X1QwRDVRdZEmu/zVW5fi8P+z8Wy42gCLYZpsoOsmR68xQNtkSI4Nm
        ELhE7HC3kCKsT1Ynmu6m37B1BkP7FfPlJeQq3l2gTF4+HALwTL1rQb+75e7ZtnoYp51+ON
        2igznxrpBV09GDmNqFVqOsVTNltKQBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695048670;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HeG7t4jPjVdwTATY9Lqi6Oc/lm1AxloZs65Tey4YBHQ=;
        b=z3qryaUwbIkEylkxO2rFZJ8ojxYGHJwLJnoMFzOsZsHcvYA9O7bb6V96UFjf0UvW2LXB55
        ND/M4x0k+u6lwaCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D476D1358A;
        Mon, 18 Sep 2023 14:51:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jQzTM95jCGXWRQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 14:51:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 55A6EA0759; Mon, 18 Sep 2023 16:51:10 +0200 (CEST)
Date:   Mon, 18 Sep 2023 16:51:10 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianjian <wangjianjian0@foxmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix incorrect offset
Message-ID: <20230918145110.nzma56rirpw3hpg7@quack3>
References: <tencent_F992989953734FD5DE3F88ECB2191A856206@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_F992989953734FD5DE3F88ECB2191A856206@qq.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 23:23:24, Wang Jianjian wrote:
> The last argumen of ext4_check_dir_entry is dentry offset
           ^^^ argument

> int the file.
  ^^ in the directory

Maybe you could also add to the changelog: Luckily this error only results
in the wrong offset being printed in the eventual error message.
 
> Signed-off-by: Wang Jianjian <wangjianjian0@foxmail.com>

Otherwise the fix looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 94608b7df7e8..33ebd35025bf 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2261,8 +2261,7 @@ static int make_indexed_dir(handle_t *handle, struct ext4_filename *fname,
>  	top = data2 + len;
>  	while ((char *)(de2 = ext4_next_entry(de, blocksize)) < top) {
>  		if (ext4_check_dir_entry(dir, NULL, de, bh2, data2, len,
> -					 (data2 + (blocksize - csum_size) -
> -					  (char *) de))) {
> +					(char *)de - data2)) {
>  			brelse(bh2);
>  			brelse(bh);
>  			return -EFSCORRUPTED;
> -- 
> 2.34.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
