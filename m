Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4EC42E23FF
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Dec 2020 04:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgLXDRQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Dec 2020 22:17:16 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49598 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728631AbgLXDRQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Dec 2020 22:17:16 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0BO3GRB7001567
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Dec 2020 22:16:28 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 52EAB420280; Wed, 23 Dec 2020 22:16:27 -0500 (EST)
Date:   Wed, 23 Dec 2020 22:16:27 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     Ext4 <linux-ext4@vger.kernel.org>
Subject: Re: discard and data=writeback
Message-ID: <X+QIC4BpJZNOb7r4@mit.edu>
References: <CAFnufp2zSthSbrOQ5JE6rKEANeFqvunCR3W5Bx2VgN_Q3NbLVg@mail.gmail.com>
 <X+AQxkC9MbuxNVRm@mit.edu>
 <CAFnufp1N-k+MWWsC0G1EhGvzRjiQn3G8qPw=6uqE1wjwnPgmqA@mail.gmail.com>
 <X+If/kAwiaMdaBtF@mit.edu>
 <CAFnufp1X1B27Dfr_0DUaBNkKhSGmUjBAvPT+tMoQ8JW6b+q03w@mail.gmail.com>
 <X+OIiNOGKmbwITC3@mit.edu>
 <CAFnufp3u66k5ucSRxxYwrcsPcJOGP25oxCfWFsrVRouQmDNyjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFnufp3u66k5ucSRxxYwrcsPcJOGP25oxCfWFsrVRouQmDNyjA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 23, 2020 at 07:59:13PM +0100, Matteo Croce wrote:
> 
> Hi,
> 
> these are the blktrace outputs for both journaling modes:

Can you send me full trace files (or the outputs of blkparse) so we
can see what's going on at a somewhat more granular detail?

They'll be huge, so you may need to make them available for download
from a web server; certainly the vger.kernel.org list server isn't
going to let an attachment that large through.

Thanks,

					- Ted
