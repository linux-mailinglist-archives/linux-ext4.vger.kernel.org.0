Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6356D2AA252
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 04:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgKGD3y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 22:29:54 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39250 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727525AbgKGD3y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 22:29:54 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A73TUV3005516
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Nov 2020 22:29:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 61183420107; Fri,  6 Nov 2020 22:29:30 -0500 (EST)
Date:   Fri, 6 Nov 2020 22:29:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Joseph Qi <joseph.qi@linux.alibaba.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Tao Ma <boyu.mt@taobao.com>
Subject: Re: [PATCH] ext4: unlock xattr_sem properly in
 ext4_inline_data_truncate()
Message-ID: <20201107032930.GB2499342@mit.edu>
References: <1604370542-124630-1-git-send-email-joseph.qi@linux.alibaba.com>
 <8B6EE337-4C54-42C3-BB2C-5D191143FAC7@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8B6EE337-4C54-42C3-BB2C-5D191143FAC7@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 02, 2020 at 08:15:36PM -0700, Andreas Dilger wrote:
> On Nov 2, 2020, at 7:29 PM, Joseph Qi <joseph.qi@linux.alibaba.com> wrote:
> > 
> > It takes xattr_sem to check inline data again but without unlock it
> > in case not have. So unlock it before return.
> > 
> > Fixes: aef1c8513c1f ("ext4: let ext4_truncate handle inline data correctly")
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Cc: Tao Ma <boyu.mt@taobao.com>
> > Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Thanks, applied.

					- Ted
