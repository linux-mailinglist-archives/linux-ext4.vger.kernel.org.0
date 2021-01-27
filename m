Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B953060E9
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jan 2021 17:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhA0QWM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jan 2021 11:22:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34315 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234244AbhA0QWJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jan 2021 11:22:09 -0500
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 10RGLGhN004640
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Jan 2021 11:21:16 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3F69415C3709; Wed, 27 Jan 2021 11:21:16 -0500 (EST)
Date:   Wed, 27 Jan 2021 11:21:16 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, jack@suse.com,
        harshadshirwadkar@gmail.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] make jbd2 debug switch per device
Message-ID: <YBGS/FJ8boyxyaPn@mit.edu>
References: <cover.1611402263.git.brookxu@tencent.com>
 <YA89Ov+yuX6BHJpS@mit.edu>
 <c2bfc960-d86c-b20a-e3eb-7995200a5dd8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c2bfc960-d86c-b20a-e3eb-7995200a5dd8@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 26, 2021 at 08:50:02AM +0800, brookxu wrote:
> 
> trace point, eBPF and other hook technologies are better for production
> environments. But for pure debugging work, adding hook points feels a bit
> heavy. However, your suggestion is very valuable, thank you very much.

What feels heavy?  The act of adding a new jbd_debug() statement to
the sources, versus adding a new tracepoint?  Or how to enable a set
of tracepoints versus setting a jbd_debug level (either globally, or
per mount point)?  Or something else?

If it's the latter (which is what I think it is), how often are you
needing to add a new jbd_debug() statement *and* needing to run in a
test environment where you have multiple disks?  How often is it
useful to have multiple disks when doing your debugging?

I'm trying to understand why this has been useful to you, since that
generally doesn't match with my development, testing, or debugging
experience.  In general I try to test with one file system at a time,
since I'm trying to find something reproducible.  Do you have cases
where you need multiple file systems in your test environment in order
to do your testing?  Why is that?  Is it because you're trying to use
your production server code as your test reproducers?  And if so, I
would have thought adding the jbd_debug() statements and sending lots
of console print messages would distort the timing enough to make it
hard to reproduce a problem in found in your production environment.

It sounds like you have a very different set of test practices than
what I'm used to, and I'm trying to understand it better.

Cheers,

						- Ted
