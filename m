Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79C623B3120
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Jun 2021 16:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXOTh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Jun 2021 10:19:37 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50354 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229878AbhFXOTh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Jun 2021 10:19:37 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15OEH5xn030201
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Jun 2021 10:17:06 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7D90515C3CD7; Thu, 24 Jun 2021 10:17:05 -0400 (EDT)
Date:   Thu, 24 Jun 2021 10:17:05 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Leah Rumancik <leah.rumancik@gmail.com>
Cc:     linux-ext4@vger.kernel.org, dan.carpenter@oracle.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ext4: fix input checking in fs/jbd2/journal.c
Message-ID: <YNST4d8fCcGjQmzS@mit.edu>
References: <20210607175558.3343945-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607175558.3343945-1-leah.rumancik@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 07, 2021 at 05:55:58PM +0000, Leah Rumancik wrote:
> Update
> 
> 	if (JBD2_JOURNAL_FLUSH_DISCARD & !blk_queue_discard(q))
> 
> to use && instead of &. JBD2_JOURNAL_FLUSH_DISCARD is set to 1 so &
> technically works but && could be a bit faster and will maintain
> correctness in the event the value of JBD2_JOURNAL_FLUSH_DISCARD is
> updated.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>

Thanks, I've folded this fix into the base commit.

	     	    	     	      - Ted
