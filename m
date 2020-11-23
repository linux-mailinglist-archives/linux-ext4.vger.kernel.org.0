Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344382C1953
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 00:21:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725827AbgKWXQm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 18:16:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:43306 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725308AbgKWXQl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 18:16:41 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANNGXqh014777
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 18:16:34 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C2CB1420136; Mon, 23 Nov 2020 18:16:33 -0500 (EST)
Date:   Mon, 23 Nov 2020 18:16:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 10/61] e2fsck: optionally configure one pfsck
 thread
Message-ID: <20201123231633.GJ132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-11-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-11-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:56AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> This patch creates only one thread to do pass1 check. The same
> codes can be used to create multiple threads, but other functions
> need to be modified to get ready for that.
> 
> pfsck support will be enabled with if configured with
> --enable-pfsck option.

This patch should probably be merged with patch #1 ("e2fsck: add -m
option for multithread").  That will make it be *much* easier to
review.

What I'd actually suggest is that we add some multi-threading support
into libext2fs as separate commits, and put them *first* in the patch
series.  They should ideally have their own unit tests so they can be
individually tested, but that way we can also review the library
changes *first* to make sure they make sense, and that way the
reviewer will understand what the library functions are before
reviewing the e2fsck patches.

I'd then also follow that up with a commit which compiles e2fsck with
the pthread library (and we need to make sure that is portable across
different OS's, and that it works when linking both statically and
dynamically), and then follow that up with e2fsck utility functions
that make life easier for the multi-threading changes --- for example,
a thread-safe logging abstraction.

Finally, I'd then add support to enable parallel fsck via a configure
option, with the default controlled by whether or not pthread support
is enabled.  (My main concern will be that there may be some minimal C
libraries which don't have threading support, when e2fsprogs is
compiled in some embedded environment.)

I'm not convinced that it makes sense to have a command-line thread to
enable multi-threading.  What probably makes more sense is to have
extended e2fsck option (using -E multithread, which takes an optional
argument indicating how many threads should be used).  In production,
the default of whether or not multi-threading should be enabled would
be via /etc/e2fsck.conf.

						- Ted

