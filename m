Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E4D4A7648
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 17:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiBBQ5S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 11:57:18 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58988 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346056AbiBBQ5S (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 11:57:18 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 40B3B21110;
        Wed,  2 Feb 2022 16:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643821037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jF8Bs3HTOn12sXQ/zQWRv1Mody7bEDmU4n3TIWFpgg=;
        b=15vQrP2KvZgO28J6TBmx5D7dCGO4NLdfJfDp4JJRxP+xfdUgIcydE9SaVebPeq0++Jkcfd
        pyEswqInWtk6KZLwUo3LCFZwdZVh4HOm2nknQ4GjQXIKuvLVnaY+KMRzS+z1Ukh6en3tmG
        lscUPEmF5mYEmuMZHwKl4zjVBG7acZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643821037;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9jF8Bs3HTOn12sXQ/zQWRv1Mody7bEDmU4n3TIWFpgg=;
        b=BUpDgri3PyC6tkBmbSfWor5cwePlT0Q0oyR+n04gX8NEwICiWv4nbtKXhxQgpCfAqHybAQ
        1AMJM6R/TVfN+fCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E02A013E99;
        Wed,  2 Feb 2022 16:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id TN+KNOy3+mG6QQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 16:57:16 +0000
Date:   Wed, 2 Feb 2022 17:57:15 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Cyril Hrubis <chrubis@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <Yfq368ht9bmasV5b@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
 <YfqTqAjEPalXzOK7@pevik>
 <Yfqtsi5Y0u8Sv2P8@yuki>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfqtsi5Y0u8Sv2P8@yuki>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Hi!
> > > In any case, Petr, I suggest adding a short timeout to the test
> > > instead of the default 5min.
> > > Test takes less than 1 second on my VM on v5.16, so...
> > We usually don't lower the default timeout, but here it's a good idea since here
> > it blocks. It's similar speed on my machine, but I'd be conservative and put
> > timeout 10 sec. Sending patch.

> Actually I hope to change the default timeout once I finish my runtime
> patchset to something more reasonable as majority of LTP tests finish
> under one second.

+1. We can then revert that temporary fix for fanotify22.

Kind regards,
Petr
