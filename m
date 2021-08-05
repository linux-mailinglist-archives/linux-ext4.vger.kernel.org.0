Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A193E1773
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 17:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236035AbhHEPAf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 11:00:35 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:56086 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHEPAf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 11:00:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4DBC11FE64;
        Thu,  5 Aug 2021 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1628175619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfbU1doiSAejI1J04e3WXfgZHBDi3ymv5pX1rZRz/Ss=;
        b=MUQsMCQc/38CZf3V1M+aYbX2WG8PKMoyJAXho41+oHhTV2QMgsjkQoCA0g5RN3IuaybgAL
        EVz+E7cpa+P7SISzMzC2WxfuOgV3uePm+yJ1RocH9sydBCCK/D4IzHH/CJQU+0itOrhBsD
        Jn1nDkXthX+PzX+jrrk859cbB5CvWyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1628175619;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LfbU1doiSAejI1J04e3WXfgZHBDi3ymv5pX1rZRz/Ss=;
        b=k1G+52t2NsEwiNIZo5UhupfykeEx1bgeMREJUJe4W5o1G5tfo7Mv6AGqqrA8g2MVYKXsqQ
        XxcjfvB+aIWC8VBA==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id CCA8BA3BE8;
        Thu,  5 Aug 2021 15:00:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 059771E1511; Thu,  5 Aug 2021 17:00:14 +0200 (CEST)
Date:   Thu, 5 Aug 2021 17:00:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 8/9] mke2fs: Add orphan_file feature into mke2fs.conf
Message-ID: <20210805150013.GM14483@quack2.suse.cz>
References: <20210712154315.9606-1-jack@suse.cz>
 <20210712154315.9606-9-jack@suse.cz>
 <YQrkqslPB8oRrgwA@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQrkqslPB8oRrgwA@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 04-08-21 15:04:10, Theodore Ts'o wrote:
> On Mon, Jul 12, 2021 at 05:43:14PM +0200, Jan Kara wrote:
> > Enable orphan_file feature by default in larger filesystems. Since the
> > feature is COMPAT, older kernels will just ignore it and happily work
> > with the filesystem as well.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> We'll need to decide whether we want to enable this by default, at
> least initially.  The general practice has been to not enable new
> kernel functionality right away by default.  It's true that older
> kernels will ignore the feature if they aren't orphan_file aware;
> however, we if have a file system which is created with orphan_file
> eanbled, but that file system with the orphan_file feature is made
> available to a system which is running an orphan_file-aware kernel,
> but the distro hadn't picked up the a version e2fsprogs which is
> orphan_file-aware.  This might happen if the file system was created
> on one system, and then it gets connected to an system w/o a new
> version of e2fsprogs (e.g. via fibre channel, iscsi, AWS EBS, GCE PD,
> etc), then could be a surprise to the user.  So that's something for
> us to discuss.

Yes, I think you are right that enabling the functionality by default right
from the start may be too aggressive. I'm fine with postponing this for
some time.

> In the shorter term, there's another problem I've notied, which is if
> we add this to mke2fs.conf, and the user runs:
> 
> 	mke2fs -t ext4 -O ^has_journal foo.img 1G
> 
> mke2fs will fail mid-way through the mkfs process with the error
> message, "mke2fs: cannot set orphan_file flag without a journal".
> This represents a regression, and if we don't want to drop orphan_file
> from the default feature set in mke2fs.conf, I think we'll need to
> check for the case where the file system doesn't have a journal, and
> only fail when the user has explicitly requested orphan_file on the
> command line.  But if orphan_file is a default as defined in
> mke2fs.conf, and the journal is not present for whatever reaseon, we
> need to silently disable the orphan_file feature.

Good catch. I'll fix this.

> (Also note that to avoid user confusion, we should refer to
> orphan_file as a "feature" instead of a "flag".  Even for things like
> "orphan_present" or "recovery_needed" it is probably clearer to call
> them features, simply because it makes it easier for system
> adminsitrators and developers to be able to find the "flag" location.)

Good point. I've fixed up couple of occurences of 'flag' I've found in the
messages.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
