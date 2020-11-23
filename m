Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD12C192C
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 00:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgKWXFX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 18:05:23 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41709 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728226AbgKWXFV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 18:05:21 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANN5BIH011354
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 18:05:11 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 00B10420136; Mon, 23 Nov 2020 18:05:10 -0500 (EST)
Date:   Mon, 23 Nov 2020 18:05:10 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 09/61] e2fsck: create logs for mult-threads
Message-ID: <20201123230510.GI132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-10-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-10-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:55AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> When multi-threads are used, different logs should be created
> for different threads. Each thread has log files with suffix
> of ".$THREAD_INDEX".
> 
> And this patch adds f_multithread_logfile test case.

I'm not convinced this is the best approach; why not add a
(thread-aware) log abstraction?  That way there can be a single
logfile, which is going to be much more user/admin/SRE-friendly.

We also need to add some kind of mutex if we are multi-threading in
e2fsck/message.c, since POSIX guarantees that the dio functions are
thread-safe --- but only on a per function basis.  So if we don't want
the output to the terminal to potentially be scrambled, we need to
take a mutex in print_e2fsck_message() if we are in multi-threading
mode, so that only one thread is printing to the terminal at a time.

(And certainly if we are going to be asking a question of the user, we
*definitely* need to be taking some kind of mutex first!)

	     	     	       	    	 - Ted
