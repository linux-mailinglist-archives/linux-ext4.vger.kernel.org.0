Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31616C1049
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Mar 2023 12:08:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbjCTLID (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Mar 2023 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjCTLHp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 20 Mar 2023 07:07:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDB72D79
        for <linux-ext4@vger.kernel.org>; Mon, 20 Mar 2023 04:03:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 42FE31F88D;
        Mon, 20 Mar 2023 11:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679310212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsBt10+2rRAaCRYVuYDEKaArxZfywvXC09T3RLLhOeI=;
        b=l2kisvP3DpS2H1JPOOMmzOOUwJWzbYTnuXtZ1n6LaVIESew4gFE53fR0wWynHec3d0fKLe
        2yrt47Qk1cpSd/nwjIqxSzk4tD4VUIe9Y6a7A6jhF6ovIbqsYz0+V4vUQ8CBL8dwHjtnaB
        YVQCsfbgbLett5YSE6rY3hpmN0AT+dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679310212;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YsBt10+2rRAaCRYVuYDEKaArxZfywvXC09T3RLLhOeI=;
        b=cjRhEqVVmRrk+pZEYJ5uSXW6NPhH3OraycRk7O+nQMGWEhGvf2j1yAFGJ+RAWNI8+B+xt4
        DYuxHg555hlXXNCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0427D13416;
        Mon, 20 Mar 2023 11:03:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id opD7AIQ9GGToJwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 20 Mar 2023 11:03:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DE33BA0719; Mon, 20 Mar 2023 12:03:29 +0100 (CET)
Date:   Mon, 20 Mar 2023 12:03:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, Eric Biggers <ebiggers@kernel.org>,
        Dan Carpenter <error27@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Fix possible corruption when moving a
 directory
Message-ID: <20230320110329.ckxg5mrenwfo5f4c@quack3>
References: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
 <ZAeOFzbhCNvskQ6b@gmail.com>
 <20230308104234.z7vmgmjz2smepwlg@quack3>
 <20230318020743.GO860405@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230318020743.GO860405@mit.edu>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 17-03-23 22:07:43, Theodore Ts'o wrote:
> On Wed, Mar 08, 2023 at 11:42:34AM +0100, Jan Kara wrote:
> > > That analysis looks correct.  FYI, I think this is the same as the syzbot report
> > > "[ext4?] WARNING: bad unlock balance in ext4_rename2"
> > > (https://lore.kernel.org/linux-ext4/000000000000435c6905f639ae8e@google.com).
> > 
> > Good spotting! This should be fixed (along with the lock ordering problem)
> > by 3c92792da8506 ("ext4: Fix deadlock during directory rename") Ted has
> > just merged couple hours ago.
> 
> Unfortunately, the Syzkaller report is still triggering after the
> merge and commit 3c92792da8506.  The double unlock is still there, and
> so the following fix is still needed (which I will be sending to Linus).

Bah, right. Thanks for fixing this!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
