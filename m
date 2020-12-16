Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5DD2DB9F3
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Dec 2020 05:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgLPEOX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Dec 2020 23:14:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60471 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgLPEOX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Dec 2020 23:14:23 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BG4COe1010992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Dec 2020 23:12:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DD0ED420280; Tue, 15 Dec 2020 23:12:23 -0500 (EST)
Date:   Tue, 15 Dec 2020 23:12:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     xiakaixu1987@gmail.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] ext4: remove the unused EXT4_CURRENT_REV macro
Message-ID: <X9mJJw+qZ8GnGZmk@mit.edu>
References: <1605164202-31120-1-git-send-email-kaixuxia@tencent.com>
 <20201210161806.GB31725@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210161806.GB31725@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 05:18:06PM +0100, Jan Kara wrote:
> On Thu 12-11-20 14:56:42, xiakaixu1987@gmail.com wrote:
> > From: Kaixu Xia <kaixuxia@tencent.com>
> > 
> > There are no callers of the EXT4_CURRENT_REV macro, so remove it.
> > 
> > Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
> 
> I guess this has fallen through the cracks? The cleanup looks good to me.
> You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
