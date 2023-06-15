Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BE27314BF
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 12:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241750AbjFOKBm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 06:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245550AbjFOKBa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 06:01:30 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB94296F
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 03:01:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id AF159223EB;
        Thu, 15 Jun 2023 10:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1686823286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwc5Q6r8DSVlGqrN9RxoOtoujMWUGpkzJ9oA//lqUxk=;
        b=AoQWYpReUwVE51XJ86pLMV63wwgtBeCml6vcnuyWzV8KnucG7CzNsR/nqzNsAmZoZw5KFK
        CxwTQBAJlqCih1oO03IQU0toSGQYIbI/7R0zxqBqlx5zXrypZjPJL8XsCVY8Bd9UNwlN2u
        nGBDJIJ5ULOZXUgwUb3va01gUsly/UA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1686823286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zwc5Q6r8DSVlGqrN9RxoOtoujMWUGpkzJ9oA//lqUxk=;
        b=/vjdkdPD+X5QQYnKp/Nj2MLs9OwAXRXPbAHkSnzcj21uSVMxZ3r52BCrFK3scgjcwZFUdD
        UjXjbrqTBOUYwsAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2EAC13A47;
        Thu, 15 Jun 2023 10:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gtvCJ3bhimScYwAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 15 Jun 2023 10:01:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 332C9A0755; Thu, 15 Jun 2023 12:01:26 +0200 (CEST)
Date:   Thu, 15 Jun 2023 12:01:26 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        bagasdotme@gmail.com, nikolas.kraetzschmar@sap.com, jack@suse.cz
Subject: Re: [PATCH 1/2] Revert "ext4: don't clear SB_RDONLY when remounting
 r/w until quota is re-enabled"
Message-ID: <20230615100126.othz2jtof4av4pur@quack3>
References: <20230608044056.GA1418535@mit.edu>
 <20230608141805.1434230-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608141805.1434230-1-tytso@mit.edu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 08-06-23 10:18:04, Theodore Ts'o wrote:
> This reverts commit a44be64bbecb15a452496f60db6eacfee2b59c79.
> 
> Link: https://lore.kernel.org/r/653b3359-2005-21b1-039d-c55ca4cffdcc@gmail.com
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>

So I was looking more into how the warning in xattr code can trigger. Sadly
the syzbot reproducer does not seem to reproduce the issue for me when I
enable the warnings in xattr code. Anyway, after staring for some time into
the code I think the problem has actually been introduced by the transition
to the new mount API. Because in the old API, userspace could not start
writes to the filesystem until we called set_mount_attributes() in
do_remount() which cleared the MNT_READONLY flag on the mount (which
happens after reconfigure_super(). In the new API, fsconfig(2) syscall
allows you to toggle SB_RDONLY flag without touching the mount flags and so
we can have userspace writing the filesystem as soon as we clear SB_RDONLY
flag.

I have checked and the other direction (i.e., remount read-only) is
properly serialized in the VFS by setting sb->s_readonly_remount (and
making sure we either return EBUSY or all writers are going to see
s_readonly_remount set) before calling into filesystem's reconfigure code.
I have actually a fixup within ext4 ready but I think it may be better to
fix this within VFS and provide similar serialization like for the rw-ro
transition there... Let's see what VFS people say to this.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
