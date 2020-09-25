Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76577277D70
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 03:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgIYBNS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 21:13:18 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35721 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726700AbgIYBNS (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Sep 2020 21:13:18 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 08P1DBpp010998
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 21:13:12 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 80C2E42003C; Thu, 24 Sep 2020 21:13:11 -0400 (EDT)
Date:   Thu, 24 Sep 2020 21:13:11 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925011311.GJ482521@mit.edu>
References: <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924143345.GD482521@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> that one of the stack traces had virtio balloon in the trace, I
> realized that when I switched the GCE VM type from e1-standard-2 to
> n1-standard-2 (where e1 VM's are cheaper because they use
> virtio-balloon to better manage host OS memory utilization), problem
> has become, much, *much* rarer (and possibly has gone away, although
> I'm going to want to run a lot more tests before I say that
> conclusively) on my test setup.  At the very least, using an n1 VM
> (which doesn't have virtio-balloon enabled in the hypervisor) is
> enough to unblock ext4 development.

.... and I spoke too soon.  A number of runs using -rc6 are now
failing even with the n1-standard-2 VM, so virtio-ballon may not be an
indicator.

This is why debugging this is frustrating; it is very much a heisenbug
--- although 5.8 seems to work completely reliably, as does commits
before 37f4a24c2469.  Anything after that point will show random
failures.  :-(

						- Ted



