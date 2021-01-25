Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3020302E60
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Jan 2021 22:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732833AbhAYVwm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 25 Jan 2021 16:52:42 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57748 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732754AbhAYVvv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 25 Jan 2021 16:51:51 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10PLoo2p011874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jan 2021 16:50:51 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 35C1515C3709; Mon, 25 Jan 2021 16:50:50 -0500 (EST)
Date:   Mon, 25 Jan 2021 16:50:50 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] make jbd2 debug switch per device
Message-ID: <YA89Ov+yuX6BHJpS@mit.edu>
References: <cover.1611402263.git.brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611402263.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jan 23, 2021 at 08:00:42PM +0800, Chunguang Xu wrote:
> On a multi-disk machine, because jbd2 debugging switch is global, this
> confuses the logs of multiple disks. It is not easy to distinguish the
> logs of each disk and the amount of generated logs is very large. Maybe
> a separate debugging switch for each disk would be better, so that we
> can easily distinguish the logs of a certain disk. 
> 
> We can enable jbd2 debugging of a device in the following ways:
> echo X > /proc/fs/jbd2/sdX/jbd2_debug
> 
> But there is a small disadvantage here. Because the debugging switch is
> placed in the journal_t object, the log before the object is initialized
> will be lost. However, usually this will not have much impact on
> debugging.

The jbd debugging infrastructure dates back to the very beginnings of
ext3, when Stephen Tweedie added them while he was first implementing
the jbd layer.  So this dates back to a time before we had other
schemes like dynamic debug or tracepoints or eBPF.

I wonder if instead of trying to enhance our own bespoke debugging
system, instead we set up something like tracepoints where they would
be useful.  I'm not proposing that we try to replace all jbd_debug()
statements with tracepoints but I think it would be useful to look at
what sort of information would actually be *useful* on a production
server, and add those tracepoints to the jbd2 layer.  What I like
about tracepoints is you can enable them on a much more fine-grained
fashion; information is sent to userspace in a much more efficient
manner than printk; you can filter tracepoint events in the kernel,
before sending them to userspace; and if you want more sophisticated
filtering or aggregation, you can use eBPF.

What was the original use case which inspired this?  Were you indeed
trying to debug some kind of problem on a production system?  (Why did
you have multiple disks active at the same time?)  Was there a
specific problem you were trying to debug?  What debug level were you
using?  Which jbd_debug statements were most useful to you?  Which
just got in the way (but which had to be enabled given the log level
you needed to get the debug messages that you needed)?

    	      	      	    	     	      - Ted
