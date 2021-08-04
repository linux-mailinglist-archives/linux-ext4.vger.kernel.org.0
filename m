Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF583E04E1
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Aug 2021 17:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhHDPwb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Aug 2021 11:52:31 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41558 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239567AbhHDPwa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Aug 2021 11:52:30 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F150C1FDFE;
        Wed,  4 Aug 2021 15:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628092336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsQZleP+a92Q9m/XYDgfuGFJXRSyYXNyPiGtDd47CFc=;
        b=fkuHI02LvqjMYRclhitwjoI9XYIBcDuLNYF1E4FwrbECKJx1Itje5zImfKp6syAWT6zpSg
        DFFwDZyAbsG7oJEDFXuXDclREyWZrv/W30tOEO1pf4cia53LEhR0yeHSN0Nk72U+v6lW5Z
        XrutC5cAgY6b/y2yi8slcQFZCoGLKBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628092336;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DsQZleP+a92Q9m/XYDgfuGFJXRSyYXNyPiGtDd47CFc=;
        b=JfCoMrYQ5IDLBP8he7K7aoZeAbEIubobla7byGvV3wBqhFBb80/ppRPmdS6HSgYxWbO2FH
        Uuuapa8oQs2JGRCw==
Received: from quack2.suse.cz (jack.udp.ovpn2.nue.suse.de [10.163.43.118])
        by relay2.suse.de (Postfix) with ESMTP id DD87BA3BD6;
        Wed,  4 Aug 2021 15:52:16 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3CE871F2B83; Wed,  4 Aug 2021 17:52:14 +0200 (CEST)
Date:   Wed, 4 Aug 2021 17:52:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca
Subject: Re: [PATCH V3 5/5] ext4: make fallocate retry when err is ENOSPC
Message-ID: <20210804155214.GN4578@quack2.suse.cz>
References: <20210724074124.25731-1-jianchao.wan9@gmail.com>
 <20210724074124.25731-6-jianchao.wan9@gmail.com>
 <0ac551b1-6295-9117-757d-12bee70de588@linux.dev>
 <2888807f-2822-a73d-4c01-f073f8fffae2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2888807f-2822-a73d-4c01-f073f8fffae2@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-07-21 15:05:41, Wang Jianchao wrote:
> 
> 
> On 2021/7/26 11:40 AM, Guoqing Jiang wrote:
> > Hi,
> > 
> > On 7/24/21 3:41 PM, Wang Jianchao wrote:
> >> From: Wang Jianchao <wangjianchao@kuaishou.com>
> >>
> >> The blocks may be waiting for journal commit to be freed back to
> >> mb buddy. Let fallocate wait and retry in that case.
> >>
> >> Signed-off-by: Wang Jianchao <wangjianchao@kuaishou.com>
> >> ---
> >>   fs/ext4/extents.c | 6 +++++-
> >>   1 file changed, 5 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> >> index 92ad64b89d9b..ad0b874d3448 100644
> >> --- a/fs/ext4/extents.c
> >> +++ b/fs/ext4/extents.c
> >> @@ -4635,7 +4635,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >>       struct inode *inode = file_inode(file);
> >>       loff_t new_size = 0;
> >>       unsigned int max_blocks;
> >> -    int ret = 0;
> >> +    int ret = 0, retries = 0;
> >>       int flags;
> >>       ext4_lblk_t lblk;
> >>       unsigned int blkbits = inode->i_blkbits;
> >> @@ -4656,6 +4656,7 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >>                FALLOC_FL_INSERT_RANGE))
> >>           return -EOPNOTSUPP;
> >>   +retry:
> >>       ext4_fc_start_update(inode);
> >>         if (mode & FALLOC_FL_PUNCH_HOLE) {
> >> @@ -4722,6 +4723,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
> >>       trace_ext4_fallocate_exit(inode, offset, max_blocks, ret);
> >>   exit:
> >>       ext4_fc_stop_update(inode);
> >> +    if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
> >> +        goto retry;
> >> +
> > 
> > Not sure if it is necessary since ext4_alloc_file_blocks already retries allocate.
> 
> Yes, this patch should be get rid of.  But it is indeed helpful to fix
> the xfstest generic/371 which does concurrently write/rm and
> fallocate/rm. I'll figure out some other way to improve that

Note that the retry logic is only a heuristic. It is not guaranteed any
number of retries is enough, we just do three to not give up too easily...
Your patch effectively raised number of retries to 9 so that may have
masked the issue. But I don't think so high number of retries is a sensible
choice because that way it may take too long to return ENOSPC.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
