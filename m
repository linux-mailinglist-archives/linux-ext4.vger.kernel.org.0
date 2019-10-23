Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F290CE2083
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Oct 2019 18:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407212AbfJWQZP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Oct 2019 12:25:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:46006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404989AbfJWQZP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 23 Oct 2019 12:25:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6FEE4AF4C;
        Wed, 23 Oct 2019 16:25:13 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2C2171E4A99; Wed, 23 Oct 2019 18:25:13 +0200 (CEST)
Date:   Wed, 23 Oct 2019 18:25:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 08/22] ext4: Provide function to handle transaction
 restarts
Message-ID: <20191023162513.GF31271@quack2.suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
 <20191003220613.10791-8-jack@suse.cz>
 <20191021162046.GA27850@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021162046.GA27850@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 21-10-19 12:20:46, Theodore Y. Ts'o wrote:
> On Fri, Oct 04, 2019 at 12:05:54AM +0200, Jan Kara wrote:
> > diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> > index fb0f99dc8c22..32f2c22c7ef2 100644
> > --- a/fs/ext4/extents.c
> > +++ b/fs/ext4/extents.c
> 
> > +/*
> > + * Make sure 'handle' has at least 'check_cred' credits. If not, restart
> > + * transaction with 'restart_cred' credits. The function drops i_data_sem
> > + * when restarting transaction and gets it after transaction is restarted.
> > + *
> > + * The function returns 0 on success, 1 if transaction had to be restarted,
> > + * and < 0 in case of fatal error.
> > + */
> > +int ext4_datasem_ensure_credits(handle_t *handle, struct inode *inode,
> > +				int check_cred, int restart_cred)
> 
> This makes me super nervous.  This gets called by ext4_access_path(),
> which in turn is called by the insert_range, and collapse_range (among
> others) where we previously were not dropping i_data_sem.  This means
> we will be dropping i_data_sem while they are in the middle of doing
> surgery to the extent tree, which makes me super nervous.

But this patch changes nothing in that regard. Previously,
ext4_access_path() was using ext4_ext_truncate_extend_restart() which
called ext4_truncate_restart_trans() which was dropping i_data_sem as well.

> Granted, insert_range and collapse_range take a lot of locks,
> including the inode lock, but it's not obvious to me that this is
> safe, and at the very least the documentation for ext4_access_path
> should have a warning note in its comments that i_data_sem can get
> dropped, and its call sites audited if they haven't already.

Yeah, comment about that would be nice. I can add that when touching this
function anyway.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
