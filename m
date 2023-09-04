Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8797913C7
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Sep 2023 10:45:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350312AbjIDIpk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Sep 2023 04:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234105AbjIDIpk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Sep 2023 04:45:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC16127;
        Mon,  4 Sep 2023 01:45:35 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B047D21887;
        Mon,  4 Sep 2023 08:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1693817134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OhoWevbiAW8FGdaKSKfCg9RefoNqol+3lejj7QXGFU=;
        b=V3D+9qWCWcL9Tn2REATiO3aZgHMo/ppk9jC0mRvQjwz1283wg7MFXK6jD0qFqW493IcMGM
        RXDvQVCFXtOlI/ZWP+gIVX8qijRRFJ8I+PSoqZ6YjHrdr7xFiJ/K5WrrO/kr8QPtlAGw1Q
        VeHtIFHx+kxDDMIqirTxEp7x1OlHfr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1693817134;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5OhoWevbiAW8FGdaKSKfCg9RefoNqol+3lejj7QXGFU=;
        b=dm0CHtarQgoKPSXYTwbqqjQ8vj2KPu5Ur9Sp9Ba/8qaNPm/UGITUNaf8rJZSefMUi0j81D
        9NeCs/npGF0pOGAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C9B41358B;
        Mon,  4 Sep 2023 08:45:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id GbwyJi6Z9WRWZgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 04 Sep 2023 08:45:34 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B3370A0776; Mon,  4 Sep 2023 10:45:33 +0200 (CEST)
Date:   Mon, 4 Sep 2023 10:45:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ye Bin <yebin10@huawei.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        jack@suse.cz
Subject: Re: [PATCH 1/2] JBD2: print io_block if check data block checksum
 failed when do recovery
Message-ID: <20230904084533.a6xyfuaijjnnhews@quack3>
References: <20230904011021.3884879-1-yebin10@huawei.com>
 <20230904011021.3884879-2-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904011021.3884879-2-yebin10@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 04-09-23 09:10:20, Ye Bin wrote:
> Now, if check data block checksum failed only print data's block number
> then skip write data. However, one data block may in more than one transaction.
> In some scenarios, offline analysis is inconvenient. As a result, it is
> difficult to locate the areas where data is faulty.
> So print 'io_block' if check data block checksum failed.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  fs/jbd2/recovery.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index c269a7d29a46..a2e2bdaed9f8 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -661,7 +661,8 @@ static int do_one_pass(journal_t *journal,
>  						printk(KERN_ERR "JBD2: Invalid "
>  						       "checksum recovering "
>  						       "data block %llu in "
> -						       "log\n", blocknr);
> +						       "log %lu\n", blocknr,

I'd make the message "...in journal block %lu\n". Otherwise the patch looks
good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
