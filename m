Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE006997D3
	for <lists+linux-ext4@lfdr.de>; Thu, 22 Aug 2019 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388345AbfHVPOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 22 Aug 2019 11:14:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36692 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732150AbfHVPOv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 22 Aug 2019 11:14:51 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7MFEiSG024985
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Aug 2019 11:14:46 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A983042049E; Thu, 22 Aug 2019 11:14:44 -0400 (EDT)
Date:   Thu, 22 Aug 2019 11:14:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Austin Kim <austindh.kim@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove unreachable statement inside
 __es_insert_extent()
Message-ID: <20190822151444.GA7550@mit.edu>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Austin Kim <austindh.kim@gmail.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190822063743.GA36528@LGEARND20B15>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822063743.GA36528@LGEARND20B15>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 22, 2019 at 03:37:43PM +0900, Austin Kim wrote:
> __es_insert_extent() never returns -EINVAL after BUG is executed.
> So remove unreachable code.
> ---
>  fs/ext4/extents_status.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index a959adc..7f97360 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -781,7 +781,6 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
>  			p = &(*p)->rb_right;
>  		} else {
>  			BUG();
> -			return -EINVAL;

This would not be safe in the case of !CONFIG_BUG.  (See init/Kconfig)

It's fair to argue that we shouldn't have CONFIG_BUG --- or
!CONFIG_BUG should still cause the kernel to stop without actually
printing the full BUG information, for those tiny kernel applications
which are really worried about kernel text space.

It also would be fair to argue that we should remove the unreachable
annotation for BUG(), or even, add a *reachable* annotation to catch
code where something something terribly might happen if the kernel is
built with !CONFIG_BUG and we trip against a bug.

But this is a much higher level issue than your sending individual
paches subsystems.

Regards,

						- Ted
