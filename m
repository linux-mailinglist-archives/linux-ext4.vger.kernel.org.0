Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290067C4F89
	for <lists+linux-ext4@lfdr.de>; Wed, 11 Oct 2023 12:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbjJKKFq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 Oct 2023 06:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjJKKFq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 Oct 2023 06:05:46 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E3F92;
        Wed, 11 Oct 2023 03:05:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 85F1321846;
        Wed, 11 Oct 2023 10:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697018742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvCiUYneHj84xzWqOcZeY7+I2IayaqBntzgcE8QwB8U=;
        b=p+rqvMXbLI2hW8Qv6uv8BDydqVQ6n1DhuxcIr7zf93KJ3qtr7qHmHxKGrFvgZBDBPP84B5
        r4UCpL6t6rDLNacSKImf9aipwXnJgMUxbxhmHmYMynGz9SFfBZIITIQj3dAp7xdTOMMuAQ
        d9Dfpxw988QJ7gqWFGFOEsmS+3Wv8wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697018742;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KvCiUYneHj84xzWqOcZeY7+I2IayaqBntzgcE8QwB8U=;
        b=wNU592+Vcr8OXaOweD0TnSahKEDozcrRqkR02RSKK+eClIhMnSLaCUIFFxLAv35dZJR8Ti
        y+TbLbHtNl+GLwAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B8BD138EF;
        Wed, 11 Oct 2023 10:05:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Xbg9GnZzJmWCVgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 11 Oct 2023 10:05:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id CF275A05BC; Wed, 11 Oct 2023 12:05:41 +0200 (CEST)
Date:   Wed, 11 Oct 2023 12:05:41 +0200
From:   Jan Kara <jack@suse.cz>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Jan Kara <jack@suse.cz>, Xiubo Li <xiubli@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.com>,
        Dave Kleikamp <shaggy@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        jfs-discussion@lists.sourceforge.net,
        Christian Brauner <brauner@kernel.org>, fdevel@quack3,
        Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: Re: [PATCH v2] fs/{posix_acl,ext2,jfs,ceph}: apply umask if ACL
 support is disabled
Message-ID: <20231011100541.sfn3prgtmp7hk2oj@quack3>
References: <69dda7be-d7c8-401f-89f3-7a5ca5550e2f@oracle.com>
 <20231009144340.418904-1-max.kellermann@ionos.com>
 <20231010131125.3uyfkqbcetfcqsve@quack3>
 <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+-nC2bQTZYL0XTzJL6Tx4Pi1gLfNWCjU2Qz1f_5CbJc1w@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 10-10-23 15:17:17, Max Kellermann wrote:
> On Tue, Oct 10, 2023 at 3:11 PM Jan Kara <jack@suse.cz> wrote:
> > Thanks for the updated changelog! But as I'm looking into VFS code isn't
> > this already handled by mode_strip_umask() / vfs_prepare_mode() in
> > fs/namei.c? Because posix_acl_create() doesn't do anything to 'mode' for
> > !IS_POSIXACL() filesystems either. So at least ext2 (where I've checked
> > the mount option handling) does seem to have umask properly applied in all
> > the cases. But I might be missing something...
> 
> I'm not sure either. I was hoping the VFS experts could tell something
> about how this API is supposed to be used and whose responsibility it
> is to apply the umask. There used to be some confusion in the code, to
> the point it was missing completely for O_TMPFILE. I'm still somewhat
> confused. Maybe this is a chance to clear this confusion up and then
> document it?

So I've checked some more and the kernel doc comments before
mode_strip_umask() and vfs_prepare_mode() make it pretty obvious - all
paths creating new inodes must be calling vfs_prepare_mode(). As a result
mode_strip_umask() which handles umask stripping for filesystems not
supporting posix ACLs. For filesystems that do support ACLs,
posix_acl_create() must be call and that handles umask stripping. So your
fix should not be needed. CCed some relevant people for confirmation.

> I wish there was one central place to apply the umask, and not spread
> it around two (or more?) different code locations, depending on
> whether there's an ACL. For my taste, that sort of policy is too error
> prone for something as sensitive as umasks. After we already had the
> O_TMPFILE vulnerability (which was only fixed last year, three
> years(!) after I reported it).

I agree having umask stripping in two places is not great but it's
difficult to avoid with how posix ACLs are implemented and intertwined in
various filesystem implementations. At least the current design made it
quite a bit harder to forget to strip the umask.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
