Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 903BD70AF6
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 23:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbfGVVCl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 17:02:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40602 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729059AbfGVVCl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 17:02:41 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-99.corp.google.com [104.133.0.99] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6ML2atk007161
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Jul 2019 17:02:37 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 054764202F5; Mon, 22 Jul 2019 17:02:35 -0400 (EDT)
Date:   Mon, 22 Jul 2019 17:02:35 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
Message-ID: <20190722210235.GE16313@mit.edu>
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 22, 2019 at 12:15:11PM -0600, Andreas Dilger wrote:
> Unless I missed it, this patch series needs a 00/11 email that describes
> *what* "fast commit" is, and why we want it.  This should include some
> benchmark results, since (I'd assume) that the "fast" part of the feature
> name implies a performance improvement?

For background, it's a simplified version of the scheme proposed by
Park and Shin, in their paper, "iJournaling: Fine-Grained Journaling
for Improving the Latency of Fsync System Call"[1]

[1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park

I agree we should have a cover letter for this patch series.  Also, we
should add documentation to Documentation/filesystems/journaling.rst
about this feature; what it does, how it works, its basic on-disk
format changes, etc.

The fs/jbd2 layer isn't as well documented as the fs/ext4 code, and
bringing Documentation/filesystems/journaling.rst to the same level as
Documentation/filesystems/ext4/* isn't a fair/reasonable request.  On
the other hand, documenting what is being added by this patch series
is something that I think we should do.

   	     	    	     	    - Ted
