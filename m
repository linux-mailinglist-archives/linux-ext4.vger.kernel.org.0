Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595112D8EB8
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Dec 2020 17:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgLMQ0f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Dec 2020 11:26:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60096 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725996AbgLMQ0X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 13 Dec 2020 11:26:23 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BDGPPet024833
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Dec 2020 11:25:25 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 29CAF420136; Sun, 13 Dec 2020 11:25:25 -0500 (EST)
Date:   Sun, 13 Dec 2020 11:25:25 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix an IS_ERR() vs NULL check
Message-ID: <20201213162525.GA835709@mit.edu>
References: <20201023112232.GB282278@mwanda>
 <20201210160419.GA31725@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210160419.GA31725@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 05:04:19PM +0100, Jan Kara wrote:
> On Fri 23-10-20 14:22:32, Dan Carpenter wrote:
> > The ext4_find_extent() function never returns NULL, it returns error
> > pointers.
> > 
> > Fixes: 44059e503b03 ("ext4: fast commit recovery path")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I think this fix has fallen through the cracks? It looks good to me so feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

This had indeed slipped through the cracks.  Thanks for pointing it
out; I've applied it.

					- Ted
