Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA574D2CE5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Mar 2022 11:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiCIKP0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Mar 2022 05:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiCIKP0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Mar 2022 05:15:26 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8261451DB
        for <linux-ext4@vger.kernel.org>; Wed,  9 Mar 2022 02:14:28 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D0DC6210F4;
        Wed,  9 Mar 2022 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1646820866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nTX6OD6W2q7I9YnXgHtc+hlZJMnkmkf44bRpxV/j6k=;
        b=XngUSEw4V8/THSa21beHgJysOatbD2m3c6+A8icA28ZixGOCO8I4Hm00gJmxtsnWJWxkCk
        yvXtNw7Zyq7eGaBZ3sCufJS7Los6HH9mo2Q2RCZhRl0e6zdk10RDZsKjwhDO7VXAksvX8A
        UcyNa+o1xgI5XzYBf+x+Z4oWgRsAZ+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1646820866;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+nTX6OD6W2q7I9YnXgHtc+hlZJMnkmkf44bRpxV/j6k=;
        b=GOM68oFP/Aofwm7flwp2n6NY8MJuSz0vqzitzmVgi4xsm1U2EwLtW2203nlH8+Q4MtcC5/
        1QNSxJCffxKlzHDA==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BD513A3B87;
        Wed,  9 Mar 2022 10:14:26 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7BBC4A060B; Wed,  9 Mar 2022 11:14:26 +0100 (CET)
Date:   Wed, 9 Mar 2022 11:14:26 +0100
From:   Jan Kara <jack@suse.cz>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Cc:     linux-ext4@vger.kernel.org, riteshh@linux.ibm.com, jack@suse.cz,
        tytso@mit.edu
Subject: Re: [PATCH v2 2/5] ext4: for committing inode, make
 ext4_fc_track_inode wait
Message-ID: <20220309101426.qumxztpd4weqzrcs@quack3.lan>
References: <20220308163319.1183625-1-harshads@google.com>
 <20220308163319.1183625-3-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308163319.1183625-3-harshads@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-03-22 08:33:16, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> If the inode that's being requested to track using ext4_fc_track_inode
> is being committed, then wait until the inode finishes the commit.
> 
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>

One comment below...

> --- a/fs/ext4/ext4_jbd2.c
> +++ b/fs/ext4/ext4_jbd2.c
> @@ -106,6 +106,18 @@ handle_t *__ext4_journal_start_sb(struct super_block *sb, unsigned int line,
>  				   GFP_NOFS, type, line);
>  }
>  
> +handle_t *__ext4_journal_start(struct inode *inode, unsigned int line,
> +				  int type, int blocks, int rsv_blocks,
> +				  int revoke_creds)
> +{
> +	handle_t *handle = __ext4_journal_start_sb(inode->i_sb, line,
> +						   type, blocks, rsv_blocks,
> +						   revoke_creds);
> +	if (ext4_handle_valid(handle) && !IS_ERR(handle))
> +		ext4_fc_track_inode(handle, inode);
> +	return handle;
> +}
> +

Please fix fs/ext4/inline.c rather than papering over the problem like
this. Because it is just a landmine waiting to explode in some strange
cornercase when someone does not call ext4_journal_start() but other handle
starting function.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
