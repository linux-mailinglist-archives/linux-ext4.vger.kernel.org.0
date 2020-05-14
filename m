Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374DF1D334A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 May 2020 16:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgENOn0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 May 2020 10:43:26 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57463 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726066AbgENOnZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 May 2020 10:43:25 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEhJZg003644
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:43:20 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9A0B5420304; Thu, 14 May 2020 10:43:19 -0400 (EDT)
Date:   Thu, 14 May 2020 10:43:19 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/2] ext4: translate a few more map flags to strings in
 tracepoints
Message-ID: <20200514144319.GR1596452@mit.edu>
References: <20200415203140.30349-1-enwlinux@gmail.com>
 <20200415203140.30349-3-enwlinux@gmail.com>
 <20200422161413.GF20756@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422161413.GF20756@quack2.suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 22, 2020 at 06:14:13PM +0200, Jan Kara wrote:
> On Wed 15-04-20 16:31:40, Eric Whitney wrote:
> > As new ext4_map_blocks() flags have been added, not all have gotten flag
> > bit to string translations to make tracepoint output more readable.
> > Fix that, and go one step further by adding a translation for the
> > EXT4_EX_NOCACHE flag as well.  The EXT4_EX_FORCE_CACHE flag can never
> > be set in a tracepoint in the current code, so there's no need to
> > bother with a translation for it right now.
> > 
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> 
> Looks good to me. You can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
