Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B02ED70F87E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 16:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjEXOS6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 10:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjEXOS4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 10:18:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A974199;
        Wed, 24 May 2023 07:18:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 490D01F749;
        Wed, 24 May 2023 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684937933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNyPM6nfC8sYHSUtNotAm4sGTuLQ7z86zDqULPosa9Y=;
        b=h+rjabaXza2fSgY0toGdYUuzCYo27SJerx5WZwugB9QIAx8uOvT5O5xEFUmbdS7ij7IjHH
        gaDWBs1HyqSUeiWqOrzzJZ4IYiNPhszwUp05Pdw9S+mOGu+X3lBXmSvwZ30jdH1ZeAWlQG
        6xsh1ZR7aSYe55n8pJ0rMIi6AyBceUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684937933;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JNyPM6nfC8sYHSUtNotAm4sGTuLQ7z86zDqULPosa9Y=;
        b=JZOviyry1t018EhHLOskPZs9QrfUsRDjDHIDy+9ZVfqg3I2zHvgZ/iJ70qcG7ZTqyphBEO
        Hgx+OnRlyxgcUhCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 36DD713425;
        Wed, 24 May 2023 14:18:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QJBjDc0cbmTQIwAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 24 May 2023 14:18:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 9B696A075C; Wed, 24 May 2023 16:18:52 +0200 (CEST)
Date:   Wed, 24 May 2023 16:18:52 +0200
From:   Jan Kara <jack@suse.cz>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, David Laight <David.Laight@aculab.com>,
        Ted Tso <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
Message-ID: <20230524141852.gu75mudt4snub4ed@quack3>
References: <20230523131408.13470-1-jack@suse.cz>
 <48d1f20b2fc1418080c96a1736f6249b@AcuMS.aculab.com>
 <20230524105148.wgjj7ayrbeol6cdx@quack3>
 <CAOQ4uxgizNA9e3rXmktU-pqCzoxg-=n4u_PAHczo1bgquba5Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxgizNA9e3rXmktU-pqCzoxg-=n4u_PAHczo1bgquba5Og@mail.gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 24-05-23 16:11:13, Amir Goldstein wrote:
> On Wed, May 24, 2023 at 2:27 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Tue 23-05-23 13:50:01, David Laight wrote:
> > > From: Jan Kara
> > > > Sent: 23 May 2023 14:14
> > > >
> > > > Commit 0813299c586b ("ext4: Fix possible corruption when moving a
> > > > directory") forgot that handling of RENAME_EXCHANGE renames needs the
> > > > protection of inode lock when changing directory parents for moved
> > > > directories. Add proper locking for that case as well.
> > > >
> > > > CC: stable@vger.kernel.org
> > > > Fixes: 0813299c586b ("ext4: Fix possible corruption when moving a directory")
> > > > Reported-by: "Darrick J. Wong" <djwong@kernel.org>
> > > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > > ---
> > > >  fs/ext4/namei.c | 23 +++++++++++++++++++++--
> > > >  1 file changed, 21 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > > > index 45b579805c95..b91abea1c781 100644
> > > > --- a/fs/ext4/namei.c
> > > > +++ b/fs/ext4/namei.c
> > > > @@ -4083,10 +4083,25 @@ static int ext4_cross_rename(struct inode *old_dir, struct dentry *old_dentry,
> > > >     if (retval)
> > > >             return retval;
> > > >
> > > > +   /*
> > > > +    * We need to protect against old.inode and new.inode directory getting
> > > > +    * converted from inline directory format into a normal one. The lock
> > > > +    * ordering does not matter here as old and new are guaranteed to be
> > > > +    * incomparable in the directory hierarchy.
> > > > +    */
> > > > +   if (S_ISDIR(old.inode->i_mode))
> > > > +           inode_lock(old.inode);
> > > > +   if (S_ISDIR(new.inode->i_mode))
> > > > +           inode_lock_nested(new.inode, I_MUTEX_NONDIR2);
> > > > +
> > >
> > > What happens if there is another concurrent rename from new.inode
> > > to old.inode?
> > > That will try to acquire the locks in the other order.
> >
> > That is not really possible because these two renames cannot happen in
> > parallel due to VFS locking - either old & new share parent which is locked
> > by VFS (so there cannot be another rename in that directory) or they have
> > different parents which are also locked by VFS (so again it is not possible
> > to race with another rename in these two dirs).
> 
> Unless D1/A ; D1/B are hardlinks of D2/B ; D2/A respectively
> and exchange (D1/A, D1/B) is racing with exchange (D2/B, D2/A)

Well, but these are *directories*. So no hardlinks possible ;) I agree with
regular files we'd have to be more careful but then VFS would take care of
the locking anyway. I'm still convinced VFS should be taking care of
locking of directories as well but Al disagreed [1] and wants only filesystems
that need this to handle the directory locking.

> There is a simple solution of course, same as xfs_lock_two_inodes()
> 
> Another possible deadlock (I think) is if D/A ; D/B are subdirs that
> are exchanged and after taking inode_lock of D and A, rename comes
> in D/B/foo => D/A/foo and lock_rename() tries to
> lock_two_directories(B, A).
> 
> So it seems that both lock_two_directories() and to be helper
> lock_two_inodes() need to order the two inodes by address?

Right, so this case indeed looks possible and I didn't think about it.
Thanks for spotting this! Let me try to persuade Al again to do the
necessary locking in VFS as it is getting really hairy and needs VFS
changes anyway.

								Honza

[1] https://lore.kernel.org/all/Y8bTk1CsH9AaAnLt@ZenIV
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
