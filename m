Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2995C1245B0
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Dec 2019 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfLRLWW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 Dec 2019 06:22:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:59416 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbfLRLWW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 18 Dec 2019 06:22:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id ACCA8AD2C;
        Wed, 18 Dec 2019 11:22:20 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 64D181E0B2D; Wed, 18 Dec 2019 12:22:20 +0100 (CET)
Date:   Wed, 18 Dec 2019 12:22:20 +0100
From:   Jan Kara <jack@suse.cz>
To:     Paul Richards <paul.richards@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: Query about ext4 commit interval vs dirty_expire_centisecs
Message-ID: <20191218112220.GA13668@quack2.suse.cz>
References: <CAMoswejffB4ys=2C5zL_j9SBrdka8MJWV3hpwber9cggo=1GQQ@mail.gmail.com>
 <20191213155912.GH15474@quack2.suse.cz>
 <CAMoswegmo08i-7TMpbM7x=RHiRsu-g40Vq2wmPzYsx7=gCi5MA@mail.gmail.com>
 <20191218083301.GA4083@quack2.suse.cz>
 <CAMoswejK1bySFnT42aEA8e-MphktZzGLzr9WK0kkxBmg=3+Kng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMoswejK1bySFnT42aEA8e-MphktZzGLzr9WK0kkxBmg=3+Kng@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 18-12-19 10:35:56, Paul Richards wrote:
> I found it here:
> https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
> 
> I think this might be the source, but I'm not sure:
> https://github.com/torvalds/linux/blame/master/Documentation/admin-guide/ext4.rst#L185-L187

Yes, that's it. Somehow my grep capabilities failed me :-| Thanks for the
pointer.

> While searching for this I also found a copy of the same `commit`
> documentation here:
> https://github.com/torvalds/linux/blob/master/Documentation/filesystems/ocfs2.txt
> I don't know if the same correction should be made for ocfs2 or not.

For OCFS2 it is somewhat different since it doesn't do delayed allocation.
So the text is actually correct for file creation. It is still incorrect
for file overwrites though on which commit interval has no effect.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
