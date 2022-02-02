Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F304A758B
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 17:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiBBQLo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 11:11:44 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:54266 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiBBQLo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 11:11:44 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1EF4421118;
        Wed,  2 Feb 2022 16:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643818303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlukEsLtcc5qax3q7IddFsI3k4ywGkJcaOWt2ZnGRJU=;
        b=kSf8r7ek39NU69nA2gEJIpsyFn19VvjxoAaRxhxQbyEwfgUL52wvzVjwqKksdWtBJ9/lGW
        YV1/1OiOVr2zg9wIvAwEdLLjyBIIJMOi3RWnHIvAdAEUynBqaO0YHLSGACBPD3ePszRlgv
        Lj4qBn6pj9dc0NLPzudFVeZ+potylLQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643818303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HlukEsLtcc5qax3q7IddFsI3k4ywGkJcaOWt2ZnGRJU=;
        b=R/CzyvP7YpBApVba8B65BS3i9gQBRdY3BQa4VYc2MY1X6MT2Ysfax6nzEvTL7rZ6l2zwwr
        Mk9mSg4IX3bzsUDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F389F13E99;
        Wed,  2 Feb 2022 16:11:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 1fi4OT6t+mFBKgAAMHmgww
        (envelope-from <chrubis@suse.cz>); Wed, 02 Feb 2022 16:11:42 +0000
Date:   Wed, 2 Feb 2022 17:13:38 +0100
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <Yfqtsi5Y0u8Sv2P8@yuki>
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
 <YfqTqAjEPalXzOK7@pevik>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfqTqAjEPalXzOK7@pevik>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi!
> > In any case, Petr, I suggest adding a short timeout to the test
> > instead of the default 5min.
> > Test takes less than 1 second on my VM on v5.16, so...
> We usually don't lower the default timeout, but here it's a good idea since here
> it blocks. It's similar speed on my machine, but I'd be conservative and put
> timeout 10 sec. Sending patch.

Actually I hope to change the default timeout once I finish my runtime
patchset to something more reasonable as majority of LTP tests finish
under one second.

-- 
Cyril Hrubis
chrubis@suse.cz
