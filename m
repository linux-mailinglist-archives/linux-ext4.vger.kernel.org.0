Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 013FF2A2AD
	for <lists+linux-ext4@lfdr.de>; Sat, 25 May 2019 05:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbfEYD6z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 May 2019 23:58:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57826 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726755AbfEYD6z (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 May 2019 23:58:55 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x4P3wm7q031642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 May 2019 23:58:48 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E17B2420481; Fri, 24 May 2019 23:58:47 -0400 (EDT)
Date:   Fri, 24 May 2019 23:58:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix dcache lookup of !casefolded directories
Message-ID: <20190525035847.GC4225@mit.edu>
References: <20190524224129.28525-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190524224129.28525-1-krisman@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, May 24, 2019 at 06:41:29PM -0400, Gabriel Krisman Bertazi wrote:
> Found by visual inspection, this wasn't caught by my xfstest, since it's
> effect is ignoring positive dentries in the cache the fallback just goes
> to the disk.  it was introduced in the last iteration of the
> case-insensitive patch.
> 
> d_compare should return 0 when the entries match, so make sure we are
> correctly comparing the entire string if the encoding feature is set and
> we are on a case-INsensitive directory.
> 
> Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Applied, thanks.

I'll note that half the implementations of *_d_compare seem to use
!!memcmp(), and half use memcmp().

The callers of d_compare only seems to care if it's 0 or != 0, so I
guess it doesn't matter...

				- Ted
