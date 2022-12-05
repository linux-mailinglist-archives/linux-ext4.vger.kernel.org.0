Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7589A64265A
	for <lists+linux-ext4@lfdr.de>; Mon,  5 Dec 2022 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbiLEKHn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 05:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbiLEKHm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 05:07:42 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7984271E
        for <linux-ext4@vger.kernel.org>; Mon,  5 Dec 2022 02:07:38 -0800 (PST)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 877031FE4C;
        Mon,  5 Dec 2022 10:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670234857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hb+nN/ooheJigShuoG6ojFj36pQYyCSkf71JYptSJjM=;
        b=fdo4yrj2x+8VerBfFaBrVyQAiU//WNNQ+Vch7k9LHlZGCD9hoEWgdQrhHVrPwTwTHOfpiF
        0XvvjuZHOWhM50EuEELgK190+2LoMlSRCH3QsrQvrEyqexq9EfmJtwepWdpa8UBUKofjF6
        R/ahV9E55bHnE31AymQ9xRRlB/0xZ9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670234857;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hb+nN/ooheJigShuoG6ojFj36pQYyCSkf71JYptSJjM=;
        b=50dx9iwtnEf/VSNQ5F792N0FF9r9ebCd5bc6aqzZlDw3gyFZFge56txmNC0bVlIVy42A+Z
        jrSvJPS6rRoFshCQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 666DD1348F;
        Mon,  5 Dec 2022 10:07:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id AG79GOnCjWNUeAAAGKfGzw
        (envelope-from <jack@suse.cz>); Mon, 05 Dec 2022 10:07:37 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5E51CA0727; Mon,  5 Dec 2022 11:07:36 +0100 (CET)
Date:   Mon, 5 Dec 2022 11:07:36 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>
Subject: Re: [PATCH v2 9/11] ext4: Switch to using write_cache_pages() for
 data=journal writeout
Message-ID: <20221205100736.h7migghyjuvmmcnc@quack3>
References: <20221202163815.22928-1-jack@suse.cz>
 <20221202183943.22640-9-jack@suse.cz>
 <Y4xFAk0ILz70ZtVW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4xFAk0ILz70ZtVW@infradead.org>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 03-12-22 22:58:10, Christoph Hellwig wrote:
> > +static int __writepage(struct page *page, struct writeback_control *wbc,
> > +		       void *data)
> 
> Can we give this a somewhat more descriptive name, e.g.
> ext4_writepage_cb or so?

OK, done. Thanks for review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
