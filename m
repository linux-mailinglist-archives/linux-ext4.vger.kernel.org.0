Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A448A3E1CF1
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Aug 2021 21:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbhHETpt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Aug 2021 15:45:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:51972 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230107AbhHETpr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Aug 2021 15:45:47 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 175JjSBc017871
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Aug 2021 15:45:29 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3A37315C3DD2; Thu,  5 Aug 2021 15:45:28 -0400 (EDT)
Date:   Thu, 5 Aug 2021 15:45:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     adilger.kernel@dilger.ca, johann@whamcloud.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+c9ff4822a62eee994ea3@syzkaller.appspotmail.com
Subject: Re: [PATCH] ext4: avoid huge mmp update interval value
Message-ID: <YQw/2PuZ8z22Qice@mit.edu>
References: <20210805151418.30659-1-paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805151418.30659-1-paskripkin@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 05, 2021 at 06:14:18PM +0300, Pavel Skripkin wrote:
> Syzbot reported task hung bug in ext4_fill_super(). The problem was in
> too huge mmp update interval.
> 
> Syzkaller reproducer setted s_mmp_update_interval to 39785 seconds. This
> update interaval is unreasonable huge and it can cause tasks to hung on
> kthread_stop() call, since it will wait until timeout timer expires.

I must be missing something.  kthread_stop() should wake up the
kmmpd() thread, which should see kthread_should_stop(), and then it
should exit.  What is causing it to wait until the timeout timer
expires?

					- Ted
