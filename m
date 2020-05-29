Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379A21E7386
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 05:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391750AbgE2DTd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 23:19:33 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55983 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2390172AbgE2DTb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 23:19:31 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T3JQEd027403
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 23:19:26 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 097AE420304; Thu, 28 May 2020 23:19:26 -0400 (EDT)
Date:   Thu, 28 May 2020 23:19:25 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid unnecessary transaction starts during
 writeback
Message-ID: <20200529031925.GL228632@mit.edu>
References: <20200525081215.29451-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525081215.29451-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 25, 2020 at 10:12:15AM +0200, Jan Kara wrote:
> ext4_writepages() currently works in a loop like:
>   start a transaction
>   scan inode for pages to write
>   map and submit these pages
>   stop the transaction
> 
> This loop results in starting transaction once more than is needed
> because in the last iteration we start a transaction only to scan the
> inode and find there are no pages to write. This can be significant
> increase in number of transaction starts for single-extent files or
> files that have all blocks already mapped. Furthermore we already know
> from previous iteration whether there are more pages to write or not. So
> propagate the information from mpage_prepare_extent_to_map() and avoid
> unnecessary looping in case there are no more pages to write.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.  I like how it shrinks the source file.  :-)

		    	     		- Ted
