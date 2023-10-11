Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC3D7C5608
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 15:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234951AbjJKN71 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 09:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjJKN70 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 09:59:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48DC93;
        Wed, 11 Oct 2023 06:59:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 336291FEC2;
        Wed, 11 Oct 2023 13:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697032763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDxQm9+A2hHDdkBqBnjxp+FzgrU9wEMk6rAhmb/Kp9s=;
        b=MX4GRXweEU3+XM4fNlEs3A+BqRtzzpgxMiAftXX6g9ZLS7hPaiN+NUwB7O5nTNbKpYHb32
        U2Ic/NoBvQHpy8Sp5DZKfmeZu81zDEqY07sNYBpyp1bl1n5s5KVSwg4rpKjfCv/ym0im0G
        22H6oXZpsKvuGNOGhE5Gg45Aib50FlU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697032763;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zDxQm9+A2hHDdkBqBnjxp+FzgrU9wEMk6rAhmb/Kp9s=;
        b=ap3Cb6XIdQHU9oUjKWllUwJlGo0UHKGx1/ng4FjeRG8qvIt+eT1khKU6uQlMCvzv9NGAp1
        8vfCNRaX2LGHl6AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E436134F5;
        Wed, 11 Oct 2023 13:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3XNmBzuqJmWcXQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 13:59:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 78020A05BC; Wed, 11 Oct 2023 15:59:22 +0200 (CEST)
Date:   Wed, 11 Oct 2023 15:59:22 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011135922.4bij3ittlg4ujkd7@quack3>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
 <20231011100541.sfn3prgtmp7hk2oj@quack3>
 <CAKPOu+_xdFALt9sgdd5w66Ab6KTqiy8+Z0Yd3Ss4+92jh8nCwg@mail.gmail.com>
 <20231011120655.ndb7bfasptjym3wl@quack3>
 <CAKPOu+-hLrrpZShHh0o6uc_KMW91suEd0_V_uzp5vMf4NM-8yw@mail.gmail.com>
 <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_0yjg=PrwAR8jKok8WskjdDEJOBtu3uKR_4Qtp8b7H1Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 11-10-23 14:27:49, Max Kellermann wrote:
> On Wed, Oct 11, 2023 at 2:18 PM Max Kellermann <max.kellermann@ionos.com> wrote:
> > But without the other filesystems. I'll resend it with just the
> > posix_acl.h hunk.
> 
> Thinking again, I don't think this is the proper solution. This may
> server as a workaround so those broken filesystems don't suffer from
> this bug, but it's not proper.
> 
> posix_acl_create() is only supposed to appy the umask if the inode
> supports ACLs; if not, the VFS is supposed to do it. But if the
> filesystem pretends to have ACL support but the kernel does not, it's
> really a filesystem bug. Hacking the umask code into
> posix_acl_create() for that inconsistent case doesn't sound right.
> 
> A better workaround would be this patch:
> https://patchwork.kernel.org/project/linux-nfs/patch/151603744662.29035.4910161264124875658.stgit@rabbit.intern.cm-ag/
> I submitted it more than 5 years ago, it got one positive review, but
> was never merged.
> 
> This patch enables the VFS's umask code even if the filesystem
> prerents to support ACLs. This still doesn't fix the filesystem bug,
> but makes VFS's behavior consistent.

OK, that solution works for me as well. I agree it seems a tad bit cleaner.
Christian, which one would you prefer?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
