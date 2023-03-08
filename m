Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4ADA6B04D6
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Mar 2023 11:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjCHKnI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Mar 2023 05:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjCHKnC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Mar 2023 05:43:02 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E79F224
        for <linux-ext4@vger.kernel.org>; Wed,  8 Mar 2023 02:42:37 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4DA961FE3C;
        Wed,  8 Mar 2023 10:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678272155; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RosoxMvMoyfYlecC2RD2QfagL531I9fxTGJa/MsDkpo=;
        b=tnauPlYXUwnSQdt08jW1ldQccXOFG4clDnngWAm37NTeoRZNT8a64GIjNlbv5nXCRjx/tN
        MO3IYBVkWt6F5z8r6cXPAgECT1KSGHMJ5T2vTHyXA0z7P4dtWwarEdV3HcVbAv6NXMubyl
        uwi00sCKuubsVy/8vvXJ1jsENHZ5YL4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678272155;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RosoxMvMoyfYlecC2RD2QfagL531I9fxTGJa/MsDkpo=;
        b=+i9pEVI+tkRDFK/sib8pfLXg3FMD8L+eHLHz5uQKnsGLPPtpJMfTMdhVA9htpQ0UUHN2j6
        d7839NCQql/0X/DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F1B31348D;
        Wed,  8 Mar 2023 10:42:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KhBiD5tmCGR/ZQAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 08 Mar 2023 10:42:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id BB7BAA0709; Wed,  8 Mar 2023 11:42:34 +0100 (CET)
Date:   Wed, 8 Mar 2023 11:42:34 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Dan Carpenter <error27@gmail.com>, jack@suse.cz,
        linux-ext4@vger.kernel.org
Subject: Re: [bug report] ext4: Fix possible corruption when moving a
 directory
Message-ID: <20230308104234.z7vmgmjz2smepwlg@quack3>
References: <5efbe1b9-ad8b-4a4f-b422-24824d2b775c@kili.mountain>
 <ZAeOFzbhCNvskQ6b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAeOFzbhCNvskQ6b@gmail.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 07-03-23 19:18:47, Eric Biggers wrote:
> On Tue, Mar 07, 2023 at 06:56:28PM +0300, Dan Carpenter wrote:
> > Hello Jan Kara,
> > 
> > The patch 0813299c586b: "ext4: Fix possible corruption when moving a
> > directory" from Jan 26, 2023, leads to the following Smatch static
> > checker warning:
> > 
> > 	fs/ext4/namei.c:4017 ext4_rename()
> > 	error: double unlocked '&old.inode->i_rwsem' (orig line 3882)
> > 
> [...]
> >     3875                 /*
> >     3876                  * We need to protect against old.inode directory getting
> >     3877                  * converted from inline directory format into a normal one.
> >     3878                  */
> >     3879                 inode_lock_nested(old.inode, I_MUTEX_NONDIR2);
> >     3880                 retval = ext4_rename_dir_prepare(handle, &old);
> >     3881                 if (retval) {
> >     3882                         inode_unlock(old.inode);
> > 
> > The issue here is that ext4_rename_dir_prepare() sets old.dir_bh and
> > then returns -EFSCORRUPTED.  It results in an unlock here and then again
> > after the goto.
> 
> That analysis looks correct.  FYI, I think this is the same as the syzbot report
> "[ext4?] WARNING: bad unlock balance in ext4_rename2"
> (https://lore.kernel.org/linux-ext4/000000000000435c6905f639ae8e@google.com).

Good spotting! This should be fixed (along with the lock ordering problem)
by 3c92792da8506 ("ext4: Fix deadlock during directory rename") Ted has
just merged couple hours ago.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
