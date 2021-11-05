Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4CFD4460F3
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Nov 2021 09:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbhKEJBt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Nov 2021 05:01:49 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47786 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhKEJBs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Nov 2021 05:01:48 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 837661FD33;
        Fri,  5 Nov 2021 08:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1636102748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vTQRd+FsseWzqLlxM7LU6kApFmHFBdkT696eVDN5rg=;
        b=UZCwcikeHe+hKrDIuu0KUBIrM88LJMxb2qcI28Owy6IwsSuaDWxZ2YQ0crX1ucR9oj/ssK
        7fVjr1WmJ09aR9YK6AettzzhWyvTGpbhOIpLvctMIJEhIqsycR/Qo9JD9Eb9uU+dPWg8c7
        hyd5tJzXNVt7Dq3ink3tPV0d8DLV6Bg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1636102748;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7vTQRd+FsseWzqLlxM7LU6kApFmHFBdkT696eVDN5rg=;
        b=irvOcv58cHch10vX6ODxoZIzRjNhIfYtToaOHS53fKMk/eUWmNU0ULvzj8xalopoGbzNab
        l8+Uaqj9lz9yYJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 25D9013FBA;
        Fri,  5 Nov 2021 08:59:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0rrqBlzyhGHlVgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 05 Nov 2021 08:59:08 +0000
Date:   Fri, 5 Nov 2021 09:59:06 +0100
From:   Petr Vorel <pvorel@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Khazhismel Kumykov <khazhy@google.com>,
        Matthew Bobrowski <repnop@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH v3 3/9] syscalls/fanotify21: Introduce FAN_FS_ERROR
 test
Message-ID: <YYTyWs4UPEL0eqjR@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-4-krisman@collabora.com>
 <CAOQ4uxiwodQm_9+XVY-cWhV6aWKkqTosBfZ0HyAQTVNijJrwuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxiwodQm_9+XVY-cWhV6aWKkqTosBfZ0HyAQTVNijJrwuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

...
> > +static struct tst_test test = {
> > +       .test = do_test,
> > +       .tcnt = ARRAY_SIZE(testcases),
> > +       .setup = setup,
> > +       .cleanup = cleanup,
> > +       .mount_device = 1,
> > +       .mntpoint = MOUNT_PATH,
> > +       .all_filesystems = 0,

> That's probably redundant and the default value anyway.
> If you want to stress out that this test cannot be run on other filesystems
> maybe add a comment why that is above dev_fs_type.

Yes, good catch. Thanks!

Kind regards,
Petr
