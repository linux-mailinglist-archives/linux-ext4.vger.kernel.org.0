Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037033F2A0C
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Aug 2021 12:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238508AbhHTKWA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Aug 2021 06:22:00 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:32928 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237840AbhHTKV7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Aug 2021 06:21:59 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9662422171;
        Fri, 20 Aug 2021 10:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629454881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhNk8lxe6JJrFZjgNC31q5GHymCThZLZrgrFHACGfgY=;
        b=ttmN+OhUloeFYb2WW86BepRW9xvOdfe6ZIWVOONttcJTVnfmvj8/MgH64mSWAPb0KD91Ad
        +bDVJKAaCPUrp0h36eVeAMV7b6hJ/u6Lq8CMr0c13YMW40aJCkObf8hlNPgNZF3NCqrmsZ
        MuoiF5U/IcSlTbHI0DRkCCES05+ALQQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629454881;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhNk8lxe6JJrFZjgNC31q5GHymCThZLZrgrFHACGfgY=;
        b=FMBf9bia21Gc0KmlG72n/vTfjhluMtYpereR/+CfD3LGO/tKB8ZuCH2GGmBybNKrlPJ4Wy
        rhCOO0VRGrZSAXCg==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 38EC113ABF;
        Fri, 20 Aug 2021 10:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id MWvSCyGCH2GHZwAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Fri, 20 Aug 2021 10:21:21 +0000
Date:   Fri, 20 Aug 2021 12:21:19 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Message-ID: <YR+CH2+GYzwU2/SG@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

> No problem. That's what review is for ;-)

> BTW, unless anyone is specifically interested I don't think there
> is a reason to re post the test patches before the submission request.
> Certainly not for the small fixes that I requested.

> I do request that you post a link to a branch with the fixed test
> so that we can experiment with the kernel patches.

> I've also CC'ed Matthew who may want to help with review of the test
> and man page that you posted in the cover letter [1].

@Amir Thanks a lot for your review, agree with all you mentioned.

@Gabriel Thanks for your contribution. I'd also consider squashing some of the
commits.

Kind regards,
Petr

> Thanks,
> Amir.

> [1] https://lore.kernel.org/linux-ext4/20210802214645.2633028-1-krisman@collabora.com/T/#m9cf637c6aca94e28390f61deac5a53afbc9e88ae
