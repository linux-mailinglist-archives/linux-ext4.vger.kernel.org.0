Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4C178534
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2020 23:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727441AbgCCWCx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Mar 2020 17:02:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgCCWCx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Mar 2020 17:02:53 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FB2920848;
        Tue,  3 Mar 2020 22:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583272972;
        bh=HSQRJP3KSvC/KIrOlVjd0RML3XWoJX2YZfIRsQwxSB0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvP8NxNMn9ZmP58Tncs5HZmmUYtvCx6yR+iNKPIpUy1350U8oXlYnW4x/Zx5DoLyM
         d+FDG6BSxDuNO6o8RyjjYIJyjgB5nsuoGF7uJlrdfo6r1jk/QvF/zUP0itfEx+3i21
         G2HAQSGIJn6hjSybnviJcj0jD13ghBEYo+RCObYg=
Date:   Wed, 4 Mar 2020 07:02:46 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-nvme@lists.infradead.org, linux-ext4@vger.kernel.org
Subject: Re: "I/O 8 QID 0 timeout, reset controller" on 5.6-rc2
Message-ID: <20200303220246.GA20545@redsun51.ssa.fujisawa.hgst.com>
References: <20200302020339.GA5532@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302020339.GA5532@zx2c4.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Mar 02, 2020 at 10:03:39AM +0800, Jason A. Donenfeld wrote:
> Hi,
> 
> My torrent client was doing some I/O when the below happened. I'm
> wondering if this is a known thing that's been fixed during the rc
> cycle, a regression, or if my (pretty new) NVMe drive is failing.
> 
> Thanks,
> Jason
> 
> Feb 24 20:36:58 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, aborting
> Feb 24 20:37:29 thinkpad kernel: nvme nvme1: I/O 852 QID 15 timeout, reset controller
> Feb 24 20:37:59 thinkpad kernel: nvme nvme1: I/O 8 QID 0 timeout, reset controller
> Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Device not ready; aborting reset
> Feb 24 20:39:00 thinkpad kernel: nvme nvme1: Abort status: 0x371

Sorry to say, this indicates the controller has become unresponsive.
You usually see "timeout" messages in batches, though, so I wonder if
only the one IO command timed out or if the controller just doesn't
support an abort command limit.

You can try throttling the queue depth and see if the problem goes away.
The lowest possible depth can be set with kernel param
"nvme.io_queue_depth=2".
