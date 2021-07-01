Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3376D3B9818
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Jul 2021 23:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhGAVRG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Jul 2021 17:17:06 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54456 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233274AbhGAVRG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Jul 2021 17:17:06 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 161LERuF018540
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jul 2021 17:14:27 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id EB61815C3CE1; Thu,  1 Jul 2021 17:14:26 -0400 (EDT)
Date:   Thu, 1 Jul 2021 17:14:26 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Junxiao Bi <junxiao.bi@oracle.com>
Subject: Re: [PATCH] ext4: use ext4_grp_locked_error in mb_find_extent
Message-ID: <YN4wMm0w6NogVrC/@mit.edu>
References: <20210623232114.34457-1-stephen.s.brennan@oracle.com>
 <20210624095501.jkd7iwu5bljw7xao@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624095501.jkd7iwu5bljw7xao@work>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 24, 2021 at 11:55:01AM +0200, Lukas Czerner wrote:
> On Wed, Jun 23, 2021 at 04:21:14PM -0700, Stephen Brennan wrote:
> > Commit 5d1b1b3f492f ("ext4: fix BUG when calling ext4_error with locked
> > block group") introduces ext4_grp_locked_error to handle unlocking a
> > group in error cases. Otherwise, there is a possibility of a sleep while
> > atomic. However, since 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON
> > in mb_find_extent()"), mb_find_extent() has contained a ext4_error()
> > call while a group spinlock is held. Replace this with
> > ext4_grp_locked_error.
> > 
> > Fixes: 43c73221b3b1 ("ext4: replace BUG_ON with WARN_ON in mb_find_extent()")
> > Cc: <stable@vger.kernel.org> # 4.14+
> > Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
> > Reviewed-by: Junxiao Bi <junxiao.bi@oracle.com>
> 
> Good catch, looks good to me.
> 
> Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks, applied.

					- Ted
