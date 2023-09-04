Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA027913CD
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236523AbjIDIqm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIDIqm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 04:46:42 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58F4127;
        Mon,  4 Sep 2023 01:46:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A83861F897;
        Mon,  4 Sep 2023 08:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693817195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YizYSvAOlDUe0YJa4YyHzLKpZsFaHWL4kC9GVQVrQPc=;
        b=fkPD3JlR5Dzzu1CMCG8tTAOv42ZwEm1u/eSoHadRqPZQv7jr4MbfmALlSwxgal4tLL5of6
        N0//z9aONWQNq1F4iA1k4mgeKszHiZYXyzL90sQKg6OXgH/EGSvnen5d7ThuB24YxhP0AR
        SI9dYL+r1EHmzCZTcBzhslbSxsTaYuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693817195;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YizYSvAOlDUe0YJa4YyHzLKpZsFaHWL4kC9GVQVrQPc=;
        b=m+iJPX87gimt8CRsC8BVwQZqhmIVrX78c7EVeYWFM5S2yTyUnKWjjk4gKZoMS5gLJhThVZ
        RsA4ED/mhQqYQzAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A4371358B;
        Mon,  4 Sep 2023 08:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gummJWuZ9WTvZgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 04 Sep 2023 08:46:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 4652DA0776; Mon,  4 Sep 2023 10:46:35 +0200 (CEST)
Date:   Mon, 4 Sep 2023 10:46:35 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH 2/2] JBD2: fix printk format type for 'io_block' in
 do_one_pass()
Message-ID: <20230904084635.x47et44qyasofrci@quack3>
References: <20230904011021.3884879-1-yebin10@huawei.com>
 <20230904011021.3884879-3-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904011021.3884879-3-yebin10@huawei.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-09-23 09:10:21, Ye Bin wrote:
> 'io_block' is unsinged long but print it by '%ld'.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/jbd2/recovery.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index a2e2bdaed9f8..d10dc7f64301 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -632,7 +632,7 @@ static int do_one_pass(journal_t *journal,
>  					success = err;
>  					printk(KERN_ERR
>  						"JBD2: IO error %d recovering "
> -						"block %ld in log\n",
> +						"block %lu in log\n",
>  						err, io_block);
>  				} else {
>  					unsigned long long blocknr;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
