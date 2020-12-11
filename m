Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6FC92D823B
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Dec 2020 23:39:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406992AbgLKWin (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 11 Dec 2020 17:38:43 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49583 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2406972AbgLKWiQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 11 Dec 2020 17:38:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BBMbN4S020852
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Dec 2020 17:37:24 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 4AA36420136; Fri, 11 Dec 2020 17:37:23 -0500 (EST)
Date:   Fri, 11 Dec 2020 17:37:23 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Saranya Muruganandam <saranyamohan@google.com>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH RFC 5/5] Enable threaded support for e2fsprogs'
 applications.
Message-ID: <20201211223723.GD575698@mit.edu>
References: <20201205045856.895342-1-tytso@mit.edu>
 <20201205045856.895342-6-tytso@mit.edu>
 <89A599C9-4978-43C9-B2B4-82C9E746AC39@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89A599C9-4978-43C9-B2B4-82C9E746AC39@dilger.ca>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Dec 10, 2020 at 09:10:09PM -0700, Andreas Dilger wrote:
> On Dec 4, 2020, at 9:58 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> 
> My understanding is that as soon as the EXT2_FLAG_THREADS is added,
> and if the backend supports CHANNEL_FLAGS_THREADS, then the pthread
> code in the previous patch will "autothread" based on the number of
> CPUs in the system.

Yep.

> That will be nice for debugfs, which would otherwise take ages to
> start on a large filesystem if "-c" was not used (which also
> precludes any kind of modifications).
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>

Yes, that's an issue that our SRE's have run across as well while
debugging customer problems, which is one of the reasons why I've been
interested in getting this change upstream first, even it takes a bit
longer to get all of the parallel fsck changes reviewed and upstream.

       	      	     	 	  - Ted

