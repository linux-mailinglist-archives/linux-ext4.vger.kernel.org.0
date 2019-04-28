Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D8DD9F3
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Apr 2019 01:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfD1Xiz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 28 Apr 2019 19:38:55 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41871 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726393AbfD1Xiz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 28 Apr 2019 19:38:55 -0400
Received: from callcc.thunk.org (adsl-173-228-226-134.prtc.net [173.228.226.134])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x3SNcmeD008140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 28 Apr 2019 19:38:50 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id ED791420023; Sun, 28 Apr 2019 19:38:47 -0400 (EDT)
Date:   Sun, 28 Apr 2019 19:38:47 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
Cc:     linux-ext4@vger.kernel.org, alexey.lyashkov@gmail.com,
        Alexey Lyashkov <c17817@cray.com>
Subject: Re: [PATCH] e2fsck: Do not to be quiet if verbose option used.
Message-ID: <20190428233847.GA31999@mit.edu>
References: <20190426130913.9288-1-c17828@cray.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426130913.9288-1-c17828@cray.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 26, 2019 at 04:09:13PM +0300, Artem Blagodarenko wrote:
> From: Alexey Lyashkov <c17817@cray.com>
> 
> e2fsck don't print a message if 'p' option used and error can be fixed without
> user assistance,  but 'v' option asks to be more verbose, so user expect to
> see any output. But not.
> Fix this, by avoid message suppress with verbose option used.
> 
> Change-Id: I358e9b04e44dd33fdb124c5663b2df0bf54ce370
> Signed-off-by: Alexey Lyashkov <c17817@cray.com>
> Cray-bug-id: LUS-6890

I need to understand the use case of what you are trying to do here.
The preen and verbose options were never intended to be mixed and this
patch changes what the verbose flag does at a fairly fundamental
level.  I'm not sure the results will be correct and they will almost
certainly be surprising.

So (a) what is the user trying to do, and (b) what does the user want
to be trying to do?  Preen was intended to be used as part of the boot
process, when multiple e2fsck's would be running in parallel, and so
you don't *want* much in the way of verbosity.

    	  	      	     	    - Ted
