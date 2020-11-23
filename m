Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545CF2C1983
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgKWXkb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 18:40:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46666 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727757AbgKWXka (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 18:40:30 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0ANNeMCm021450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Nov 2020 18:40:22 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E8BBF420136; Mon, 23 Nov 2020 18:40:21 -0500 (EST)
Date:   Mon, 23 Nov 2020 18:40:21 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Saranya Muruganandam <saranyamohan@google.com>
Cc:     linux-ext4@vger.kernel.org, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 13/61] e2fsck: print thread log properly
Message-ID: <20201123234021.GK132317@mit.edu>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-14-saranyamohan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118153947.3394530-14-saranyamohan@google.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Nov 18, 2020 at 07:38:59AM -0800, Saranya Muruganandam wrote:
> From: Li Xi <lixi@ddn.com>
> 
> When multi-thread fsck is enabled, logs printed from multiple
> threads could overlap with each other. The overlap sometimes
> makes the logs unreadable because log_out() is used multiple times
> for a single line.
> 
> This patch adds leading [Thread XXX] to each logs if multi-thread
> is enabed by -m option.

Given that the leading "[Thread XXX]" is output using a separate
printf, this is still going to result in potential overlapped messages:

> +#ifdef CONFIG_PFSCK
> +static void thread_log_out(struct e2fsck_thread *tinfo)
> +{
> +	printf("[Thread %d] %s", tinfo->et_thread_index,
> +	       tinfo->et_log_buf);
> +	tinfo->et_log_length = 0;
> +	tinfo->et_log_buf[0] = '\0';
> +}
> +#endif

Instead of using a separate 2k buffer for each thread, why not just
have a mutex so only one thread can be printing to the terminal and/or
log files at one time?

						- Ted
