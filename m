Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F0628FB2
	for <lists+linux-ext4@lfdr.de>; Fri, 24 May 2019 05:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388625AbfEXDrT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 May 2019 23:47:19 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58258 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387454AbfEXDrS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 May 2019 23:47:18 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4O3lA57011041
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 May 2019 23:47:11 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id B4D3D420481; Thu, 23 May 2019 23:47:10 -0400 (EDT)
Date:   Thu, 23 May 2019 23:47:10 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/3] ext4: Do not delete unlinked inode from orphan list
 on failed truncate
Message-ID: <20190524034710.GC2532@mit.edu>
References: <20190522090317.28716-1-jack@suse.cz>
 <20190522090317.28716-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190522090317.28716-3-jack@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, May 22, 2019 at 11:03:16AM +0200, Jan Kara wrote:
> It is possible that unlinked inode enters ext4_setattr() (e.g. if
> somebody calls ftruncate(2) on unlinked but still open file). In such
> case we should not delete the inode from the orphan list if truncate
> fails. Note that this is mostly a theoretical concern as filesystem is
> corrupted if we reach this path anyway but let's be consistent in our
> orphan handling.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied (and I added a cc:stable@kernel.org).

		       	       - Ted
