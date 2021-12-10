Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031BE47080E
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Dec 2021 19:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245099AbhLJSIo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Dec 2021 13:08:44 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52312 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241522AbhLJSIo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Dec 2021 13:08:44 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-106.corp.google.com [104.133.8.106] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BAI54B1001820
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Dec 2021 13:05:05 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 834714205DB; Fri, 10 Dec 2021 13:05:03 -0500 (EST)
Date:   Fri, 10 Dec 2021 13:05:03 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] fs: ext4: possible ABBA deadlock in
 ext4_inline_data_truncate() and ext4_punch_hole()
Message-ID: <YbOWz7tvA6DuXcrw@mit.edu>
References: <03a92134-ce74-f586-59a0-baed436b275a@gmail.com>
 <YbI2IEzCVo+A6GTi@mit.edu>
 <c9f25d5a-0963-5b2d-b1f0-e7c7454f7153@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9f25d5a-0963-5b2d-b1f0-e7c7454f7153@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 10, 2021 at 10:03:37AM +0800, Jia-Ju Bai wrote:
> 
> Thank you very much for the detailed explanation!
> I will improve my static analysis tool for this point.

I'm not sure it will be possible to programatically detect why the
ABBA deadlock isn't possible without having the static analyzer having
a semantic understanding how the code works (so it can understand that
that code path which leads to the ABBA deadlock won't get executed).

It may very well be that being able to understand why the ABBA
deadlock can't happen in that case is equivalent to solving the
halting problem.  But if you do come up with a clever way of improving
your static analysis tool, I'll be excited to see it!

Cheers,

					- Ted
