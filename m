Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDD72C17AB
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Nov 2020 22:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728974AbgKWV26 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 16:28:58 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54128 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726325AbgKWV25 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 16:28:57 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANLSmYT012536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 16:28:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D889A420136; Mon, 23 Nov 2020 16:28:47 -0500 (EST)
Date:   Mon, 23 Nov 2020 16:28:47 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 01/61] e2fsck: add -m option for multithread
Message-ID: <20201123212847.GD132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-2-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-2-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:47AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> -m option is added but no actual functionality is added. This
> patch only adds the logic that when -m is specified, one of
> -p/-y/-n options should be specified. And when -m is specified,
> -C shouldn't be specified and the completion progress report won't
> be triggered by sending SIGUSR1/SIGUSR2 signals. This simplifies
> the implementation of multi-thread fsck in the future.
> 
> Completion progress support with multi-thread fsck will be added
> back after multi-thread fsck implementation is finished. Right
> now, disable it to simplify the implementation of multi-thread fsck.
> 
> Signed-off-by: Li Xi <lixi@ddn.com>
> Signed-off-by: Wang Shilong <wshilong@ddn.com>
> Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>

I'm a bit surprised the changes to the e2fsck man page aren't
inclulded in this patch.  I see the man page changes were added in
"e2fsck: misc cleanups for pfsck", which I would have merged into
other patches, but that's a bit of a nit-pick.  (The way I normally do
these sorts of changes is to expert the patches using "git
format-patch", and then I'll use an editor to move patch hunks around,
and then apply them all using "git am".  Or I'll using something like
the "guilt" program, which is essentially quilt for git patch series.)

(Don't worry about making changes for this, unless you're going to be
making lots of other changes to the patch series.)

       	       	     	     	- Ted
