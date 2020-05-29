Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 544191E7394
	for <lists+linux-ext4@lfdr.de>; Fri, 29 May 2020 05:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407473AbgE2DZV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 May 2020 23:25:21 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:56592 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388714AbgE2DZS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 May 2020 23:25:18 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04T3P5xl028612
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 23:25:06 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6188C420304; Thu, 28 May 2020 23:25:05 -0400 (EDT)
Date:   Thu, 28 May 2020 23:25:05 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jan (janneke) Nieuwenhuizen" <janneke@gnu.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Danny Milosavljevic <dannym@scratchpost.org>,
        Samuel Thibault <samuel.thibault@gnu.org>
Subject: Re: [PATCH v2] ext4: support xattr gnu.* namespace for the Hurd
Message-ID: <20200529032505.GM228632@mit.edu>
References: <20200525193940.878-1-janneke@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525193940.878-1-janneke@gnu.org>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, May 25, 2020 at 09:39:40PM +0200, Jan (janneke) Nieuwenhuizen wrote:
> The Hurd gained[0] support for moving the translator and author
> fields out of the inode and into the "gnu.*" xattr namespace.
> 
> In anticipation of that, an xattr INDEX was reserved[1].  The Hurd has
> now been brought into compliance[2] with that.
> 
> This patch adds support for reading and writing such attributes from
> Linux; you can now do something like
> 
>     mkdir -p hurd-root/servers/socket
>     touch hurd-root/servers/socket/1
>     setfattr --name=gnu.translator --value='"/hurd/pflocal\0"' \
>         hurd-root/servers/socket/1
>     getfattr --name=gnu.translator hurd-root/servers/socket/1
>     # file: 1
>     gnu.translator="/hurd/pflocal"
> 
> to setup a pipe translator, which is being used to create[3] a
> vm-image for the Hurd from GNU Guix.
> 
> [0] https://summerofcode.withgoogle.com/projects/#5869799859027968
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3980bd3b406addb327d858aebd19e229ea340b9a
> [2] https://git.savannah.gnu.org/cgit/hurd/hurd.git/commit/?id=a04c7bf83172faa7cb080fbe3b6c04a8415ca645
> [3] https://git.savannah.gnu.org/cgit/guix.git/log/?h=wip-hurd-vm

This patch is missing a Signed-off-by.  If you don't understand why
this is really important, please read: 

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Can you resubmit with the DCO or confirm that it's OK for me to add your Signed-off-by?

    		      	      	 	      - Ted
					      
