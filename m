Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CC5702803
	for <lists+linux-ext4@lfdr.de>; Mon, 15 May 2023 11:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjEOJNJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 15 May 2023 05:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEOJMM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 15 May 2023 05:12:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB70211D
        for <linux-ext4@vger.kernel.org>; Mon, 15 May 2023 02:10:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7CE0821CE2;
        Mon, 15 May 2023 09:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1684141848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRiG69e+7udZxsEUqXdQkRKoiIcY6+0SF3qbfDzaZT0=;
        b=pOjUelKxaFR57O13cMXrmMh6/de9jWd5Sn4IDmUzwhGwqdLbmaYdYXw3JemjZ//WEWgN1f
        wDX2hQlgSCmm0paKZfbi7+xDvEA8e5XqvTwkNRRyS7wejpoOEq4xajaAIio+DkUh6Xkey6
        PJKlVwFvkcmSLGAywEsbZ7B3eRnvr3U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1684141848;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sRiG69e+7udZxsEUqXdQkRKoiIcY6+0SF3qbfDzaZT0=;
        b=txHWgYgt5t2GABySCLxHClMgTragiEBraYxK0bpGA/vZkKts58SKe1AKjs0ytU0saNcgJ1
        qddZnroYZk9ylXDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E08B13466;
        Mon, 15 May 2023 09:10:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 2KrVGhj3YWR3QAAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 15 May 2023 09:10:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F299CA0757; Mon, 15 May 2023 11:10:47 +0200 (CEST)
Date:   Mon, 15 May 2023 11:10:47 +0200
From:   Jan Kara <jack@suse.cz>
To:     Marcus Hoffmann <marcus.hoffmann@othermo.de>
Cc:     Greg KH <gregkh@linuxfoundation.org>, tytso@mit.edu,
        famzah@icdsoft.com, jack@suse.cz, linux-ext4@vger.kernel.org
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <20230515091047.37mu44px4h73gecp@quack3>
References: <20230315185711.GB3024297@mit.edu>
 <578c0eb1-5271-b5fe-afa2-e2c1107b8968@othermo.de>
 <2023051249-finalize-sneak-2864@gregkh>
 <114216cf-6dfe-71b3-0ffe-3883296bc144@othermo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <114216cf-6dfe-71b3-0ffe-3883296bc144@othermo.de>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 12-05-23 16:24:30, Marcus Hoffmann wrote:
> On 12.05.23 14:19, Greg KH wrote:
> > On Thu, May 11, 2023 at 11:21:27AM +0200, Marcus Hoffmann wrote:
> > > Hi,
> > > 
> > > > On Wed, Mar 15, 2023 at 18:57, Theodore Ts'o wrote:
> > > > 
> > > > Yeah, sorry, I didn't see it since it was in an attachment as opposed
> > > > to with an explicit [PATCH] subject line.
> > > > 
> > > > And at this point, the data=journal writeback patches have landed in
> > > > the ext4/dev tree, and while we could try to see if we could land this
> > > > before the next merge window, I'm worried about merge or semantic
> > > > conflicts of having both patches in a tree at one time.
> > > > 
> > > > I guess we could send it to Linus, let it get backported into stable,
> > > > and then revert it during the merge window, ahead of applying the
> > > > data=journal cleanup patch series.  But that seems a bit ugly.  Or we
> > > > could ask for an exception from the stable kernel folks, after I do a
> > > > full set of xfstests runs on it.  (Of course, I don't think anyone has
> > > > been able to create a reliable reproducer, so all we can do is to test
> > > > for regression failures.)
> > > > 
> > > > Jan, Greg, what do you think?
> > > 
> > > We've noticed this appearing for us as well now (on 5.15 with
> > > data=journaled) and I wanted to ask what the status here is. Did any fix
> > > here make it into a stable kernel yet? If not, I suppose I can still
> > > apply the patch posted above as a quick-fix until this (or another
> > > solution) makes it into the stable tree?
> > 
> > Any reason you can't just move to 6.1.y instead?  What prevents that?
> > 
> 
> We will move to 6.1.y soon-ish (we are downstream from the rpi kernel tree)
> Is this problem fixed there though? I couldn't really find anything
> related to that in the tree?

Yeah. Due to various delays the rewrite of data=journal mode got merged
only into 6.4-rc1. So updating to 6.1.y isn't going to fix the problem.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
