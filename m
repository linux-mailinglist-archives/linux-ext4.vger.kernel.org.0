Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16DA01492D5
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 02:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387629AbgAYB52 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 24 Jan 2020 20:57:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45763 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387608AbgAYB52 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 24 Jan 2020 20:57:28 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P1vLQO025103
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jan 2020 20:57:23 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id E88C942014A; Fri, 24 Jan 2020 20:57:20 -0500 (EST)
Date:   Fri, 24 Jan 2020 20:57:20 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Colin Zou <colin.zou@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Help: ext4 jbd2 IO requests slow down fsync
Message-ID: <20200125015720.GJ147870@mit.edu>
References: <CACZyaBsCb7KxQce27C79WhD5BKekq4Gi4z_P4h_xYvQ8_zv26A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACZyaBsCb7KxQce27C79WhD5BKekq4Gi4z_P4h_xYvQ8_zv26A@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 10:28:47PM -0800, Colin Zou wrote:
> 
> I used to run my application on ext3 on SSD and recently switched to
> ext4. However, my application sees performance regression. The root
> cause is, iosnoop shows that the workload includes a lot of fsync and
> every fsync does data IO and also jbd2 IO. While on ext3, it seldom
> does journal IO. Is there a way to tune ext4 to increase fsync
> performance? Say, by reducing jbd2 IO requests?

If you're not seeing journal I/O from ext3 after an fsync, you're not
looking at things correctly.  At the very *least* there will be
journal I/O for the commit block, unless all of the work was done
earlier in a previous journal commit.

In general, ext4 and ext3 will be doing roughly the same amount of I/O
to the journal.  In some cases, depending on the workload, ext4
*might* need to do more data I/O for the file being synced.  That's
because with ext3, if there is an intervening periodic 5 second
journal commit, some or all of the data I/O may have been forced out
to disk earlier due to said 5 second sync.

What sort of workload does your application do?  How much data blocks
are you writing before each fsync(), and how often are the fsync()
operations?

						- Ted
