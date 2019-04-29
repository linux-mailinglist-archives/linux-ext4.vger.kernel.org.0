Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B640DA2F
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 02:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfD2AVE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 20:21:04 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49195 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726580AbfD2AVE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 20:21:04 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3T0Kt8e018408
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 20:20:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 8F304420023; Sun, 28 Apr 2019 20:20:55 -0400 (EDT)
Date:   Sun, 28 Apr 2019 20:20:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.co.uk>
Subject: Re: [PATCH] debugfs: fix encoding handling in dx_hash command
Message-ID: <20190429002055.GE3789@mit.edu>
References: <20190422210124.181075-1-ebiggers@kernel.org>
 <85o94xs6tr.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85o94xs6tr.fsf@collabora.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 23, 2019 at 12:07:12AM -0400, Gabriel Krisman Bertazi wrote:
> Eric Biggers <ebiggers@kernel.org> writes:
> 
> > From: Eric Biggers <ebiggers@google.com>
> >
> > Fix the following bugs:
> >
> > 1. 'encoding' and 'hash_flags' are not initialized, causing a segfault.
> >
> > 2. 'hash_flags' incorrectly uses a __bitwise type.
> >
> > 3. The optstring doesn't contain "c" or "e", so the -c and -e options
> >    aren't recognized.
> >
> > 4. The code that handles the -e option always returns.
> >
> 
> Ugly. Thanks for finding it.
> 
> Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Thanks, applied.

						- Ted
