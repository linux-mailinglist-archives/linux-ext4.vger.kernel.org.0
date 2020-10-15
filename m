Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFB728F562
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 16:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389512AbgJOO4X (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 10:56:23 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388086AbgJOO4W (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 10:56:22 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09FEuG4J002433
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 10:56:17 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9A113420107; Thu, 15 Oct 2020 10:56:16 -0400 (EDT)
Date:   Thu, 15 Oct 2020 10:56:16 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>
Subject: Re: [PATCH v2] ext4: Detect already used quota file early
Message-ID: <20201015145616.GE181507@mit.edu>
References: <20201015110330.28716-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201015110330.28716-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Oct 15, 2020 at 01:03:30PM +0200, Jan Kara wrote:
> When we try to use file already used as a quota file again (for the same
> or different quota type), strange things can happen. At the very least
> lockdep annotations may be wrong but also inode flags may be wrongly set
> / reset. When the file is used for two quota types at once we can even
> corrupt the file and likely crash the kernel. Catch all these cases by
> checking whether passed file is already used as quota file and bail
> early in that case.
> 
> This fixes occasional generic/219 failure due to lockdep complaint.
> 
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Replied to the wrong patch previously.  Thanks, applied.

	       	     	   		- Ted
