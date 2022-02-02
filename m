Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E394A72EA
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Feb 2022 15:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiBBOWg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Feb 2022 09:22:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:39042 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbiBBOWf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Feb 2022 09:22:35 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A680721128;
        Wed,  2 Feb 2022 14:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1643811754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFKOPJuk1IdAkljF/XJSg7G3dUqJ+jpAmQxaqluSBbU=;
        b=AHn7yIdqtPhrxDRq1quEFqpeyTe5jFmr+L60G7vrf005InBjW7ZIR5Cmoeb8sm+G8p+b3p
        8rJvjhRjss2fujZyaY7nvdc6NsJdnI9SyuuA41jn/PEU+T8vo+mJ36KnwNmdeKQZPiE5bO
        +xhCfm3fFYkgtHfG6ZAXuXtEMnaQRms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1643811754;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EFKOPJuk1IdAkljF/XJSg7G3dUqJ+jpAmQxaqluSBbU=;
        b=UUWSIi2XPje1hcJ2iZr0oQicYBTvjlf0eUnSx/n3fl9kPRuhEUUDeWiqk8ji01vqvA3NLX
        IxVwyP37RTlaWIBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5D86E13BBC;
        Wed,  2 Feb 2022 14:22:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RRI9FaqT+mHiaAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 02 Feb 2022 14:22:34 +0000
Date:   Wed, 2 Feb 2022 15:22:32 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Jan Kara <jack@suse.com>,
        Matthew Bobrowski <repnop@google.com>,
        Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH v4 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YfqTqAjEPalXzOK7@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211118235744.802584-1-krisman@collabora.com>
 <YdxN6HBJF+ATgZxP@pevik>
 <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxia2NNMPUCQzjo6Gsnz8xr_9YKTeTqzOu-hgdsjfHHx0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Amir,

> On Mon, Jan 10, 2022 at 5:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi all,

> > v5.16 released => patchset merged.
> > Thanks!


> Guys,

> Looks like we have a regression.
> With kernel v5.17-rc1, test fanotify22 blocks on the first test case,
> because the expected ECORRUPTED event on remount,abort is never received.
> The multiple error test cases also fail for the same reason.

> Gabriel,

> Are you aware of any ext4 change that could explain this regression?

> In any case, Petr, I suggest adding a short timeout to the test
> instead of the default 5min.
> Test takes less than 1 second on my VM on v5.16, so...
We usually don't lower the default timeout, but here it's a good idea since here
it blocks. It's similar speed on my machine, but I'd be conservative and put
timeout 10 sec. Sending patch.

Kind regards,
Petr


> Thanks,
> Amir.
