Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C11802498F7
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Aug 2020 11:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHSJBu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 19 Aug 2020 05:01:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:58644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgHSJBs (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 19 Aug 2020 05:01:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E007DB6B9;
        Wed, 19 Aug 2020 09:02:12 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 5CB2A1E1312; Wed, 19 Aug 2020 11:01:46 +0200 (CEST)
Date:   Wed, 19 Aug 2020 11:01:46 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Wang Hai <wanghai38@huawei.com>, jack@suse.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ext2: remove duplicate include
Message-ID: <20200819090146.GG1902@quack2.suse.cz>
References: <20200819025434.65763-1-wanghai38@huawei.com>
 <20200819050049.F103511C073@d06av25.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200819050049.F103511C073@d06av25.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 19-08-20 10:30:49, Ritesh Harjani wrote:
> 
> 
> On 8/19/20 8:24 AM, Wang Hai wrote:
> > Remove linux/fiemap.h which is included more than once
> > 
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Wang Hai <wanghai38@huawei.com>
> 
> 
> LGTM, please feel free to add,
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Thanks. I've added the patch to my tree.

								Honza

> 
> > ---
> >   fs/ext2/inode.c | 1 -
> >   1 file changed, 1 deletion(-)
> > 
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index 80662e1f7889..de6b97612410 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -36,7 +36,6 @@
> >   #include <linux/iomap.h>
> >   #include <linux/namei.h>
> >   #include <linux/uio.h>
> > -#include <linux/fiemap.h>
> >   #include "ext2.h"
> >   #include "acl.h"
> >   #include "xattr.h"
> > 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
