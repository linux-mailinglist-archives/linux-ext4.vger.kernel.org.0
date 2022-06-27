Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDEB55CD44
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jun 2022 15:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237053AbiF0Ln1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jun 2022 07:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237491AbiF0Lm6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Jun 2022 07:42:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47C3108D
        for <linux-ext4@vger.kernel.org>; Mon, 27 Jun 2022 04:38:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 601551FD57;
        Mon, 27 Jun 2022 11:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1656329904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnYtMAhEQNFQDNlNrHAarPHyb7FBwsQCf1CZ85s4BUI=;
        b=KzCkQdO/vMi5XsdKDwf15ny9Zi1nhIphrutRkFJB6P07NieIZFrrTMkYpuRG9sx/FVL1cB
        OUp6CBks/iuY0y8EU8utFjyzAv71GfREas3GBxTPi/W9BKKxqRVqjPbCduGLeYV3gmmYpg
        zRdTcIhGeva7Z62WoShi12pCy7jp9kU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1656329904;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EnYtMAhEQNFQDNlNrHAarPHyb7FBwsQCf1CZ85s4BUI=;
        b=uWTQuCK/PT429IKMCqj8Bq1W2/H2aQll20N67S9V78eVdgWrds5nmTMRVVModheCNxqyZ+
        C4VfMrKcdZVAXHCg==
Received: from quack3.suse.cz (unknown [10.163.43.118])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E043A2C141;
        Mon, 27 Jun 2022 11:38:23 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 09E99A062F; Mon, 27 Jun 2022 13:38:22 +0200 (CEST)
Date:   Mon, 27 Jun 2022 13:38:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH] ext4: silence the warning when evicting inode with
 dioread_nolock
Message-ID: <20220627113822.g55mttsy2nx6yuyr@quack3.lan>
References: <20220624070404.763603-1-yi.zhang@huawei.com>
 <20220624125117.bi5o4ovuhhtgs44x@quack3.lan>
 <22096be1-d77a-a7e4-cb72-6378e76ae6cd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22096be1-d77a-a7e4-cb72-6378e76ae6cd@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 25-06-22 17:33:50, Zhang Yi wrote:
> > probably we should add:
> > 
> > 	WARN_ON_ONCE(!list_empty(&inode->i_io_list));
> > 
> > to the no_delete: case of ext4_evict_inode()? Race like you mention above
> > does not seem possible for that case but seeing the complicated
> > interactions I'd rather have the assertion in place.
> > 
> 
> For the no_delete case, I did some tests and IIUC, it's true that the race could
> not happen, because inode_lru_isolate() make sure inode->i_data.nrpages is zero
> before adding inode into the freeable list, so the evict() procedure could not be
> invoked before the page cache have been dropped (it could only happened after
> ext4_end_io_end() has been finished).
> 
> We don't have a !list_empty(&inode->i_io_list) check for the no_delete case now.
> But I am not quite get the purpose of adding it, do you want to detect inode
> use-after-free issue in advance?

Yes, I wanted to check that we didn't accidentally dirty the inode
somewhere on the eviction path which would cause use-after-free issues
which are always hard to debug...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
