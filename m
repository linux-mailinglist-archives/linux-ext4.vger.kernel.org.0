Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4B13ED100
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Aug 2021 11:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235341AbhHPJYQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 16 Aug 2021 05:24:16 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:43698 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbhHPJYP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 16 Aug 2021 05:24:15 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 83DE421E82;
        Mon, 16 Aug 2021 09:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629105823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVjEIt3W3N0ioxUEoE4nV42/vOY7qLn9Wu2rJoiorNU=;
        b=u0c4toL7Ku4L5E8o/vmJbRIP7Zp7W9zQhL9NNOCCkSixE9BXEUF187bh7VrR+i2ychdMm5
        69rDr5zvlsXGGKjZ1ga8gzWg0vpL1N4kD+YEkncsfCg6isdJx5fvW+XAfpRIIRtgj6Bp+L
        8AtLkmlukGoRa3lTQGvHOzNXb1hbGuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629105823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TVjEIt3W3N0ioxUEoE4nV42/vOY7qLn9Wu2rJoiorNU=;
        b=VLVhxNzbybC2xKFnBmuh310J4qb9+5IbB+fiKKInzlZT4i7MrhlvUhgH5PVf646SZzZZl0
        YnX28MzQ8rodsBBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 792FCA3BB0;
        Mon, 16 Aug 2021 09:23:43 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 58B2D1E0426; Mon, 16 Aug 2021 11:23:40 +0200 (CEST)
Date:   Mon, 16 Aug 2021 11:23:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/5] ext4: Speedup ext4 orphan inode handling
Message-ID: <20210816092340.GA24793@quack2.suse.cz>
References: <20210811101006.2033-1-jack@suse.cz>
 <20210811101925.6973-3-jack@suse.cz>
 <YRU3zjcP5hukrsyt@mit.edu>
 <20210813123434.GB11955@quack2.suse.cz>
 <YRaPNaukNFEObAvJ@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRaPNaukNFEObAvJ@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 13-08-21 11:26:45, Theodore Ts'o wrote:
> On Fri, Aug 13, 2021 at 02:34:34PM +0200, Jan Kara wrote:
> > Actually, in the orphan list code, we leave the inode in the on-disk list
> > but remove it from the in-memory list - see how
> > list_del_init(&ei->i_orphan) is called very early in ext4_orphan_del(). The
> > reason for this unconditional deletion is that if we do not remove the
> > inode from the in-memory orphan list, the filesystem will complain and
> > corrupt memory on unmount.
> > 
> > Also note that leaving inode in the on-disk orphan list actually does no
> > serious harm. Because the orphan cleanup code just checks i_nlink and
> > i_disksize and truncates inode down to current i_disksize and removes inode
> > completely if i_nlink is 0. So even if an inode on the orphan list gets
> > reused, orphan cleanup will just do nothing for it. So the worst problem
> > that will likely happen is that on-disk orphan linked list becomes
> > corrupted but there's no data loss AFAICT.
> > 
> > Is it clearer now or am I missing something?
> 
> Yes, you're right, I misread the code.  Thanks for clarifying.
> 
> Can you send the final spin of this patch set?  I think we're all set
> for this patch series.
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Thanks. I've posted v6 with all the updates.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
