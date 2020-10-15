Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E06F628F549
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Oct 2020 16:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389287AbgJOOw4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Oct 2020 10:52:56 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52515 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388348AbgJOOwz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Oct 2020 10:52:55 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09FEqmGE000997
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Oct 2020 10:52:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 2DE27420107; Thu, 15 Oct 2020 10:52:48 -0400 (EDT)
Date:   Thu, 15 Oct 2020 10:52:48 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [PATCH] ext4: Detect already used quota file early
Message-ID: <20201015145248.GD181507@mit.edu>
References: <20201013132221.22725-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013132221.22725-1-jack@suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 13, 2020 at 03:22:21PM +0200, Jan Kara wrote:
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
> Reported-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted
