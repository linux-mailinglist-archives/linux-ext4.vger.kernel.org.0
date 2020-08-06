Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D4523D65F
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Aug 2020 07:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgHFFRt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Aug 2020 01:17:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46672 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725440AbgHFFRs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Aug 2020 01:17:48 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0765HfOX026385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 6 Aug 2020 01:17:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 0303D420263; Thu,  6 Aug 2020 01:17:40 -0400 (EDT)
Date:   Thu, 6 Aug 2020 01:17:40 -0400
From:   tytso@mit.edu
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: don't hardcode bit values in EXT4_FL_USER_*
Message-ID: <20200806051740.GI7657@mit.edu>
References: <20200713031012.192440-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713031012.192440-1-ebiggers@kernel.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Jul 12, 2020 at 08:10:12PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Define the EXT4_FL_USER_* constants by OR-ing together the appropriate
> flags, rather than hard-coding a numeric value.  This makes it much
> easier to see which flags are listed.
> 
> No change in the actual values.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Thanks, applied.

					- Ted
