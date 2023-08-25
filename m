Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4822B78878E
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Aug 2023 14:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244837AbjHYMfM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Aug 2023 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244893AbjHYMeu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 25 Aug 2023 08:34:50 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3914C2706
        for <linux-ext4@vger.kernel.org>; Fri, 25 Aug 2023 05:34:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E8F761F747;
        Fri, 25 Aug 2023 12:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1692966862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vThGHqQXucKWDKUAxiSP8ATSe7QhhXbj1eXCgzDJF6o=;
        b=0zVcgrJ2+VyIoGVaPMAzGWrh4RVmFuFkHdnola34FL6x4Qi0uIvpi26YlMIYPZEOQCvvRL
        XqPiyauwGFaepJm1JiQhTUf8mrtASDL9RMA4xzR5zC1ZXVoQ+lszSkGuDyG2WlYWfypCoX
        RsKtYDaMKKV0VSuJfJMLXbLGDiiF9IY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1692966862;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vThGHqQXucKWDKUAxiSP8ATSe7QhhXbj1eXCgzDJF6o=;
        b=hBjaH9uOSg9M03qhW982212Igdf2qZzAchyHEStB+bRxyR3qsJOXev75GrfL6mYIwwhiCU
        Y9glm9DiNI/aGpBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB2301340A;
        Fri, 25 Aug 2023 12:34:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iGFzNc6f6GRVXQAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 25 Aug 2023 12:34:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 6E30EA0774; Fri, 25 Aug 2023 14:34:22 +0200 (CEST)
Date:   Fri, 25 Aug 2023 14:34:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Vitaliy Kuznetsov <vk.en.mail@gmail.com>, adilger@dilger.ca
Subject: Re: [PATCH v2] ext4: Add periodic superblock update check
Message-ID: <20230825123422.xiex6inglvlqtayd@quack3>
References: <20230731122526.30158-1-vk.en.mail@gmail.com>
 <20230810143852.40228-1-vk.en.mail@gmail.com>
 <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169285281338.4146427.4994363470834118959.b4-ty@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 24-08-23 00:53:44, Theodore Ts'o wrote:
> 
> On Thu, 10 Aug 2023 18:38:52 +0400, Vitaliy Kuznetsov wrote:
> > This patch introduces a mechanism to periodically check and update
> > the superblock within the ext4 file system. The main purpose of this
> > patch is to keep the disk superblock up to date. The update will be
> > performed if more than one hour has passed since the last update, and
> > if more than 16MB of data have been written to disk.
> > 
> > This check and update is performed within the ext4_journal_commit_callback
> > function, ensuring that the superblock is written while the disk is
> > active, rather than based on a timer that may trigger during disk idle
> > periods.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/1] ext4: Add periodic superblock update check
>       commit: 58d85f2e88c97c69c869cae6c6bdd1af32936146

Coverity is telling me that this commit is adding uninitialized variable
access to call_notify_err and it seems to be correct... call_notify_err
needs to be initialized to 0.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
