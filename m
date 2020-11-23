Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 280702C17CE
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 22:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731316AbgKWVih (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 16:38:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55772 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731017AbgKWVig (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 16:38:36 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANLcQKP016024
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 16:38:27 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ACA8F420136; Mon, 23 Nov 2020 16:38:26 -0500 (EST)
Date:   Mon, 23 Nov 2020 16:38:26 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 02/61] e2fsck: copy context when using
 multi-thread fsck
Message-ID: <20201123213826.GE132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-3-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-3-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:48AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> This patch only copy the context to a new one when -m is enabled.
> It doesn't actually start any thread. When pass1 test finishes,
> the new context is copied back to the original context.
> 
> Since the signal handler only changes the original context, so
> add global_ctx in "struct e2fsck_struct" and use that to check
> whether there is any signal of canceling.
> 
> This patch handles the long jump properly so that all the existing
> tests can be passed even the context has been copied. Otherwise,
> test f_expisize_ea_del would fail when aborting.

The patch description is a bit misleading.  What this is really about
is adding the infrastructure to start and join threads in pass #1.
Since we presumably will add multiple threading support for other
passes, the one-line summary and commit description should make this
clear, so that in the future, when a future developer is trying to
examine the 60+ commits in this patch series, it will be a bit easier
for them to understand what is happening.

It might also be good to explain the patch series that this only
starts a single thread, since this patch series is really only about
adding the multi-threading machinery.

Some questions which immediately come up is whether it makes sense to
have this machinery in e2fsck/pass1.c, or whether some of this is more
general and should be in e2fsck/util.c --- although obviously some
portion of the code when we are merging the results from the pass will
be pass specific.  Of course, none of this is in this commit, so it's
hard for me to see whether or not it will make sense in the long run.

We can refactor the code later, or in a future patch series, but the
point is that it's hard for me to tell whether the existing function
breakdown makes the most amount of sense in the first reading of the
patches.  If you have an opinion of what's the better way to do
things, having looked at the whole patch series, feel free to move
some of the refactoring into the earlier patches; the patch series
doesn't have to reflect the developmental history of the changes, and
for the purposes of patch review, it's often simpler when you change
earlier patches to simplify things --- although that can make it
harder since then you'll have to rework later patches.  (If it's too
hard, it's fine to leave things as they are.)

            	   	   	 	- Ted
