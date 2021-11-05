Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93DF14461F6
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 11:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232883AbhKEKNE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 06:13:04 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:52598 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhKEKND (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 06:13:03 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9E9BB212C0;
        Fri,  5 Nov 2021 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636107023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Wqby23pgih4bJELPymWZZdR5S0E6N3dTsc6SakmTbY=;
        b=Qt6VwAECDU5YCDHsziGa5nLocz3jpcEgbcgdHexeAE+xvpdcamQni+28BfF68+so6byldz
        qZBHZoUF5b2p8+pulV2Tn8FHPf9vW0HX6OeFd+oGNjiV8vpAVFntac91DM4FP5ILKi1Z/T
        jwyR/26i6PsdqQFhF/GEY7xGfv8WKp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636107023;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5Wqby23pgih4bJELPymWZZdR5S0E6N3dTsc6SakmTbY=;
        b=D2+jMNhnlhfNiG4WVuADOBiJoHNf2AvRtA1hSYPKiZSbONd4Qis0FKJXgSJ57luXq035iI
        6mIqWHgAtgtGb0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C54E13B97;
        Fri,  5 Nov 2021 10:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6dOmDA8DhWGjewAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 10:10:23 +0000
Date:   Fri, 5 Nov 2021 11:10:21 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     jack@suse.com, amir73il@gmail.com, repnop@google.com,
        linux-ext4@vger.kernel.org, kernel@collabora.com,
        khazhy@google.com, ltp@lists.linux.it
Subject: Re: [LTP] [PATCH v3 0/9] Test the new fanotify FAN_FS_ERROR event
Message-ID: <YYUDDU0A9hLFbM4c@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-1-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Gabriel, all,

> Hi,

> Now that FAN_FS_ERROR is close to being merged, I'm sending a new
> version of the LTP tests.  This is the v3 of this patchset, and it
> applies the feedback of the previous version, in particular, it solves
> the issue Amir pointed out, that ltp won't gracefully handle a test with
> tcnt==0.  To solve that, I merged the patch that set up the environment
> with a simple test, that only triggers a fs abort and watches the
> event.

> I'm also renaming the testcase from fanotify20 to fanotify21, to leave
> room for the pidfs test that is also in the baking by Matthew Bobrowski.

> One important detail is that, for the tests to succeed, there is a
> dependency on an ext4 fix I sent a few days ago:

> https://lore.kernel.org/linux-ext4/20211026173302.84000-1-krisman@collabora.com/T/#u
It has been merged into Theodore Ts'o ext4 tree into dev branch as c1e2e0350ce3
("ext4: Fix error code saved on super block during file system abort")

We should probably add it as .tags (see fanotify06.c).

Also it'd be nice just to mention relevant commits which added FAN_FS_ERROR in
fanotify21.c (probably "fanotify: Allow users to request FAN_FS_ERROR events" ?)
+ kernel version it added it -suppose 5.16 (although it can be backported; and
these commits should not go to .tags, as we track there only
fixes not new features). I can add it myself (no need to repost).

Kind regards,
Petr
