Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C512CD8AE
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Dec 2020 15:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbgLCOM4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Dec 2020 09:12:56 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56965 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726889AbgLCOM4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Dec 2020 09:12:56 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B3EBRPi024509
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Dec 2020 09:11:29 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CBF27420136; Thu,  3 Dec 2020 09:11:27 -0500 (EST)
Date:   Thu, 3 Dec 2020 09:11:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Xianting Tian <tian.xianting@h3c.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: remove the null check of bio_vec page
Message-ID: <20201203141127.GF441757@mit.edu>
References: <20201020082201.34257-1-tian.xianting@h3c.com>
 <20201021102503.GC19726@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021102503.GC19726@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 21, 2020 at 12:25:03PM +0200, Jan Kara wrote:
> On Tue 20-10-20 16:22:01, Xianting Tian wrote:
> > bv_page can't be NULL in a valid bio_vec, so we can remove the NULL check,
> > as we did in other places when calling bio_for_each_segment_all() to go
> > through all bio_vec of a bio.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> 
> Thanks for the patch. It looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
