Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75213642690
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbiLEKRp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 05:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbiLEKRn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 05:17:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D4B55
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 02:17:41 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D863F21C41;
        Mon,  5 Dec 2022 10:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670235459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BV9WAyegNBye8OCOsYo/1cJxpL271y+FDMQ1+2MSQcQ=;
        b=zArE5V03Yc3P+2doLRbazXqtTgdScZHXGJix0IgG9aiPxUI4owTiqNUPI2PrkFcrnxHwh0
        3r0AdwN1T7wWRZECApVqUC3H3XRtP7wjbwWanCPgzfSCbdgZHHQNmUjI7hnlJG/zxV3UwF
        37ueO2iX45If4mxIBK2Sd8qqZED1fqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670235459;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BV9WAyegNBye8OCOsYo/1cJxpL271y+FDMQ1+2MSQcQ=;
        b=kCmpTI9mMnepgEdxHSBc3kEk4H7zQO7ijPSz6kkz+O9x4BCM907cRurrE6jEa0iV503Pxt
        B7GIVpzLqLg6gNBw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id CA5141348F;
        Mon,  5 Dec 2022 10:17:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id ob5ZMUPFjWM5fgAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 10:17:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5ACC6A0727; Mon,  5 Dec 2022 11:17:39 +0100 (CET)
Date:   Mon, 5 Dec 2022 11:17:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 1/11] ext4: Remove ordered data support from
 ext4_writepage()
Message-ID: <20221205101739.e3ssi3rtev2e6rro@quack3>
References: <20221202163815.22928-1-jack@suse.cz>
 <20221202183943.22640-11-jack@suse.cz>
 <Y4xHB+fDxyfOCwu5@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4xHB+fDxyfOCwu5@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 03-12-22 23:06:47, Christoph Hellwig wrote:
> > + * This function is now used only when journaling data. We cannot start
> > + * transaction directly because transaction start ranks above page lock so we
> > + * have to do some magic.
> >   */
> > +static int ext4_writepage(struct page *page, struct writeback_control *wbc,
> > +			  void *data)
> 
> Maybe call this ext4_journalled_writepage now to make the limitation
> more clear?  And/or fold __ext4_journalled_writepage into while we're
> at it.

Yeah, I've renamed it to ext4_journalled_writepage. I've refrained from the
folding of __ext4_journalled_writepage() because that is not completely
trivial (due to goto labels, variable naming...) so it would require
separate patch and I'll just spare that for the cleanup of the whole
journalled writeout path.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
