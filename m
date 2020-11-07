Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F4B2AA24C
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Nov 2020 04:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgKGDXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Nov 2020 22:23:40 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37764 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727298AbgKGDXk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Nov 2020 22:23:40 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0A73NUFe002848
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Nov 2020 22:23:30 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3464A420107; Fri,  6 Nov 2020 22:23:30 -0500 (EST)
Date:   Fri, 6 Nov 2020 22:23:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: silence an uninitialized variable warning
Message-ID: <20201107032330.GN1750809@mit.edu>
References: <20201030114620.GB3251003@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201030114620.GB3251003@mwanda>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 30, 2020 at 02:46:20PM +0300, Dan Carpenter wrote:
> Smatch complains that "i" can be uninitialized if we don't enter the
> loop.  I don't know if it's possible but we may as well silence this
> warning.

Thanks, applied.

I changed the patch so that i gets initialized to sb->s_blocksize
instead of 0.  The only way the for loop could be skipped entirely,
leaving i initialized, is if the in-memory data structures, in
particular the bh->b_data for the on-disk superblock has gotten
corrupted enough that calculated value of group is >= to
ext4_get_groups_count(sb).  In that case, we want to exit immediately
without allocating a block, and if i is left to sb->s_blocksize, that
will cause the function to bail out right after the skipped for loop.

     	       		   	    - Ted
