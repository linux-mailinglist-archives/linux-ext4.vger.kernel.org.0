Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD6E33249
	for <lists+linux-ext4@lfdr.de>; Mon,  3 Jun 2019 16:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbfFCOiM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 3 Jun 2019 10:38:12 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42161 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728681AbfFCOiM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 3 Jun 2019 10:38:12 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x53Ec258023477
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 3 Jun 2019 10:38:02 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id CA561420481; Mon,  3 Jun 2019 10:38:01 -0400 (EDT)
Date:   Mon, 3 Jun 2019 10:38:01 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xiaoguang Wang <xiaoguang.wang@linux.alibaba.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca
Subject: Re: [RFC] jbd2: add new "stats" proc file
Message-ID: <20190603143801.GA3048@mit.edu>
References: <20190603124238.9050-1-xiaoguang.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603124238.9050-1-xiaoguang.wang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 03, 2019 at 08:42:38PM +0800, Xiaoguang Wang wrote:
> /proc/fs/jbd2/${device}/info only shows whole average statistical
> info about jbd2's life cycle, but it can not show jbd2 info in
> specified time interval and sometimes this capability is very useful
> for trouble shooting. For example, we can not see how rs_locked and
> rs_flushing grows in specified time interval, but these two indexes
> can explain some reasons for app's behaviours.

We actually had something like this, but we removed it in commit
bf6993276f7: "jbd2: Use tracepoints for history file".  The idea was
that you can get the same information using the jbd2_run_tracepoints

# echo jbd2_run_stats > /sys/kernel/debug/tracing/set_event
# cat /sys/kernel/debug/tracing/trace_pipe 

... which will produce output like this:

      jbd2/vdg-8-293   [000] ...2   122.822487: jbd2_run_stats: dev 254,96 tid 4403 wait 0 request_delay 0 running 4 locked 0 flushing 0 logging 7 handle_count 98 blocks 3 blocks_logged 4
      jbd2/vdg-8-293   [000] ...2   122.833101: jbd2_run_stats: dev 254,96 tid 4404 wait 0 request_delay 0 running 14 locked 0 flushing 0 logging 4 handle_count 198 blocks 1 blocks_logged 2
      jbd2/vdg-8-293   [000] ...2   122.839325: jbd2_run_stats: dev 254,96 tid 4405 wait

With eBPF, we should be able to do something even more user friendly.

BTW, if you are looking to try to optimize jbd2, a good thing to do is
to take a look at jbd2_handle_stats, filtered on ones where the
interval is larger than some cut-off.  Ideally, the time between a
handle getting started and stopped should be as small as possible,
because if a transaction is trying to close, an open handle will get
in the way of that, and other CPU's will be stuck waiting for handle
to complete.  This means that pre-reading blocks before starting a
handle, etc., is a really good idea.  And monitoring jbd2_handle_stats
is a good way to find potential spots to topimize in ext4.

     	      	      		      	 	  - Ted
