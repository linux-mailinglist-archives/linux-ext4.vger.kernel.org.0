Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53913E5AD1
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 15:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhHJNQB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 09:16:01 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48608 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbhHJNP7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 09:15:59 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 8EAF720069;
        Tue, 10 Aug 2021 13:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628601336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/dQpzK2RGx0nfJIPi8qmIpzidGZ0GBUTr3TF7pmVws=;
        b=U/LzfaVSHRidE7zGYrcbbGFVi/lH2E3+UYGl4e/m84PKk6RKrH1ZzBkUCokv94oZksrhCU
        H2Vp2V1Ldjwc42MkipSVjlsHEx5fgtxwYgr668vOQr+DLgr9Cd6NcVsNDFt4C9VEjd8GdQ
        yU1ZDQ5EO+UnlmJ003MRng2tVRwgHCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628601336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D/dQpzK2RGx0nfJIPi8qmIpzidGZ0GBUTr3TF7pmVws=;
        b=8yFAzmy0KKRsTEauzrTuwDIonUaIiPXt5w1KYdBwwSbxz9KGuJ0psHPxHK9N+HJBrllBNY
        9UUlX22wCF1LXMDg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 80F1FA3B85;
        Tue, 10 Aug 2021 13:15:36 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5BE8D1F2AC2; Tue, 10 Aug 2021 15:15:33 +0200 (CEST)
Date:   Tue, 10 Aug 2021 15:15:33 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH 2/5] ext4: Move orphan inode handling into a separate file
Message-ID: <20210810131533.GA14725@quack2.suse.cz>
References: <20210712154009.9290-1-jack@suse.cz>
 <20210712154009.9290-3-jack@suse.cz>
 <YQ/qL+lOaYd3iD1+@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQ/qL+lOaYd3iD1+@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun 08-08-21 10:29:03, Theodore Ts'o wrote:
> On Mon, Jul 12, 2021 at 05:40:06PM +0200, Jan Kara wrote:
> > Move functions for handling orphan inodes into a new file
> > fs/ext4/orphan.c to have them in one place and somewhat reduce size of
> > other files. No code changes.
> > 
> > Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Note that when you refresh this patch, you'll need to include commit
> b9a037b7f3c4: ("ext4: cleanup in-core orphan list if ext4_truncate()
> failed to get a transaction handle") when moving ext4_orphan_cleanup()
> to fs/ext4/orphan.c.

Yes, I have that already included in my local version. I guess I'll send a
new version of the kernel patches and e2fsprogs patches tomorrow since some
time has passed from the previous posting and some changes have already
accumulated.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
