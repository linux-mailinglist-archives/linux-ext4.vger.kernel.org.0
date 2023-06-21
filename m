Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6B9738B0A
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Jun 2023 18:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjFUQ01 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 21 Jun 2023 12:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFUQ00 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 21 Jun 2023 12:26:26 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178D11BC;
        Wed, 21 Jun 2023 09:26:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCA9E21E4B;
        Wed, 21 Jun 2023 16:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687364784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6CJq22EsTUKPE7zgo5RgdZXUoE5R7t4kP2ywckwJMM=;
        b=tFiJjSjFoinE4OaeK4k0KLatajEmcWyh39sKhDkHIagpQxdiwV3MKj6uKdM31ffni8YXdw
        HCk5KUkOqa2bMMd95Ohs7HXLTL6pzZttWrlCfcKs7i01xrKS6UTI+2RhmBNS4w/Nb5S9Qa
        5XUTYi/GOHcG/+9OEWHf2yf7rdWVXOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687364784;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=T6CJq22EsTUKPE7zgo5RgdZXUoE5R7t4kP2ywckwJMM=;
        b=GWeSsD+5NK8d1wfsM21KF4NbVzzX6k8lWav6lSJAw1QqB09PAfEF3DuMNcQqzW9yipvBV5
        isS1J2tzY1LIbKCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C07ED133E6;
        Wed, 21 Jun 2023 16:26:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id bR72LrAkk2T5PgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 21 Jun 2023 16:26:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2EC4DA075D; Wed, 21 Jun 2023 18:26:24 +0200 (CEST)
Date:   Wed, 21 Jun 2023 18:26:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/2] ext4: Fix crash in ext4_bdev_mark_dead()
Message-ID: <20230621162624.efgmx6lguqjnxcqv@quack3>
References: <20230621144354.10915-1-jack@suse.cz>
 <20230621144744.1580-1-jack@suse.cz>
 <ZJMOqynQKadyBOXX@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJMOqynQKadyBOXX@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 21-06-23 07:52:27, Christoph Hellwig wrote:
> On Wed, Jun 21, 2023 at 04:47:42PM +0200, Jan Kara wrote:
> > ext4_bdev_mark_dead() passes bdev->bd_holder to ext4_force_shutdown()
> > instead of bdev->bd_super leading to crashes. Fix it.
> 
> How does this crash? ext4_blkdev_get passes the sb as holder, and I
> actually tested this code.
> 
> This is not to be confused with the blkdev_get_by_path in get_tree_bdev,
> but that never ends up in ext4_bdev_mark_dead.

Indeed, I have confused the method called for journal device with the
method called for the main filesystem device. Both my patches are wrong and
I'm sorry for the confusion!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
