Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20271F6A79
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728405AbgFKPA5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 11:00:57 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47353 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728059AbgFKPA4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jun 2020 11:00:56 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 05BExr8q024568
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 10:59:53 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 112B14200DD; Thu, 11 Jun 2020 10:59:53 -0400 (EDT)
Date:   Thu, 11 Jun 2020 10:59:53 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     yangerkun <yangerkun@huawei.com>, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] ext4: stop overwrite the errcode in ext4_setup_super
Message-ID: <20200611145953.GN1347934@mit.edu>
References: <20200601073404.3712492-1-yangerkun@huawei.com>
 <20200601114708.GG3960@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601114708.GG3960@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 01, 2020 at 01:47:08PM +0200, Jan Kara wrote:
> On Mon 01-06-20 15:34:04, yangerkun wrote:
> > Now the errcode from ext4_commit_super will overwrite EROFS exists in
> > ext4_setup_super. Actually, no need to call ext4_commit_super since we
> > will return EROFS. Fix it by goto done directly.
> > 
> > Fixes: c89128a00838 ("ext4: handle errors on ext4_commit_super")
> > Signed-off-by: yangerkun <yangerkun@huawei.com>
> 
> Yeah, makes sense. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
