Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABD07D350D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Oct 2023 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbjJWLpC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Oct 2023 07:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjJWLow (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Oct 2023 07:44:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E10B10D9;
        Mon, 23 Oct 2023 04:44:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A085A21854;
        Mon, 23 Oct 2023 11:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698061487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyBgA0p/uKGTwLj21br3aElfg2rh/CHxAERkPcM1SDQ=;
        b=K3X8AkI9NDdHhKxQ5KfpHOgi6n7fQkKiBpWRR1MjeEpZ0/31MqHQclbIOaf3fDHKLd8XXJ
        tGmhJF4OobmwzX+6ZVQwnQItTdXeSQ2jWO5F1xQDkqt/uhixzWsK5hxVxoTNUXpyRTpPX9
        FfCGVx3dAj/XsthkGf1AbwVLOtb4Xj4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698061487;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gyBgA0p/uKGTwLj21br3aElfg2rh/CHxAERkPcM1SDQ=;
        b=N/n5pSvZMrJf4yMBZCW6xlNlpqYR5p4yZ65A+uXhV2eKNtHv7g4ttl5hIL1pwDKfGgmBJD
        qAV0a8x5TTTuP5Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 86C0E139C2;
        Mon, 23 Oct 2023 11:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6jPfIK9cNmVdDwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 23 Oct 2023 11:44:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 1030DA06B2; Mon, 23 Oct 2023 13:44:47 +0200 (CEST)
Date:   Mon, 23 Oct 2023 13:44:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Gou Hao <gouhao@uniontech.com>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        gouhaojake@163.com
Subject: Re: [PATCH] ext4: delete redundant calculations in
 ext4_mb_get_buddy_page_lock()
Message-ID: <20231023114447.crn3bt4qdmkxkrxi@quack3>
References: <20231023013416.17246-1-gouhao@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231023013416.17246-1-gouhao@uniontech.com>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -7.64
X-Spamd-Result: default: False [-7.64 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[163.com];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[7];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.04)[58.56%];
         FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,vger.kernel.org,163.com]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 23-10-23 09:34:16, Gou Hao wrote:
> 'blocks_per_page' is always 1 after 'if (blocks_per_page >= 2)',
> 'pnum' and 'block' is equal in this case.
> 
> Signed-off-by: Gou Hao <gouhao@uniontech.com>
> Signed-off-by: Gou Hao <gouhaojake@163.com>

No need for two signed-off-by here. Any one from you is enough :)

> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 454d5612641e..8442f5474b25 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1456,9 +1456,7 @@ static int ext4_mb_get_buddy_page_lock(struct super_block *sb,
>  		return 0;
>  	}
>  
> -	block++;
> -	pnum = block / blocks_per_page;
> -	page = find_or_create_page(inode->i_mapping, pnum, gfp);
> +	page = find_or_create_page(inode->i_mapping, ++block, gfp);
						     ^^^ perhaps just
"block + 1" here? Maybe also add a comment before this call like:

	/* blocks_per_page == 1, hence we need another page for the buddy */

Otherwise the patch looks good!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
