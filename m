Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6165222B212
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jul 2020 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgGWPAO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jul 2020 11:00:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43439 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729323AbgGWPAO (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jul 2020 11:00:14 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 06NF07ln026768
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 11:00:08 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 14030420304; Thu, 23 Jul 2020 11:00:07 -0400 (EDT)
Date:   Thu, 23 Jul 2020 11:00:06 -0400
From:   tytso@mit.edu
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        Shuichi Ihara <sihara@ddn.com>
Subject: Re: [PATCH 1/4] ext4: add prefetching for block allocation bitmaps
Message-ID: <20200723150006.GF1536749@mit.edu>
References: <20200717155352.1053040-1-tytso@mit.edu>
 <20200717155352.1053040-2-tytso@mit.edu>
 <1F791FDF-75A7-48D9-A0A7-764D5AEC8E4B@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1F791FDF-75A7-48D9-A0A7-764D5AEC8E4B@dilger.ca>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jul 21, 2020 at 01:42:54AM -0600, Andreas Dilger wrote:
> 
> I re-reviewed the patch with the changes, and it looks OK.  I see that
> you reduced the prefetch limit from 32 to 4 group blocks, presumably to
> keep the latency low?  It would be useful to see what impact that has
> on the mount time and IO performance of a large filesystem.

No, I didn't change it.  As before, it's 4 times the size of the
flex_bg size (assuming the file system has flex bg's enabled);
otherwise it's 128 (4 times 32).

I'm actually worried that this is too aggressive on storage devies
where LBA's which are adjacent to each other aren't necessarily
adjacent to each other on the physical storage device.  For example,
on dm-thin, some qemu-img formats, and potentially some cloud virtual
block devices....

Unfortunately, there isn't a good way to query a block device to
determine whether adjacent LBA's are really adjacent in the real world.

	  	  	   	     	    	     - Ted
